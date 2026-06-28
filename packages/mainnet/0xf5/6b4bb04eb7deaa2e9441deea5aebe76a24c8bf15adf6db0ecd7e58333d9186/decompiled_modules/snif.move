module 0xf56b4bb04eb7deaa2e9441deea5aebe76a24c8bf15adf6db0ecd7e58333d9186::snif {
    struct SNIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIF>(arg0, 9, b"SNIF", b"SNIFFER", b"SNIFFER is a test token deployed using latest state of the art infrastructure (Currently BETA) built to deploy tokens across multiple chains with no code. Platform will be live next month depending on beta outcome.Currently devs are working day and nigt.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeic5rgcs7n7njk77jutd7zwfthttohpzuigpr3hzjdix7sgdub5v6y")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SNIF>>(0x2::coin::mint<SNIF>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIF>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIF>>(v1);
    }

    // decompiled from Move bytecode v7
}

