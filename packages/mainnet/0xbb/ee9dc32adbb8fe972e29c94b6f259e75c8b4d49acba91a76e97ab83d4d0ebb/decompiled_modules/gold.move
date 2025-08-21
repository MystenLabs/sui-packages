module 0xbbee9dc32adbb8fe972e29c94b6f259e75c8b4d49acba91a76e97ab83d4d0ebb::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        0xb237dca14b895ec0f743b175a7e4747ec25b567c65df1f0b38a7da105be92a36::connector_v3::new<GOLD>(arg0, 1000, b"gold", b"GOLD", b"gold by suifun", b"http://127.0.0.1:8000/api/v1/blob/fndxh6k2vcv2MaHJFP_iZYeTB-5cm7KMHoOQ5-x5IBg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

