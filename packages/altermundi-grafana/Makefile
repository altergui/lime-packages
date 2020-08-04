#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=altermundi-grafana
PKG_VERSION=$(GIT_COMMIT_DATE)-$(GIT_COMMIT_TSTAMP)
GIT_COMMIT_DATE:=$(shell git log -n 1 --pretty=%ad --date=short . )
GIT_COMMIT_TSTAMP:=$(shell git log -n 1 --pretty=%at . )

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=$(PKG_NAME) allows AlterMundi to gather statistics in https://grafana.altermundi.net
  MAINTAINER:=Gui Iribarren <gui@altermundi.net>
  DEPENDS:= +collectd \
            +collectd-mod-cpu \
            +collectd-mod-conntrack \
            +collectd-mod-exec \
            +collectd-mod-interface \
            +collectd-mod-iwinfo \
            +collectd-mod-load \
            +collectd-mod-memory \
            +collectd-mod-network \
            +collectd-mod-ping \
            +collectd-mod-processes \
            +collectd-mod-table \
            +collectd-mod-uptime
endef

define Package/$(PKG_NAME)/description
  Installs collectd (with necessary modules) and configures it to push data
  to an InfluxDB public instance running at https://grafana.altermundi.net/
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
