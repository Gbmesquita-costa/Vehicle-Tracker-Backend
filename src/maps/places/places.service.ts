import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import {
  Client as GoogleMapsClient,
  FindPlaceFromTextResponseData,
  PlaceInputType,
} from '@googlemaps/google-maps-services-js';

@Injectable()
export class PlacesService {
  constructor(
    private googleMapsClient: GoogleMapsClient,
    private configService: ConfigService,
  ) {}

  async findPlaces(text: string): Promise<FindPlaceFromTextResponseData> {
    const { data } = await this.googleMapsClient.findPlaceFromText({
      params: {
        input: text,
        inputtype: PlaceInputType.textQuery,
        fields: ['place_id', 'formatted_address', 'geometry', 'name'],
        key: this.configService.get('GOOGLE_MAPS_API_KEY'),
      },
    });

    return data;
  }
}
