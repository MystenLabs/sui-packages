module 0xc94a39d01f2249aa0551eca61fb90afca5059da2b9cc9ef98557c194d211ff0d::b_strat {
    struct B_STRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STRAT>(arg0, 9, b"bSTRAT", b"bToken STRAT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

