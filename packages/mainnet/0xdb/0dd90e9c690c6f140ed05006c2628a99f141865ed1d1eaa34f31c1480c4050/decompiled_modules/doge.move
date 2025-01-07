module 0xdb0dd90e9c690c6f140ed05006c2628a99f141865ed1d1eaa34f31c1480c4050::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE>(arg0, 6, b"Doge", b"Sleep Dog", x"57616b65206d65207570207768656e2077652068697420746865206d756c7469206d696c6c696f6e20646f6c6c6172206d61726b6574206361702e200a0a576520646f6e2774206e65656420736f6369616c206d65646961206f722061207765627369746520746f206272696e67207468697320736c656570696e6720646f6720746f20746865206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9970_b250830b3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

