module 0x2cfdbf9777962f0bb6b995935c40b60b6d3c4966f21e26f37d211540ef939be2::twiggy {
    struct TWIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIGGY>(arg0, 6, b"TWIGGY", b"Sui Twiggy", b"fan token of Twiggy the Water-Skiing Squirrel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011429_d97d6b8476.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

