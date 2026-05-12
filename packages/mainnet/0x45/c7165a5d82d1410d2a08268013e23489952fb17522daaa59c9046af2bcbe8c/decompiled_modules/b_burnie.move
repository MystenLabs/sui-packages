module 0x45c7165a5d82d1410d2a08268013e23489952fb17522daaa59c9046af2bcbe8c::b_burnie {
    struct B_BURNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BURNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BURNIE>(arg0, 9, b"bBURNIE", b"bToken BURNIE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BURNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BURNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

