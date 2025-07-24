module 0x8b7bfb21042fae25e13d09c5fc958ca8f9446641d3d1e70ebc5701978918f8e2::b_fold {
    struct B_FOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FOLD>(arg0, 9, b"bFOLD", b"bToken FOLD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

