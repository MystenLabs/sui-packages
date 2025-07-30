module 0xceca6f67f03e70c09dfb6ab969022791be58466a7c774856665befe4382a4d3f::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 6, b"Dolf", b"Dolfin", b"$Dolf - A character that deserves a top spot on the water chain, originally designed by Matt Furie. Fair launched for the community. A character that fully represents the Sui narrative- raised the bonding by x2 for a fatter LP for long term success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibf6yvroqdblmbzgpt6vohv77yfn7qspd5stfksqogb5cg7edwnjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

