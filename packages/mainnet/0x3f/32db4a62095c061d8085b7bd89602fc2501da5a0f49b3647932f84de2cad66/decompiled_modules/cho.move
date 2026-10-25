module 0x3f32db4a62095c061d8085b7bd89602fc2501da5a0f49b3647932f84de2cad66::cho {
    struct CHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHO>(arg0, 9, 0x1::string::utf8(b"CHO"), 0x1::string::utf8(b"cho"), 0x1::string::utf8(b"cho (CHO)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHO>>(0x2::coin_registry::finalize<CHO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

