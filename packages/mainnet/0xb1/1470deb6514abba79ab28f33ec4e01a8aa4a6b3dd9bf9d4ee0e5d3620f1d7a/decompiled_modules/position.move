module 0xb11470deb6514abba79ab28f33ec4e01a8aa4a6b3dd9bf9d4ee0e5d3620f1d7a::position {
    struct Position<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        owner: address,
        position_index_in_pool: u64,
        state: u64,
        collateral_coin_balance: u64,
        collateral_factor: u64,
        borrow_coin_balance: 0x2::balance::Balance<T1>,
        position_pool_share: u128,
        position_debt_share: u128,
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u128, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : Position<T0, T1, T2> {
        Position<T0, T1, T2>{
            id                      : 0x2::object::new(arg7),
            pool_id                 : arg0,
            owner                   : 0x2::tx_context::sender(arg7),
            position_index_in_pool  : arg1,
            state                   : 0,
            collateral_coin_balance : arg2,
            collateral_factor       : arg3,
            borrow_coin_balance     : arg4,
            position_pool_share     : arg5,
            position_debt_share     : arg6,
        }
    }

    public(friend) fun decrease_position_debt_share<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>, arg1: u128) {
        arg0.position_debt_share = arg0.position_debt_share - arg1;
    }

    public(friend) fun decrease_position_pool_share<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>, arg1: u128) {
        arg0.position_pool_share = arg0.position_pool_share - arg1;
    }

    public fun get_position_collateral_coin_balance<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : u64 {
        arg0.collateral_coin_balance
    }

    public fun get_position_debt_share<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : u128 {
        arg0.position_debt_share
    }

    public fun get_position_pool_share<T0, T1, T2>(arg0: &Position<T0, T1, T2>) : u128 {
        arg0.position_pool_share
    }

    public(friend) fun increase_position_debt_share<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>, arg1: u128) {
        arg0.position_debt_share = arg0.position_debt_share + arg1;
    }

    public(friend) fun increase_position_pool_share<T0, T1, T2>(arg0: &mut Position<T0, T1, T2>, arg1: u128) {
        arg0.position_pool_share = arg0.position_pool_share + arg1;
    }

    // decompiled from Move bytecode v6
}

