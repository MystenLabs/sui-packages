module 0x5f982db287864be6e99eb15e9bd764368116ce5c5ddbc8a9d26ecac1cf6af461::LittleMoreInterestingCOIN {
    struct LITTLEMOREINTERESTINGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEMOREINTERESTINGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEMOREINTERESTINGCOIN>(arg0, 6, b"LCOIN", b"LittleMoreInterestingCOIN", b"LittleMoreInterestingCOIN Task 2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEMOREINTERESTINGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LITTLEMOREINTERESTINGCOIN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LITTLEMOREINTERESTINGCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LITTLEMOREINTERESTINGCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

