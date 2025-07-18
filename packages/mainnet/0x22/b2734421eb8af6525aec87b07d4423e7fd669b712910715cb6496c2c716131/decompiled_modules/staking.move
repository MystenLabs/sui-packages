module 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::staking {
    struct StakeConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        tge_time: u64,
        ratio_base_18: u64,
        max_stake_limit: u64,
        total_staked: u64,
    }

    public fun change_ratio(arg0: &0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::admin::AdminCap, arg1: &mut StakeConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.ratio_base_18 = arg2;
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = take_percent_base_18(1000000000, arg2);
        assert!(v1 > 0, 5001);
        let v2 = take_percent_base_18(1000000000, arg1.ratio_base_18) * (v0 - arg1.tge_time) / 31536000000 * 31536000000 / v1;
        assert!(v2 <= v0, 5002);
        arg1.tge_time = v0 - v2;
    }

    public fun change_stake_config(arg0: &0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::admin::AdminCap, arg1: &mut StakeConfig, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>, arg5: &mut 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.tge_time = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.ratio_base_18 = 0x1::option::extract<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(arg5)) {
            arg1.max_stake_limit = 0x1::option::extract<u64>(arg5);
        };
    }

    fun check_version(arg0: &StakeConfig) {
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::version::check_version(arg0.version);
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : StakeConfig {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        StakeConfig{
            id              : 0x2::object::new(arg1),
            version         : 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::version::current_version(),
            tge_time        : 1746057600000,
            ratio_base_18   : 100000000000000000,
            max_stake_limit : 1000000000000000,
            total_staked    : 0,
        }
    }

    public fun stake(arg0: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::CUSDCTreasuryCoinfig, arg1: &mut StakeConfig, arg2: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::Treasury, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::CUSDC> {
        check_version(arg1);
        let v0 = (((0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) as u128) * 1000000000 / (1000000000 + ((take_percent_base_18(1000000000, arg1.ratio_base_18) * (0x2::clock::timestamp_ms(arg4) - arg1.tge_time) / 31536000000) as u128))) as u64);
        arg1.total_staked = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) + arg1.total_staked;
        assert!(arg1.total_staked <= arg1.max_stake_limit, 0);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg3);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::events::emit_stake_event(v0, arg5);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::mint_csui(arg0, v0, arg5)
    }

    public fun take_percent_base_18(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000000000000) as u64)
    }

    public fun unstake(arg0: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::CUSDCTreasuryCoinfig, arg1: &mut StakeConfig, arg2: &mut 0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::Treasury, arg3: 0x2::coin::Coin<0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::CUSDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        check_version(arg1);
        let v0 = (((0x2::coin::value<0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::CUSDC>(&arg3) as u128) * (1000000000 + ((take_percent_base_18(1000000000, arg1.ratio_base_18) * (0x2::clock::timestamp_ms(arg4) - arg1.tge_time) / 31536000000) as u128)) / 1000000000) as u64);
        assert!(arg1.total_staked >= v0, 0);
        arg1.total_staked = arg1.total_staked - v0;
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::cusdc::burn_csui(arg0, arg3);
        0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::events::emit_unstake_event(v0, arg5);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x22b2734421eb8af6525aec87b07d4423e7fd669b712910715cb6496c2c716131::treasury::borrow_from_treasury<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2), v0), arg5)
    }

    // decompiled from Move bytecode v6
}

