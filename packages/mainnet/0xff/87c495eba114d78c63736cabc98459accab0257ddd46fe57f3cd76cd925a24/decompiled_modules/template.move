module 0xff87c495eba114d78c63736cabc98459accab0257ddd46fe57f3cd76cd925a24::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"I";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"I"))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEMPLATE>(arg0, 6, b"SAPT0", b"NAeroPad Test 0", b"DAeroPad test coin", v1, arg1);
        0x7efba387fc9d67f9fffed572d3353c0918dab2b936413bcd89067bb9eac6b8fe::factory::launch<TEMPLATE>(v2, v3, b"M", 1000000000, 0, 3600000, arg1);
    }

    // decompiled from Move bytecode v7
}

