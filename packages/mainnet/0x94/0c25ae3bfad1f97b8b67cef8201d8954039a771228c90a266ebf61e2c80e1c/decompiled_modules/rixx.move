module 0x940c25ae3bfad1f97b8b67cef8201d8954039a771228c90a266ebf61e2c80e1c::rixx {
    struct RIXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIXX>(arg0, 9, b"RIXX", b"Surf", b"The surf board of memes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76c56dbe-ad57-4edb-a61b-2f1a7f5339c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

