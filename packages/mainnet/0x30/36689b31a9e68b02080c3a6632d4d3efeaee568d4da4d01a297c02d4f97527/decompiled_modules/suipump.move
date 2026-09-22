module 0x3036689b31a9e68b02080c3a6632d4d3efeaee568d4da4d01a297c02d4f97527::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03535a4e06537569737a6ea30143616c6c65642062792068747470733a2f2f782e636f6d2f68616c745f61622076696120404f7572626c617374626f74202268617920406f7572626c617374626f74206c61756e63682061206d656d65204e616d65203a20537569737a6e205469636b6572203a2024737a6e205365742040456d616e4162696f206173206665652072656365697665722068747470733a2f2f742e636f2f5848753841476e743930222f68747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f485330736d5955586b4141734475412e6a7067");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

