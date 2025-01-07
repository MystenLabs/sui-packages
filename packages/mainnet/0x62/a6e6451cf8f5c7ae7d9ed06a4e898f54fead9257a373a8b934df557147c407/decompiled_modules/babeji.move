module 0x62a6e6451cf8f5c7ae7d9ed06a4e898f54fead9257a373a8b934df557147c407::babeji {
    struct BABEJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABEJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABEJI>(arg0, 9, b"BABEJI", b"Babe", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd889f9b-571b-42a6-aae3-84c230811af5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABEJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABEJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

