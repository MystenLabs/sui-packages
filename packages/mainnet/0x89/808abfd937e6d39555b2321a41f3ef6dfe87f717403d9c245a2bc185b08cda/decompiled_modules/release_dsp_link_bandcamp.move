module 0x89808abfd937e6d39555b2321a41f3ef6dfe87f717403d9c245a2bc185b08cda::release_dsp_link_bandcamp {
    struct BandcampData has copy, drop, store {
        subdomain: 0x1::string::String,
        slug: 0x1::string::String,
    }

    public fun new(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::DspLink<BandcampData> {
        assert!(!0x1::string::is_empty(&arg0) && !0x1::string::is_empty(&arg1), 0);
        let v0 = BandcampData{
            subdomain : arg0,
            slug      : arg1,
        };
        0x6bab6da95a2188dc789858176093ecf8ff82db87c504963594409406ab090586::dsp_link::new<BandcampData>(v0)
    }

    public fun slug(arg0: &BandcampData) : 0x1::string::String {
        arg0.slug
    }

    public fun subdomain(arg0: &BandcampData) : 0x1::string::String {
        arg0.subdomain
    }

    // decompiled from Move bytecode v7
}

