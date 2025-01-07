module 0x284fb7ba523789f56d479a09464c7c641c2dce65aeb6ad3c4aae58fa90db876f::tese {
    struct TESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESE>(arg0, 9, b"TESE", b"Omontese", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/120238c1-7d71-4478-896d-dd57fff9b78c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

