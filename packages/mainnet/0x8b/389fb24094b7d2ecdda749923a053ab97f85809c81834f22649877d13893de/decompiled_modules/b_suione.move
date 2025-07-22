module 0x8b389fb24094b7d2ecdda749923a053ab97f85809c81834f22649877d13893de::b_suione {
    struct B_SUIONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUIONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUIONE>(arg0, 9, b"bSUIONE", b"bToken SUIONE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUIONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUIONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

