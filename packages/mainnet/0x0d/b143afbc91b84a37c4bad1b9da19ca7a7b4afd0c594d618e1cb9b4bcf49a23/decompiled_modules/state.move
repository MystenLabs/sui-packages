module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state {
    struct PoolState has copy, drop, store {
        asset_type: 0x1::ascii::String,
        flow_rate: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        timestamp: u64,
        total_stake: u64,
        unit: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
    }

    public fun add_unit(arg0: &mut PoolState, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float) {
        arg0.unit = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(unit(arg0), arg1);
    }

    public fun asset_type(arg0: &PoolState) : 0x1::ascii::String {
        arg0.asset_type
    }

    fun err_not_enough_to_unstake() {
        abort 0
    }

    public fun flow_rate(arg0: &PoolState) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.flow_rate
    }

    public fun get_release_amount(arg0: &PoolState, arg1: u64) : u64 {
        if (arg1 > timestamp(arg0)) {
            0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(flow_rate(arg0), arg1 - timestamp(arg0)))
        } else {
            0
        }
    }

    public fun new<T0>(arg0: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg1: u64, arg2: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float) : PoolState {
        PoolState{
            asset_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            flow_rate   : arg0,
            timestamp   : arg1,
            total_stake : 0,
            unit        : arg2,
        }
    }

    public fun set_flow_rate(arg0: &mut PoolState, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float) {
        arg0.flow_rate = arg1;
    }

    public fun set_timestamp(arg0: &mut PoolState, arg1: u64) {
        arg0.timestamp = arg1;
    }

    public fun stake(arg0: &mut PoolState, arg1: u64) : u64 {
        let v0 = total_stake(arg0) + arg1;
        arg0.total_stake = v0;
        v0
    }

    public fun timestamp(arg0: &PoolState) : u64 {
        arg0.timestamp
    }

    public fun total_stake(arg0: &PoolState) : u64 {
        arg0.total_stake
    }

    public fun unit(arg0: &PoolState) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.unit
    }

    public fun unstake(arg0: &mut PoolState, arg1: u64) : u64 {
        if (total_stake(arg0) < arg1) {
            err_not_enough_to_unstake();
        };
        let v0 = total_stake(arg0) - arg1;
        arg0.total_stake = v0;
        v0
    }

    // decompiled from Move bytecode v6
}

