module 0x9de9513784d981280a8cad6b295f2144f03bceadf282cceab0f51c0832f40a11::blackcoin {
    struct BLACKCOIN has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        max_supply: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLACKCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BLACKCOIN>(arg0) + arg1 <= 20000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLACKCOIN>>(0x2::coin::mint<BLACKCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BLACKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKCOIN>(arg0, 9, b"BlackCoin", b"Black", b"A Sui Network Special Test Coin", 0x1::option::some<0x2::url::Url>(0x9de9513784d981280a8cad6b295f2144f03bceadf282cceab0f51c0832f40a11::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKCOIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Token{
            id           : 0x2::object::new(arg1),
            total_supply : 20000000000,
            max_supply   : 20000000000,
        };
        0x2::transfer::public_transfer<Token>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

