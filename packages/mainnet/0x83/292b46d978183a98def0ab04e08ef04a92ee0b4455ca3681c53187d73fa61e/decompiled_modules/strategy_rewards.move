module 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_rewards {
    struct RewardCfgKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardBalKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardConfig has copy, drop, store {
        enabled: bool,
        feed_id: vector<u8>,
        decimals: u8,
        value_mult_bps: u64,
        max_slippage_bps: u64,
        max_age_ms: u64,
        min_price_e9: u64,
    }

    struct RewardSwap<phantom T0> {
        vault: 0x2::object::ID,
        amount: u64,
        min_out: u64,
    }

    struct RewardConfigSet has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        enabled: bool,
        feed_id: vector<u8>,
        decimals: u8,
        value_mult_bps: u64,
        max_slippage_bps: u64,
        max_age_ms: u64,
        min_price_e9: u64,
    }

    struct RewardClaimed has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        reserve_id: u64,
        reward_index: u64,
        is_deposit: bool,
        amount: u64,
        held: u64,
    }

    struct RewardSwapped has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
        min_out: u64,
        usdc_in: u64,
        to_buffer: bool,
    }

    public fun begin_reward_swap<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u64, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, RewardSwap<T3>) {
        let v0 = swap_gate<T0, T1, T2, T3>(arg0, arg1, arg2);
        assert!(!0x1::vector::is_empty<u8>(&v0.feed_id), 605);
        let v1 = pyth_min_out(&v0, arg2, arg3, 0x2::clock::timestamp_ms(arg4));
        let v2 = floor_min_out(&v0, arg2);
        let v3 = if (v1 > v2) {
            v1
        } else {
            v2
        };
        take_for_swap<T0, T1, T2, T3>(arg0, arg2, v3, arg5)
    }

    public fun begin_reward_swap_floor<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, RewardSwap<T3>) {
        let v0 = swap_gate<T0, T1, T2, T3>(arg0, arg1, arg2);
        assert!(0x1::vector::is_empty<u8>(&v0.feed_id) && v0.min_price_e9 > 0, 605);
        take_for_swap<T0, T1, T2, T3>(arg0, arg2, floor_min_out(&v0, arg2), arg3)
    }

    public fun claim_suilend_reward<T0, T1, T2, T3, T4>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T1, T2, T3>(arg0, arg1);
        assert!(is_enabled<T1, T2, T3, T4>(arg0), 600);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T4>(arg2, 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::strategy_suilend::obligation_cap<T0, T1, T2, T3>(arg0), arg6, arg3, arg4, arg5, arg7);
        let v1 = 0x2::coin::value<T4>(&v0);
        let v2 = join_held<T1, T2, T3, T4>(arg0, 0x2::coin::into_balance<T4>(v0));
        let v3 = RewardClaimed{
            vault        : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T1, T2, T3>>(arg0),
            reward       : 0x1::type_name::with_defining_ids<T4>(),
            reserve_id   : arg3,
            reward_index : arg4,
            is_deposit   : arg5,
            amount       : v1,
            held         : v2,
        };
        0x2::event::emit<RewardClaimed>(v3);
        v1
    }

    fun config<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : RewardConfig {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0);
        let v1 = RewardCfgKey<T3>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RewardCfgKey<T3>>(v0, v1), 600);
        let v2 = RewardCfgKey<T3>{dummy_field: false};
        *0x2::dynamic_field::borrow<RewardCfgKey<T3>, RewardConfig>(v0, v2)
    }

    public fun finish_reward_swap<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: 0x2::coin::Coin<T0>, arg3: RewardSwap<T3>) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T0, T1, T2>(arg0, arg1);
        let RewardSwap {
            vault   : v0,
            amount  : v1,
            min_out : v2,
        } = arg3;
        assert!(v0 == 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0), 610);
        assert!(!0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::is_op_open<T0, T1, T2>(arg0), 603);
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 >= v2, 609);
        let v4 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::is_derisk<T0, T1, T2>(arg0);
        if (v4) {
            0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_buffer<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(arg2));
        } else {
            0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::put_pending<T0, T1, T2>(arg0, 0x2::coin::into_balance<T0>(arg2));
        };
        let v5 = RewardSwapped{
            vault     : v0,
            reward    : 0x1::type_name::with_defining_ids<T3>(),
            amount    : v1,
            min_out   : v2,
            usdc_in   : v3,
            to_buffer : v4,
        };
        0x2::event::emit<RewardSwapped>(v5);
    }

    fun floor_min_out(arg0: &RewardConfig, arg1: u64) : u64 {
        to_u64((arg1 as u256) * (arg0.min_price_e9 as u256) / pow10((arg0.decimals as u64)) * 1000000000)
    }

    public fun is_enabled<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : bool {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0);
        let v1 = RewardCfgKey<T3>{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardCfgKey<T3>>(v0, v1)) {
            let v3 = RewardCfgKey<T3>{dummy_field: false};
            0x2::dynamic_field::borrow<RewardCfgKey<T3>, RewardConfig>(v0, v3).enabled
        } else {
            false
        }
    }

    fun join_held<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: 0x2::balance::Balance<T3>) : u64 {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0);
        let v1 = RewardBalKey<T3>{dummy_field: false};
        if (!0x2::dynamic_field::exists<RewardBalKey<T3>>(v0, v1)) {
            let v2 = RewardBalKey<T3>{dummy_field: false};
            0x2::dynamic_field::add<RewardBalKey<T3>, 0x2::balance::Balance<T3>>(v0, v2, 0x2::balance::zero<T3>());
        };
        let v3 = RewardBalKey<T3>{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<RewardBalKey<T3>, 0x2::balance::Balance<T3>>(v0, v3);
        0x2::balance::join<T3>(v4, arg1);
        0x2::balance::value<T3>(v4)
    }

    fun pow10(arg0: u64) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun pyth_min_out(arg0: &RewardConfig, arg1: u64, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: u64) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price_identifier(v1);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2) == arg0.feed_id, 606);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(v1);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v3) * 1000 + arg0.max_age_ms >= arg3, 607);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v3);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4), 608);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v3);
        assert!(v5 > 0 && (v6 as u128) * (10000 as u128) <= (v5 as u128) * (200 as u128), 608);
        let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v3);
        let v8 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v7);
        let v9 = if (v8) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v7)
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v7)
        };
        assert!(v9 <= 30, 608);
        let v10 = if (v8) {
            0
        } else {
            v9
        };
        let v11 = if (v8) {
            v9
        } else {
            0
        };
        to_u64((arg1 as u256) * ((v5 - v6) as u256) * (arg0.value_mult_bps as u256) * ((10000 - arg0.max_slippage_bps) as u256) * pow10(6 + v10) / (10000 as u256) * (10000 as u256) * pow10((arg0.decimals as u64) + v11))
    }

    public fun quote_min_out<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: u64, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) : u64 {
        let v0 = config<T0, T1, T2, T3>(arg0);
        let v1 = pyth_min_out(&v0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        let v2 = floor_min_out(&v0, arg1);
        if (v1 > v2) {
            v1
        } else {
            v2
        }
    }

    public fun reward_balance<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : u64 {
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid<T0, T1, T2>(arg0);
        let v1 = RewardBalKey<T3>{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardBalKey<T3>>(v0, v1)) {
            let v3 = RewardBalKey<T3>{dummy_field: false};
            0x2::balance::value<T3>(0x2::dynamic_field::borrow<RewardBalKey<T3>, 0x2::balance::Balance<T3>>(v0, v3))
        } else {
            0
        }
    }

    public fun reward_config<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>) : (bool, vector<u8>, u8, u64, u64, u64, u64) {
        let v0 = config<T0, T1, T2, T3>(arg0);
        (v0.enabled, v0.feed_id, v0.decimals, v0.value_mult_bps, v0.max_slippage_bps, v0.max_age_ms, v0.min_price_e9)
    }

    public fun set_reward_config<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::AdminCap, arg2: bool, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_version<T0, T1, T2>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        let v1 = if (v0 != 0x1::type_name::with_defining_ids<T0>()) {
            if (v0 != 0x1::type_name::with_defining_ids<T1>()) {
                v0 != 0x1::type_name::with_defining_ids<T2>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 612);
        assert!(0x1::vector::is_empty<u8>(&arg3) || 0x1::vector::length<u8>(&arg3) == 32, 601);
        assert!(arg4 <= 18, 601);
        assert!(arg5 >= 5000 && arg5 <= 15000, 601);
        assert!(arg6 <= 500, 601);
        assert!(arg7 <= 600000, 601);
        assert!(0x1::vector::is_empty<u8>(&arg3) || arg7 > 0, 601);
        let v2 = RewardConfig{
            enabled          : arg2,
            feed_id          : arg3,
            decimals         : arg4,
            value_mult_bps   : arg5,
            max_slippage_bps : arg6,
            max_age_ms       : arg7,
            min_price_e9     : arg8,
        };
        let v3 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0);
        let v4 = RewardCfgKey<T3>{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardCfgKey<T3>>(v3, v4)) {
            let v5 = RewardCfgKey<T3>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<RewardCfgKey<T3>, RewardConfig>(v3, v5) = v2;
        } else {
            let v6 = RewardCfgKey<T3>{dummy_field: false};
            0x2::dynamic_field::add<RewardCfgKey<T3>, RewardConfig>(v3, v6, v2);
        };
        let v7 = RewardConfigSet{
            vault            : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0),
            reward           : v0,
            enabled          : arg2,
            feed_id          : v2.feed_id,
            decimals         : arg4,
            value_mult_bps   : arg5,
            max_slippage_bps : arg6,
            max_age_ms       : arg7,
            min_price_e9     : arg8,
        };
        0x2::event::emit<RewardConfigSet>(v7);
    }

    fun swap_gate<T0, T1, T2, T3>(arg0: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: &0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::KeeperCap, arg2: u64) : RewardConfig {
        0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::assert_keeper<T0, T1, T2>(arg0, arg1);
        assert!(!0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::is_paused<T0, T1, T2>(arg0), 602);
        assert!(!0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::is_op_open<T0, T1, T2>(arg0), 603);
        assert!(arg2 > 0, 604);
        let v0 = config<T0, T1, T2, T3>(arg0);
        assert!(v0.enabled, 600);
        v0
    }

    fun take_for_swap<T0, T1, T2, T3>(arg0: &mut 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, RewardSwap<T3>) {
        assert!(arg2 > 0, 604);
        let v0 = 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::uid_mut<T0, T1, T2>(arg0);
        let v1 = RewardBalKey<T3>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RewardBalKey<T3>>(v0, v1), 611);
        let v2 = RewardBalKey<T3>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<RewardBalKey<T3>, 0x2::balance::Balance<T3>>(v0, v2);
        assert!(0x2::balance::value<T3>(v3) >= arg1, 611);
        let v4 = RewardSwap<T3>{
            vault   : 0x2::object::id<0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault::LoopVault<T0, T1, T2>>(arg0),
            amount  : arg1,
            min_out : arg2,
        };
        (0x2::coin::from_balance<T3>(0x2::balance::split<T3>(v3, arg1), arg3), v4)
    }

    fun to_u64(arg0: u256) : u64 {
        let v0 = 18446744073709551615;
        let v1 = if (arg0 > v0) {
            v0
        } else {
            arg0
        };
        (v1 as u64)
    }

    // decompiled from Move bytecode v7
}

