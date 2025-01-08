module 0x741cfaeb15aca06a0bfe5eb99136f73cb8e83c4eb8c7d5f1e0e85fe7ada17b6a::meme_x {
    struct MEME_X has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_X>(arg0, 9, b"MEME_X", b"$X", b"MemeX is a meme coin used for fun and entertainment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c8de9de-1e2d-47c7-996a-42f125475a40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_X>>(v1);
    }

    // decompiled from Move bytecode v6
}

