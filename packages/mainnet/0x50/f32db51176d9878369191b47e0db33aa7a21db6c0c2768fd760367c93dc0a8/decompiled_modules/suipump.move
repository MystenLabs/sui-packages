module 0x50f32db51176d9878369191b47e0db33aa7a21db6c0c2768fd760367c93dc0a8::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0548554d414e02484dde014275696c7420646966666572656e742e204769766520616e206167656e7420617574686f726974792c206e6f7420612070726976617465206b657920e29ca8204f6e65206163636f756e74206163726f73732045564d2c20537569202620536f6c616e612028616e6420736f6f6e20657665727920636861696e292e2041204068756d6e746563682070726f746f636f6c2e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f5761615078797a222c2277656273697465223a2268747470733a2f2f77616c6c65742e68756d616e2e746563682f227d1f68747470733a2f2f692e696d6775722e636f6d2f363471674962562e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

