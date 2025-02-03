module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round {
    struct RoundKey<phantom T0> has copy, drop, store {
        epoch: u64,
    }

    struct RoundInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        start_timestamp: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        lock_price: 0x1::option::Option<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>,
        close_price: 0x1::option::Option<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>,
        total_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bull_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bear_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        pool_price: 0x2::table::Table<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>,
        treasury_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        reward_base_cal_value: u128,
        reward_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        users_bet: 0x2::table::Table<u64, address>,
        is_finished: bool,
        error_code: u64,
    }

    struct StartRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        epoch: u64,
        start_timestamp: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        pool_name: 0x1::string::String,
    }

    struct LockRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        epoch: u64,
        lock_timestamp: u64,
        lock_price: u128,
        lock_price_decimals: u64,
        total_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bull_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bear_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        total_user: u64,
        pool_name: 0x1::string::String,
    }

    struct EndRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        epoch: u64,
        close_timestamp: u64,
        close_price: u128,
        close_price_decimals: u64,
        pool_name: 0x1::string::String,
    }

    struct ForceStopRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        epoch: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        total_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bull_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bear_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        total_user: u64,
        pool_name: 0x1::string::String,
        error_code: u64,
    }

    struct UpdatePoolPriceAndTreasuryEvent has copy, drop {
        round_id: 0x2::object::ID,
        bet_coin_symbol: 0x1::string::String,
        bet_coin_price: u128,
        bet_coin_decimals: u64,
        treasury_amount: u64,
        pool_name: 0x1::string::String,
    }

    struct RewardCalculatedEvent has copy, drop {
        round_id: 0x2::object::ID,
        reward_base_cal_value: u128,
        reward_amount: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        pool_name: 0x1::string::String,
    }

    public fun bettable<T0>(arg0: &RoundInfo<T0>, arg1: u64) : bool {
        arg1 > arg0.start_timestamp && arg1 < arg0.lock_timestamp
    }

    public(friend) fun calculate_rewards<T0>(arg0: &mut RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: vector<0x1::string::String>) {
        assert!(arg0.is_finished, 2);
        assert!(!0x2::table::is_empty<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.pool_price), 1);
        if (arg0.is_finished && arg0.error_code == 0) {
            let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(0x1::option::borrow<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.lock_price));
            let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(0x1::option::borrow<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.close_price));
            let v2 = 0;
            if (v1 > v0) {
                while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                    let v3 = 0x1::vector::borrow<0x1::string::String>(&arg2, v2);
                    let v4 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_info<T0>(arg1, *v3);
                    let v5 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_type<T0>(arg1, *v3);
                    if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.bull_amount, &v5)) {
                        arg0.reward_base_cal_value = arg0.reward_base_cal_value + 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::calculate_amount_value(0x2::table::borrow<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.pool_price, v5), v4, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.bull_amount, &v5));
                    };
                    v2 = v2 + 1;
                };
            } else if (v1 < v0) {
                while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                    let v6 = 0x1::vector::borrow<0x1::string::String>(&arg2, v2);
                    let v7 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_info<T0>(arg1, *v6);
                    let v8 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_type<T0>(arg1, *v6);
                    if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.bear_amount, &v8)) {
                        arg0.reward_base_cal_value = arg0.reward_base_cal_value + 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::calculate_amount_value(0x2::table::borrow<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.pool_price, v8), v7, *0x2::vec_map::get<0x1::string::String, u64>(&arg0.bear_amount, &v8));
                    };
                    v2 = v2 + 1;
                };
            };
            v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                let v9 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_type<T0>(arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v2));
                if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.total_amount, &v9)) {
                    let v10 = if (v1 != v0) {
                        *0x2::vec_map::get<0x1::string::String, u64>(&arg0.total_amount, &v9) - *0x2::vec_map::get<0x1::string::String, u64>(&arg0.treasury_amount, &v9)
                    } else {
                        0
                    };
                    0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.reward_amount, v9, v10);
                };
                v2 = v2 + 1;
            };
        };
        let v11 = RewardCalculatedEvent{
            round_id              : 0x2::object::id<RoundInfo<T0>>(arg0),
            reward_base_cal_value : arg0.reward_base_cal_value,
            reward_amount         : arg0.reward_amount,
            pool_name             : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg1),
        };
        0x2::event::emit<RewardCalculatedEvent>(v11);
    }

    public fun close_price_value<T0>(arg0: &RoundInfo<T0>) : u128 {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(0x1::option::borrow<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.close_price))
    }

    public fun close_timestamp<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.close_timestamp
    }

    public fun contains_reward<T0>(arg0: &RoundInfo<T0>, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.reward_amount, &arg1)
    }

    public(friend) fun end_round<T0>(arg0: &mut RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo, arg3: u64) {
        arg0.close_timestamp = arg3;
        arg0.close_price = 0x1::option::some<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(arg2);
        arg0.is_finished = true;
        let v0 = EndRoundEvent{
            round_id             : 0x2::object::id<RoundInfo<T0>>(arg0),
            epoch                : arg0.epoch,
            close_timestamp      : arg0.close_timestamp,
            close_price          : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(&arg2),
            close_price_decimals : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price_decimals(&arg2),
            pool_name            : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg1),
        };
        0x2::event::emit<EndRoundEvent>(v0);
    }

    public fun error_code<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.error_code
    }

    public(friend) fun force_stop_round<T0>(arg0: &mut RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: u64) {
        arg0.is_finished = true;
        arg0.error_code = arg2;
        let v0 = ForceStopRoundEvent{
            round_id        : 0x2::object::id<RoundInfo<T0>>(arg0),
            epoch           : arg0.epoch,
            lock_timestamp  : arg0.lock_timestamp,
            close_timestamp : arg0.close_timestamp,
            total_amount    : arg0.total_amount,
            bull_amount     : arg0.bull_amount,
            bear_amount     : arg0.bear_amount,
            total_user      : 0x2::table::length<u64, address>(&arg0.users_bet),
            pool_name       : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg1),
            error_code      : arg2,
        };
        0x2::event::emit<ForceStopRoundEvent>(v0);
    }

    public fun is_finished<T0>(arg0: &RoundInfo<T0>) : bool {
        arg0.is_finished
    }

    public fun lock_price_value<T0>(arg0: &RoundInfo<T0>) : u128 {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(0x1::option::borrow<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.lock_price))
    }

    public(friend) fun lock_round<T0>(arg0: &mut RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo, arg4: u64) {
        arg0.lock_timestamp = arg4;
        arg0.close_timestamp = arg4 + 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::interval_ms<T0>(arg1);
        arg0.lock_price = 0x1::option::some<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(arg3);
        let v0 = LockRoundEvent{
            round_id            : 0x2::object::id<RoundInfo<T0>>(arg0),
            epoch               : arg0.epoch,
            lock_timestamp      : arg0.lock_timestamp,
            lock_price          : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(&arg3),
            lock_price_decimals : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price_decimals(&arg3),
            total_amount        : arg0.total_amount,
            bull_amount         : arg0.bull_amount,
            bear_amount         : arg0.bear_amount,
            total_user          : 0x2::table::length<u64, address>(&arg0.users_bet),
            pool_name           : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg2),
        };
        0x2::event::emit<LockRoundEvent>(v0);
    }

    public fun lock_timestamp<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.lock_timestamp
    }

    public(friend) fun new_round_key<T0>(arg0: u64) : RoundKey<T0> {
        RoundKey<T0>{epoch: arg0}
    }

    public fun pool_price<T0>(arg0: &RoundInfo<T0>, arg1: 0x1::string::String) : &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo {
        0x2::table::borrow<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.pool_price, arg1)
    }

    public fun reward_amount<T0>(arg0: &RoundInfo<T0>, arg1: 0x1::string::String) : u64 {
        *0x2::vec_map::get<0x1::string::String, u64>(&arg0.reward_amount, &arg1)
    }

    public fun reward_base_cal_value<T0>(arg0: &RoundInfo<T0>) : u128 {
        arg0.reward_base_cal_value
    }

    public(friend) fun start_new_round<T0>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : RoundInfo<T0> {
        let v0 = RoundInfo<T0>{
            id                    : 0x2::object::new(arg4),
            epoch                 : arg2,
            start_timestamp       : arg3,
            lock_timestamp        : arg3 + 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::interval_ms<T0>(arg0),
            close_timestamp       : arg3 + 2 * 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::interval_ms<T0>(arg0),
            lock_price            : 0x1::option::none<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(),
            close_price           : 0x1::option::none<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(),
            total_amount          : 0x2::vec_map::empty<0x1::string::String, u64>(),
            bull_amount           : 0x2::vec_map::empty<0x1::string::String, u64>(),
            bear_amount           : 0x2::vec_map::empty<0x1::string::String, u64>(),
            pool_price            : 0x2::table::new<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(arg4),
            treasury_amount       : 0x2::vec_map::empty<0x1::string::String, u64>(),
            reward_base_cal_value : 0,
            reward_amount         : 0x2::vec_map::empty<0x1::string::String, u64>(),
            users_bet             : 0x2::table::new<u64, address>(arg4),
            is_finished           : false,
            error_code            : 0,
        };
        let v1 = StartRoundEvent{
            round_id        : 0x2::object::id<RoundInfo<T0>>(&v0),
            epoch           : arg2,
            start_timestamp : v0.start_timestamp,
            lock_timestamp  : v0.lock_timestamp,
            close_timestamp : v0.close_timestamp,
            pool_name       : arg1,
        };
        0x2::event::emit<StartRoundEvent>(v1);
        v0
    }

    public(friend) fun update_bet_amount<T0>(arg0: &mut RoundInfo<T0>, arg1: u64, arg2: 0x1::string::String, arg3: u8, arg4: address) {
        0x2::table::add<u64, address>(&mut arg0.users_bet, 0x2::table::length<u64, address>(&arg0.users_bet), arg4);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&arg0.total_amount, &arg2)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.total_amount, arg2, arg1);
        } else {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.total_amount, &arg2);
            *v0 = *v0 + arg1;
        };
        if (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::is_bull_position(arg3)) {
            if (!0x2::vec_map::contains<0x1::string::String, u64>(&arg0.bull_amount, &arg2)) {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.bull_amount, arg2, arg1);
            } else {
                let v1 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.bull_amount, &arg2);
                *v1 = *v1 + arg1;
            };
        } else if (!0x2::vec_map::contains<0x1::string::String, u64>(&arg0.bear_amount, &arg2)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.bear_amount, arg2, arg1);
        } else {
            let v2 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.bear_amount, &arg2);
            *v2 = *v2 + arg1;
        };
    }

    public(friend) fun update_pool_price_and_treasury<T0>(arg0: &mut RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: 0x1::string::String, arg4: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo) : u64 {
        let v0 = 0;
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_type<T0>(arg2, arg3);
        assert!(arg0.is_finished, 2);
        assert!(!0x2::table::contains<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.pool_price, v1), 3);
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.total_amount, &v1)) {
            if (zero_winner<T0>(arg0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(0x1::option::borrow<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.lock_price)), 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(0x1::option::borrow<0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&arg0.close_price)))) {
                v0 = *0x2::vec_map::get<0x1::string::String, u64>(&arg0.total_amount, &v1);
            } else {
                v0 = (((*0x2::vec_map::get<0x1::string::String, u64>(&arg0.total_amount, &v1) as u128) * (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::treasury_fee_bps<T0>(arg1) as u128) / 10000) as u64);
            };
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.treasury_amount, v1, v0);
        };
        0x2::table::add<0x1::string::String, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo>(&mut arg0.pool_price, v1, arg4);
        let v2 = UpdatePoolPriceAndTreasuryEvent{
            round_id          : 0x2::object::id<RoundInfo<T0>>(arg0),
            bet_coin_symbol   : arg3,
            bet_coin_price    : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price(&arg4),
            bet_coin_decimals : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::price_decimals(&arg4),
            treasury_amount   : v0,
            pool_name         : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg2),
        };
        0x2::event::emit<UpdatePoolPriceAndTreasuryEvent>(v2);
        v0
    }

    fun zero_winner<T0>(arg0: &RoundInfo<T0>, arg1: u128, arg2: u128) : bool {
        arg1 < arg2 && 0x2::vec_map::is_empty<0x1::string::String, u64>(&arg0.bull_amount) || arg1 > arg2 && 0x2::vec_map::is_empty<0x1::string::String, u64>(&arg0.bear_amount) || arg2 == arg1
    }

    // decompiled from Move bytecode v6
}

