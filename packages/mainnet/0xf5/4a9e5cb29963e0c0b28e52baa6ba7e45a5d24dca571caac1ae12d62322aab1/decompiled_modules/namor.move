module 0xf54a9e5cb29963e0c0b28e52baa6ba7e45a5d24dca571caac1ae12d62322aab1::namor {
    struct NAMOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMOR>(arg0, 6, b"Namor", b"Kukulkan", b"I have many names. My people call me Kukulkan. But my enemies call me Namor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029855_d4f91517bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

