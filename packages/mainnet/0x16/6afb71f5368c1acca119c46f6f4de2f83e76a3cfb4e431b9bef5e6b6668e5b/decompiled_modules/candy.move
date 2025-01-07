module 0x166afb71f5368c1acca119c46f6f4de2f83e76a3cfb4e431b9bef5e6b6668e5b::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"CANDY", b"Sui Candy", b"Suicandy, a sweet and mischievous meme, captured the hearts of the Sui community. Its vibrant design and playful spirit quickly made it an icon, representing the network's fun and innovative side. From simple doodles to widespread popularity, Suicandy became a symbol of community and creativity, reminding everyone to embrace the sweetness of life, even in the complex world of blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1666_37da0abcf4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

