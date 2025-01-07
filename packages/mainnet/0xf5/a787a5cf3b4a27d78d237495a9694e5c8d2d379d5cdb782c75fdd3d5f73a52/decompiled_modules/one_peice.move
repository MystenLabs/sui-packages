module 0xf5a787a5cf3b4a27d78d237495a9694e5c8d2d379d5cdb782c75fdd3d5f73a52::one_peice {
    struct ONE_PEICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE_PEICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE_PEICE>(arg0, 9, b"ONE_PEICE", b"OnePeice", b"This meme coin is dedicated to the OnePiece fan base and all other Anime lovers across the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f857ff46-0f54-4d35-af0b-780ee876d612.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE_PEICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONE_PEICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

