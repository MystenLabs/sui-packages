module 0x19942044a0c3983a20b1436c27b0c867aff6252f650fb7eb8181aff411e2d5d5::reward_pool {
    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        total_balance: 0x2::balance::Balance<T0>,
        yield_gain_pending: u256,
    }

    public fun get_balance<T0>(arg0: &RewardPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.total_balance)
    }

    public fun get_farm_id<T0>(arg0: &RewardPool<T0>) : 0x2::object::ID {
        arg0.farm_id
    }

    public fun get_yield_gain_pending<T0>(arg0: &RewardPool<T0>) : u256 {
        arg0.yield_gain_pending
    }

    public(friend) fun intern_add_balance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>) {
        0x2::balance::join<T0>(&mut arg1.total_balance, 0x2::coin::into_balance<T0>(arg0));
    }

    public(friend) fun intern_add_yield_gain_pending<T0>(arg0: u256, arg1: &mut RewardPool<T0>) {
        arg1.yield_gain_pending = arg1.yield_gain_pending + arg0;
    }

    public(friend) fun intern_create_reward_pool<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : RewardPool<T0> {
        RewardPool<T0>{
            id                 : 0x2::object::new(arg1),
            farm_id            : arg0,
            total_balance      : 0x2::balance::zero<T0>(),
            yield_gain_pending : 0,
        }
    }

    public(friend) fun intern_reset_yield_gain_pending<T0>(arg0: &mut RewardPool<T0>) {
        arg0.yield_gain_pending = 0;
    }

    public(friend) fun intern_withdraw_balance<T0>(arg0: u64, arg1: &mut RewardPool<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg1.total_balance, arg0)
    }

    // decompiled from Move bytecode v6
}

