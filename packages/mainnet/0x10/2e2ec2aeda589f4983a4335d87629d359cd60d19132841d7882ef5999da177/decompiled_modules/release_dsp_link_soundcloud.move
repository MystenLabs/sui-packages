module 0x102e2ec2aeda589f4983a4335d87629d359cd60d19132841d7882ef5999da177::release_dsp_link_soundcloud {
    struct SoundCloudData has copy, drop, store {
        user: 0x1::string::String,
        slug: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<SoundCloudData> {
        assert!(!0x1::string::is_empty(&arg0) && !0x1::string::is_empty(&arg1), 0);
        let v0 = SoundCloudData{
            user : arg0,
            slug : arg1,
        };
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<SoundCloudData>(v0)
    }

    public fun slug(arg0: &SoundCloudData) : 0x1::string::String {
        arg0.slug
    }

    public fun user(arg0: &SoundCloudData) : 0x1::string::String {
        arg0.user
    }

    // decompiled from Move bytecode v7
}

