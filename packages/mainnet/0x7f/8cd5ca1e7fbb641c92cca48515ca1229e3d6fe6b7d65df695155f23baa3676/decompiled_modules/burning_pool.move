module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::burning_pool {
    struct MoomeBurningPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        all_time_burned_amount: u64,
        all_time_to_burn_amount: u64,
        burn_interval: u64,
        latest_burn_time: u64,
        pool: 0x2::balance::Balance<T0>,
        meta: vector<u8>,
    }

    public(friend) fun burn<T0>(arg0: &mut MoomeBurningPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::MoomeLockedSupply<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = burn_pending<T0>(arg0, arg2, arg3, arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.pool, arg1);
        arg0.all_time_to_burn_amount = arg0.all_time_to_burn_amount + v1;
        0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::events::emit_burned_event(v0, v1, 0x2::balance::value<T0>(&arg0.pool));
    }

    public fun burn_interval<T0>(arg0: &MoomeBurningPool<T0>) : u64 {
        arg0.burn_interval
    }

    public(friend) fun burn_pending<T0>(arg0: &mut MoomeBurningPool<T0>, arg1: &mut 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::MoomeLockedSupply<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.latest_burn_time == 0) {
            arg0.latest_burn_time = v0;
        };
        let v1 = get_virtual_burn_amount<T0>(arg0, v0);
        if (v1 > 0) {
            0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::locked_supply::lock_balance<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.pool, v1), arg3);
            arg0.all_time_burned_amount = arg0.all_time_burned_amount + v1;
        };
        arg0.latest_burn_time = v0;
        v1
    }

    public fun get_pool_balance<T0>(arg0: &MoomeBurningPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool)
    }

    public fun get_virtual_burn_amount<T0>(arg0: &MoomeBurningPool<T0>, arg1: u64) : u64 {
        if (arg1 > arg0.latest_burn_time) {
            if (arg0.latest_burn_time == 0) {
                return 0
            };
            let v1 = get_pool_balance<T0>(arg0);
            let v2 = 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::math::mul_factor(v1, arg1 - arg0.latest_burn_time, arg0.burn_interval);
            if (v2 > v1) {
                return v1
            };
            v2
        } else {
            0
        }
    }

    public fun latest_burn_time<T0>(arg0: &MoomeBurningPool<T0>) : u64 {
        arg0.latest_burn_time
    }

    public(friend) fun make<T0>(arg0: &mut 0x2::tx_context::TxContext) : MoomeBurningPool<T0> {
        MoomeBurningPool<T0>{
            id                      : 0x2::object::new(arg0),
            all_time_burned_amount  : 0,
            all_time_to_burn_amount : 0,
            burn_interval           : 604800000,
            latest_burn_time        : 0,
            pool                    : 0x2::balance::zero<T0>(),
            meta                    : 0x1::vector::empty<u8>(),
        }
    }

    // decompiled from Move bytecode v6
}

