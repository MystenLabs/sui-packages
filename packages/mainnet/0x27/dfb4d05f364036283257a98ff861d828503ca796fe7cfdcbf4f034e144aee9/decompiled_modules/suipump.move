module 0x27dfb4d05f364036283257a98ff861d828503ca796fe7cfdcbf4f034e144aee9::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"09454443524950544f460a456443726970746f4669d101f09f9a8020456443726970746f4669207c205355492045636f73797374656d0af09f928e20446973636f7665722e204275696c642e2047726f772e0af09f8c9020436f6d6d756e69747920e280a2204d656d657320e280a22043727970746f0af09f94a520546865206a6f75726e65792073746172747320686572652e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f456443726970746f4669222c2277656273697465223a2268747470733a2f2f656473706f7274666f6c696f2e70616765732e6465762f227d4268747470733a2f2f63646e2e73756970756d702e6f72672f69636f6e732f38313430366665666566333362316237373066396265393465323537663831652e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

