module 0xb18a735ef1e71b3c3304433b8ee276b8320827997c69871e01f78598c9d1226c::release_dsp_link_apple_music {
    struct AppleMusicData has copy, drop, store {
        storefront: 0x1::string::String,
        album_id: 0x1::string::String,
        track_id: 0x1::option::Option<0x1::string::String>,
    }

    public fun album_id(arg0: &AppleMusicData) : 0x1::string::String {
        arg0.album_id
    }

    public fun new_album(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<AppleMusicData> {
        assert!(!0x1::string::is_empty(&arg0) && !0x1::string::is_empty(&arg1), 0);
        let v0 = AppleMusicData{
            storefront : arg0,
            album_id   : arg1,
            track_id   : 0x1::option::none<0x1::string::String>(),
        };
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<AppleMusicData>(v0)
    }

    public fun new_track(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<AppleMusicData> {
        let v0 = if (!0x1::string::is_empty(&arg0)) {
            if (!0x1::string::is_empty(&arg1)) {
                !0x1::string::is_empty(&arg2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = AppleMusicData{
            storefront : arg0,
            album_id   : arg1,
            track_id   : 0x1::option::some<0x1::string::String>(arg2),
        };
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<AppleMusicData>(v1)
    }

    public fun storefront(arg0: &AppleMusicData) : 0x1::string::String {
        arg0.storefront
    }

    public fun track_id(arg0: &AppleMusicData) : 0x1::option::Option<0x1::string::String> {
        arg0.track_id
    }

    // decompiled from Move bytecode v7
}

