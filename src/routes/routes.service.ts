import { Injectable } from '@nestjs/common';

import { CreateRouteDto } from './dto/create-route.dto';

import { PrismaService } from 'src/prisma/prisma.service';
import { DirectionsService } from 'src/maps/directions/directions.service';

@Injectable()
export class RoutesService {
  constructor(
    private prismaService: PrismaService,
    private directionsService: DirectionsService,
  ) {}

  async create(createRouteDto: CreateRouteDto) {
    const { available_travel_modes, geocoded_waypoints, routes, request } =
      await this.directionsService.getDirections({
        destinationId: createRouteDto.destination_id,
        originId: createRouteDto.source_id,
      });

    const legs = routes[0].legs[0];
    return await this.prismaService.route.create({
      data: {
        name: createRouteDto.name,
        source: {
          create: {
            name: legs.start_address,
            location: {
              create: {
                lng: legs.start_location.lat,
                lat: legs.start_location.lng,
              },
            },
          },
        },
        destination: {
          create: {
            name: legs.end_address,
            location: {
              create: {
                lng: legs.end_location.lat,
                lat: legs.end_location.lng,
              },
            },
          },
        },
        duration: legs.duration.value,
        distance: legs.distance.value,
        directions: JSON.parse(
          JSON.stringify({
            available_travel_modes,
            geocoded_waypoints,
            routes,
            request,
          }),
        ),
      },
    });
  }

  async findAll() {
    return await this.prismaService.route.findMany();
  }

  async findOne(id: string) {
    return await this.prismaService.route.findUnique({
      where: {
        id,
      },
    });
  }
}
