module 0x321a48e5e51d4481af37e2e25c2f4244cda59e55c7417ef743a1e6b59acaad3b::b_sctoo {
    struct B_SCTOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SCTOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SCTOO>(arg0, 9, b"bSCTOO", b"bToken SCTOO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SCTOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SCTOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

