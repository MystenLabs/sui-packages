module 0x629db65019274c38a6fcdf8fd59f06b14969b2698247caa93e3aa98c1751df14::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        0xc907e599b1690d7b75b3d15acb57f48f762141ca86828abd435b98588a1f8414::connector_v3::new<HI>(arg0, 180225536, b"hi", b"HI", b"hi by suifun", b"http://127.0.0.1:8000/api/v1/blob/84l2plAIhMDnUUwooTvdI8sFb3lXMF0HzCJCZYAxIts", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

