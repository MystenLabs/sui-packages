module 0x9ffbb5765a0c9677ab090ebfc36523c55e64b043daa77634f0759c2da4ffc028::bodingfak {
    struct BODINGFAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BODINGFAK, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<BODINGFAK>(arg0, 1000, b"bodingfak", b"BODINGFAK", b"bodingfak by suifun", b"http://127.0.0.1:8000/api/v1/blob/MSd-qxdvxuKjg10kq0QMIjhLRbRnIeJ0Cz0QjMukdCg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

