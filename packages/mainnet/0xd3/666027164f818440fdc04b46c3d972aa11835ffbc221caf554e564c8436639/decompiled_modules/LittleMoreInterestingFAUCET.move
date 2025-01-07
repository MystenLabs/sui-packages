module 0xd3666027164f818440fdc04b46c3d972aa11835ffbc221caf554e564c8436639::LittleMoreInterestingFAUCET {
    struct LITTLEMOREINTERESTINGFAUCET has drop {
        dummy_field: bool,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<LITTLEMOREINTERESTINGFAUCET>,
    }

    public entry fun faucet(arg0: &mut Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LITTLEMOREINTERESTINGFAUCET>>(0x2::coin::take<LITTLEMOREINTERESTINGFAUCET>(&mut arg0.coin, 500000, arg1), 0x2::tx_context::sender(arg1));
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

