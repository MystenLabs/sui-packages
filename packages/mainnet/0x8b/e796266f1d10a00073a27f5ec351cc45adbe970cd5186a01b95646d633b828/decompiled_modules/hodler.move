module 0x8be796266f1d10a00073a27f5ec351cc45adbe970cd5186a01b95646d633b828::hodler {
    struct HODLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLER>(arg0, 6, b"HODLER", b"The Little Hodler", b"support the popularity and products of thelittlehodler, make $HODLER famous throughout the world and @SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048564_effef33ac3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

