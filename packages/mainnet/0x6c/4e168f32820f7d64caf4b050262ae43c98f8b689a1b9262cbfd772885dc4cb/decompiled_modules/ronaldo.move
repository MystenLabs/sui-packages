module 0x6c4e168f32820f7d64caf4b050262ae43c98f8b689a1b9262cbfd772885dc4cb::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 9, b"RONALDO", x"e29abd2053756969696969696969696969", b"Official token of Ronaldo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/51U6C6xFHEL.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONALDO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

