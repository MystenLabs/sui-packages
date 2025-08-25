module 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::navi_section {
    struct NaviConfig has store {
        limit_ltv: u64,
        min_ltv: u64,
        limit_hf: u64,
        min_hf: u64,
        max_loops: u64,
        asset_hasui: u8,
        asset_sui: u8,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    public(friend) fun borrow_sui(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: u64, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &NaviConfig) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg2, arg7.asset_sui);
        let v2 = (ray_mul((arg4 as u256), v1) as u64);
        assert!(check_total_borrow_cap(arg2, arg7, v2), 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::exceed_borrow_cap());
        let v3 = get_vault_health_factor(arg0, arg2, arg1, arg7);
        assert!(v3 > arg7.limit_hf, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::exceed_borrow_limit());
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg7.asset_sui, v2, arg5, arg6, &arg7.account_cap)
    }

    public(friend) fun check_min_hf(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &NaviConfig) : bool {
        get_vault_health_factor(arg0, arg1, arg2, arg3) <= arg3.min_hf
    }

    public(friend) fun check_total_borrow_cap(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig, arg2: u64) : bool {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_cap_ceiling_ratio(arg0, arg1.asset_hasui) / 100000000000000000000000;
        let v1 = get_hasui_total_supply(arg0, arg1);
        let v2 = (v1 as u256);
        if (v2 == 0) {
            return true
        };
        let v3 = (get_sui_total_borrow(arg0, arg1) as u256);
        let v4 = v2 * v0 / 100;
        let v5 = false;
        if (v4 >= v3) {
            if (v4 - v3 >= (arg2 as u256)) {
                v5 = true;
            };
        };
        v5
    }

    public(friend) fun check_total_supply_cap(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig, arg2: u64) : bool {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_supply_cap_ceiling(arg0, arg1.asset_hasui);
        let v1 = (get_hasui_total_supply(arg0, arg1) as u256);
        let v2 = false;
        if (v0 > v1) {
            if (v0 - v1 >= (arg2 as u256)) {
                v2 = true;
            };
        };
        v2
    }

    public(friend) fun claim_reward_cert(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &NaviConfig) : 0x2::balance::Balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        let (v0, v1, v2, v3, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg1, arg2, get_account_owner(&arg4.account_cap)));
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
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, arg2, arg1, arg3, v12, v13, &arg4.account_cap)
    }

    public(friend) fun create_vault_account(arg0: &mut 0x2::tx_context::TxContext) : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0)
    }

    public(friend) fun flash_loan_fee<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>) : u64 {
        let (_, _, _, _, v4, v5) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::parsed_receipt<T0>(arg0);
        ((v4 + v5) as u64)
    }

    public(friend) fun flash_loan_sui(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg2: u64, arg3: &NaviConfig) : (0x2::balance::Balance<0x2::sui::SUI>, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<0x2::sui::SUI>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_account_cap<0x2::sui::SUI>(arg0, arg1, arg2, &arg3.account_cap)
    }

    public(friend) fun flash_repay_sui(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg3: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &NaviConfig) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_account_cap<0x2::sui::SUI>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), &arg5.account_cap)
    }

    public(friend) fun get_account_owner(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg0)
    }

    public fun get_hasui_total_supply(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1.asset_hasui, get_account_owner(&arg1.account_cap));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1.asset_hasui);
        (ray_mul(v0, v2) as u64)
    }

    public fun get_hf_ltv(arg0: &NaviConfig) : (u64, u64, u64, u64, u64, u64) {
        (arg0.limit_ltv, arg0.min_ltv, arg0.limit_hf, arg0.min_hf, arg0.max_loops, 10000)
    }

    public fun get_lending_liquidation_factors(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig) : u64 {
        let (_, _, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg0, arg1.asset_hasui);
        let v3 = if (v2 > 0 && v2 > 100000000000000000000000) {
            let v4 = v2 / 100000000000000000000000;
            let v5 = v4;
            let v6 = 18446744073709551615;
            if (v4 > v6) {
                v5 = v6;
            };
            v5
        } else {
            0
        };
        (v3 as u64)
    }

    public fun get_limit_data(arg0: &NaviConfig) : (u64, u64) {
        (arg0.limit_ltv, arg0.limit_hf)
    }

    public fun get_ltv(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg0, arg1)
    }

    public fun get_min_data(arg0: &NaviConfig) : (u64, u64) {
        (arg0.min_ltv, arg0.min_hf)
    }

    public fun get_pool_supply_borrow(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig) : (u64, u64) {
        let v0 = get_account_owner(&arg1.account_cap);
        let (v1, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1.asset_hasui, v0);
        let (_, v4) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1.asset_sui, v0);
        ((v1 as u64), (v4 as u64))
    }

    public fun get_rewards(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &NaviConfig) : (vector<0x1::ascii::String>, u64) {
        let (v0, v1, v2, v3, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg0, arg1, arg2, get_account_owner(&arg3.account_cap)));
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

    public fun get_sui_total_borrow(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig) : u64 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1.asset_sui, get_account_owner(&arg1.account_cap));
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1.asset_sui);
        (ray_mul(v1, v3) as u64)
    }

    public fun get_vault_collateral_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, arg1.asset_hasui, get_account_owner(&arg1.account_cap))
    }

    public fun get_vault_health_factor(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &NaviConfig) : u64 {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_health_factor(arg0, arg1, arg2, get_account_owner(&arg3.account_cap));
        let v1 = if (v0 > 0 && v0 > 100000000000000000000000) {
            let v2 = v0 / 100000000000000000000000;
            let v3 = v2;
            let v4 = 18446744073709551615;
            if (v2 > v4) {
                v3 = v4;
            };
            v3
        } else {
            0
        };
        (v1 as u64)
    }

    public fun get_vault_lend_sui(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig) : u256 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, arg1.asset_sui, get_account_owner(&arg1.account_cap))
    }

    public(friend) fun navi_collateral_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig, arg2: u64) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1.asset_hasui);
        (ray_mul((arg2 as u256), v0) as u64)
    }

    public(friend) fun navi_debt_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &NaviConfig, arg2: u64) : u64 {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1.asset_sui);
        (ray_mul((arg2 as u256), v1) as u64)
    }

    public(friend) fun new_navi(arg0: &mut 0x2::tx_context::TxContext) : NaviConfig {
        NaviConfig{
            limit_ltv   : 6000,
            min_ltv     : 5500,
            limit_hf    : 12000,
            min_hf      : 11000,
            max_loops   : 3,
            asset_hasui : 6,
            asset_sui   : 0,
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
        }
    }

    fun ray_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 500000000000000000000000000) / arg1, 1101);
        (arg0 * arg1 + 500000000000000000000000000) / 1000000000000000000000000000
    }

    public(friend) fun repay_sui(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &NaviConfig) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg7.asset_sui, arg4, arg5, arg6, &arg7.account_cap)
    }

    public(friend) fun supply_hasui(arg0: &0x2::clock::Clock, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg3: 0x2::coin::Coin<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &NaviConfig) {
        assert!(0x2::coin::value<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(&arg3) > 0, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::insufficient_collateral());
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, arg2, arg6.asset_hasui, arg3, arg4, arg5, &arg6.account_cap);
    }

    public(friend) fun update_navi_asset_num(arg0: &mut NaviConfig, arg1: u8, arg2: u8) {
        assert!(arg1 != arg0.asset_hasui, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::invalid_config());
        assert!(arg2 != arg0.asset_sui, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::invalid_config());
        arg0.asset_hasui = arg1;
        arg0.asset_sui = arg2;
    }

    public(friend) fun update_navi_max_loop(arg0: &mut NaviConfig, arg1: u64) {
        assert!(arg1 != arg0.max_loops, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::invalid_config());
        arg0.max_loops = arg1;
    }

    public(friend) fun update_risk_parameters(arg0: &mut NaviConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg3 > arg4, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::invalid_parameters());
        assert!(arg1 > arg2, 0x53193df44006ae7cdebf6328566dc62ed80a454909cd73d43e9140e7b49ea4c2::error::invalid_ltv());
        arg0.limit_hf = arg3;
        arg0.min_hf = arg4;
        arg0.limit_ltv = arg1;
        arg0.min_ltv = arg2;
    }

    public(friend) fun withdraw_hasui(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>, arg4: u64, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &NaviConfig) : 0x2::balance::Balance<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0, arg1, arg2, arg3, arg7.asset_hasui, arg4, arg5, arg6, &arg7.account_cap)
    }

    // decompiled from Move bytecode v6
}

