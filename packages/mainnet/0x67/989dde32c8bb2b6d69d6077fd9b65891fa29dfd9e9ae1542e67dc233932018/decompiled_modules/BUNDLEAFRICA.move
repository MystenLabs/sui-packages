module 0x67989dde32c8bb2b6d69d6077fd9b65891fa29dfd9e9ae1542e67dc233932018::BUNDLEAFRICA {
    struct BUNDLEAFRICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNDLEAFRICA, arg1: &mut 0x2::tx_context::TxContext) {
        0x80720f8aa621edc4fb6fbc72069352d6d539bb8e74d36f43e85c5a3dfea2748d::connector_v3::new<BUNDLEAFRICA>(arg0, 1000, b"bundleafrica", b"BUNDLEAFRICA", x"62756e646c656166726963612062792073756966756e20f09f9887", b"http://127.0.0.1:8000/api/v1/blob/fndxh6k2vcv2MaHJFP_iZYeTB-5cm7KMHoOQ5-x5IBg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

