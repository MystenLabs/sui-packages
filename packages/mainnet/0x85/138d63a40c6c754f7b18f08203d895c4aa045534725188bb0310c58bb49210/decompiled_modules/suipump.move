module 0x85138d63a40c6c754f7b18f08203d895c4aa045534725188bb0310c58bb49210::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"054752414654054752414654af01596f75206275792c2068697320686169722067726f77732e204164656e2077617320626f726e204e6f72776f6f6420372e205a65726f2067726166747320746f207369782074686f7573616e642c207468656e2069742773206f7665722e7c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f67726166745f737569222c2277656273697465223a2268747470733a2f2f67726166747375692e6e65746c6966792e6170702f227d2468747470733a2f2f67726166747375692e6e65746c6966792e6170702f7066702e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

