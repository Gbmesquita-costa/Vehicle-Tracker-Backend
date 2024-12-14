/*
  Warnings:

  - You are about to drop the column `lang` on the `coord` table. All the data in the column will be lost.
  - Added the required column `lng` to the `coord` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "coord" DROP COLUMN "lang",
ADD COLUMN     "lng" DOUBLE PRECISION NOT NULL;
