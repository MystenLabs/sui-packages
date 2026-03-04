module 0x439b186bb333666cc3cd7d357460535db8304257520d56f14d09ed01e265154c::b_fukoff {
    struct B_FUKOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FUKOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FUKOFF>(arg0, 9, b"bFUKOFF", b"bToken FUKOFF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FUKOFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FUKOFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

