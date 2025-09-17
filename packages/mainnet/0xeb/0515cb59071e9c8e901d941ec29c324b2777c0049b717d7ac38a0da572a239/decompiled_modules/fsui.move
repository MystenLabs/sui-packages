module 0xeb0515cb59071e9c8e901d941ec29c324b2777c0049b717d7ac38a0da572a239::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUI>(arg0, 9, b"FSUI", b"Fake SUI", b"Fake SUI for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FSUI>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

