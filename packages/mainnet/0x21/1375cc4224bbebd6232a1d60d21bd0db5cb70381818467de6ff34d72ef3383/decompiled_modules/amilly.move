module 0x211375cc4224bbebd6232a1d60d21bd0db5cb70381818467de6ff34d72ef3383::amilly {
    struct AMILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMILLY>(arg0, 6, b"AMILLY", b"A milly", x"576520676f696e6720746f2041204d494c4c592c2041204d494c4c592c2041204d494c4c592e200a0a546865206d696c6c696f6e20646f6c6c617220646177672c20746865206d6f6e6579204d617977656174686572206f66207468652053756920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_201733_303_54748da78e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

