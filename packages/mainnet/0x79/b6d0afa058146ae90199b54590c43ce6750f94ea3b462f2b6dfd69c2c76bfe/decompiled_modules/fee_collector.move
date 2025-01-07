module 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector {
    struct FeeCollector<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        fees: 0x2::balance::Balance<T0>,
        last_round_pool_balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : FeeCollector<T0> {
        FeeCollector<T0>{
            id                      : 0x2::object::new(arg1),
            version                 : arg0,
            fees                    : 0x2::balance::zero<T0>(),
            last_round_pool_balance : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun add_fee<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.fees, arg1);
    }

    public(friend) fun add_last_round_pool_balance<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.last_round_pool_balance, arg1);
    }

    public(friend) fun claim_fees<T0>(arg0: &mut FeeCollector<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.fees) >= arg1, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.fees, arg1, arg3), arg2);
    }

    public(friend) fun claim_last_round_pool_balance<T0>(arg0: &mut FeeCollector<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg0.last_round_pool_balance, 0x2::balance::value<T0>(&arg0.last_round_pool_balance), arg1)
    }

    public fun get_version<T0>(arg0: &FeeCollector<T0>) : u64 {
        arg0.version
    }

    public(friend) fun set_version<T0>(arg0: &mut FeeCollector<T0>, arg1: u64) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

