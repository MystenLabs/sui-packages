module 0x5ee1b7f45ac25bbdd6002a36a7744d4044d59521798ac287c722f64f58463c42::honda {
    struct HONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONDA>(arg0, 9, b"HONDA", b"Honda s", b"Honda most popular model bike for sale ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e4e3fb2-8895-4408-a562-07729479196b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

