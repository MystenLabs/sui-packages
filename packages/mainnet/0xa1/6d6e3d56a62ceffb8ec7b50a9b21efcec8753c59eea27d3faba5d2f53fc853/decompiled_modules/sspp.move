module 0xa16d6e3d56a62ceffb8ec7b50a9b21efcec8753c59eea27d3faba5d2f53fc853::sspp {
    struct SSPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSPP>(arg0, 6, b"SSPP", b"Sui Save Poor People", b"SSPP will use  the rewords to donate and help poor people every month.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjnye3bift7lzhojbthz3czevagjl2gdssqsco4germ3rh4kwviq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSPP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

