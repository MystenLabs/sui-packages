module 0xe9c18e462e797bd71157645663429f12f056f8e3fd8a4267231d1154e086ed53::CHMD {
    struct CHMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMD>(arg0, 9, 0x1::string::utf8(b"CHMD"), 0x1::string::utf8(b"chammmanda"), 0x1::string::utf8(b"Token deployment for chammmanda"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMD>>(0x2::coin_registry::finalize<CHMD>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMD>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMD>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMD>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

