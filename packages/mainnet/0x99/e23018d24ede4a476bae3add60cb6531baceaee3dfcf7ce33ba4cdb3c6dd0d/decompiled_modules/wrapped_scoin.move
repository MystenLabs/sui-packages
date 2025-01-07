module 0x99e23018d24ede4a476bae3add60cb6531baceaee3dfcf7ce33ba4cdb3c6dd0d::wrapped_scoin {
    struct WrappedTreasuryCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        inner: 0x2::balance::Supply<T1>,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun total_supply<T0, T1>(arg0: &WrappedTreasuryCap<T0, T1>) : u64 {
        0x2::balance::supply_value<T1>(&arg0.inner)
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T1>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &mut 0x2::tx_context::TxContext) : WrappedTreasuryCap<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1> {
        assert!(0x2::coin::total_supply<T1>(&arg0) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg1) == 0x2::coin::get_decimals<T1>(arg2), 1);
        WrappedTreasuryCap<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>{
            id      : 0x2::object::new(arg3),
            inner   : 0x2::coin::treasury_into_supply<T1>(arg0),
            balance : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        }
    }

    public fun burn<T0, T1>(arg0: &mut WrappedTreasuryCap<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::balance::decrease_supply<T1>(&mut arg0.inner, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::coin::value<T1>(&arg1)), arg2)
    }

    public fun mint<T0, T1>(arg0: &mut WrappedTreasuryCap<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T1>(0x2::balance::increase_supply<T1>(&mut arg0.inner, 0x2::coin::value<T0>(&arg1)), arg2)
    }

    public fun share<T0, T1>(arg0: WrappedTreasuryCap<T0, T1>) {
        0x2::transfer::share_object<WrappedTreasuryCap<T0, T1>>(arg0);
    }

    public fun total_underlying<T0, T1>(arg0: &WrappedTreasuryCap<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

