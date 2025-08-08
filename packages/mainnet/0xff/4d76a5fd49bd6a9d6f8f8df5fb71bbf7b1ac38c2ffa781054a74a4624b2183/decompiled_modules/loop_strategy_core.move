module 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_core {
    struct Strategy has store, key {
        id: 0x2::object::UID,
        version: u64,
        initial_hasui_total_staked: u64,
        total_vsui_reward: u64,
        buffer_pool_vault: 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::Vault<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        deposit_fee_vault: 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::Vault<0x2::sui::SUI>,
        performance_fee_vault: 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::Vault<0x2::sui::SUI>,
        deposit_fee: u64,
        performance_fee: u64,
        lp_cap: 0x2::coin::TreasuryCap<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>,
        pause_deposit: bool,
        pause_withdraw: bool,
        naviConfig: 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::NaviConfig,
    }

    struct VersionUpdated has copy, drop {
        old: u64,
        new: u64,
    }

    struct DepositLoopEvent has copy, drop {
        owner: address,
        principal: u128,
        hasui_amount: u128,
        mint_lp_amount: u128,
        deposit_fee: u64,
    }

    struct DepositBufferEvent has copy, drop {
        hasui_amount: u128,
        sui_amount: u128,
    }

    struct DoDepositEvent has copy, drop {
        owner: address,
        hasui_supply_amount: u64,
        sui_borrow_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        owner: address,
        user_amount: u64,
        user_ratio: u64,
        debt: u64,
        collateral: u64,
        pool_hasui: u64,
    }

    struct DoWithdrawEvent has copy, drop {
        owner: address,
        repay_sui: u64,
        withdraw_hasui: u64,
        check_hf: bool,
    }

    struct DoEquilibrateEvent has copy, drop {
        eq_sui_amount: u128,
        repay_sui: u64,
        eq_hasui_amount: u128,
        hf_new: u256,
    }

    struct ReinvestmentEvent has copy, drop {
        reward: u64,
        reward_sui: u64,
        supply_hasui: u64,
    }

    public(friend) fun assert_version(arg0: &Strategy) {
        assert!(arg0.version == 0, 1);
    }

    public fun buffer_pool_check(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_pool_supply_borrow(arg1, &arg0.naviConfig);
        let v2 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_supply_cap(arg1, &arg0.naviConfig);
        let v3 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_borrow_cap(arg1, &arg0.naviConfig);
        let v4 = ((v2 - (v0 as u256)) as u128);
        let v5 = v4;
        let v6 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::withdraw_all<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.buffer_pool_vault);
        let v7 = (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v6) as u128);
        if (v4 > v7) {
            v5 = v7;
        };
        let (v8, v9, _, _) = pre_calulate_health_factor(arg0, arg1, arg8, v0, v1, v5);
        assert!(((v1 + v9) as u128) <= (v3 as u128), 7);
        assert!(((v0 + v8) as u128) <= (v2 as u128), 8);
        let v12 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v6, arg11);
        do_deposit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v12, arg9, arg10, (v9 as u64), arg11);
        let v13 = DepositBufferEvent{
            hasui_amount : v7,
            sui_amount   : v9,
        };
        0x2::event::emit<DepositBufferEvent>(v13);
    }

    public fun deposit_and_loop_sui(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT> {
        let v0 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::stake_sui(arg13, arg11, arg12, arg15);
        deposit_loop_coin(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, v0, arg13, arg14, arg15)
    }

    public fun deposit_loop_coin(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg13: &mut 0x3::sui_system::SuiSystemState, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT> {
        assert!(arg0.pause_deposit, 5);
        let v0 = 0x2::coin::into_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg12);
        let (v1, v2) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_pool_supply_borrow(arg1, &arg0.naviConfig);
        assert!(10000 > 0, 2);
        let v3 = (((0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0) as u128) * (arg0.deposit_fee as u128) / (10000 as u128)) as u64);
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::deposit<0x2::sui::SUI>(&mut arg0.deposit_fee_vault, 0x2::coin::into_balance<0x2::sui::SUI>(0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::cetus_section::swap_hasui_sui(arg8, arg9, arg10, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v0, v3), arg15), arg14, arg15)));
        let (v4, v5, v6, v7) = pre_calulate_health_factor(arg0, arg1, arg11, v1, v2, (0x2::balance::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v0) as u128));
        assert!(((v2 + v5) as u128) <= (0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_borrow_cap(arg1, &arg0.naviConfig) as u128), 7);
        if (((v1 + v4) as u128) > (0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_supply_cap(arg1, &arg0.naviConfig) as u128)) {
            0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::deposit<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.buffer_pool_vault, v0);
        } else {
            let v8 = 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v0, arg15);
            do_deposit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg11, v8, arg13, arg14, (v5 as u64), arg15);
        };
        let v9 = DepositLoopEvent{
            owner          : 0x2::tx_context::sender(arg15),
            principal      : v6,
            hasui_amount   : v4,
            mint_lp_amount : v7,
            deposit_fee    : v3,
        };
        0x2::event::emit<DepositLoopEvent>(v9);
        0x2::coin::mint<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>(&mut arg0.lp_cap, (v7 as u64), arg15)
    }

    fun do_deposit(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg9: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_loan_sui(arg6, arg3, arg12, &arg0.naviConfig);
        let v2 = v1;
        let v3 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::stake_sui(arg10, arg8, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg13), arg13);
        0x2::coin::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v3, arg9);
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::supply_hasui(arg11, arg1, arg2, v3, arg4, arg5, &arg0.naviConfig);
        let v4 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::borrow_sui(arg11, arg7, arg1, arg3, arg12, arg4, arg5, &arg0.naviConfig);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::withdraw<0x2::sui::SUI>(&mut arg0.deposit_fee_vault, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_loan_fee<0x2::sui::SUI>(&v2)));
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::deposit<0x2::sui::SUI>(&mut arg0.deposit_fee_vault, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_repay_sui(arg11, arg1, arg3, v2, 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg13), &arg0.naviConfig));
        let v5 = DoDepositEvent{
            owner               : 0x2::tx_context::sender(arg13),
            hasui_supply_amount : 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v3),
            sui_borrow_amount   : arg12,
        };
        0x2::event::emit<DoDepositEvent>(v5);
    }

    fun do_equilibrate(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_pool_supply_borrow(arg1, &arg0.naviConfig);
        let v2 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::get_hasui_rate(arg11);
        let (v3, v4) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_limit_data(&arg0.naviConfig);
        assert!(v2 > 0, 2);
        assert!(v4 > 0, 2);
        assert!(1000000 > 0, 2);
        let v5 = (v2 as u128);
        let v6 = (v3 as u128);
        assert!(v5 <= 340282366920938463463374607431768211455 / v6, 2);
        let v7 = v5 * v6;
        assert!(v0 <= 340282366920938463463374607431768211455 / v7, 2);
        let v8 = v0 * v7 / (1000000 as u128) / (v4 as u128);
        assert!(v8 <= v1, 2);
        let v9 = v1 - v8;
        let (v10, v11) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_loan_sui(arg6, arg3, (v9 as u64), &arg0.naviConfig);
        let v12 = v11;
        let v13 = v10;
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::deposit<0x2::sui::SUI>(&mut arg0.performance_fee_vault, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::repay_sui(arg13, arg7, arg1, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v13, arg14), arg4, arg5, &arg0.naviConfig));
        let v14 = if (v5 == 0) {
            0
        } else {
            v9 / v5
        };
        let v15 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_vault_health_factor(arg13, arg1, arg7, &arg0.naviConfig);
        let (_, v17) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_min_data(&arg0.naviConfig);
        assert!(v15 > (v17 as u256), 10);
        let v18 = 0x2::coin::into_balance<0x2::sui::SUI>(0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::cetus_section::swap_hasui_sui(arg8, arg9, arg10, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::withdraw_hasui(arg13, arg7, arg1, arg2, (v14 as u64), arg4, arg5, &arg0.naviConfig), arg14), arg13, arg14));
        0x2::balance::join<0x2::sui::SUI>(&mut v18, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::withdraw<0x2::sui::SUI>(&mut arg0.performance_fee_vault, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_loan_fee<0x2::sui::SUI>(&v12)));
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::supply_hasui(arg13, arg1, arg2, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::stake_sui(arg12, arg11, 0x2::coin::from_balance<0x2::sui::SUI>(0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_repay_sui(arg13, arg1, arg3, v12, 0x2::coin::from_balance<0x2::sui::SUI>(v18, arg14), &arg0.naviConfig), arg14), arg14), arg4, arg5, &arg0.naviConfig);
        let v19 = DoEquilibrateEvent{
            eq_sui_amount   : v9,
            repay_sui       : 0x2::balance::value<0x2::sui::SUI>(&v13),
            eq_hasui_amount : v14,
            hf_new          : v15,
        };
        0x2::event::emit<DoEquilibrateEvent>(v19);
    }

    fun do_withdraw_buffer(arg0: &mut Strategy, arg1: u64) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        let v0 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::vault_amount<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg0.buffer_pool_vault);
        assert!(v0 > 0 && v0 >= arg1, 9);
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::withdraw<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut arg0.buffer_pool_vault, arg1)
    }

    fun do_withdraw_navi(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        let (v0, v1) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_loan_sui(arg6, arg3, arg13, &arg0.naviConfig);
        let v2 = v1;
        let v3 = v0;
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::deposit<0x2::sui::SUI>(&mut arg0.deposit_fee_vault, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::repay_sui(arg15, arg7, arg1, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg16), arg4, arg5, &arg0.naviConfig));
        let v4 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::withdraw_hasui(arg15, arg7, arg1, arg2, arg14, arg4, arg5, &arg0.naviConfig);
        let v5 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_repay_sui(arg15, arg1, arg3, v2, 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::cetus_section::swap_hasui_sui(arg8, arg9, arg10, 0x2::coin::from_balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(0x2::balance::split<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v4, ((((arg13 + 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::flash_loan_fee<0x2::sui::SUI>(&v2)) as u128) * (1000000 as u128) / (0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::get_hasui_rate(arg11) as u128)) as u64)), arg16), arg15, arg16), &arg0.naviConfig);
        let v6 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::check_min_hf(arg15, arg1, arg7, &arg0.naviConfig);
        if (v6) {
            do_equilibrate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15, arg16);
        };
        let v7 = DoWithdrawEvent{
            owner          : 0x2::tx_context::sender(arg16),
            repay_sui      : 0x2::balance::value<0x2::sui::SUI>(&v3),
            withdraw_hasui : arg14,
            check_hf       : v6,
        };
        0x2::event::emit<DoWithdrawEvent>(v7);
        (v5, v4)
    }

    public fun equilibrate(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_vault_health_factor(arg13, arg1, arg7, &arg0.naviConfig);
        assert!(v0 > 0, 3);
        let (_, v2) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_min_data(&arg0.naviConfig);
        assert!(v0 < (v2 as u256), 4);
        do_equilibrate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    public fun get_config_mut(arg0: &mut Strategy) : &mut 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::NaviConfig {
        assert_version(arg0);
        &mut arg0.naviConfig
    }

    public fun get_initial_hasui_total_staked(arg0: &Strategy) : u64 {
        arg0.initial_hasui_total_staked
    }

    public fun get_lp_total_supply(arg0: &Strategy) : u64 {
        0x2::coin::total_supply<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>(&arg0.lp_cap)
    }

    public fun get_now_hasui_total_staked(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &Strategy, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        let (v0, v1) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_pool_supply_borrow(arg0, &arg1.naviConfig);
        let v2 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::get_hasui_rate(arg2);
        assert!(1000000 > 0, 2);
        let v3 = if (v2 == 0) {
            0
        } else {
            assert!(v1 <= 340282366920938463463374607431768211455 / (v2 as u128), 2);
            (v1 as u128) * (v2 as u128) / (1000000 as u128)
        };
        let v4 = (v0 as u128);
        if (v4 >= v3) {
            ((v4 - v3) as u64)
        } else {
            0
        }
    }

    public fun get_total_vsui_reward(arg0: &Strategy) : u64 {
        arg0.total_vsui_reward
    }

    public(friend) fun initialize(arg0: 0x2::coin::TreasuryCap<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategy{
            id                         : 0x2::object::new(arg1),
            version                    : 0,
            initial_hasui_total_staked : 0,
            total_vsui_reward          : 0,
            buffer_pool_vault          : 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::new<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg1),
            deposit_fee_vault          : 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::new<0x2::sui::SUI>(arg1),
            performance_fee_vault      : 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::new<0x2::sui::SUI>(arg1),
            deposit_fee                : 38,
            performance_fee            : 2000,
            lp_cap                     : arg0,
            pause_deposit              : true,
            pause_withdraw             : true,
            naviConfig                 : 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::new_navi(arg1),
        };
        0x2::transfer::share_object<Strategy>(v0);
    }

    public(friend) fun migrate(arg0: &mut Strategy) {
        assert!(arg0.version < 0, 1);
        let v0 = VersionUpdated{
            old : arg0.version,
            new : 0,
        };
        0x2::event::emit<VersionUpdated>(v0);
        arg0.version = 0;
    }

    fun pre_calulate_health_factor(arg0: &Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg3: u128, arg4: u128, arg5: u128) : (u128, u128, u128, u128) {
        assert!(arg5 > 0, 22);
        let v0 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_lending_liquidation_factors(arg1, &arg0.naviConfig);
        let (v1, v2, v3, v4, v5) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_hf_ltv(&arg0.naviConfig);
        let v6 = (0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::get_hasui_rate(arg2) as u128);
        assert!(v6 > 0, 33);
        assert!(v0 > 0, 44);
        let v7 = 0;
        let v8 = arg5;
        let v9 = 0;
        while (v7 < v5) {
            let v10 = arg3 + v8;
            let v11 = arg4 + v9;
            let v12 = if (v11 == 0) {
                (v3 as u128) + 1
            } else {
                assert!(v10 <= 340282366920938463463374607431768211455 / v0, 55);
                assert!(v11 <= 340282366920938463463374607431768211455 / v6, 66);
                let v13 = (((v11 as u256) * (v6 as u256)) as u128) / (1000000 as u128);
                if (v13 == 0) {
                    (v3 as u128) + 1
                } else {
                    (((v10 as u256) * (v0 as u256)) as u128) / v13
                }
            };
            let v14 = 0;
            if (v12 > 0 && v12 < (v4 as u128)) {
                break
            };
            if (v12 >= (v3 as u128) || v12 == 0) {
                v14 = (v1 as u128);
            } else if (v12 >= (v4 as u128) && v12 < (v3 as u128)) {
                v14 = (v2 as u128);
            };
            if (v14 > 0) {
                assert!(v14 <= 340282366920938463463374607431768211455 / (1000000 as u128), 77);
                assert!(v8 <= 340282366920938463463374607431768211455 / v14 * (1000000 as u128), 88);
            };
            let v15 = if (v6 == 0) {
                0
            } else {
                v8 * v14 * v6 / (1000000 as u128)
            };
            v9 = v15;
            let v16 = v15 * v6;
            assert!(arg5 <= 340282366920938463463374607431768211455 - v16, 99);
            v8 = arg5 + v16 / (1000000 as u128);
            v7 = v7 + 1;
        };
        let v17 = if (v6 == 0) {
            0
        } else {
            assert!(arg5 <= 340282366920938463463374607431768211455 / v6, 111);
            arg5 * v6 / (1000000 as u128)
        };
        (v8, v9, arg5, v17)
    }

    public(friend) fun reinvestment(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, 0x2::sui::SUI>, arg9: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_rewards(arg11, arg1, arg4, &arg0.naviConfig);
        let v2 = v0;
        assert!(0x1::vector::length<0x1::ascii::String>(&v2) > 0 && v1 > 0, 11);
        let v3 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::claim_reward_cert(arg11, arg1, arg4, arg5, &arg0.naviConfig);
        let v4 = 0x2::balance::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v3);
        let v5 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::cetus_section::swap_vsui_sui(arg6, arg7, arg8, 0x2::coin::from_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v3, arg12), arg11, arg12);
        assert!(10000 > 0, 2);
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::loop_strategy_vault::deposit<0x2::sui::SUI>(&mut arg0.performance_fee_vault, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v5, ((((0x2::coin::value<0x2::sui::SUI>(&v5) as u128) * (arg0.performance_fee as u128) / (10000 as u128)) as u64) as u64), arg12)));
        let v6 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::haedal_section::stake_sui(arg10, arg9, v5, arg12);
        arg0.total_vsui_reward = arg0.total_vsui_reward + v4;
        let v7 = ReinvestmentEvent{
            reward       : v4,
            reward_sui   : 0x2::coin::value<0x2::sui::SUI>(&v5),
            supply_hasui : 0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&v6),
        };
        0x2::event::emit<ReinvestmentEvent>(v7);
        0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::supply_hasui(arg11, arg1, arg2, v6, arg3, arg4, &arg0.naviConfig);
    }

    public(friend) fun toggle_deposit(arg0: &mut Strategy, arg1: bool) {
        arg0.pause_deposit = arg1;
    }

    public(friend) fun toggle_withdraw(arg0: &mut Strategy, arg1: bool) {
        arg0.pause_withdraw = arg1;
    }

    public fun withdraw_coin(arg0: &mut Strategy, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, 0x2::sui::SUI>, arg11: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg12: &mut 0x3::sui_system::SuiSystemState, arg13: 0x2::coin::Coin<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        assert!(arg0.pause_withdraw, 6);
        let v0 = 0x2::coin::value<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>(&arg13);
        let (v1, v2) = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_pool_supply_borrow(arg1, &arg0.naviConfig);
        let v3 = get_lp_total_supply(arg0);
        assert!(v3 > 0, 2);
        assert!(1000000000 > 0, 2);
        let v4 = (((v0 as u128) * 1000000000 / (v3 as u128)) as u64);
        let v5 = (((v2 as u128) * (v4 as u128) / 1000000000) as u64);
        let v6 = (((v1 as u128) * (v4 as u128) / 1000000000) as u64);
        let v7 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_hasui_total_supply(arg1, &arg0.naviConfig);
        let v8 = 0x2::balance::zero<0x2::sui::SUI>();
        let v9 = 0x2::balance::zero<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>();
        if (v7 == 0) {
            let v10 = do_withdraw_buffer(arg0, v6);
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v9, v10);
        } else if (v7 < v6) {
            let v11 = do_withdraw_buffer(arg0, v6 - v7);
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v9, v11);
            let v12 = 0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::navi_section::get_sui_total_borrow(arg1, &arg0.naviConfig);
            let (v13, v14) = do_withdraw_navi(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v12, v7, arg14, arg15);
            0x2::balance::join<0x2::sui::SUI>(&mut v8, v13);
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v9, v14);
        } else {
            let (v15, v16) = do_withdraw_navi(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v5, v6, arg14, arg15);
            0x2::balance::join<0x2::sui::SUI>(&mut v8, v15);
            0x2::balance::join<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&mut v9, v16);
        };
        0x2::coin::burn<0xff4d76a5fd49bd6a9d6f8f8df5fb71bbf7b1ac38c2ffa781054a74a4624b2183::vaultlpt::VAULTLPT>(&mut arg0.lp_cap, arg13);
        let v17 = WithdrawEvent{
            owner       : 0x2::tx_context::sender(arg15),
            user_amount : v0,
            user_ratio  : v4,
            debt        : v5,
            collateral  : v6,
            pool_hasui  : v7,
        };
        0x2::event::emit<WithdrawEvent>(v17);
        (v8, v9)
    }

    // decompiled from Move bytecode v6
}

