import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class RoutesDriverService {
  constructor(private prismaService: PrismaService) {}

  async processRoute(dto: { route_id: string; lat: number; lng: number }) {
    return await this.prismaService.routeDriver.upsert({
      include: {
        route: true, // eager loading
      },
      where: { route_id: dto.route_id },
      create: {
        route_id: dto.route_id,
        points: {
          create: {
            location: {
              create: {
                lat: dto.lat,
                lng: dto.lng,
              },
            },
          },
        },
      },
      update: {
        points: {
          create: {
            location: {
              create: {
                lat: dto.lat,
                lng: dto.lng,
              },
            },
          },
        },
      },
    });
  }
}
