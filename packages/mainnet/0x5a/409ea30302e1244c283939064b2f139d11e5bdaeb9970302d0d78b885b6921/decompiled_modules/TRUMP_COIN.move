module 0xc9fbe1280a650aecbfdad2a06fcb3d9caee10c07a1c0ae405e8494727d3a29a5::TRUMP_COIN {
    struct TRUMP_COIN has drop {
        dummy_field: bool,
    }

    struct Public_Wallet has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<TRUMP_COIN>,
        faucet_amount: u64,
    }

    public entry fun create_faucet(arg0: &mut 0x2::coin::TreasuryCap<TRUMP_COIN>, arg1: u64, arg2: &mut Public_Wallet, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<TRUMP_COIN>(&mut arg2.coin, 0x2::coin::into_balance<TRUMP_COIN>(0x2::coin::mint<TRUMP_COIN>(arg0, arg1, arg3)));
    }

    public entry fun get_faucet(arg0: &mut Public_Wallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<TRUMP_COIN>(&arg0.coin) >= arg0.faucet_amount, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP_COIN>>(0x2::coin::from_balance<TRUMP_COIN>(0x2::balance::split<TRUMP_COIN>(&mut arg0.coin, arg0.faucet_amount), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: TRUMP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_COIN>(arg0, 8, b"TRUMP_COIN", b"TRUMP_COIN", b"TRUMP_COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/UNM9lClNgS1UYX5SRZzEx_DFJheAPKre6dZM_A7LV1I")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_COIN>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Public_Wallet{
            id            : 0x2::object::new(arg1),
            coin          : 0x2::balance::zero<TRUMP_COIN>(),
            faucet_amount : 100000000,
        };
        0x2::transfer::share_object<Public_Wallet>(v2);
    }

    public entry fun set_faucet_amount(arg0: &mut Public_Wallet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.faucet_amount = arg1;
    }

    // decompiled from Move bytecode v6
}

