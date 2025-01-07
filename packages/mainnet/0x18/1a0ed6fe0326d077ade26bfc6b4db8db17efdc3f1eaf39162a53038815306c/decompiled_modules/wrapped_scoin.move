module 0x181a0ed6fe0326d077ade26bfc6b4db8db17efdc3f1eaf39162a53038815306c::wrapped_scoin {
    struct WrappedTreasuryCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        inner: 0x2::balance::Supply<T1>,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun total_supply<T0, T1>(arg0: &WrappedTreasuryCap<T0, T1>) : u64 {
        0x2::balance::supply_value<T1>(&arg0.inner)
    }

    public fun new<T0, T1, T2>(arg0: 0x2::coin::TreasuryCap<T2>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T2>, arg3: &mut 0x2::tx_context::TxContext) : WrappedTreasuryCap<T1, T2> {
        assert!(0x2::coin::total_supply<T2>(&arg0) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg1) == 0x2::coin::get_decimals<T2>(arg2), 1);
        WrappedTreasuryCap<T1, T2>{
            id      : 0x2::object::new(arg3),
            inner   : 0x2::coin::treasury_into_supply<T2>(arg0),
            balance : 0x2::balance::zero<T1>(),
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

