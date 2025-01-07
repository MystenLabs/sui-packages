module 0x33783d0e4ba95c031b7b84c7ccb89d153a566641d6c6ff40eedb5058077b6344::dog_meme {
    struct DOG_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MEME>(arg0, 9, b"DOG_MEME", b"Dogscute", b"Help me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90f56fb7-a2c8-4966-9101-7ab11d14034e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

