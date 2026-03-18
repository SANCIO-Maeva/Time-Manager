-- CreateTable
CREATE TABLE "Clocks" (
    "idClock" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "clockIn" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "clockOut" TIMESTAMP(3),
    "hoursWorked" DOUBLE PRECISION,
    "late" BOOLEAN NOT NULL DEFAULT false,
    "earlyLeave" BOOLEAN NOT NULL DEFAULT false,
    "shortDay" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Clocks_pkey" PRIMARY KEY ("idClock")
);

-- CreateTable
CREATE TABLE "Plannings" (
    "idPlanning" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "date" TIMESTAMP(3),
    "dayOfWeek" INTEGER,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3) NOT NULL,
    "isTemplate" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Plannings_pkey" PRIMARY KEY ("idPlanning")
);

-- CreateTable
CREATE TABLE "Reports" (
    "idReport" SERIAL NOT NULL,
    "kpi" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER NOT NULL,
    "teamId" INTEGER NOT NULL,

    CONSTRAINT "Reports_pkey" PRIMARY KEY ("idReport")
);

-- CreateTable
CREATE TABLE "Kpi" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "metric" TEXT NOT NULL,
    "scope" TEXT NOT NULL,
    "targetUserId" INTEGER,
    "targetTeamId" INTEGER,
    "params" JSONB,
    "createdBy" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Kpi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Roles" (
    "idRole" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Roles_pkey" PRIMARY KEY ("idRole")
);

-- CreateTable
CREATE TABLE "TeamUser" (
    "id" SERIAL NOT NULL,
    "teamId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "TeamUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Teams" (
    "idTeam" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "managerId" INTEGER NOT NULL,

    CONSTRAINT "Teams_pkey" PRIMARY KEY ("idTeam")
);

-- CreateTable
CREATE TABLE "UserRoles" (
    "idUserRole" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "UserRoles_pkey" PRIMARY KEY ("idUserRole")
);

-- CreateTable
CREATE TABLE "Users" (
    "idUser" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" INTEGER NOT NULL,
    "profile" TEXT,
    "latenessCount" INTEGER NOT NULL DEFAULT 0,
    "latenessMonth" TEXT,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("idUser")
);

-- CreateTable
CREATE TABLE "Vacations" (
    "idVacation" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Vacations_pkey" PRIMARY KEY ("idVacation")
);

-- CreateIndex
CREATE INDEX "Clocks_userId_idx" ON "Clocks"("userId");

-- CreateIndex
CREATE INDEX "Plannings_userId_idx" ON "Plannings"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Plannings_userId_dayOfWeek_isTemplate_key" ON "Plannings"("userId", "dayOfWeek", "isTemplate");

-- CreateIndex
CREATE INDEX "Reports_teamId_idx" ON "Reports"("teamId");

-- CreateIndex
CREATE INDEX "Reports_userId_idx" ON "Reports"("userId");

-- CreateIndex
CREATE INDEX "Kpi_createdBy_idx" ON "Kpi"("createdBy");

-- CreateIndex
CREATE INDEX "Kpi_targetUserId_idx" ON "Kpi"("targetUserId");

-- CreateIndex
CREATE INDEX "Kpi_targetTeamId_idx" ON "Kpi"("targetTeamId");

-- CreateIndex
CREATE UNIQUE INDEX "Roles_name_key" ON "Roles"("name");

-- CreateIndex
CREATE INDEX "TeamUser_userId_idx" ON "TeamUser"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "TeamUser_teamId_userId_key" ON "TeamUser"("teamId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "Teams_name_key" ON "Teams"("name");

-- CreateIndex
CREATE INDEX "Teams_managerId_idx" ON "Teams"("managerId");

-- CreateIndex
CREATE INDEX "UserRoles_roleId_idx" ON "UserRoles"("roleId");

-- CreateIndex
CREATE UNIQUE INDEX "UserRoles_userId_roleId_key" ON "UserRoles"("userId", "roleId");

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE INDEX "Vacations_userId_idx" ON "Vacations"("userId");

-- AddForeignKey
ALTER TABLE "Clocks" ADD CONSTRAINT "Clocks_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Plannings" ADD CONSTRAINT "Plannings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reports" ADD CONSTRAINT "Reports_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Teams"("idTeam") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reports" ADD CONSTRAINT "Reports_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kpi" ADD CONSTRAINT "Kpi_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TeamUser" ADD CONSTRAINT "TeamUser_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Teams"("idTeam") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TeamUser" ADD CONSTRAINT "TeamUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Teams" ADD CONSTRAINT "Teams_managerId_fkey" FOREIGN KEY ("managerId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRoles" ADD CONSTRAINT "UserRoles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Roles"("idRole") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserRoles" ADD CONSTRAINT "UserRoles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vacations" ADD CONSTRAINT "Vacations_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("idUser") ON DELETE RESTRICT ON UPDATE CASCADE;
