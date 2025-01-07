module 0x985417b9c97a471f8c470b10b46d3b2137877a0c4826bb5d694e1535c2b77ace::configuration {
    struct Configuration<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        min_bet_amount: u64,
        treasury_fee: u64,
        oracle_update_allowance: u64,
        buffer_seconds: u64,
        interval_seconds: u64,
        pool: 0x1::string::String,
        pair_name: 0x1::string::String,
        pair: u32,
    }

    public(friend) fun new<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u32, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration<T0, T1>{
            id                      : 0x2::object::new(arg8),
            min_bet_amount          : arg2,
            treasury_fee            : arg4,
            oracle_update_allowance : arg3,
            buffer_seconds          : arg1,
            interval_seconds        : arg0,
            pool                    : arg5,
            pair_name               : arg6,
            pair                    : arg7,
        };
        0x2::transfer::share_object<Configuration<T0, T1>>(v0);
    }

    public fun get_buffer_seconds<T0, T1>(arg0: &Configuration<T0, T1>) : u64 {
        arg0.buffer_seconds
    }

    public fun get_interval_seconds<T0, T1>(arg0: &Configuration<T0, T1>) : u64 {
        arg0.interval_seconds
    }

    public fun get_min_bet_amount<T0, T1>(arg0: &Configuration<T0, T1>) : u64 {
        arg0.min_bet_amount
    }

    public fun get_oracle_update_allowance<T0, T1>(arg0: &Configuration<T0, T1>) : u64 {
        arg0.oracle_update_allowance
    }

    public fun get_pair_index<T0, T1>(arg0: &Configuration<T0, T1>) : u32 {
        arg0.pair
    }

    public fun get_pair_name<T0, T1>(arg0: &Configuration<T0, T1>) : 0x1::string::String {
        arg0.pair_name
    }

    public fun get_pool<T0, T1>(arg0: &Configuration<T0, T1>) : 0x1::string::String {
        arg0.pool
    }

    public fun get_treasury_fee<T0, T1>(arg0: &Configuration<T0, T1>) : u64 {
        arg0.treasury_fee
    }

    public(friend) fun update<T0, T1>(arg0: &mut Configuration<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u32) {
        arg0.interval_seconds = arg1;
        arg0.buffer_seconds = arg2;
        arg0.min_bet_amount = arg3;
        arg0.oracle_update_allowance = arg4;
        arg0.treasury_fee = arg5;
        arg0.pool = arg6;
        arg0.pair_name = arg7;
        arg0.pair = arg8;
    }

    // decompiled from Move bytecode v6
}

