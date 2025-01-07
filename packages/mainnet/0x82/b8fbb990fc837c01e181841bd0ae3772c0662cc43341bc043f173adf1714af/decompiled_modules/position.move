module 0x82b8fbb990fc837c01e181841bd0ae3772c0662cc43341bc043f173adf1714af::position {
    struct Position<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        owner: address,
        position_index_in_pool: u64,
        state: u64,
        collateral_coin_balance: u64,
        position_scoin_share_in_pool: u128,
        position_debt_share: u128,
    }

    public(friend) fun new<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : Position<T0, T1> {
        Position<T0, T1>{
            id                           : 0x2::object::new(arg5),
            pool_id                      : arg0,
            owner                        : 0x2::tx_context::sender(arg5),
            position_index_in_pool       : arg1,
            state                        : 0,
            collateral_coin_balance      : arg2,
            position_scoin_share_in_pool : arg3,
            position_debt_share          : arg4,
        }
    }

    public(friend) fun decrease_position_debt_share<T0, T1>(arg0: &mut Position<T0, T1>, arg1: u128) {
        arg0.position_debt_share = arg0.position_debt_share - arg1;
    }

    public(friend) fun decrease_position_scoin_share_in_pool<T0, T1>(arg0: &mut Position<T0, T1>, arg1: u128) {
        arg0.position_scoin_share_in_pool = arg0.position_scoin_share_in_pool - arg1;
    }

    public fun get_position_collateral_coin_balance<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        arg0.collateral_coin_balance
    }

    public fun get_position_debt_share<T0, T1>(arg0: &Position<T0, T1>) : u128 {
        arg0.position_debt_share
    }

    public fun get_position_scoin_share_in_pool<T0, T1>(arg0: &Position<T0, T1>) : u128 {
        arg0.position_scoin_share_in_pool
    }

    public(friend) fun increase_position_debt_share<T0, T1>(arg0: &mut Position<T0, T1>, arg1: u128) {
        arg0.position_debt_share = arg0.position_debt_share + arg1;
    }

    public(friend) fun increase_position_scoin_share_in_pool<T0, T1>(arg0: &mut Position<T0, T1>, arg1: u128) {
        arg0.position_scoin_share_in_pool = arg0.position_scoin_share_in_pool + arg1;
    }

    public(friend) fun update_position_state<T0, T1>(arg0: &mut Position<T0, T1>, arg1: u64) {
        arg0.state = arg1;
    }

    // decompiled from Move bytecode v6
}

