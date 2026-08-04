module 0x54e20831c146721af31b1cdc9f164c16dddac22b53e5af3e5ddcbd05a0d04793::release_dsp_link_deezer {
    struct DeezerData has copy, drop, store {
        id: 0x1::string::String,
    }

    public fun id(arg0: &DeezerData) : 0x1::string::String {
        arg0.id
    }

    public fun new(arg0: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<DeezerData> {
        assert!(!0x1::string::is_empty(&arg0), 0);
        let v0 = DeezerData{id: arg0};
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<DeezerData>(v0)
    }

    // decompiled from Move bytecode v7
}

