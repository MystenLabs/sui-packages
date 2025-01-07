module 0x60ba79ef3b9909f5da1b552af95cb774be8b68be1cfcaa43468b6cafa2082918::mdvd {
    struct MDVD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDVD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDVD>(arg0, 9, b"MDVD", b"Medved", b"Preved medved", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54a50a60-0fe1-40fb-afcd-c80dca6e627d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDVD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDVD>>(v1);
    }

    // decompiled from Move bytecode v6
}

