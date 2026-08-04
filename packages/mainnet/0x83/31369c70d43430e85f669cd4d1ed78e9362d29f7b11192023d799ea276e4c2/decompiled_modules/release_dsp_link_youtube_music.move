module 0x8331369c70d43430e85f669cd4d1ed78e9362d29f7b11192023d799ea276e4c2::release_dsp_link_youtube_music {
    struct YouTubeMusicData has copy, drop, store {
        id: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<YouTubeMusicData> {
        assert!(!0x1::string::is_empty(&arg0), 0);
        let v0 = YouTubeMusicData{id: arg0};
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<YouTubeMusicData>(v0)
    }

    public fun id(arg0: &YouTubeMusicData) : 0x1::string::String {
        arg0.id
    }

    // decompiled from Move bytecode v7
}

