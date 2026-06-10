module 0x6d1b04107e3973507b0aab3ac38677070ec8e6569f3d94e6fadaf960d8d263b7::current_adapter {
    struct RewardBufferKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct CurrentWitness<phantom T0> has drop {
        dummy_field: bool,
    }

    struct CurrentAdapter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_in: u64,
        obligation_owner_cap: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ObligationOwnerCap,
        dust: 0x2::balance::Balance<T0>,
        reward_pool_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        min_reward_redeem: u64,
        apr: u256,
        apr_ratio: u256,
        apr_sync_ms: u64,
        reward_flow: u64,
        reward_apr: u256,
        reward_sync_ms: u64,
    }

    struct RewardHarvest<phantom T0, phantom T1> {
        earnings: 0x2::balance::Balance<T0>,
        available: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        apr: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
        depth: 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18,
    }

    public fun new<T0, T1>(arg0: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg2: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::acl::AdminWitness<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam::SAM>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CurrentAdapter<T0, T1>{
            id                   : 0x2::object::new(arg3),
            coin_in              : 0,
            obligation_owner_cap : 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::enter_market::enter_market_return<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg0, arg1, arg3),
            dust                 : 0x2::balance::zero<T0>(),
            reward_pool_table    : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg3),
            min_reward_redeem    : 1000000,
            apr                  : 0,
            apr_ratio            : 0,
            apr_sync_ms          : 0,
            reward_flow          : 0,
            reward_apr           : 0,
            reward_sync_ms       : 0,
        };
        0x2::transfer::public_share_object<CurrentAdapter<T0, T1>>(v0);
    }

    public fun allocate_to_protocol<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T0, T1>, arg5: &0x2::clock::Clock, arg6: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CurrentWitness<T1>{dummy_field: false};
        let v1 = 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::allocate_to_protocol<T0, T1, CurrentWitness<T1>>(arg1, arg4, v0, arg6, arg7);
        arg0.coin_in = arg0.coin_in + 0x2::balance::value<T0>(&v1);
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::deposit::deposit<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket, T0>(arg2, arg3, &arg0.obligation_owner_cap, 0x2::coin::from_balance<T0>(v1, arg7), arg5, arg7);
    }

    public fun begin_approve<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, T1> {
        let v0 = arg0.coin_in;
        begin_approve_with_depth<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public fun begin_approve_with_depth<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : RewardHarvest<T0, T1> {
        let v0 = redeem_growth<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg7, arg8);
        snapshot<T0, T1>(arg0, arg1, v0, arg6, withdrawable_value<T0, T1>(arg0, arg3))
    }

    fun buffer_add<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<RewardBufferKey>(arg0, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0);
            0x2::balance::join<T0>(v2, arg1);
            0x2::balance::value<T0>(v2)
        } else if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            0
        } else {
            0x2::dynamic_field::add<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
            0x2::balance::value<T0>(&arg1)
        }
    }

    fun buffer_excess<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T0>(&arg1) <= arg2) {
            return arg1
        };
        0x2::balance::join<T0>(&mut arg0.dust, 0x2::balance::split<T0>(&mut arg1, 0x2::balance::value<T0>(&arg1) - arg2));
        arg1
    }

    fun buffer_take<T0>(arg0: &mut 0x2::object::UID) : 0x2::balance::Balance<T0> {
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<RewardBufferKey>(arg0, v0)) {
            0x2::dynamic_field::remove<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun drop_reward_pool<T0, T1, T2>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::acl::AdminWitness<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam::SAM>) {
        0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T2>());
    }

    public fun end_approve<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::ptr::ProtocolRequest<T0>, arg3: RewardHarvest<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        let RewardHarvest {
            earnings  : v0,
            available : v1,
            apr       : v2,
            depth     : v3,
        } = arg3;
        let (v4, v5, v6) = 0x4e4803595f76d5e15f05b3ee939638f0e4b6b0a485d743400b73d9914bcc946::apr::accrue_reward(arg0.reward_apr, arg0.reward_flow, arg0.coin_in, arg0.reward_sync_ms, 0x2::clock::timestamp_ms(arg4));
        arg0.reward_apr = v4;
        arg0.reward_flow = v5;
        arg0.reward_sync_ms = v6;
        let v7 = CurrentWitness<T1>{dummy_field: false};
        0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::approve_protocol_request<T0, T1, CurrentWitness<T1>>(arg1, arg2, v1, v3, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::add(v2, 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(v4)), v0, v7, arg5, arg6);
    }

    fun get_apr<T0, T1>(arg0: &CurrentAdapter<T0, T1>) : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::Fixed18 {
        0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::from_raw_u256(arg0.apr)
    }

    public fun harvest_reward_native<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &mut RewardHarvest<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (!has_deposit<T0, T1>(arg0, arg3)) {
            return
        };
        let v0 = 0x2::coin::into_balance<T0>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::liquidity_mining::claim_reward_as_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket, T0, T0>(arg2, arg3, &arg0.obligation_owner_cap, arg4, arg5, arg6, arg7));
        arg0.reward_flow = arg0.reward_flow + 0x2::balance::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg1.earnings, v0);
    }

    public fun harvest_reward_swap<T0, T1, T2>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &mut RewardHarvest<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>>(arg5) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, 0x1::type_name::with_defining_ids<T2>()), 0);
        if (!has_deposit<T0, T1>(arg0, arg3)) {
            return
        };
        let v0 = &mut arg0.id;
        if (buffer_add<T2>(v0, 0x2::coin::into_balance<T2>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::liquidity_mining::claim_reward_as_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket, T0, T2>(arg2, arg3, &arg0.obligation_owner_cap, arg6, arg7, arg8, arg9))) < arg0.min_reward_redeem) {
            return
        };
        let v1 = &mut arg0.id;
        let v2 = buffer_take<T2>(v1);
        let v3 = &mut v2;
        let v4 = swap_b_to_a<T0, T2>(arg4, arg5, v3, arg8);
        let v5 = &mut arg0.id;
        buffer_add<T2>(v5, v2);
        arg0.reward_flow = arg0.reward_flow + 0x2::balance::value<T0>(&v4);
        0x2::balance::join<T0>(&mut arg1.earnings, v4);
    }

    fun has_deposit<T0, T1>(arg0: &CurrentAdapter<T0, T1>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>) : bool {
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ctoken_amount_by_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::borrow_obligation<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg1, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&arg0.obligation_owner_cap)), 0x1::type_name::with_defining_ids<T0>()) > 0
    }

    public fun min_reward_redeem<T0, T1>(arg0: &CurrentAdapter<T0, T1>) : u64 {
        arg0.min_reward_redeem
    }

    fun redeem_exact<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ctoken_amount_by_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::borrow_obligation<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg2, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&arg0.obligation_owner_cap)), v0);
        let v2 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::exchange_rate<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg2, v0);
        let v3 = 0x1::u64::min(arg5, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::mul_u64(v2, v1)));
        let v4 = if (arg0.coin_in > v3) {
            arg0.coin_in - v3
        } else {
            0
        };
        arg0.coin_in = v4;
        if (v3 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v5 = 0x2::coin::into_balance<T0>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket, T0>(arg1, arg2, &arg0.obligation_owner_cap, arg3, 0x1::u64::min(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::ceil(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from(v3), v2)), v1), arg4, arg6, arg7));
        buffer_excess<T0, T1>(arg0, v5, v3)
    }

    fun redeem_growth<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg3: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg4: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ctoken_amount_by_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::borrow_obligation<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg2, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&arg0.obligation_owner_cap)), v0);
        let v2 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::exchange_rate<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg2, v0);
        let v3 = 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::mul_u64(v2, v1));
        let (v4, v5, v6) = 0x4e4803595f76d5e15f05b3ee939638f0e4b6b0a485d743400b73d9914bcc946::apr::update_apr_from_ratio(arg0.apr, arg0.apr_ratio, arg0.apr_sync_ms, 0x4e4803595f76d5e15f05b3ee939638f0e4b6b0a485d743400b73d9914bcc946::apr::ratio_from_amounts(v3, v1), 0x2::clock::timestamp_ms(arg5));
        arg0.apr = v4;
        arg0.apr_ratio = v5;
        arg0.apr_sync_ms = v6;
        let v7 = 0x2::balance::withdraw_all<T0>(&mut arg0.dust);
        if (v3 > arg0.coin_in) {
            let v8 = v3 - arg0.coin_in;
            if (v8 >= 1000) {
                0x2::balance::join<T0>(&mut v7, 0x2::coin::into_balance<T0>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket, T0>(arg1, arg2, &arg0.obligation_owner_cap, arg3, 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::div(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::from(v8), v2)), arg4, arg5, arg6)));
            };
        };
        v7
    }

    public fun set_min_reward_redeem<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: u64, arg2: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::acl::AdminWitness<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam::SAM>) {
        arg0.min_reward_redeem = arg1;
    }

    public fun set_reward_pool<T0, T1, T2>(arg0: &mut CurrentAdapter<T0, T1>, arg1: 0x2::object::ID, arg2: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::acl::AdminWitness<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam::SAM>) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.reward_pool_table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.reward_pool_table, v0, arg1);
    }

    fun snapshot<T0, T1>(arg0: &CurrentAdapter<T0, T1>, arg1: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64) : RewardHarvest<T0, T1> {
        let v0 = 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::decimals<T0, T1>(arg1);
        let v1 = if (arg3 < arg4) {
            arg3
        } else {
            arg4
        };
        RewardHarvest<T0, T1>{
            earnings  : arg2,
            available : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(v1, v0),
            apr       : get_apr<T0, T1>(arg0),
            depth     : 0x99a1d666d9e4792bee2f34a2693aeab95a57b3c662da2e68574a03e929e60b0e::fixed18::u64_to_fixed18(arg3, v0),
        }
    }

    fun swap_b_to_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(arg2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), arg3);
        let v3 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), v3);
        0x2::balance::join<T1>(arg2, v1);
        v0
    }

    public fun update_apr<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: u256, arg2: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::acl::AdminWitness<0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam::SAM>) {
        arg0.apr = arg1;
    }

    public fun withdraw_rbr<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::RebalanceRequest<T0, T1>, arg7: &0x2::clock::Clock, arg8: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_exact<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::rbr::amount<T0, T1>(arg6), arg7, arg9);
        let v1 = CurrentWitness<T1>{dummy_field: false};
        0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::fill_rebalance_request<T0, T1, CurrentWitness<T1>>(arg1, arg6, v0, v1, arg8, arg9);
    }

    public fun withdraw_wdr<T0, T1>(arg0: &mut CurrentAdapter<T0, T1>, arg1: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::SAMState<T0, T1>, arg2: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg3: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>, arg4: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &mut 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::WithdrawRequest<T0, T1>, arg7: &0x2::clock::Clock, arg8: &0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::sam_allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_exact<T0, T1>(arg0, arg2, arg3, arg4, arg5, 0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::wdr::get_coin_amount<T0, T1>(arg6), arg7, arg9);
        let v1 = CurrentWitness<T1>{dummy_field: false};
        0x9316c04dba4e6ac65118fc4132b0b23610d1e24e2d2d2edfd22f9b07b6d850a9::state::fill_withdraw_request<T0, T1, CurrentWitness<T1>>(arg1, arg6, v0, v1, arg8, arg9);
    }

    fun withdrawable_value<T0, T1>(arg0: &CurrentAdapter<T0, T1>, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::floor(0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::mul_u64(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::exchange_rate<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg1, v0), 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::ctoken_amount_by_coin<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::borrow_obligation<0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market_type::MainMarket>(arg1, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::obligation::id(&arg0.obligation_owner_cap)), v0)))
    }

    public fun witness_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<CurrentWitness<T0>>()
    }

    // decompiled from Move bytecode v7
}

