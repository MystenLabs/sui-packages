module 0x36450580669a57cbb5c7d30e1df9756c13e87046478024978a445cc88a22c18b::deprecated_lst_vc {
    struct DEPRECATED_LST_VC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPRECATED_LST_VC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPRECATED_LST_VC>(arg0, 6, b"DEPRECATED_LST_VC", b"DEPRECATED_LST_VC", b"DEPRECATED_LST_VC sample description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://arweave.net/2R1_8mQgn1ofjXxEwripdxrfQK1ldiWUsiKeX2DDb_A"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEPRECATED_LST_VC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPRECATED_LST_VC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

