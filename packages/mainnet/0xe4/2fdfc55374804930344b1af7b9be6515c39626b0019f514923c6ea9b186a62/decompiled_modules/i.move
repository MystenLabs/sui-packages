module 0xe42fdfc55374804930344b1af7b9be6515c39626b0019f514923c6ea9b186a62::i {
    struct I has drop {
        dummy_field: bool,
    }

    fun init(arg0: I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I>(arg0, 9, b"I", b"inosuke", b"inosuke MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84a30bbf-c6d7-45a8-bc21-22b33418551b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<I>>(v1);
    }

    // decompiled from Move bytecode v6
}

