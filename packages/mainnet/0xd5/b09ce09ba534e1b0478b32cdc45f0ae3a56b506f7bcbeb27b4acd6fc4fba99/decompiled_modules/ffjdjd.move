module 0xd5b09ce09ba534e1b0478b32cdc45f0ae3a56b506f7bcbeb27b4acd6fc4fba99::ffjdjd {
    struct FFJDJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFJDJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFJDJD>(arg0, 9, b"FFJDJD", b"Jfjf", b"Jddjdj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b66d2a7-ad56-4e40-b6af-4fa176e5f2ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFJDJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFJDJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

