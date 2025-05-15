module 0xe44d4932a7c9e2ce27794a3f77834d37a85d54244ec5960ff89b5028bc389987::spce {
    struct SPCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPCE>(arg0, 6, b"SPCE", b"Sui Piece", b"From the Grand Line to the Sui seas...join the as they embark on their journey for the almighty Sui Piece!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeietcg4o44xdnawlfci33yukvhnvteu7xj53syyjcnljuj7um5or5a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPCE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

