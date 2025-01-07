module 0xa206f0968e13d698f4a1c06d71868bf4a510a2800fc333d0d3e787b32f210b56::dog_meme {
    struct DOG_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MEME>(arg0, 9, b"DOG_MEME", b"Dogscute", b"Help me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4395b77-4f74-4540-946a-37be3820f771.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

