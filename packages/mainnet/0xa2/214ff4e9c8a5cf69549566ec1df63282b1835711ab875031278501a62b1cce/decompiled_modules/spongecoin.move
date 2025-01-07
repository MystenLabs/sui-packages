module 0xa2214ff4e9c8a5cf69549566ec1df63282b1835711ab875031278501a62b1cce::spongecoin {
    struct SPONGECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGECOIN>(arg0, 6, b"SPONGECOIN", b"Sponge Bob", b"Get ready to ape into the most fire meme coin to ever hit the Sui blockchain!  We're talkin' bout $SPONGECOIN, the memiest, squishiest, most absorbent token you've ever seen! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_333fac836c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

