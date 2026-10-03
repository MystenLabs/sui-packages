module 0xfa66987dc92037881844457b89cd14f3ffb715989196abfe06a4cb9664eb0f5d::template {
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
        let (v2, v3) = 0x2::coin::create_currency<TEMPLATE>(arg0, 6, untag(b"SAPT1"), untag(b"NAeroPad Test 1"), untag(b"DAeroPad test coin"), v1, arg1);
        0x7efba387fc9d67f9fffed572d3353c0918dab2b936413bcd89067bb9eac6b8fe::factory::launch<TEMPLATE>(v2, v3, untag(b"M"), 1000000000, 1, 3600000, arg1);
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

