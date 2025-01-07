module 0x2eebc97208cdb969f97545955f6eb400908094c85f00255ad14100d8bec12c47::reward_pool {
    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun value<T0>(arg0: &RewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : RewardPool<T0> {
        RewardPool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        }
    }

    public fun destroy<T0>(arg0: RewardPool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let RewardPool {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

