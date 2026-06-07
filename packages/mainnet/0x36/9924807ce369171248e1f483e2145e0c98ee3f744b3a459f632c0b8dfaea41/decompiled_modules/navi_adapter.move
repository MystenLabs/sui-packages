module 0x369924807ce369171248e1f483e2145e0c98ee3f744b3a459f632c0b8dfaea41::navi_adapter {
    struct RewardBufferKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct NaviWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct NaviAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        asset: u8,
        reward_pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        reward_asset_table: 0x2::table::Table<0x1::type_name::TypeName, vector<0x1::ascii::String>>,
        reward_rule_table: 0x2::table::Table<0x1::type_name::TypeName, vector<address>>,
        mid_pool: 0x2::object::ID,
        min_reward_redeem: u64,
        apr: u256,
        reward_flow: u64,
        reward_apr: u256,
        reward_sync_ms: u64,
    }

    struct RewardHarvest<phantom T0> {
        earnings: 0x2::balance::Balance<T0>,
        available: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        depth: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
    }

    public fun new<T0, T1>(arg0: u8, arg1: 0x2::object::ID, arg2: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapter<T0, T1>{
            id                 : 0x2::object::new(arg3),
            coin_in            : 0,
            account_cap        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3),
            asset              : arg0,
            reward_pool_table  : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg3),
            reward_asset_table : 0x2::table::new<0x1::type_name::TypeName, vector<0x1::ascii::String>>(arg3),
            reward_rule_table  : 0x2::table::new<0x1::type_name::TypeName, vector<address>>(arg3),
            mid_pool           : arg1,
            min_reward_redeem  : 1000000,
            apr                : 0,
            reward_flow        : 0,
            reward_apr         : 0,
            reward_sync_ms     : 0,
        };
        0x2::transfer::public_share_object<NaviAdapter<T0, T1>>(v0);
    }

    public fun allocate_to_protocol<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::rbr::RebalanceRequest<T0>, arg8: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviWitness<T1>{dummy_field: false};
        let v1 = 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::allocate_to_protocol<T0, T1, NaviWitness<T1>>(arg1, arg7, v0, arg8, arg9);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T0>(&v1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg0.asset, 0x2::coin::from_balance<T0>(v1, arg9), arg5, arg6, &arg0.account_cap);
    }

    public fun begin_approve<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) : RewardHarvest<T0> {
        let v0 = redeem_growth<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        snapshot<T0, T1>(arg0, arg1, arg4, v0)
    }

    public fun begin_approve_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0> {
        let v0 = redeem_growth_sui<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        snapshot<T0, T1>(arg0, arg1, arg4, v0)
    }

    fun buffer_join_take<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        let v1 = if (0x2::dynamic_field::exists<RewardBufferKey>(arg0, v0)) {
            0x2::dynamic_field::remove<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0)
        } else {
            0x2::balance::zero<T0>()
        };
        let v2 = v1;
        0x2::balance::join<T0>(&mut v2, arg1);
        v2
    }

    fun buffer_put<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::add<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
    }

    fun claim_rewards<T0, T1, T2>(arg0: &NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>) : 0x2::balance::Balance<T2> {
        if (arg0.coin_in == 0) {
            return 0x2::balance::zero<T2>()
        };
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg1, arg3, arg2, arg4, *0x2::table::borrow<0x1::type_name::TypeName, vector<0x1::ascii::String>>(&arg0.reward_asset_table, v0), *0x2::table::borrow<0x1::type_name::TypeName, vector<address>>(&arg0.reward_rule_table, v0), &arg0.account_cap)
    }

    public fun drop_reward_config<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, v0);
        0x2::table::remove<0x1::type_name::TypeName, vector<0x1::ascii::String>>(&mut arg0.reward_asset_table, v0);
        0x2::table::remove<0x1::type_name::TypeName, vector<address>>(&mut arg0.reward_rule_table, v0);
    }

    public fun end_approve<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::ptr::ProtocolRequest<T0>, arg3: RewardHarvest<T0>, arg4: &0x2::clock::Clock, arg5: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let RewardHarvest {
            earnings  : v0,
            available : v1,
            apr       : v2,
            depth     : v3,
        } = arg3;
        let (v4, v5, v6) = 0xb23208de702112f80bc9a36b441c9d5df3be072e7e7157be09d8818cefb57533::apr::accrue_reward(arg0.reward_apr, arg0.reward_flow, arg0.coin_in, arg0.reward_sync_ms, 0x2::clock::timestamp_ms(arg4));
        arg0.reward_apr = v4;
        arg0.reward_flow = v5;
        arg0.reward_sync_ms = v6;
        let v7 = 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v2, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(v4));
        let v8 = NaviWitness<T1>{dummy_field: false};
        0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::approve_protocol_request<T0, T1, NaviWitness<T1>>(arg1, arg2, v1, v7, v0, v8, arg5, arg6);
        let v9 = NaviWitness<T1>{dummy_field: false};
        0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::record_point<T0, T1, NaviWitness<T1>>(arg1, v7, v3, v9, arg5);
    }

    fun get_apr<T0, T1>(arg0: &NaviAdapter<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(arg0.apr)
    }

    fun get_available_liquidity<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: u8) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(arg0.coin_in, arg1)
    }

    public fun harvest_reward<T0, T1, T2, T3>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut RewardHarvest<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>) {
        let v0 = swap_rewards_route<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        arg0.reward_flow = arg0.reward_flow + 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg1.earnings, v0);
    }

    public fun inject_reward<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>) {
        let v0 = &mut arg0.id;
        let v1 = buffer_join_take<T2>(v0, 0x2::coin::into_balance<T2>(arg1));
        let v2 = &mut arg0.id;
        buffer_put<T2>(v2, v1);
    }

    fun learn_and_growth<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg0.asset);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, (ray_mul(v0, v2) as u64));
        arg0.apr = 0xb23208de702112f80bc9a36b441c9d5df3be072e7e7157be09d8818cefb57533::apr::update_apr_from_ratio(&mut arg0.id, arg0.apr, v2, 0x2::clock::timestamp_ms(arg3));
        if (v4 <= arg0.coin_in) {
            0
        } else {
            v4 - arg0.coin_in
        }
    }

    public fun min_reward_redeem<T0, T1>(arg0: &NaviAdapter<T0, T1>) : u64 {
        arg0.min_reward_redeem
    }

    fun ray_mul(arg0: u256, arg1: u256) : u256 {
        (arg0 * arg1 + 1000000000000000000000000000 / 2) / 1000000000000000000000000000
    }

    fun redeem_growth<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) : 0x2::balance::Balance<T0> {
        let v0 = learn_and_growth<T0, T1>(arg0, arg3, arg4, arg1);
        if (v0 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg0.asset, v0, arg5, arg6, &arg0.account_cap)
    }

    fun redeem_growth_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = learn_and_growth<T0, T1>(arg0, arg3, arg4, arg1);
        if (v0 == 0) {
            return 0x2::balance::zero<T0>()
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg1, arg2, arg3, arg4, arg0.asset, v0, arg5, arg6, &arg0.account_cap, arg7, arg8)
    }

    fun reserve_depth<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: u8) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg1, arg0.asset);
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg0.asset);
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18((ray_mul(v0, v2) as u64), arg2)
    }

    public fun set_mid_pool<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::object::ID, arg2: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>) {
        arg0.mid_pool = arg1;
    }

    public fun set_min_reward_redeem<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u64, arg2: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>) {
        arg0.min_reward_redeem = arg1;
    }

    public fun set_reward_config<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::object::ID, arg2: vector<0x1::ascii::String>, arg3: vector<address>, arg4: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = &mut arg0.reward_pool_table;
        upsert<0x2::object::ID>(v1, v0, arg1);
        let v2 = &mut arg0.reward_asset_table;
        upsert<vector<0x1::ascii::String>>(v2, v0, arg2);
        let v3 = &mut arg0.reward_rule_table;
        upsert<vector<address>>(v3, v0, arg3);
    }

    fun snapshot<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: 0x2::balance::Balance<T0>) : RewardHarvest<T0> {
        let v0 = 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::decimals<T0, T1>(arg1);
        RewardHarvest<T0>{
            earnings  : arg3,
            available : get_available_liquidity<T0, T1>(arg0, v0),
            apr       : get_apr<T0, T1>(arg0),
            depth     : reserve_depth<T0, T1>(arg0, arg2, v0),
        }
    }

    fun swap_a_to_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>(), v3);
        0x2::balance::join<T0>(arg2, v0);
        v1
    }

    fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::join<T1>(arg2, v1);
        v0
    }

    fun swap_rewards_route<T0, T1, T2, T3>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>) : 0x2::balance::Balance<T0> {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg6) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T2>()), 0);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>>(arg7) == arg0.mid_pool, 0);
        let v0 = arg0.min_reward_redeem;
        let v1 = &mut arg0.id;
        let v2 = buffer_join_take<T2>(v1, claim_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4));
        if (0x2::balance::value<T2>(&v2) < v0) {
            let v3 = &mut arg0.id;
            buffer_put<T2>(v3, v2);
            return 0x2::balance::zero<T0>()
        };
        let v4 = &mut v2;
        let v5 = &mut arg0.id;
        buffer_put<T2>(v5, v2);
        let v6 = &mut arg0.id;
        let v7 = buffer_join_take<T3>(v6, swap_a_to_b<T2, T3>(arg5, arg6, v4, arg1));
        if (0x2::balance::value<T3>(&v7) < v0) {
            let v8 = &mut arg0.id;
            buffer_put<T3>(v8, v7);
            return 0x2::balance::zero<T0>()
        };
        let v9 = &mut v7;
        let v10 = &mut arg0.id;
        buffer_put<T3>(v10, v7);
        swap_b_to_a<T0, T3>(arg5, arg7, v9, arg1)
    }

    public fun update_apr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u256, arg2: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::acl::AdminWitness<0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam::SAM>) {
        arg0.apr = arg1;
    }

    fun upsert<T0: drop + store>(arg0: &mut 0x2::table::Table<0x1::type_name::TypeName, T0>, arg1: 0x1::type_name::TypeName, arg2: T0) {
        if (0x2::table::contains<0x1::type_name::TypeName, T0>(arg0, arg1)) {
            0x2::table::remove<0x1::type_name::TypeName, T0>(arg0, arg1);
        };
        0x2::table::add<0x1::type_name::TypeName, T0>(arg0, arg1, arg2);
    }

    public fun withdraw_wdr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::WithdrawRequest<T0>, arg9: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::get_coin_amount<T0>(arg8);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = NaviWitness<T1>{dummy_field: false};
        0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::fill_withdraw_request<T0, T1, NaviWitness<T1>>(arg1, arg8, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg0.asset, v0, arg6, arg7, &arg0.account_cap), v1, arg9, arg10);
    }

    public fun withdraw_wdr_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::WithdrawRequest<T0>, arg10: &0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::wdr::get_coin_amount<T0>(arg9);
        arg0.coin_in = arg0.coin_in - v0;
        let v1 = NaviWitness<T1>{dummy_field: false};
        0x33ea4e67f076ebc0315e9a881a19e422ab3b264409c78392294cc752cc33411f::state::fill_withdraw_request<T0, T1, NaviWitness<T1>>(arg1, arg9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg2, arg3, arg4, arg5, arg0.asset, v0, arg6, arg7, &arg0.account_cap, arg8, arg11), v1, arg10, arg11);
    }

    public fun witness_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<NaviWitness<T0>>()
    }

    // decompiled from Move bytecode v7
}

