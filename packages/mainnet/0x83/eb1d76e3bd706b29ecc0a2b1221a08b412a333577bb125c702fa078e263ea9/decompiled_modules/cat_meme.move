module 0x83eb1d76e3bd706b29ecc0a2b1221a08b412a333577bb125c702fa078e263ea9::cat_meme {
    struct CAT_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_MEME>(arg0, 9, b"CAT_MEME", b"Snowy", b"Snowy the lucky cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82ac4cb1-4182-4340-840b-4ec0dff6add5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

