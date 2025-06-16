module 0x6b42605c1f17a42afa7ad90fb39420506d991962449bb9979f9dc97e7318ffaf::ponyo {
    struct PONYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONYO>(arg0, 6, b"PONYO", b"Ponyo On Sui", b"Ponyo is introduced as a goldfish who lives in the ocean with her father, a powerful wizard, and her many sisters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihjlr5dn5bqbilnllgz7podumhwskr6fqztuill4xrqoblvsbjxvi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PONYO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

