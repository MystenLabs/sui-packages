module 0xfb768ce4734f4ff1490d37287f55729932b0159fd5da6b70c37aec2d72356d75::burg {
    struct BURG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURG>(arg0, 6, b"BURG", b"Trump Burger Coin", b"TrumpBurger is a meme coin celebrating the moment Trump paid for a burger with Bitcoin. With BURG, you can invest in crypto fast food and join the fun memes of the cryptocurrency world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ded202ac_de43_46f0_8751_a4de609a4bac_8c02178c64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURG>>(v1);
    }

    // decompiled from Move bytecode v6
}

