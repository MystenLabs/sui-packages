module 0x70d004a7e250fff1e274a7965241187024bb814f337ac52cbaa4da1e4236596a::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"084149444153554949084169646153756969ba01416964615375696920282441494441535549492920e28094206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e206f6e205375692e20506f7765726564206279206d656d65732c20636f6d6d756e6974792c20616e642074686520537569207370697269742e20f09f9a80f09f929a7c7c7b2274656c656772616d223a22742e6d652f416964615375696969222c2274776974746572223a2268747470733a2f2f782e636f6d2f4169646153756969227d2068747470733a2f2f692e696d6775722e636f6d2f465956565579482e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

