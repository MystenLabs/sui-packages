module 0x43bd842b00451a610fa2959ceae52d5c7f8f5bcbe31a8ea48c0a46760e5fadc0::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = untag(b"Ihttps://aeropad.fun/api/public/meta/sui-808e5afa/image");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEMPLATE>(arg0, 6, untag(b"SSUI"), untag(b"Nsui test"), untag(b"Dasdsad"), v1, arg1);
        0x7efba387fc9d67f9fffed572d3353c0918dab2b936413bcd89067bb9eac6b8fe::factory::launch<TEMPLATE>(v2, v3, untag(b"Mhttps://aeropad.fun/api/public/meta/sui-808e5afa"), 2784602076125, 2, 86400000, arg1);
    }

    fun untag(arg0: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

