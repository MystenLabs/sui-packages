module 0xffd61b7d19610aaf1f19f836aa6663881529067a369b892d0a303bfceaa8b33f::gator {
    struct GATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATOR>(arg0, 6, b"GATOR", b"GATOR Mania", x"4741544f520a5448495320697320616e2041697264726f702067616d652e2e2e0a5769746820796f75206f6e204d617920323074682e0a4741544f522066756c6c206d616e6961212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000536_7446f7ae04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

