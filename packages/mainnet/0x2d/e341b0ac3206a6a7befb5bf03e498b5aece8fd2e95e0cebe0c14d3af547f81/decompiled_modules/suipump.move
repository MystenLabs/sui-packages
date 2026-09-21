module 0x2de341b0ac3206a6a7befb5bf03e498b5aece8fd2e95e0cebe0c14d3af547f81::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"06484f4c4d4f5406486f6c6d6f748b0143616c6c65642062792068747470733a2f2f782e636f6d2f4d6a626472616e2076696120404f7572626c617374626f742022404f7572626c617374626f74206465706c6f79206120746f6b656e204e616d653a20486f6c6d6f74205469636b65723a2024484f4c4d4f5420496d616765203a2068747470733a2f2f742e636f2f67303161623656315a4d222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485373376d435158774145655a5a6d2e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

