module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration {
    struct Configuration<phantom T0> has store, key {
        id: 0x2::object::UID,
        buffer_seconds: u64,
        treasury_fee_rate: u64,
        treasury_reserve_rate: u64,
        treasury_reserve_transfer_rate: u64,
        reward_breakdown: vector<u64>,
        pool: 0x1::string::String,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = total_prize_rate(arg3);
        assert!(v0 <= 10000, 500);
        assert!(arg2 <= 10000, 501);
        let v1 = Configuration<T0>{
            id                             : 0x2::object::new(arg5),
            buffer_seconds                 : arg0,
            treasury_fee_rate              : arg1,
            treasury_reserve_rate          : 10000 - v0,
            treasury_reserve_transfer_rate : arg2,
            reward_breakdown               : arg3,
            pool                           : arg4,
        };
        0x2::transfer::share_object<Configuration<T0>>(v1);
    }

    public fun get_buffer_seconds<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.buffer_seconds
    }

    public fun get_pool<T0>(arg0: &Configuration<T0>) : 0x1::string::String {
        arg0.pool
    }

    public fun get_reward_breakdown<T0>(arg0: &Configuration<T0>) : vector<u64> {
        arg0.reward_breakdown
    }

    public fun get_treasury_fee_rate<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.treasury_fee_rate
    }

    public fun get_treasury_reserve_rate<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.treasury_reserve_rate
    }

    public fun get_treasury_reserve_transfer_rate<T0>(arg0: &Configuration<T0>) : u64 {
        arg0.treasury_reserve_transfer_rate
    }

    fun total_prize_rate(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        loop {
            if (v0 >= 0x1::vector::length<u64>(&arg0)) {
                break
            };
            v1 = v1 + *0x1::vector::borrow<u64>(&arg0, v0);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun update<T0>(arg0: &mut Configuration<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: 0x1::string::String) {
        let v0 = total_prize_rate(arg4);
        assert!(v0 <= 10000, 500);
        assert!(arg3 <= 10000, 501);
        arg0.buffer_seconds = arg1;
        arg0.treasury_fee_rate = arg2;
        arg0.treasury_reserve_rate = 10000 - v0;
        arg0.reward_breakdown = arg4;
        arg0.treasury_reserve_transfer_rate = arg3;
        arg0.pool = arg5;
    }

    // decompiled from Move bytecode v6
}

