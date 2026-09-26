module 0x8beaca0cd9290b7e391dd141e202ce6dd8573061bbf811824cd4494e23acb28b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"04434c41570f434c4157204352555354414345414e8e0143616c6c65642062792068747470733a2f2f782e636f6d2f437962756e5f4167656e742076696120404f7572626c617374626f742022404f7572626c617374626f742043726561746520746f6b656e204e616d65203a20434c4157204352555354414345414e207469636b6572203a2024434c41572068747470733a2f2f742e636f2f5a7a75547a5953323750222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f48544a4c47735a626f414138344c6d2e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

