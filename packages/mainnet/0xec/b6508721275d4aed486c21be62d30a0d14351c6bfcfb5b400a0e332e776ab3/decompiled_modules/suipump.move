module 0xecb6508721275d4aed486c21be62d30a0d14351c6bfcfb5b400a0e332e776ab3::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0852454c49435355490972656c69632e737569a701f09f90892054686520616e6369656e742072656c696320686173206177616b656e65642e0a2452454c4943535549206f6e205375692e0a4e6f2070726f6d697365732c206a757374207669626573202620636f6d6d756e6974792e20f09f94a50a5468652072656c696320697320796f7572732e20f09f97bff09f9a807c7c7b2274776974746572223a2268747470733a2f2f782e636f6d2f556e646561645f52656c6963227d2068747470733a2f2f692e696d6775722e636f6d2f727758376d76752e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

