-- CreateTable
CREATE TABLE "route" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "sourceId" TEXT,
    "destinationId" TEXT,
    "distance" DOUBLE PRECISION NOT NULL,
    "duration" DOUBLE PRECISION NOT NULL,
    "directions" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "route_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "route_driver" (
    "id" TEXT NOT NULL,
    "route_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "route_driver_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "place" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "place_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "point" (
    "id" TEXT NOT NULL,
    "routeDriverId" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "point_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "coord" (
    "id" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "lang" DOUBLE PRECISION NOT NULL,
    "placeId" TEXT NOT NULL,
    "pointId" TEXT NOT NULL,

    CONSTRAINT "coord_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "route_driver_route_id_key" ON "route_driver"("route_id");

-- CreateIndex
CREATE UNIQUE INDEX "coord_placeId_key" ON "coord"("placeId");

-- CreateIndex
CREATE UNIQUE INDEX "coord_pointId_key" ON "coord"("pointId");

-- AddForeignKey
ALTER TABLE "route" ADD CONSTRAINT "route_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "place"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route" ADD CONSTRAINT "route_destinationId_fkey" FOREIGN KEY ("destinationId") REFERENCES "place"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "route_driver" ADD CONSTRAINT "route_driver_route_id_fkey" FOREIGN KEY ("route_id") REFERENCES "route"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "point" ADD CONSTRAINT "point_routeDriverId_fkey" FOREIGN KEY ("routeDriverId") REFERENCES "route_driver"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coord" ADD CONSTRAINT "coord_placeId_fkey" FOREIGN KEY ("placeId") REFERENCES "place"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "coord" ADD CONSTRAINT "coord_pointId_fkey" FOREIGN KEY ("pointId") REFERENCES "point"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
