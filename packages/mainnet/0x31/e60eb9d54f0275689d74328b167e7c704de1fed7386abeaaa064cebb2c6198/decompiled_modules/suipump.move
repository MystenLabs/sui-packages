module 0x31e60eb9d54f0275689d74328b167e7c704de1fed7386abeaaa064cebb2c6198::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06464c555252590e466c7572727920546865204361749a014c6f666920616c77617973207361797320466c757272792c20616e64206e6f77206973207468652074696d6520746f2068617665206f6e6520616e64207468657265206973206e6f7468696e6720626574746572207468616e2061206361742e204c6f6669e2809973206361747c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f666c75727279746865636174737569227d1f68747470733a2f2f692e696d6775722e636f6d2f425777694474472e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

