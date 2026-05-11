module 0x392376028bff8a4ab3103e4d1dc306de89ffae8abae99bc8e74fda284c21d935::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        create_fee: u64,
        rapid_create_fee: u64,
        rapid_create_window_ms: u64,
        last_launch_ms: u64,
        creator_fee_bps: u16,
        flags: u8,
        launch_count: u64,
        accrued_create_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Launch<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        pool_id: 0x2::object::ID,
        seed_position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        launch_position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        fixed_supply: 0x1::option::Option<0x2::balance::Supply<T0>>,
        creator_fee_bps: u16,
        created_ms: u64,
        finalized_ms: u64,
        metadata_uri: vector<u8>,
    }

    struct LaunchCreated<phantom T0, phantom T1> has copy, drop {
        version: u16,
        launch_id: 0x2::object::ID,
        creator: address,
        cetus_pool_id: 0x2::object::ID,
        seed_position_id: 0x2::object::ID,
        creator_fee_bps: u16,
        created_ms: u64,
        metadata_uri: vector<u8>,
    }

    struct LaunchFinalized<phantom T0, phantom T1> has copy, drop {
        version: u16,
        launch_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        launch_position_id: 0x2::object::ID,
        token_amount: u64,
        token_amount_used: u64,
        finalized_ms: u64,
    }

    struct FeesCollected<phantom T0, phantom T1> has copy, drop {
        version: u16,
        launch_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        collector: address,
        creator: address,
        treasury: address,
        amount_a: u64,
        amount_b: u64,
        creator_amount_a: u64,
        creator_amount_b: u64,
        treasury_amount_a: u64,
        treasury_amount_b: u64,
    }

    struct CreateFeesCollected has copy, drop {
        version: u16,
        config_id: 0x2::object::ID,
        collector: address,
        recipient: address,
        amount: u64,
    }

    struct PauseUpdated has copy, drop {
        version: u16,
        config_id: 0x2::object::ID,
        flags: u8,
    }

    struct ConfigUpdated has copy, drop {
        version: u16,
        config_id: 0x2::object::ID,
        admin: address,
        treasury: address,
        create_fee: u64,
        rapid_create_fee: u64,
        creator_fee_bps: u16,
        flags: u8,
    }

    fun assert_admin(arg0: &AdminCap, arg1: &Config, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.admin, 1);
    }

    fun assert_fee_bps(arg0: u16) {
        assert!((arg0 as u64) <= 10000, 4);
    }

    fun assert_pool_matches<T0, T1>(arg0: &Launch<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(arg0.pool_id == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), 9);
    }

    fun burn_or_destroy_zero<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::coin::burn<T0>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
    }

    fun collect_create_fee(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = current_create_fee(arg0, arg2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1) >= v0, 5);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.accrued_create_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0));
        };
        refund_balance_if_any<0x2::sui::SUI>(v1, arg3, arg4);
    }

    public fun collect_create_fees(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.accrued_create_fees);
        let v1 = if (arg2 == 0 || arg2 > v0) {
            v0
        } else {
            arg2
        };
        assert!(v1 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.accrued_create_fees, v1), arg3), arg1.treasury);
        let v2 = CreateFeesCollected{
            version   : 2,
            config_id : 0x2::object::id<Config>(arg1),
            collector : 0x2::tx_context::sender(arg3),
            recipient : arg1.treasury,
            amount    : v1,
        };
        0x2::event::emit<CreateFeesCollected>(v2);
    }

    public fun collect_fees<T0, T1>(arg0: &Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut Launch<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags & 2 == 0, 3);
        assert_pool_matches<T0, T1>(arg3, arg2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg3.seed_position, true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = v4;
        let v6 = 0x2::balance::value<T1>(&v2);
        let v7 = v6;
        let v8 = distribute_balance<T0>(v3, arg3.creator, arg0.treasury, arg3.creator_fee_bps, arg4);
        let v9 = v8;
        let v10 = distribute_balance<T1>(v2, arg3.creator, arg0.treasury, arg3.creator_fee_bps, arg4);
        let v11 = v10;
        if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3.launch_position)) {
            let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3.launch_position), true);
            let v14 = v13;
            let v15 = v12;
            v5 = v4 + 0x2::balance::value<T0>(&v15);
            v7 = v6 + 0x2::balance::value<T1>(&v14);
            let v16 = distribute_balance<T0>(v15, arg3.creator, arg0.treasury, arg3.creator_fee_bps, arg4);
            v9 = v8 + v16;
            let v17 = distribute_balance<T1>(v14, arg3.creator, arg0.treasury, arg3.creator_fee_bps, arg4);
            v11 = v10 + v17;
        };
        let v18 = FeesCollected<T0, T1>{
            version           : 2,
            launch_id         : 0x2::object::id<Launch<T0, T1>>(arg3),
            cetus_pool_id     : arg3.pool_id,
            collector         : 0x2::tx_context::sender(arg4),
            creator           : arg3.creator,
            treasury          : arg0.treasury,
            amount_a          : v5,
            amount_b          : v7,
            creator_amount_a  : v9,
            creator_amount_b  : v11,
            treasury_amount_a : v5 - v9,
            treasury_amount_b : v7 - v11,
        };
        0x2::event::emit<FeesCollected<T0, T1>>(v18);
    }

    public fun config_state(arg0: &Config) : (address, address, u64, u64, u16, u8, u64) {
        (arg0.admin, arg0.treasury, arg0.create_fee, arg0.rapid_create_fee, arg0.creator_fee_bps, arg0.flags, arg0.launch_count)
    }

    public fun create_config(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert_fee_bps(arg5);
        let v0 = Config{
            id                     : 0x2::object::new(arg6),
            admin                  : 0x2::tx_context::sender(arg6),
            treasury               : arg1,
            create_fee             : arg2,
            rapid_create_fee       : arg3,
            rapid_create_window_ms : arg4,
            last_launch_ms         : 0,
            creator_fee_bps        : arg5,
            flags                  : 0,
            launch_count           : 0,
            accrued_create_fees    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = ConfigUpdated{
            version          : 2,
            config_id        : 0x2::object::id<Config>(&v0),
            admin            : v0.admin,
            treasury         : arg1,
            create_fee       : arg2,
            rapid_create_fee : arg3,
            creator_fee_bps  : arg5,
            flags            : 0,
        };
        0x2::event::emit<ConfigUpdated>(v1);
        0x2::transfer::share_object<Config>(v0);
    }

    public fun create_default_config(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        create_config(arg0, arg1, arg2, arg3, arg4, 5000, arg5);
    }

    public fun create_seeded_cetus_pool_a<T0, T1>(arg0: &mut Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u32, arg8: u128, arg9: u32, arg10: u32, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags & 1 == 0, 2);
        assert!(arg6 > 0, 6);
        assert!(0x2::coin::value<T1>(&arg4) > 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg12);
        let v1 = 0x2::tx_context::sender(arg13);
        collect_create_fee(arg0, arg5, v0, v1, arg13);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3<T0, T1>(arg1, arg2, arg7, arg8, 0x1::string::utf8(arg11), arg9, arg10, 0x2::coin::mint<T0>(&mut arg3, arg6, arg13), arg4, true, arg12, arg13);
        let v5 = v2;
        let v6 = &mut arg3;
        burn_or_destroy_zero<T0>(v6, v3);
        refund_coin_if_any<T1>(v4, 0x2::tx_context::sender(arg13));
        let v7 = Launch<T0, T1>{
            id              : 0x2::object::new(arg13),
            creator         : 0x2::tx_context::sender(arg13),
            pool_id         : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v5),
            seed_position   : v5,
            launch_position : 0x1::option::none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            treasury_cap    : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg3),
            fixed_supply    : 0x1::option::none<0x2::balance::Supply<T0>>(),
            creator_fee_bps : arg0.creator_fee_bps,
            created_ms      : v0,
            finalized_ms    : 0,
            metadata_uri    : arg11,
        };
        arg0.last_launch_ms = v0;
        arg0.launch_count = arg0.launch_count + 1;
        let v8 = LaunchCreated<T0, T1>{
            version          : 2,
            launch_id        : 0x2::object::id<Launch<T0, T1>>(&v7),
            creator          : v7.creator,
            cetus_pool_id    : v7.pool_id,
            seed_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v7.seed_position),
            creator_fee_bps  : v7.creator_fee_bps,
            created_ms       : v7.created_ms,
            metadata_uri     : v7.metadata_uri,
        };
        0x2::event::emit<LaunchCreated<T0, T1>>(v8);
        0x2::transfer::share_object<Launch<T0, T1>>(v7);
    }

    fun current_create_fee(arg0: &Config, arg1: u64) : u64 {
        if (arg0.last_launch_ms > 0 && arg1 < arg0.last_launch_ms + arg0.rapid_create_window_ms) {
            arg0.rapid_create_fee
        } else {
            arg0.create_fee
        }
    }

    fun distribute_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: address, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return 0
        };
        let v1 = (((v0 as u128) * ((arg3 as u64) as u128) / (10000 as u128)) as u64);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0, v1), arg4), arg1);
        };
        refund_balance_if_any<T0>(arg0, arg2, arg4);
        v1
    }

    public fun finalize_single_sided_position_a<T0, T1>(arg0: &Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut Launch<T0, T1>, arg4: u64, arg5: u32, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.flags & 1 == 0, 2);
        assert!(0x2::tx_context::sender(arg8) == arg3.creator, 7);
        assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3.launch_position), 8);
        assert!(arg4 > 0, 6);
        assert_pool_matches<T0, T1>(arg3, arg2);
        let v0 = 0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg3.treasury_cap);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg8);
        let v2 = 0x2::coin::mint<T0>(&mut v0, arg4, arg8);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v1, arg4, true, arg7);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        assert!(v5 == 0, 10);
        assert!(v4 > 0, 6);
        assert!(v4 <= 0x2::coin::value<T0>(&v2), 11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v4, arg8)), 0x2::balance::zero<T1>(), v3);
        let v6 = &mut v0;
        burn_or_destroy_zero<T0>(v6, v2);
        0x1::option::fill<0x2::balance::Supply<T0>>(&mut arg3.fixed_supply, 0x2::coin::treasury_into_supply<T0>(v0));
        let v7 = 0x2::clock::timestamp_ms(arg7);
        arg3.finalized_ms = v7;
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg3.launch_position, v1);
        let v8 = LaunchFinalized<T0, T1>{
            version            : 2,
            launch_id          : 0x2::object::id<Launch<T0, T1>>(arg3),
            cetus_pool_id      : arg3.pool_id,
            launch_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            token_amount       : arg4,
            token_amount_used  : v4,
            finalized_ms       : v7,
        };
        0x2::event::emit<LaunchFinalized<T0, T1>>(v8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun launch_state<T0, T1>(arg0: &Launch<T0, T1>) : (address, 0x2::object::ID, 0x2::object::ID, bool, u16, u64, u64, vector<u8>) {
        (arg0.creator, arg0.pool_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.seed_position), 0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.launch_position), arg0.creator_fee_bps, arg0.created_ms, arg0.finalized_ms, arg0.metadata_uri)
    }

    fun refund_balance_if_any<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    fun refund_coin_if_any<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun set_config(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u16, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg8);
        assert_fee_bps(arg6);
        arg1.treasury = arg2;
        arg1.create_fee = arg3;
        arg1.rapid_create_fee = arg4;
        arg1.rapid_create_window_ms = arg5;
        arg1.creator_fee_bps = arg6;
        arg1.flags = arg7;
        let v0 = ConfigUpdated{
            version          : 2,
            config_id        : 0x2::object::id<Config>(arg1),
            admin            : arg1.admin,
            treasury         : arg2,
            create_fee       : arg3,
            rapid_create_fee : arg4,
            creator_fee_bps  : arg6,
            flags            : arg7,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_flags(arg0: &AdminCap, arg1: &mut Config, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        arg1.flags = arg2;
        let v0 = PauseUpdated{
            version   : 2,
            config_id : 0x2::object::id<Config>(arg1),
            flags     : arg2,
        };
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun transfer_admin(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1, arg3);
        arg1.admin = arg2;
    }

    // decompiled from Move bytecode v7
}

