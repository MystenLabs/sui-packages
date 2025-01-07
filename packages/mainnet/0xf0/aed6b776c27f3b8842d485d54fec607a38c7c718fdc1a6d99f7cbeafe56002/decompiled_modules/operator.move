module 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::operator {
    struct OperatorStore has store, key {
        id: 0x2::object::UID,
        admin: address,
        next_admin: address,
        operators: 0x2::vec_set::VecSet<address>,
        max_ltv: u128,
        min_ltv: u128,
        withdraw_fee_rate: u128,
        reward_fee_rate: u128,
        reward_fee: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
    }

    public entry fun accept_admin(arg0: &mut OperatorStore, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.next_admin == 0x2::tx_context::sender(arg1), 2);
        arg0.admin = arg0.next_admin;
    }

    public(friend) fun accrue_interest(arg0: &mut OperatorStore, arg1: &mut 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg7: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::claim_vsui_reward_navi(arg1, arg2, arg3, arg4, arg5, arg12);
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.reward_fee, 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdc(arg1, (((0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::sell_vsui(arg1, arg6, arg7, arg8, arg9, arg10, 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_vsui_treasury_balance(arg1), arg11, arg2, arg12) as u128) * arg0.reward_fee_rate / 1000000) as u64), arg12));
    }

    public entry fun add_operator(arg0: &mut OperatorStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.operators, &arg1), 4);
        0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
    }

    public(friend) fun after_deposit(arg0: &mut OperatorStore, arg1: &mut 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::supply_all_usdc_navi(arg1, arg2, arg4, arg5, arg7, arg8, arg9);
        0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::supply_all_usdt_navi(arg1, arg2, arg4, arg6, arg7, arg8, arg9);
        let v0 = 0;
        while (v0 != 2) {
            let v1 = 2;
            v0 = v1;
            let v2 = usdc_account_ltv(arg1, arg2, arg3, arg4);
            if (v2 < arg0.min_ltv) {
                v0 = v1 - 1;
                let v3 = get_usdt_borrow_limit(arg0, arg1, arg2, arg3, arg4);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::borrow_usdt_navi(arg1, arg2, arg3, arg4, arg6, arg8, v3, arg9);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::supply_all_usdt_navi(arg1, arg2, arg4, arg6, arg7, arg8, arg9);
            };
            let v4 = usdt_account_ltv(arg1, arg2, arg3, arg4);
            if (v4 < arg0.min_ltv) {
                v0 = v0 - 1;
                let v5 = get_usdc_borrow_limit(arg0, arg1, arg2, arg3, arg4);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::borrow_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg8, v5, arg9);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::supply_all_usdc_navi(arg1, arg2, arg4, arg5, arg7, arg8, arg9);
            };
        };
    }

    public(friend) fun before_withdraw(arg0: &mut OperatorStore, arg1: &mut 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg9: bool, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        if (arg9) {
            assert!(0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdc_balance(arg1, arg4) >= arg10, 9);
            0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg10, arg11);
            let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdc_treasury_balance(arg1);
            while (v0 < arg10) {
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::repay_all_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg8, arg11);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdt_navi(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg10, arg11);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::repay_all_usdt_navi(arg1, arg2, arg3, arg4, arg6, arg8, arg11);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg10, arg11);
                v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdc_treasury_balance(arg1);
            };
            let v1 = 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdc(arg1, arg10, arg11), arg11);
            after_deposit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
            0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::depsosit_usdc(arg1, v1, arg11);
        } else {
            assert!(0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdt_balance(arg1, arg4) >= arg10, 9);
            0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdt_navi(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg10, arg11);
            let v2 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdt_treasury_balance(arg1);
            while (v2 < arg10) {
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::repay_all_usdt_navi(arg1, arg2, arg3, arg4, arg6, arg8, arg11);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg10, arg11);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::repay_all_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg8, arg11);
                0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdt_navi(arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg10, arg11);
                v2 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdt_treasury_balance(arg1);
            };
            let v3 = 0x2::coin::from_balance<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>(0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::withdraw_usdt(arg1, arg10, arg11), arg11);
            after_deposit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
            0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::depsosit_usdt(arg1, v3, arg11);
        };
    }

    public entry fun extract_fee(arg0: &mut OperatorStore, arg1: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>>(0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.reward_fee), arg1), arg0.admin);
    }

    public fun get_mint_receive_amount(arg0: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u64) : u64 {
        ((0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::cusd_exchange_rate(arg0, arg1) * (arg2 as u128) / 1000000) as u64)
    }

    public fun get_redeem_receive_amount(arg0: &OperatorStore, arg1: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u64) : u64 {
        let v0 = ((0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::cusd_exchange_rate_reverse(arg1, arg2) * (arg3 as u128) / 1000000) as u64);
        v0 - (((v0 as u128) * arg0.withdraw_fee_rate / 1000000) as u64)
    }

    fun get_usdc_borrow_limit(arg0: &OperatorStore, arg1: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdt_accountcap_address(arg1);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg2, arg3, arg4, 1, v0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg2, arg3, arg4, 2, v0) * (arg0.max_ltv as u256) / (1000000 as u256);
        let v3 = if (v2 <= v1) {
            0
        } else {
            v2 - v1
        };
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg2, arg3, v3, 1) as u64)
    }

    fun get_usdc_withdraw_limit(arg0: &OperatorStore, arg1: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdc_accountcap_address(arg1);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg2, arg3, arg4, 2, v0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg2, arg3, arg4, 1, v0) * (arg0.max_ltv as u256) / (1000000 as u256);
        let v3 = if (v2 <= v1) {
            0
        } else {
            v2 - v1
        };
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg2, arg3, v3 * (1000000 as u256) / (arg0.max_ltv as u256), 1) as u64)
    }

    fun get_usdt_borrow_limit(arg0: &OperatorStore, arg1: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdc_accountcap_address(arg1);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg2, arg3, arg4, 2, v0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg2, arg3, arg4, 1, v0) * (arg0.max_ltv as u256) / (1000000 as u256);
        let v3 = if (v2 <= v1) {
            0
        } else {
            v2 - v1
        };
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg2, arg3, v3, 2) as u64)
    }

    fun get_usdt_withdraw_limit(arg0: &OperatorStore, arg1: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u64 {
        let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdt_accountcap_address(arg1);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg2, arg3, arg4, 1, v0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg2, arg3, arg4, 2, v0) * (arg0.max_ltv as u256) / (1000000 as u256);
        let v3 = if (v2 <= v1) {
            0
        } else {
            v2 - v1
        };
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_amount(arg2, arg3, v3 * (1000000 as u256) / (arg0.max_ltv as u256), 2) as u64)
    }

    public entry fun harvest(arg0: &mut OperatorStore, arg1: &mut 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg8: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg9: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        only_operator(arg0, arg14);
        accrue_interest(arg0, arg1, arg2, arg6, arg7, arg3, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::supply_all_usdc_navi(arg1, arg2, arg3, arg4, arg5, arg6, arg14);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OperatorStore{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            next_admin        : v0,
            operators         : 0x2::vec_set::empty<address>(),
            max_ltv           : 650000,
            min_ltv           : 600000,
            withdraw_fee_rate : 0,
            reward_fee_rate   : 0,
            reward_fee        : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
        };
        0x2::transfer::share_object<OperatorStore>(v1);
    }

    fun only_admin(arg0: &OperatorStore, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
    }

    fun only_operator(arg0: &OperatorStore, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
    }

    public entry fun remove_operator(arg0: &mut OperatorStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &arg1), 5);
        0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
    }

    public entry fun set_ltv(arg0: &mut OperatorStore, arg1: u128, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg3);
        assert!(arg1 >= arg2, 6);
        assert!(arg1 <= 70000, 8);
        arg0.max_ltv = arg1;
        arg0.min_ltv = arg2;
    }

    public entry fun set_reward_fee_rate(arg0: &mut OperatorStore, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert!(arg1 <= 1000000, 7);
        arg0.reward_fee_rate = arg1;
    }

    public entry fun set_withdraw_fee_rate(arg0: &mut OperatorStore, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        assert!(arg1 <= 1000000, 7);
        arg0.withdraw_fee_rate = arg1;
    }

    public entry fun transfer_admin(arg0: &mut OperatorStore, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        only_admin(arg0, arg2);
        arg0.next_admin = arg1;
    }

    fun usdc_account_ltv(arg0: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u128 {
        let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdc_accountcap_address(arg0);
        ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg1, arg2, arg3, 2, v0) * (1000000 as u256) / 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg1, arg2, arg3, 1, v0)) as u128)
    }

    fun usdt_account_ltv(arg0: &0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::StrategyStore, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) : u128 {
        let v0 = 0xf0aed6b776c27f3b8842d485d54fec607a38c7c718fdc1a6d99f7cbeafe56002::cusd::get_usdt_accountcap_address(arg0);
        ((0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_value(arg1, arg2, arg3, 1, v0) * (1000000 as u256) / 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_value(arg1, arg2, arg3, 2, v0)) as u128)
    }

    // decompiled from Move bytecode v6
}

