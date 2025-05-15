module 0x9aeb7a9af33ef2333506cd8f4293df8c5f741d5af1e603911b3a2ad2a1ec2334::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVE>(arg0, 6, b"EVE", b"EEVEE ON SUI", b"The Eeveelution is here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigzp2qtwm4qiecvpzeizfg3mi46crojmj5fugewajmufd62j7jdxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

