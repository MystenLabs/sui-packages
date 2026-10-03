module 0xb274fd3626cd6d9286517ffda76cffc6970e5ecea9bd42ef75c6efd05feec0af::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = untag(b"I");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEMPLATE>(arg0, 6, untag(b"SAPT0"), untag(b"NAeroPad Test 0"), untag(b"DAeroPad test coin"), v1, arg1);
        0x7efba387fc9d67f9fffed572d3353c0918dab2b936413bcd89067bb9eac6b8fe::factory::launch<TEMPLATE>(v2, v3, untag(b"M"), 1000000000, 0, 3600000, arg1);
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

