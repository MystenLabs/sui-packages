module 0xdea79ead5c3af12a84666ea6d6ccc939c7bc474d389fbaed1ef96a2751c4c3eb::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0x89441a012376b078afe948c8026f618e18781d6d784b85f1efe348d57a9f0b7f::connector_v3::new<HI>(arg0, 867900871, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/84l2plAIhMDnUUwooTvdI8sFb3lXMF0HzCJCZYAxIts", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

