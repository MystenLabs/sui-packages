module 0xead26aa39be56502dc09ddd664cc82a53e8f7d93778a19cc7cc338ae03afcba2::mahira {
    struct MAHIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAHIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAHIRA>(arg0, 9, b"MAHIRA", b"Minie", b"Koin meme yang di ciptakan oleh seorang ayah untuk anak perempuan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7f62ced-88a1-48b2-b2de-e78afd3c71ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAHIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAHIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

