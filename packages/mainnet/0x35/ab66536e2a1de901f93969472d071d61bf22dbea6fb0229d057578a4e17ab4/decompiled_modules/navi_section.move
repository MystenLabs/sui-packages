module 0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::navi_section {
    struct NaviConfig has store, key {
        id: 0x2::object::UID,
        active: bool,
        limit_ltv: u256,
        min_ltv: u256,
        limit_hf: u256,
        min_hf: u256,
        max_loops: u64,
        storage: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,
        pool_hasui: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>,
        asset_hasui: u8,
        pool_sui: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>,
        asset_sui: u8,
        incentive2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,
        incentive3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,
        flash_loan_config: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,
        reward_fund: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        vault_lpt_treasury_cap: 0x2::coin::TreasuryCap<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>,
    }

    public fun borrow_sui(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut NaviConfig, arg3: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_sui_total_borrow(arg2);
        let v1 = get_borrow_cap(arg2);
        assert!(((v0 + arg3) as u256) <= v1, 3);
        let v2 = get_vault_health_factor(arg0, arg2, arg1);
        assert!(v2 > (arg2.limit_hf as u256), 2);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<0x2::sui::SUI>(arg0, arg1, &mut arg2.storage, &mut arg2.pool_sui, arg2.asset_sui, arg3, &mut arg2.incentive2, &mut arg2.incentive3, &arg2.account_cap)
    }

    public fun burn_lp(arg0: &mut NaviConfig, arg1: 0x2::coin::Coin<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>) {
        0x2::coin::burn<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>(&mut arg0.vault_lpt_treasury_cap, arg1);
    }

    public fun check_min_hf(arg0: &0x2::clock::Clock, arg1: &mut NaviConfig, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) : bool {
        let v0 = get_vault_health_factor(arg0, arg1, arg2);
        v0 <= arg1.min_hf
    }

    public fun claim_reward_cert(arg0: &0x2::clock::Clock, arg1: &mut NaviConfig) : 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, &mut arg1.storage, &arg1.incentive3, get_account_owner(&arg1.account_cap)));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = v0;
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>());
        let v11 = &v10;
        let v12 = 0x1::vector::empty<0x1::ascii::String>();
        let v13 = 0x1::vector::empty<address>();
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::ascii::String>(&v9)) {
            let v15 = 0x1::vector::borrow<0x1::ascii::String>(&v9, v14);
            let v16 = 0x1::vector::borrow<0x1::ascii::String>(&v8, v14);
            let v17 = 0x1::vector::borrow<vector<address>>(&v5, v14);
            if (*0x1::vector::borrow<u256>(&v7, v14) > *0x1::vector::borrow<u256>(&v6, v14) && v16 == v11) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v12, *v15);
                0x1::vector::append<address>(&mut v13, *v17);
            };
            v14 = v14 + 1;
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, &mut arg1.incentive3, &mut arg1.storage, &mut arg1.reward_fund, v12, v13, &arg1.account_cap)
    }

    public fun create_vault_account(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public fun flash_loan_fee<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>) : u64 {
        let (_, _, _, _, v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(arg0);
        ((v4 + v5) as u64)
    }

    public fun flash_loan_sui(arg0: &mut NaviConfig, arg1: u64) : (0x2::balance::Balance<0x2::sui::SUI>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<0x2::sui::SUI>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(&arg0.flash_loan_config, &mut arg0.pool_sui, arg1, &arg0.account_cap)
    }

    public fun flash_repay_sui(arg0: &0x2::clock::Clock, arg1: &mut NaviConfig, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg0, &mut arg1.storage, &mut arg1.pool_sui, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), &arg1.account_cap)
    }

    public fun get_account_owner(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg0)
    }

    public fun get_borrow_cap(arg0: &mut NaviConfig) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_cap_ceiling_ratio(&mut arg0.storage, arg0.asset_sui)
    }

    public fun get_dynamic_liquidation_threshold(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: address, arg4: u8, arg5: u256, arg6: bool) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::dynamic_calculator::dynamic_liquidation_threshold(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun get_hasui_total_supply(arg0: &mut NaviConfig) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(&mut arg0.storage, arg0.asset_hasui, get_account_owner(&arg0.account_cap));
        (v0 as u64)
    }

    public fun get_hf_ltv(arg0: &NaviConfig) : (u256, u256, u256, u256, u64) {
        (arg0.limit_ltv, arg0.min_ltv, arg0.limit_hf, arg0.min_hf, arg0.max_loops)
    }

    public fun get_lending_liquidation_factors(arg0: &mut NaviConfig) : (u256, u256, u256) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(&mut arg0.storage, arg0.asset_hasui)
    }

    public fun get_limit_data(arg0: &NaviConfig) : (u256, u256) {
        (arg0.limit_ltv, arg0.limit_hf)
    }

    public fun get_lp_total_supply(arg0: &NaviConfig) : u64 {
        0x2::coin::total_supply<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>(&arg0.vault_lpt_treasury_cap)
    }

    public fun get_ltv(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg0, arg1)
    }

    public fun get_min_data(arg0: &NaviConfig) : (u256, u256) {
        (arg0.min_ltv, arg0.min_hf)
    }

    public(friend) fun get_navi_lp_coin(arg0: &mut NaviConfig, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT> {
        0x2::coin::mint<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>(&mut arg0.vault_lpt_treasury_cap, (arg1 as u64), arg2)
    }

    public fun get_pool_supply_borrow(arg0: &mut NaviConfig) : (u256, u256) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(&mut arg0.storage, arg0.asset_hasui, get_account_owner(&arg0.account_cap))
    }

    public fun get_rewards(arg0: &0x2::clock::Clock, arg1: &mut NaviConfig) : (vector<0x1::ascii::String>, u64) {
        let (v0, v1, v2, v3, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, &mut arg1.storage, &arg1.incentive3, get_account_owner(&arg1.account_cap)));
        let v5 = v3;
        let v6 = v2;
        let v7 = v0;
        let v8 = 0;
        let v9 = 0;
        while (v8 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v10 = *0x1::vector::borrow<u256>(&v6, v8);
            let v11 = *0x1::vector::borrow<u256>(&v5, v8);
            if (v10 > v11) {
                v9 = v9 + v10 - v11;
            };
            v8 = v8 + 1;
        };
        (v1, (v9 as u64))
    }

    public fun get_sui_total_borrow(arg0: &mut NaviConfig) : u64 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(&mut arg0.storage, arg0.asset_sui, get_account_owner(&arg0.account_cap));
        (v1 as u64)
    }

    public fun get_supply_cap(arg0: &mut NaviConfig) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_supply_cap_ceiling(&mut arg0.storage, arg0.asset_hasui)
    }

    public fun get_vault_collateral_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : u256 {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, arg1, get_account_owner(arg2)) as u256)
    }

    public fun get_vault_health_factor(arg0: &0x2::clock::Clock, arg1: &mut NaviConfig, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, &mut arg1.storage, arg2, get_account_owner(&arg1.account_cap))
    }

    public fun get_vault_lend_sui(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : u256 {
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, arg1, get_account_owner(arg2)) as u256)
    }

    public(friend) fun new_navi(arg0: 0x2::coin::TreasuryCap<0x35ab66536e2a1de901f93969472d071d61bf22dbea6fb0229d057578a4e17ab4::vaultlpt::VAULTLPT>, arg1: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: u8, arg4: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg5: u8, arg6: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg9: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviConfig{
            id                     : 0x2::object::new(arg10),
            active                 : true,
            limit_ltv              : 60,
            min_ltv                : 55,
            limit_hf               : 120,
            min_hf                 : 110,
            max_loops              : 3,
            storage                : arg1,
            pool_hasui             : arg2,
            asset_hasui            : arg3,
            pool_sui               : arg4,
            asset_sui              : arg5,
            incentive2             : arg6,
            incentive3             : arg7,
            flash_loan_config      : arg8,
            reward_fund            : arg9,
            account_cap            : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg10),
            vault_lpt_treasury_cap : arg0,
        };
        0x2::transfer::share_object<NaviConfig>(v0);
    }

    public fun repay_sui(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut NaviConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<0x2::sui::SUI>(arg0, arg1, &mut arg2.storage, &mut arg2.pool_sui, arg2.asset_sui, arg3, &mut arg2.incentive2, &mut arg2.incentive3, &arg2.account_cap)
    }

    public fun supply_hasui(arg0: &0x2::clock::Clock, arg1: &mut NaviConfig, arg2: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>) {
        assert!(0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg2) > 0, 1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, &mut arg1.storage, &mut arg1.pool_hasui, arg1.asset_hasui, arg2, &mut arg1.incentive2, &mut arg1.incentive3, &arg1.account_cap);
    }

    public(friend) fun update_risk_parameters(arg0: &mut NaviConfig, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        assert!(arg3 > arg4, 4);
        assert!(arg1 > arg2, 5);
        arg0.limit_hf = arg3;
        arg0.min_hf = arg4;
        arg0.limit_ltv = arg1;
        arg0.min_ltv = arg2;
    }

    public fun withdraw_hasui(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut NaviConfig, arg3: u64) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, &mut arg2.storage, &mut arg2.pool_hasui, arg2.asset_hasui, arg3, &mut arg2.incentive2, &mut arg2.incentive3, &arg2.account_cap)
    }

    // decompiled from Move bytecode v6
}

