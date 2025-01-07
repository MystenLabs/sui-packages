module 0x4771a254231c96d7f86fd19f8a9bc6c597fb90b8fb4fa576800487a5e03fa7a7::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MEME COIN", b"Join MEME Token, the fun cryptocurrency where humor meets blockchain! Engage with a vibrant community, share memes, and earn tokens while enjoying laughter. Transform digital currency into joy and creativity. Let's laugh our way to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8759e06e-a9ba-4925-82ad-e705e7de5af6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

