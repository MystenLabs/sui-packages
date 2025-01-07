module 0xbb548d3b48b31853dcd6dda3df7adefc7506b85f1059d5ad7f26d0a4e3962da3::lobster {
    struct LOBSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOBSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOBSTER>(arg0, 9, b"LOBSTER", b"Sui Lobster", b"Sui Lobster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmcY5BaYWQu9dUUCVjHeznSbFNbV3sdBBzeHaBG7zN3S29"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOBSTER>>(v1);
        0x2::coin::mint_and_transfer<LOBSTER>(&mut v2, 1000000000000000000, @0x66829f0f0fa4d0717a8df8ef87efccced82c3bad100f3eb45b0730d67caf9239, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOBSTER>>(v2);
    }

    // decompiled from Move bytecode v6
}

