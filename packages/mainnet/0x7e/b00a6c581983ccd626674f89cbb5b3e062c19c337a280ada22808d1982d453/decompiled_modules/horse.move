module 0x7eb00a6c581983ccd626674f89cbb5b3e062c19c337a280ada22808d1982d453::horse {
    struct HORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSE>(arg0, 9, b"HORSE", b"Hrs", b"horse meme is the first memecoin that is 100% community oriented", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e30b08b-c853-46c9-b31f-ff9d5cf6dc97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

