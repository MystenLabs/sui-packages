module 0xcde519096282b0afa353eb1201eb622505b14db2524e79d9aad8a0932b24420d::ech {
    struct ECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECH>(arg0, 9, b"ECH", b"Echoes ", b"This meme coin was served as a revenge of memes games in the sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/266f2193-58fb-4379-bb5e-925969bc5982.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECH>>(v1);
    }

    // decompiled from Move bytecode v6
}

