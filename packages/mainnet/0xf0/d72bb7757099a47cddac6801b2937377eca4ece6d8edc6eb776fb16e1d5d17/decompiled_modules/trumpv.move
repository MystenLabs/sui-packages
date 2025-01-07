module 0xf0d72bb7757099a47cddac6801b2937377eca4ece6d8edc6eb776fb16e1d5d17::trumpv {
    struct TRUMPV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPV>(arg0, 6, b"TRUMPV", b"DONALD TRUMP VOTE", b"VOTE DONALD TRUMP NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3016584e70584d3ac607ae612a558ea3_high_00d05005f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPV>>(v1);
    }

    // decompiled from Move bytecode v6
}

