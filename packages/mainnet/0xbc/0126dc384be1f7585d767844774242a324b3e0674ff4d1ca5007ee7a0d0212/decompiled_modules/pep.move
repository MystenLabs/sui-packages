module 0xbc0126dc384be1f7585d767844774242a324b3e0674ff4d1ca5007ee7a0d0212::pep {
    struct PEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEP>(arg0, 9, b"pep", b"smol pepe ", b"smol pepe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZ71y8zE9Nf6SmAPexZpHhpKi7RcUGDLiBMEAhPynfBtg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

