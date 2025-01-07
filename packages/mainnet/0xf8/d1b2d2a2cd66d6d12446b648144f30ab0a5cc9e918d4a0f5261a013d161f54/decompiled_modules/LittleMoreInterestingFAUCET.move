module 0xf8d1b2d2a2cd66d6d12446b648144f30ab0a5cc9e918d4a0f5261a013d161f54::LittleMoreInterestingFAUCET {
    struct LITTLEMOREINTERESTINGFAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEMOREINTERESTINGFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEMOREINTERESTINGFAUCET>(arg0, 6, b"LFAUCET", b"LittleMoreInterestingFAUCET", b"LittleMoreInterestingFAUCET Task 2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LITTLEMOREINTERESTINGFAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LITTLEMOREINTERESTINGFAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LITTLEMOREINTERESTINGFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LITTLEMOREINTERESTINGFAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

