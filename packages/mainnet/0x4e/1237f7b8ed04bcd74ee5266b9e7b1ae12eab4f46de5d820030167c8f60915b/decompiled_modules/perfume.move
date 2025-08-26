module 0x4e1237f7b8ed04bcd74ee5266b9e7b1ae12eab4f46de5d820030167c8f60915b::perfume {
    struct PERFUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PERFUME, arg1: &mut 0x2::tx_context::TxContext) {
        0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::connector_v3::new<PERFUME>(arg0, 1000, b"perfume", b"PERFUME", b"perfume by suifun", b"http://127.0.0.1:8000/api/v1/blob/MSd-qxdvxuKjg10kq0QMIjhLRbRnIeJ0Cz0QjMukdCg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

