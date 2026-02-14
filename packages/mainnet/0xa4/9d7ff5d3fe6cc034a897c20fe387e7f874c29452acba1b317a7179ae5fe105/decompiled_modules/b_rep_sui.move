module 0xa49d7ff5d3fe6cc034a897c20fe387e7f874c29452acba1b317a7179ae5fe105::b_rep_sui {
    struct B_REP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_REP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_REP_SUI>(arg0, 9, b"brepSUI", b"bToken repSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_REP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_REP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

