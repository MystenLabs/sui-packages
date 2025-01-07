module 0xb1dd48c48e68fb2d30ee58933836e8f370c35289d8336cfe75f45883deffad3::invest {
    struct God<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct INVEST has drop {
        dummy_field: bool,
    }

    public(friend) fun buy_coin<T0, T1>(arg0: &mut 0x2::coin::TreasuryCap<T1>, arg1: &mut God<T0>, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg4 <= 0x2::balance::value<T0>(&arg3), 0);
        0x2::balance::join<T0>(&mut arg1.balance, arg3);
        0x2::coin::into_balance<T1>(0x2::coin::mint<T1>(arg0, arg4 * 2, arg5))
    }

    public entry fun create_god<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = God<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<God<T0>>(v0);
    }

    public entry fun donate<T0>(arg0: &mut God<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, arg2, arg3)));
    }

    fun init(arg0: INVEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVEST>(arg0, 9, b"INVEST", b"Test Coin", b"Test Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<INVEST>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INVEST>>(v1);
    }

    public(friend) fun sale_coin<T0, T1>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &mut God<T1>, arg2: address, arg3: &mut 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg4 <= 0x2::balance::value<T0>(arg3), 0);
        0x2::coin::burn<T0>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg3, arg4), arg5));
        0x2::balance::split<T1>(&mut arg1.balance, arg4 / 2 + 10000000)
    }

    // decompiled from Move bytecode v6
}

