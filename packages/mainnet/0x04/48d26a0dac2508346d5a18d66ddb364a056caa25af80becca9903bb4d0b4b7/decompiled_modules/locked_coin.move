module 0x448d26a0dac2508346d5a18d66ddb364a056caa25af80becca9903bb4d0b4b7::locked_coin {
    struct Locker has store, key {
        id: 0x2::object::UID,
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        current_balance: 0x2::balance::Balance<LOCKED_COIN>,
    }

    struct LOCKED_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKED_COIN>(arg0, 8, b"LOCKED COIN", b"LOCK", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOCKED_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKED_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun locked_mint(arg0: &mut 0x2::coin::TreasuryCap<LOCKED_COIN>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Locker{
            id               : 0x2::object::new(arg5),
            start_date       : v0,
            final_date       : v0 + arg3,
            original_balance : arg2,
            current_balance  : 0x2::coin::into_balance<LOCKED_COIN>(0x2::coin::mint<LOCKED_COIN>(arg0, arg2, arg5)),
        };
        0x2::transfer::public_transfer<Locker>(v1, arg1);
    }

    public fun withdraw_vested(arg0: &mut Locker, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.final_date - arg0.start_date;
        let v1 = 0x2::clock::timestamp_ms(arg1) - arg0.start_date;
        let v2 = if (v1 > v0) {
            arg0.original_balance
        } else {
            arg0.original_balance * v1 / v0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<LOCKED_COIN>>(0x2::coin::take<LOCKED_COIN>(&mut arg0.current_balance, v2 - arg0.original_balance - 0x2::balance::value<LOCKED_COIN>(&arg0.current_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

