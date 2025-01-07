module 0x67bf1f427ae07d6d3647d8c34a428b9795f7483c35eb08f58d1efba056aa5a5c::guange2015FaucetCoin {
    struct GUANGE2015FAUCETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUANGE2015FAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUANGE2015FAUCETCOIN>(arg0, 6, b"guange2015FaucetCoin", b"guange2015FaucetCoin", b"guange2015FaucetCoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUANGE2015FAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GUANGE2015FAUCETCOIN>>(v0);
    }

    entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

