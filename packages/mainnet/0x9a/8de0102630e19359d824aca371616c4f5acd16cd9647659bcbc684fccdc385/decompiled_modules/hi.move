module 0x9a8de0102630e19359d824aca371616c4f5acd16cd9647659bcbc684fccdc385::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x89441a012376b078afe948c8026f618e18781d6d784b85f1efe348d57a9f0b7f::connector_v3::new<HI>(arg0, 668671478, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/84l2plAIhMDnUUwooTvdI8sFb3lXMF0HzCJCZYAxIts", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

