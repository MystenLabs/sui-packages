module 0xc09cdbe7e5294a1e266c243281c49f28918d1f5ee321feb1ea0ecb3066922939::tardi {
    struct TARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDI>(arg0, 6, b"TARDI", b"Tardi On Sui", b"TARDI survives everything bear markets, nuclear winters, you name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigf73luodu7m4ih3dbi4ptb2xorz6poezsjekizjixbxcvkrpcnyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARDI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

