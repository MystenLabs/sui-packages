module 0xbe89e5ddcfbe213bc8191de918e3bf018eebb15872fe9fe9e14cb666369dcfea::merci {
    struct MERCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCI>(arg0, 6, b"MERCI", b"DONNE", b"THANKS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TELEGRAM_BETEU_93790503ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

