module 0xcb272aa7cab042d54798e9bbbf964c305e8fbd8b0cb068f95439f7fccb6b9b22::chillmoon {
    struct CHILLMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMOON>(arg0, 6, b"CHILLMOON", b"Chill Moon", b"Hey, Im Chill Moon. I dont do rush or stress, I just hang out, glowing and taking it easy. Lifes better when you slow down and enjoy the little things, dont you think After all, I just a chill moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsiuxrrrzgjjq5zj7cos7cykhel2oivhr6e4ccqj77xn6xoc44mi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHILLMOON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

