module 0xe3e792f82884be2a888ba0e54465399f7e957034185fb3eb7d5b20423ba91950::catskt {
    struct CATSKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSKT>(arg0, 9, b"CATSKT", b"Catsketch", b"The memes coin sketch of cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fccc0a7-a634-4ccd-88e0-ed55597216b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

