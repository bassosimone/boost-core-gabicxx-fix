TOP_LOCAL_PATH := $(call my-dir)
LOCAL_PATH := $(TOP_LOCAL_PATH)

include $(CLEAR_VARS)

LOCAL_MODULE    := main
LOCAL_SRC_FILES := main.cpp

include $(BUILD_STATIC_LIBRARY)
