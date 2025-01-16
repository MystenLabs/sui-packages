module 0xf9865664723d5a3ab0fcd9a069e428f2a4041f73e203ace13c01f101aae244c::herod {
    struct HEROD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEROD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEROD>(arg0, 6, b"HEROD", b"Hero Dog", b"HEROD is purely a meme coin  just for fun, for laughs, for communities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026051_a4240f9253.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEROD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEROD>>(v1);
    }

    // decompiled from Move bytecode v6
}

