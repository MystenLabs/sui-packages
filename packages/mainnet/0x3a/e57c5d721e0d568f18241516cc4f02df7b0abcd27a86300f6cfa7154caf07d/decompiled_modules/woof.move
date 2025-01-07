module 0x3ae57c5d721e0d568f18241516cc4f02df7b0abcd27a86300f6cfa7154caf07d::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 9, b"WOOF", b"WOOF Bucks", b"Inspired by dog memes but with a bite! Woof Bucks are perfect for crypto lovers who just can't get enough of those doggo memes. Loyal, unpredictable, and guaranteed to leave a mark.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5031454c-9bd9-45d4-9af3-0e5653138a46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

