module 0x358f397db2ccdb4631335e53cdc24ec8ef5d694fff7bb2480d9668a1b793a474::b_mows {
    struct B_MOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MOWS>(arg0, 9, b"bMOWS", b"bToken MOWS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

