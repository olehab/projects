USE [master]
GO
/****** Object:  Database [Heartbeat]    Script Date: 09/30/2010 16:34:53 ******/
CREATE DATABASE [Heartbeat] ON  PRIMARY 
( NAME = N'Heartbeat', FILENAME = N'C:\Heartbeat.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Heartbeat_log', FILENAME = N'C:\Heartbeat_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
USE [Heartbeat]
GO
/****** Object:  Table [dbo].[HeartbeatApplications]    Script Date: 09/30/2010 16:34:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HeartbeatApplications]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HeartbeatApplications](
	[ApplicationId] [int] IDENTITY(1,1) NOT NULL,
	[ComponentTypeName] [nvarchar](200) NOT NULL,
	[FriendlyName] [nchar](50) NOT NULL,
 CONSTRAINT [PK_HeartbeatApplications] PRIMARY KEY CLUSTERED 
(
	[ApplicationId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HeartbeatStatuses]    Script Date: 09/30/2010 16:34:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HeartbeatStatuses]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HeartbeatStatuses](
	[StatusCode] [nchar](10) NOT NULL,
	[StatusDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_HeartbeatStatuses] PRIMARY KEY CLUSTERED 
(
	[StatusCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[HeartbeatLogs]    Script Date: 09/30/2010 16:34:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HeartbeatLogs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HeartbeatLogs](
	[HeartbeatLogId] [int] IDENTITY(1,1) NOT NULL,
	[HeartbeatInstanceId] [uniqueidentifier] NOT NULL,
	[ComponentTypeName] [nvarchar](200) NOT NULL,
	[StatusCode] [nchar](10) NOT NULL,
	[PulseTimerInterval] [float] NULL,
	[PulseCountInterval] [bigint] NULL,
	[LogDate] [datetime] NOT NULL,
	[LogText] [nvarchar](500) NULL,
	[TimerPulseNumber] [int] NULL,
	[CountPulseNumber] [int] NULL,
	[TimerMilliseconds] [float] NULL,
	[CountNumber] [bigint] NULL,
 CONSTRAINT [PK_HeartbeatLogs] PRIMARY KEY CLUSTERED 
(
	[HeartbeatLogId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  ForeignKey [FK_Heartbeat_HeartbeatStatuses]    Script Date: 09/30/2010 16:34:42 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Heartbeat_HeartbeatStatuses]') AND parent_object_id = OBJECT_ID(N'[dbo].[HeartbeatLogs]'))
ALTER TABLE [dbo].[HeartbeatLogs]  WITH CHECK ADD  CONSTRAINT [FK_Heartbeat_HeartbeatStatuses] FOREIGN KEY([StatusCode])
REFERENCES [dbo].[HeartbeatStatuses] ([StatusCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Heartbeat_HeartbeatStatuses]') AND parent_object_id = OBJECT_ID(N'[dbo].[HeartbeatLogs]'))
ALTER TABLE [dbo].[HeartbeatLogs] CHECK CONSTRAINT [FK_Heartbeat_HeartbeatStatuses]
GO
INSERT [dbo].[HeartbeatStatuses] ([StatusCode], [StatusDescription]) VALUES (N'FAIL', N'Completed but failed')
INSERT [dbo].[HeartbeatStatuses] ([StatusCode], [StatusDescription]) VALUES (N'START', N'Service started')
INSERT [dbo].[HeartbeatStatuses] ([StatusCode], [StatusDescription]) VALUES (N'SUCCEED', N'Completed sucessfully')
INSERT [dbo].[HeartbeatStatuses] ([StatusCode], [StatusDescription]) VALUES (N'UNKNOWN', N'Stopped in unknown state')
INSERT [dbo].[HeartbeatStatuses] ([StatusCode], [StatusDescription]) VALUES (N'WORKING', N'In progress')
GO
