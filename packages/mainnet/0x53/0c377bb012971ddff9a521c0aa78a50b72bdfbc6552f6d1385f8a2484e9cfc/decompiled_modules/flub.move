module 0x530c377bb012971ddff9a521c0aa78a50b72bdfbc6552f6d1385f8a2484e9cfc::flub {
    struct FLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUB>(arg0, 6, b"FLUB", b"Flub The Fish", b"$Flub The King Of Fish in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih4jotwkth3miph73ele5pefmyfg6eohiglwtlrsrgfzr56ubtobu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

