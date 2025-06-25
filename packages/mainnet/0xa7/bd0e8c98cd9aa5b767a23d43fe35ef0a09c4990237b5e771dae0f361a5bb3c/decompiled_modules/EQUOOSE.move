module 0xa7bd0e8c98cd9aa5b767a23d43fe35ef0a09c4990237b5e771dae0f361a5bb3c::EQUOOSE {
    struct EQUOOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EQUOOSE, arg1: &mut 0x2::tx_context::TxContext) {
        0x80720f8aa621edc4fb6fbc72069352d6d539bb8e74d36f43e85c5a3dfea2748d::connector_v3::new<EQUOOSE>(arg0, 1000, b"equoose", b"EQUOOSE", x"6571756f6f73652062792073756966756e20f09f9887", b"http://127.0.0.1:8000/api/v1/blob/fndxh6k2vcv2MaHJFP_iZYeTB-5cm7KMHoOQ5-x5IBg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

