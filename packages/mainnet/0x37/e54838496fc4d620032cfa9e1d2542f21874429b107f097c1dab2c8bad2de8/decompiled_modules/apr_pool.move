module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        ad: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::AccumulationDistributor,
        reserve: 0x2::balance::Balance<T0>,
        deposits: 0x2::balance::Balance<T1>,
        target_apr_bps: u64,
        max_emission_per_sec: u64,
        last_ts: u64,
        tvl_shares: u64,
    }

    public fun create<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, AdminCap) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let (v1, _) = create_internal<T0, T1>(0x2::balance::zero<T0>(), arg0, arg1, &v0, arg2);
        (v1, v0)
    }

    public fun withdraw_shares<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        accrue<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
        arg0.tvl_shares = arg0.tvl_shares - arg2;
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::withdraw_shares(&mut arg0.ad, arg1, arg2);
        0x2::balance::split<T1>(&mut arg0.deposits, arg2)
    }

    fun accrue<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) {
        let v0 = if (arg0.last_ts == 0) {
            0
        } else {
            arg1 - arg0.last_ts
        };
        if (v0 == 0) {
            arg0.last_ts = arg1;
            return
        };
        let v1 = compute_needed_funds(arg0.tvl_shares, arg0.target_apr_bps, arg0.max_emission_per_sec, v0);
        if (v1 > 0) {
            assert!(v1 <= 0x2::balance::value<T0>(&arg0.reserve), 0);
            0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::top_up<T0>(&mut arg0.ad, 0x2::balance::split<T0>(&mut arg0.reserve, v1));
            arg0.last_ts = arg1;
        };
    }

    public fun claim_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position) : 0x2::balance::Balance<T0> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::withdraw_all_rewards<T0>(&mut arg0.ad, arg1)
    }

    public fun compute_needed_funds(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 == 0) {
            true
        } else if (arg0 == 0) {
            true
        } else {
            arg1 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (arg0 as u128) * (arg1 as u128) * (arg3 as u128) / (31536000 as u128) * (10000 as u128);
        let v2 = (arg2 as u128) * (arg3 as u128);
        let v3 = if (v1 < v2) {
            v1
        } else {
            v2
        };
        (v3 as u64)
    }

    public(friend) fun create_internal<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) : (Pool<T0, T1>, 0x2::object::ID) {
        let v0 = Pool<T0, T1>{
            id                   : 0x2::object::new(arg4),
            admin_id             : 0x2::object::id<AdminCap>(arg3),
            ad                   : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::create(arg4),
            reserve              : arg0,
            deposits             : 0x2::balance::zero<T1>(),
            target_apr_bps       : arg1,
            max_emission_per_sec : arg2,
            last_ts              : 0,
            tvl_shares           : 0,
        };
        (v0, 0x2::object::id<AdminCap>(arg3))
    }

    public fun deposit_more<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        accrue<T0, T1>(arg0, v0);
        if (arg0.tvl_shares == 0) {
            arg0.last_ts = v0;
        };
        let v1 = 0x2::balance::value<T1>(&arg2);
        0x2::balance::join<T1>(&mut arg0.deposits, arg2);
        arg0.tvl_shares = arg0.tvl_shares + v1;
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::deposit_shares(&mut arg0.ad, arg1, v1);
    }

    public fun deposit_new<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        accrue<T0, T1>(arg0, v0);
        if (arg0.tvl_shares == 0) {
            arg0.last_ts = v0;
        };
        let v1 = 0x2::balance::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.deposits, arg1);
        arg0.tvl_shares = arg0.tvl_shares + v1;
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::deposit_shares_new(&mut arg0.ad, v1)
    }

    public fun fund_reserve<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
    }

    public fun poke<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        accrue<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1) / 1000);
    }

    public fun pre_accrue_need<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        let v0 = if (arg0.last_ts == 0) {
            0
        } else {
            arg1 - arg0.last_ts
        };
        compute_needed_funds(arg0.tvl_shares, arg0.target_apr_bps, arg0.max_emission_per_sec, v0)
    }

    public fun set_max_eps_ts<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg2) == arg0.admin_id, 1);
        arg0.max_emission_per_sec = arg1;
    }

    public fun set_target_apr_bps<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg2) == arg0.admin_id, 1);
        arg0.target_apr_bps = arg1;
    }

    // decompiled from Move bytecode v6
}

