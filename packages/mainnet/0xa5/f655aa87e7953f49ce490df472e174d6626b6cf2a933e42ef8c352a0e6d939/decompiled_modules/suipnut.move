module 0xa5f655aa87e7953f49ce490df472e174d6626b6cf2a933e42ef8c352a0e6d939::suipnut {
    struct SUIPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPNUT>(arg0, 6, b"SUIPNUT", b"PNUT ON SUI", b"PNUT THE SQUIRREL IS NOW ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaf2asezjiznefuiqxrdibz4iab6si272n5kreohipahxtwyn3apu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

