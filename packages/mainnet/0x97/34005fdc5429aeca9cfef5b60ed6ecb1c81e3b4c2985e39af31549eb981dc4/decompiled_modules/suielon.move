module 0x9734005fdc5429aeca9cfef5b60ed6ecb1c81e3b4c2985e39af31549eb981dc4::suielon {
    struct SUIELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIELON>(arg0, 6, b"SUIELON", b"ELON ON SUI", b"Sui Elon is a bold meme coin featuring a muscular, blue-toned character that merges Elon Musks persona with the playful humor of internet culture. Embracing a fusion of strength and meme appeal, Sui Elon aims to captivate the crypto community with its unique character and drive growth through widespread community support.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suielon_ef000b243e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

