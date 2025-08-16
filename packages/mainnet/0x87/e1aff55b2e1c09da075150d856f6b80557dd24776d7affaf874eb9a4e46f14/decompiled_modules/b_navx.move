module 0x87e1aff55b2e1c09da075150d856f6b80557dd24776d7affaf874eb9a4e46f14::b_navx {
    struct B_NAVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NAVX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NAVX>(arg0, 9, b"bNAVX", b"bToken NAVX", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NAVX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NAVX>>(v1);
    }

    // decompiled from Move bytecode v6
}

