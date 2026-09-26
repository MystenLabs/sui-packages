module 0x701c58bde0dfd121ec053f522a17c88adff54b96bf39738763f4f514edd569e7::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"074a4f424c4553531b4e6f204a6f62204f6e20537569204f6e6c79205472656e636865739c0143616c6c65642062792068747470733a2f2f782e636f6d2f437962756e5f4167656e742076696120404f7572626c617374626f742022404f7572626c617374626f742043726561746520746f6b656e204e616d65203a204e6f204a6f62204f6e20537569204f6e6c79205472656e63686573207469636b6572203a204a6f626c6573732068747470733a2f2f742e636f2f364157616a30714e7352222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f48544a4a69646c614941416a394f452e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

