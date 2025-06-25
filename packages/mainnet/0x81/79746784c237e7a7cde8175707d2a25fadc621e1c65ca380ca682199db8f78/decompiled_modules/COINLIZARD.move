module 0x8179746784c237e7a7cde8175707d2a25fadc621e1c65ca380ca682199db8f78::COINLIZARD {
    struct COINLIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINLIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x80720f8aa621edc4fb6fbc72069352d6d539bb8e74d36f43e85c5a3dfea2748d::connector_v3::new<COINLIZARD>(arg0, 1000, b"coinlizard", b"COINLIZARD", x"636f696e6c697a6172642062792073756966756e20f09f9887", b"http://127.0.0.1:8000/api/v1/blob/fndxh6k2vcv2MaHJFP_iZYeTB-5cm7KMHoOQ5-x5IBg", 0x1::string::utf8(b"https://x.com/SuiNetwork"), 0x1::string::utf8(b"http://sui.io/"), 0x1::string::utf8(b""), arg1);
    }

    // decompiled from Move bytecode v6
}

