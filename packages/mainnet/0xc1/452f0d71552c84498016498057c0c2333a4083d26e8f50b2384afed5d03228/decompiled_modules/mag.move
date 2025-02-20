module 0xc1452f0d71552c84498016498057c0c2333a4083d26e8f50b2384afed5d03228::mag {
    struct MAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAG>(arg0, 9, b"MAG", b"Magnum SniperBot", b"The Fastest On-chain Automated Trading Platform!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmT9MidwCjf6FWXPzPhw4vmB2X6T3LfQdB55coseHzvR6R")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

