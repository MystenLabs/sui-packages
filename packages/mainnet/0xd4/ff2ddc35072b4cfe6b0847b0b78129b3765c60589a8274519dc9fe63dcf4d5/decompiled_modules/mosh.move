module 0xd4ff2ddc35072b4cfe6b0847b0b78129b3765c60589a8274519dc9fe63dcf4d5::mosh {
    struct MOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSH>(arg0, 6, b"MOSH", b"MOSH the cutest pup.", b"Barf! Barf! Barf! $Mosh the cutest pup!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawrfshkpj6wqdvdupgjtwmzkak63adorsvfv234g5vdfkgsc42dm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOSH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

