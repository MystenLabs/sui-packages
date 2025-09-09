module 0x3771c691db8cc79c8b1e07e18d3cfb5aa2936a89f1ddb39a7e7f48a424c93a2a::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0xc22df1602973f0528766132f8e8380351ebbdd6c8586c6027f4404b2a1bf205d::connector_v3::new<HI>(arg0, 18404143, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/84l2plAIhMDnUUwooTvdI8sFb3lXMF0HzCJCZYAxIts", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

