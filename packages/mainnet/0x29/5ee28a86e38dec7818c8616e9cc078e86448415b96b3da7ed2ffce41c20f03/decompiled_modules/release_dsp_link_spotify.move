module 0x295ee28a86e38dec7818c8616e9cc078e86448415b96b3da7ed2ffce41c20f03::release_dsp_link_spotify {
    struct SpotifyData has copy, drop, store {
        id: 0x1::string::String,
    }

    public fun id(arg0: &SpotifyData) : 0x1::string::String {
        arg0.id
    }

    public fun new(arg0: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<SpotifyData> {
        assert!(!0x1::string::is_empty(&arg0), 0);
        let v0 = SpotifyData{id: arg0};
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<SpotifyData>(v0)
    }

    // decompiled from Move bytecode v7
}

