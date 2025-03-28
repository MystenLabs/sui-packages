module 0x7e3f7d2c3e80a21a25ec6229befcb9b93c5a592a73ee566c86ee7e1831aded8::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: vector<0x2::coin::Coin<USDT>>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<USDT>>(&arg0) > 0, 0);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<USDT>>(&mut arg0);
        0x2::pay::join_vec<USDT>(&mut v0, arg0);
        0x2::pay::split_and_transfer<USDT>(&mut v0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<USDT>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<USDT>(arg0) + arg1 <= 5000000000, 0);
        0x2::coin::mint_and_transfer<USDT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

