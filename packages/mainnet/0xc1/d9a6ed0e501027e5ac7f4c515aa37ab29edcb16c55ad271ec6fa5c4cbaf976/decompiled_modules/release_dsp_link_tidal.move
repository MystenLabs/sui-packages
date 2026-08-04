module 0xc1d9a6ed0e501027e5ac7f4c515aa37ab29edcb16c55ad271ec6fa5c4cbaf976::release_dsp_link_tidal {
    struct TidalData has copy, drop, store {
        id: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<TidalData> {
        assert!(!0x1::string::is_empty(&arg0), 0);
        let v0 = TidalData{id: arg0};
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<TidalData>(v0)
    }

    public fun id(arg0: &TidalData) : 0x1::string::String {
        arg0.id
    }

    // decompiled from Move bytecode v7
}

