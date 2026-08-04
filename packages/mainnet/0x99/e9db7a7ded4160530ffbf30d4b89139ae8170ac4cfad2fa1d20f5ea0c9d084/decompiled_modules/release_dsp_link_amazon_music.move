module 0x99e9db7a7ded4160530ffbf30d4b89139ae8170ac4cfad2fa1d20f5ea0c9d084::release_dsp_link_amazon_music {
    struct AmazonMusicData has copy, drop, store {
        album_id: 0x1::string::String,
        track_id: 0x1::option::Option<0x1::string::String>,
    }

    public fun album_id(arg0: &AmazonMusicData) : 0x1::string::String {
        arg0.album_id
    }

    public fun new_album(arg0: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<AmazonMusicData> {
        assert!(!0x1::string::is_empty(&arg0), 0);
        let v0 = AmazonMusicData{
            album_id : arg0,
            track_id : 0x1::option::none<0x1::string::String>(),
        };
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<AmazonMusicData>(v0)
    }

    public fun new_track(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<AmazonMusicData> {
        assert!(!0x1::string::is_empty(&arg0) && !0x1::string::is_empty(&arg1), 0);
        let v0 = AmazonMusicData{
            album_id : arg0,
            track_id : 0x1::option::some<0x1::string::String>(arg1),
        };
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<AmazonMusicData>(v0)
    }

    public fun track_id(arg0: &AmazonMusicData) : 0x1::option::Option<0x1::string::String> {
        arg0.track_id
    }

    // decompiled from Move bytecode v7
}

