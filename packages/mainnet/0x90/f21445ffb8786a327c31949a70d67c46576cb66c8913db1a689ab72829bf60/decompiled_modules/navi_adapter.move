module 0x90f21445ffb8786a327c31949a70d67c46576cb66c8913db1a689ab72829bf60::navi_adapter {
    struct NaviWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct NaviAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        dust: 0x2::balance::Balance<T0>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        asset: u8,
        reward_pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        reward_asset_table: 0x2::table::Table<0x1::type_name::TypeName, vector<0x1::ascii::String>>,
        reward_rule_table: 0x2::table::Table<0x1::type_name::TypeName, vector<address>>,
        mid_pool: 0x2::object::ID,
        min_reward_redeem: u64,
        apr: 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::AprState,
        reward: 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::RewardAprState,
    }

    struct RewardHarvest<phantom T0, phantom T1> {
        earnings: 0x2::balance::Balance<T0>,
        available: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        depth: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
    }

    public fun new<T0, T1>(arg0: u8, arg1: 0x2::object::ID, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapter<T0, T1>{
            id                 : 0x2::object::new(arg3),
            coin_in            : 0,
            dust               : 0x2::balance::zero<T0>(),
            account_cap        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg3),
            asset              : arg0,
            reward_pool_table  : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg3),
            reward_asset_table : 0x2::table::new<0x1::type_name::TypeName, vector<0x1::ascii::String>>(arg3),
            reward_rule_table  : 0x2::table::new<0x1::type_name::TypeName, vector<address>>(arg3),
            mid_pool           : arg1,
            min_reward_redeem  : 1000000,
            apr                : 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::new(),
            reward             : 0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::new(),
        };
        0x2::transfer::public_share_object<NaviAdapter<T0, T1>>(v0);
    }

    public fun allocate_to_protocol<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::RebalanceRequest<T0, T1>, arg8: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviWitness<T1>{dummy_field: false};
        let v1 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::allocate_to_protocol<T0, T1, NaviWitness<T1>>(arg1, arg7, v0, arg8, arg9);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T0>(&v1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg2, arg3, arg4, arg0.asset, 0x2::coin::from_balance<T0>(v1, arg9), arg5, arg6, &arg0.account_cap);
    }

    fun assert_reward_pool<T0, T1, T2>(arg0: &NaviAdapter<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg1 == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T2>()), 0);
    }

    public fun begin_approve<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) : RewardHarvest<T0, T1> {
        let v0 = redeem_growth<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        snapshot<T0, T1>(arg0, arg1, arg4, arg5, v0)
    }

    public fun begin_approve_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, T1> {
        let v0 = redeem_growth_sui<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        snapshot<T0, T1>(arg0, arg1, arg4, arg5, v0)
    }

    fun buffer_excess<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T0>(&arg1) <= arg2) {
            return arg1
        };
        0x2::balance::join<T0>(&mut arg0.dust, 0x2::balance::split<T0>(&mut arg1, 0x2::balance::value<T0>(&arg1) - arg2));
        arg1
    }

    fun claim_rewards<T0, T1, T2>(arg0: &NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>) : 0x2::balance::Balance<T2> {
        if (arg0.coin_in == 0) {
            return 0x2::balance::zero<T2>()
        };
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T2>(arg1, arg3, arg2, arg4, *0x2::table::borrow<0x1::type_name::TypeName, vector<0x1::ascii::String>>(&arg0.reward_asset_table, v0), *0x2::table::borrow<0x1::type_name::TypeName, vector<address>>(&arg0.reward_rule_table, v0), &arg0.account_cap)
    }

    public fun drop_reward_config<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, v0);
        0x2::table::remove<0x1::type_name::TypeName, vector<0x1::ascii::String>>(&mut arg0.reward_asset_table, v0);
        0x2::table::remove<0x1::type_name::TypeName, vector<address>>(&mut arg0.reward_rule_table, v0);
    }

    public fun end_approve<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::ptr::ProtocolRequest<T0>, arg3: RewardHarvest<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let RewardHarvest {
            earnings  : v0,
            available : v1,
            apr       : v2,
            depth     : v3,
        } = arg3;
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::accrue(&mut arg0.reward, arg0.coin_in, 0x2::clock::timestamp_ms(arg4));
        let v4 = NaviWitness<T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::approve_protocol_request<T0, T1, NaviWitness<T1>>(arg1, arg2, v1, v3, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v2, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::value(&arg0.reward))), v0, v4, arg5, arg6);
    }

    public fun harvest_reward<T0, T1, T2, T3>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut RewardHarvest<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>) {
        let v0 = swap_rewards_route<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<T0>(&v0));
        0x2::balance::join<T0>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_direct<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut RewardHarvest<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>) {
        assert_reward_pool<T0, T1, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg7));
        let v0 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_b_to_a<T0, T2>(&mut arg0.id, claim_rewards<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5), arg0.min_reward_redeem, arg6, arg7, arg2);
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<T0>(&v0));
        0x2::balance::join<T0>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_direct_a<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut RewardHarvest<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>) {
        assert_reward_pool<T0, T1, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>>(arg7));
        let v0 = 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_a_to_b<T2, T0>(&mut arg0.id, claim_rewards<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5), arg0.min_reward_redeem, arg6, arg7, arg2);
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::reward_apr::record(&mut arg0.reward, 0x2::balance::value<T0>(&v0));
        0x2::balance::join<T0>(&mut arg1.earnings, v0);
    }

    public fun inject_reward<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer::add<T2>(&mut arg0.id, 0x2::coin::into_balance<T2>(arg1));
    }

    fun learn_and_growth<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0x2::clock::Clock) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg1, arg0.asset, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap));
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg0.asset);
        let v4 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, (ray_mul(v0, v2) as u64));
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::observe_ratio(&mut arg0.apr, v2, 0x2::clock::timestamp_ms(arg3));
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

    fun redeem_exact<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) : 0x2::balance::Balance<T0> {
        arg0.coin_in = arg0.coin_in - arg1;
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg2, arg3, arg4, arg5, arg0.asset, arg1, arg6, arg7, &arg0.account_cap);
        buffer_excess<T0, T1>(arg0, v0, arg1)
    }

    fun redeem_exact_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        arg0.coin_in = arg0.coin_in - arg1;
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg2, arg3, arg4, arg5, arg0.asset, arg1, arg6, arg7, &arg0.account_cap, arg8, arg9);
        buffer_excess<T0, T1>(arg0, v0, arg1)
    }

    fun redeem_growth<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) : 0x2::balance::Balance<T0> {
        let v0 = learn_and_growth<T0, T1>(arg0, arg3, arg4, arg1);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.dust);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg0.asset, v0, arg5, arg6, &arg0.account_cap));
        };
        v1
    }

    fun redeem_growth_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = learn_and_growth<T0, T1>(arg0, arg3, arg4, arg1);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.dust);
        if (v0 > 0) {
            0x2::balance::join<T0>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap_v2<T0>(arg1, arg2, arg3, arg4, arg0.asset, v0, arg5, arg6, &arg0.account_cap, arg7, arg8));
        };
        v1
    }

    fun reserve_cash<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : u64 {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg1, arg0.asset);
        let (v2, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg1, arg0.asset);
        let v4 = (ray_mul(v0, v2) as u64);
        let v5 = (ray_mul(v1, v3) as u64);
        let v6 = if (v4 > v5) {
            v4 - v5
        } else {
            0
        };
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg2, v6)
    }

    public fun set_mid_pool<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::object::ID, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        arg0.mid_pool = arg1;
    }

    public fun set_min_reward_redeem<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u64, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        assert!(arg1 > 0, 1);
        arg0.min_reward_redeem = arg1;
    }

    public fun set_reward_config<T0, T1, T2>(arg0: &mut NaviAdapter<T0, T1>, arg1: 0x2::object::ID, arg2: vector<0x1::ascii::String>, arg3: vector<address>, arg4: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::table_util::upsert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, v0, arg1);
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::table_util::upsert<0x1::type_name::TypeName, vector<0x1::ascii::String>>(&mut arg0.reward_asset_table, v0, arg2);
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::table_util::upsert<0x1::type_name::TypeName, vector<address>>(&mut arg0.reward_rule_table, v0, arg3);
    }

    fun snapshot<T0, T1>(arg0: &NaviAdapter<T0, T1>, arg1: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: 0x2::balance::Balance<T0>) : RewardHarvest<T0, T1> {
        let v0 = 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::decimals<T0, T1>(arg1);
        let v1 = reserve_cash<T0, T1>(arg0, arg2, arg3);
        let v2 = if (arg0.coin_in < v1) {
            arg0.coin_in
        } else {
            v1
        };
        RewardHarvest<T0, T1>{
            earnings  : arg4,
            available : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v2, v0),
            apr       : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::value(&arg0.apr)),
            depth     : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v1, v0),
        }
    }

    fun swap_rewards_route<T0, T1, T2, T3>(arg0: &mut NaviAdapter<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T2>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>) : 0x2::balance::Balance<T0> {
        assert_reward_pool<T0, T1, T2>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg6));
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T3>>(arg7) == arg0.mid_pool, 0);
        let v0 = arg0.min_reward_redeem;
        0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_b_to_a<T0, T3>(&mut arg0.id, 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::cetus_swap::buffered_swap_a_to_b<T2, T3>(&mut arg0.id, claim_rewards<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), v0, arg5, arg6, arg1), v0, arg5, arg7, arg1)
    }

    public fun update_apr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: u256, arg2: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::acl::AdminWitness<0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam::SAM>) {
        0xd4450b190660b6df4eeb7151dfc249e565ed727aea37bf9aea9266bcece6d8af::apr::set(&mut arg0.apr, arg1);
    }

    public fun withdraw_rbr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::RebalanceRequest<T0, T1>, arg9: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviWitness<T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_rebalance_request<T0, T1, NaviWitness<T1>>(arg1, arg8, redeem_exact<T0, T1>(arg0, 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::amount<T0, T1>(arg8), arg2, arg3, arg4, arg5, arg6, arg7), v0, arg9, arg10);
    }

    public fun withdraw_rbr_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::RebalanceRequest<T0, T1>, arg10: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_exact_sui<T0, T1>(arg0, 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::rbr::amount<T0, T1>(arg9), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
        let v1 = NaviWitness<T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_rebalance_request<T0, T1, NaviWitness<T1>>(arg1, arg9, v0, v1, arg10, arg11);
    }

    public fun withdraw_wdr<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::WithdrawRequest<T0, T1>, arg9: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviWitness<T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_withdraw_request<T0, T1, NaviWitness<T1>>(arg1, arg8, redeem_exact<T0, T1>(arg0, 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::get_coin_amount<T0, T1>(arg8), arg2, arg3, arg4, arg5, arg6, arg7), v0, arg9, arg10);
    }

    public fun withdraw_wdr_sui<T0, T1>(arg0: &mut NaviAdapter<T0, T1>, arg1: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::SAMState<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &mut 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::WithdrawRequest<T0, T1>, arg10: &0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::sam_allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_exact_sui<T0, T1>(arg0, 0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::wdr::get_coin_amount<T0, T1>(arg9), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg11);
        let v1 = NaviWitness<T1>{dummy_field: false};
        0x6f3c9ce6b1f496974066ab37640eb09017a6b9d392138039021db4e4e4c6032c::state::fill_withdraw_request<T0, T1, NaviWitness<T1>>(arg1, arg9, v0, v1, arg10, arg11);
    }

    public fun witness_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<NaviWitness<T0>>()
    }

    // decompiled from Move bytecode v7
}

