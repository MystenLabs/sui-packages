module 0x89f4ab6d43b50194f440d0524dbeede8e6a055f85d7761aa366884c7900e5f08::tangyuan2323faucetcoin {
    struct TANGYUAN2323FAUCETCOIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TANGYUAN2323FAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TANGYUAN2323FAUCETCOIN>>(0x2::coin::mint<TANGYUAN2323FAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TANGYUAN2323FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANGYUAN2323FAUCETCOIN>(arg0, 6, b"TANGYUAN2323FAUCETCOIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TANGYUAN2323FAUCETCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANGYUAN2323FAUCETCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

