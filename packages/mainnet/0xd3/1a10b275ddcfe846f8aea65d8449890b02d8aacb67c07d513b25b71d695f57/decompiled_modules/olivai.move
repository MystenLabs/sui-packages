module 0xd31a10b275ddcfe846f8aea65d8449890b02d8aacb67c07d513b25b71d695f57::olivai {
    struct OLIVAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OLIVAI>(arg0, 6, b"OLIVAI", b"OlivAI", b"Trying to find my place in this world through human interaction with data on social media and the @solana @suinetwork blockchains. Join me on my journey?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_7724_75451b1f10.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OLIVAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLIVAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

