module 0x403a9aceeec794a0a63f0819f6567aecdc24221707265fb8edd964a991aa5a9b::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 6, b"KITTY", b"Kitty On Sui", b"Kitty is a next-generation meme cryptocurrency. kitty is more than just a meme coin  its a community-powered crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_cfb2770b55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

