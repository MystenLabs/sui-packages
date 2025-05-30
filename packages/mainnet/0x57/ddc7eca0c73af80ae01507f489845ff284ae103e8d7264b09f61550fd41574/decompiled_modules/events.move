module 0x57ddc7eca0c73af80ae01507f489845ff284ae103e8d7264b09f61550fd41574::events {
    struct NewPool<phantom T0, phantom T1> has copy, drop {
        pool_address: address,
        amount_x: u64,
        amount_y: u64,
        policy_address: address,
    }

    struct GoLive<phantom T0, phantom T1, phantom T2> has copy, drop {
        clamm_address: address,
        staking_pool_address: address,
    }

    struct Swap<phantom T0, phantom T1, T2: copy + drop + store> has copy, drop {
        pool_address: address,
        amount_in: u64,
        swap_amount: T2,
    }

    struct AddLiquidity<phantom T0, phantom T1> has copy, drop {
        pool_address: address,
        amount_x: u64,
        amount_y: u64,
        shares: u64,
    }

    struct RemoveLiquidity<phantom T0, phantom T1> has copy, drop {
        pool_address: address,
        amount_x: u64,
        amount_y: u64,
        shares: u64,
        fee_x_value: u64,
        fee_y_value: u64,
    }

    public(friend) fun swap<T0, T1, T2: copy + drop + store>(arg0: address, arg1: u64, arg2: T2) {
        let v0 = Swap<T0, T1, T2>{
            pool_address : arg0,
            amount_in    : arg1,
            swap_amount  : arg2,
        };
        0x2::event::emit<Swap<T0, T1, T2>>(v0);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AddLiquidity<T0, T1>{
            pool_address : arg0,
            amount_x     : arg1,
            amount_y     : arg2,
            shares       : arg3,
        };
        0x2::event::emit<AddLiquidity<T0, T1>>(v0);
    }

    public(friend) fun go_live<T0, T1, T2>(arg0: address, arg1: address) {
        let v0 = GoLive<T0, T1, T2>{
            clamm_address        : arg0,
            staking_pool_address : arg1,
        };
        0x2::event::emit<GoLive<T0, T1, T2>>(v0);
    }

    public(friend) fun new_pool<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: address) {
        let v0 = NewPool<T0, T1>{
            pool_address   : arg0,
            amount_x       : arg1,
            amount_y       : arg2,
            policy_address : arg3,
        };
        0x2::event::emit<NewPool<T0, T1>>(v0);
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = RemoveLiquidity<T0, T1>{
            pool_address : arg0,
            amount_x     : arg1,
            amount_y     : arg2,
            shares       : arg3,
            fee_x_value  : arg4,
            fee_y_value  : arg5,
        };
        0x2::event::emit<RemoveLiquidity<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

