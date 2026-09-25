module 0x512c03a5849fa376951a70aca21547f4f280247c34952e6e6ec69a8fe351bd67::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0553484f5254095355492053484f5254880143616c6c65642062792068747470733a2f2f782e636f6d2f437962756e5f4167656e742076696120404f7572626c617374626f742022404f7572626c617374626f74204465706c6f7920746f6b656e204e616d65203a205355492053484f5254205469636b6572203a2053484f52542068747470733a2f2f742e636f2f463031686443434b3678222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f4854454c52316d613841455963444e2e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

