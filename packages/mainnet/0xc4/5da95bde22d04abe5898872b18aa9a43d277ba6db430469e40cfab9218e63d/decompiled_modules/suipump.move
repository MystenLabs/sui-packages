module 0xc45da95bde22d04abe5898872b18aa9a43d277ba6db430469e40cfab9218e63d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554c514f52410753554c514f5241ba0153554c514f524120e28094206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e206f6e205375692e20f09f8c8af09f928e204275696c7420666f722074686520636f6d6d756e6974792c20706f77657265642062792074686520537569207370697269742e20f09f9a807c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f53554c514f5241222c2274776974746572223a2268747470733a2f2f782e636f6d2f53756c716f7261227d2068747470733a2f2f692e696d6775722e636f6d2f375a353265797a2e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

