module 0x2e2eb57fcd4c7c9f527f7c108b37b60ede40dd9ac5e279bc0e16184d69272d6b::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"Seal Eel", x"49732069742061207365616c206f7220697320697420616e2065656c3f0a0a4e6f20736f6369616c73206a7573742073656e64207468697320656c656374726963207365616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0291_9ef5c6218d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

