module 0x7ec68f4115dc2944426239b13ce6804dd9971b24069fb4efe88360d29b17f0ce::xpump_migrator {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct XPumpConfig has key {
        id: 0x2::object::UID,
        initialize_price: u128,
        treasury: address,
        reward_value: u64,
        treasury_fee: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        package_version: u64,
    }

    struct PositionOwner has store, key {
        id: 0x2::object::UID,
        pool: address,
        position: address,
        meme: 0x1::type_name::TypeName,
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct PositionKeyV2 has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct PositionData<phantom T0> has store {
        pool: address,
        position: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position,
        position_owner: address,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NewPool has copy, drop {
        pool: address,
        tick_spacing: u32,
        meme: 0x1::type_name::TypeName,
        meme_amount: u64,
        sui_amount: u64,
        position: address,
        dev: address,
    }

    struct SetTreasury has copy, drop {
        pos0: address,
        pos1: address,
    }

    struct SetInitializePrice has copy, drop {
        pos0: u128,
        pos1: u128,
    }

    struct SetRewardValue has copy, drop {
        pos0: u64,
        pos1: u64,
    }

    struct SetTreasuryFee has copy, drop {
        pos0: u64,
        pos1: u64,
    }

    struct UpdatePositionOwner has copy, drop {
        old_position_owner: address,
        new_position_owner: address,
        meme: 0x1::type_name::TypeName,
    }

    struct CollectFee has copy, drop {
        pool: address,
        position_owner: address,
        position: address,
        owner_meme_amount: u64,
        owner_sui_amount: u64,
        treasury_meme_amount: u64,
        treasury_sui_amount: u64,
    }

    public fun collect_fee<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &PositionOwner, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_package_version(arg0);
        let v0 = arg0.treasury_fee;
        let v1 = position_mut<T0>(arg0);
        assert!(arg4.position == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1.position), 13906835956754808831);
        assert!(arg4.pool == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 13906835961049776127);
        let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v1.position);
        let v6 = v5;
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut v6, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v0, v3));
        let v8 = CollectFee{
            pool                 : v1.pool,
            position_owner       : 0x2::object::uid_to_address(&arg4.id),
            position             : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1.position),
            owner_meme_amount    : 0,
            owner_sui_amount     : 0x2::balance::value<0x2::sui::SUI>(&v6) + 0x2::balance::value<0x2::sui::SUI>(&v1.sui_balance),
            treasury_meme_amount : v2,
            treasury_sui_amount  : 0x2::balance::value<0x2::sui::SUI>(&v7),
        };
        0x2::event::emit<CollectFee>(v8);
        0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.sui_balance));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg5), arg0.treasury);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5)
    }

    public fun position<T0>(arg0: &XPumpConfig) : &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        &get_position<T0>(arg0).position
    }

    public fun add_liquidity_to_existing_pool<T0>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_package_version(arg0);
        assert!(0x2::coin::get_decimals<T0>(arg5) == 9, 0);
        assert!(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::total_supply<T0>(arg4) == 1000000000000000000, 1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, 0x2::sui::SUI>(arg2) == 10000, 13906835359754354687);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, 0x2::sui::SUI>(arg2) == 200, 13906835364049321983);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg1, arg2, 4294523696, 443600, arg8);
        let v1 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v0, 0x2::coin::into_balance<T0>(arg7), 0x2::coin::into_balance<0x2::sui::SUI>(arg6), 0x2::coin::value<0x2::sui::SUI>(&arg6), false);
        let v6 = PositionOwner{
            id       : 0x2::object::new(arg8),
            pool     : v1,
            position : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0),
            meme     : 0x1::type_name::get<T0>(),
        };
        let v7 = PositionData<T0>{
            pool           : v1,
            position       : v0,
            position_owner : 0x2::object::uid_to_address(&v6.id),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        save_position_v2<T0>(arg0, v7);
        0x2::transfer::public_transfer<PositionOwner>(v6, 0x2::tx_context::sender(arg8));
        destroy_zero_or_transfer<T0>(0x2::coin::from_balance<T0>(v4, arg8), 0x2::tx_context::sender(arg8));
        destroy_zero_or_transfer<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg8), 0x2::tx_context::sender(arg8));
    }

    fun assert_package_version(arg0: &XPumpConfig) {
        assert!(arg0.package_version == 1, 2);
    }

    public fun destroy_position_owner<T0>(arg0: &mut XPumpConfig, arg1: PositionOwner) {
        assert_package_version(arg0);
        let v0 = position_mut<T0>(arg0);
        let PositionOwner {
            id       : v1,
            pool     : v2,
            position : v3,
            meme     : _,
        } = arg1;
        let v5 = v1;
        assert!(v3 == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0.position), 13906836137143435263);
        assert!(v2 == v0.pool, 13906836141438402559);
        if (v0.position_owner == 0x2::object::uid_to_address(&v5)) {
            v0.position_owner = @0x0;
        };
        0x2::object::delete(v5);
    }

    fun destroy_zero_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    fun get_position<T0>(arg0: &XPumpConfig) : &PositionData<T0> {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow<PositionKey, PositionData<T0>>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XPumpConfig{
            id               : 0x2::object::new(arg0),
            initialize_price : 63901395939770060,
            treasury         : @0x881d835c410f33a1decd8067ce04f6c2ec63eaca196235386b44d315c2152797,
            reward_value     : 1000000000,
            treasury_fee     : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(5000),
            package_version  : 1,
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<XPumpConfig>(v0);
        0x2::transfer::public_transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate_to_existing_pool<T0>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_package_version(arg0);
        assert!(0x2::coin::get_decimals<T0>(arg5) == 9, 0);
        assert!(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::total_supply<T0>(arg4) == 1000000000000000000, 1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, 0x2::sui::SUI>(arg2) == 10000, 13906835617452392447);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, 0x2::sui::SUI>(arg2) == 200, 13906835621747359743);
        let v0 = Witness{dummy_field: false};
        let (v1, v2, v3) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::destroy<T0, 0x2::sui::SUI, Witness>(arg6, v0);
        let v4 = v3;
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, arg0.reward_value), arg7);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg1, arg2, 4294523696, 443600, arg7);
        let v7 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let (v8, v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v6, v2, v4, 0x2::balance::value<0x2::sui::SUI>(&v4), false);
        let v12 = NewPool{
            pool         : v7,
            tick_spacing : 200,
            meme         : 0x1::type_name::get<T0>(),
            meme_amount  : v8,
            sui_amount   : v9,
            position     : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v6),
            dev          : v1,
        };
        0x2::event::emit<NewPool>(v12);
        let v13 = PositionOwner{
            id       : 0x2::object::new(arg7),
            pool     : v7,
            position : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v6),
            meme     : 0x1::type_name::get<T0>(),
        };
        let v14 = PositionData<T0>{
            pool           : v7,
            position       : v6,
            position_owner : 0x2::object::uid_to_address(&v13.id),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        save_position<T0>(arg0, v14);
        0x2::transfer::public_transfer<PositionOwner>(v13, v1);
        destroy_zero_or_transfer<T0>(0x2::coin::from_balance<T0>(v10, arg7), @0x0);
        destroy_zero_or_transfer<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg7), arg0.treasury);
        v5
    }

    public fun migrate_to_new_pool<T0, T1>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2, v3, v4, v5) = new_pool_and_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let (v9, v10, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, 0x2::sui::SUI>(arg2, arg1, &mut v8, &mut v7, v4, v6, 0x1::u64::min(0x2::balance::value<0x2::sui::SUI>(&v6), 2400000000000), false);
        share_pool_and_save_position<T0>(arg0, v8, v7, v9, v10, v11, v12, v0, arg8);
        v5
    }

    public fun migrate_to_new_pool_with_liquidity<T0, T1>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2, v3, v4, v5) = new_pool_and_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        let v6 = v2;
        let v7 = v1;
        let (v8, v9, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, 0x2::sui::SUI>(arg2, arg1, &mut v7, &mut v6, v4, v3, arg8);
        share_pool_and_save_position<T0>(arg0, v7, v6, v8, v9, v10, v11, v0, arg9);
        v5
    }

    fun new_pool_and_position<T0, T1>(arg0: &XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : (address, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_package_version(arg0);
        assert!(0x2::coin::get_decimals<T0>(arg5) == 9, 0);
        assert!(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::total_supply<T0>(arg3) == 1000000000000000000, 1);
        let v0 = Witness{dummy_field: false};
        let (v1, v2, v3) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::destroy<T0, 0x2::sui::SUI, Witness>(arg6, v0);
        let v4 = v3;
        let v5 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<T0>(arg5), 0x2::url::new_unsafe_from_bytes(b""));
        let v6 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<0x2::sui::SUI>(arg4), 0x2::url::new_unsafe_from_bytes(b""));
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, 0x2::sui::SUI, T1>(arg2, arg1, pool_name<T0>(arg5), b"", 0x1::ascii::into_bytes(0x2::coin::get_symbol<T0>(arg5)), 0x2::coin::get_decimals<T0>(arg5), 0x1::ascii::into_bytes(0x2::url::inner_url(&v5)), 0x1::ascii::into_bytes(0x2::coin::get_symbol<0x2::sui::SUI>(arg4)), 0x2::coin::get_decimals<0x2::sui::SUI>(arg4), 0x1::ascii::into_bytes(0x2::url::inner_url(&v6)), 200, 10000, arg0.initialize_price, 0x2::coin::into_balance<T1>(arg7), arg8);
        (v1, v7, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0x2::sui::SUI>(arg1, &mut v7, 4294523696, 443600, arg8), v4, v2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, arg0.reward_value), arg8))
    }

    public fun new_position_owner<T0>(arg0: &mut XPumpConfig, arg1: &Admin, arg2: &mut 0x2::tx_context::TxContext) : PositionOwner {
        let v0 = position_mut<T0>(arg0);
        let v1 = PositionOwner{
            id       : 0x2::object::new(arg2),
            pool     : v0.pool,
            position : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0.position),
            meme     : 0x1::type_name::get<T0>(),
        };
        v0.position_owner = 0x2::object::uid_to_address(&v1.id);
        v1
    }

    fun pool_name<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : vector<u8> {
        let v0 = b"xPump-";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::coin::get_name<T0>(arg0)));
        0x1::vector::append<u8>(&mut v0, b"/");
        0x1::vector::append<u8>(&mut v0, b"SUI");
        v0
    }

    public fun position_data<T0>(arg0: &XPumpConfig) : &PositionData<T0> {
        get_position<T0>(arg0)
    }

    public fun position_data_owner<T0>(arg0: &XPumpConfig) : address {
        get_position<T0>(arg0).position_owner
    }

    fun position_mut<T0>(arg0: &mut XPumpConfig) : &mut PositionData<T0> {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow_mut<PositionKey, PositionData<T0>>(&mut arg0.id, v0)
    }

    public fun position_pool<T0>(arg0: &XPumpConfig) : address {
        get_position<T0>(arg0).pool
    }

    fun save_position<T0>(arg0: &mut XPumpConfig, arg1: PositionData<T0>) {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::add<PositionKey, PositionData<T0>>(&mut arg0.id, v0, arg1);
    }

    fun save_position_v2<T0>(arg0: &mut XPumpConfig, arg1: PositionData<T0>) {
        let v0 = PositionKeyV2{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::add<PositionKeyV2, PositionData<T0>>(&mut arg0.id, v0, arg1);
    }

    public fun set_initialize_price(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u128) {
        assert!(arg2 != 0, 13906836442086113279);
        let v0 = SetInitializePrice{
            pos0 : arg0.initialize_price,
            pos1 : arg2,
        };
        0x2::event::emit<SetInitializePrice>(v0);
        arg0.initialize_price = arg2;
    }

    public fun set_reward_value(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u64) {
        let v0 = SetRewardValue{
            pos0 : arg0.reward_value,
            pos1 : arg2,
        };
        0x2::event::emit<SetRewardValue>(v0);
        arg0.reward_value = arg2;
    }

    public fun set_treasury(arg0: &mut XPumpConfig, arg1: &Admin, arg2: address) {
        let v0 = SetTreasury{
            pos0 : arg0.treasury,
            pos1 : arg2,
        };
        0x2::event::emit<SetTreasury>(v0);
        arg0.treasury = arg2;
    }

    public fun set_treasury_fee(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u64) {
        let v0 = SetTreasuryFee{
            pos0 : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::value(arg0.treasury_fee),
            pos1 : arg2,
        };
        0x2::event::emit<SetTreasuryFee>(v0);
        arg0.treasury_fee = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg2);
    }

    fun share_pool_and_save_position<T0>(arg0: &mut XPumpConfig, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(&arg1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, 0x2::sui::SUI>(arg1);
        let v1 = NewPool{
            pool         : v0,
            tick_spacing : 200,
            meme         : 0x1::type_name::get<T0>(),
            meme_amount  : arg3,
            sui_amount   : arg4,
            position     : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2),
            dev          : arg7,
        };
        0x2::event::emit<NewPool>(v1);
        let v2 = PositionOwner{
            id       : 0x2::object::new(arg8),
            pool     : v0,
            position : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2),
            meme     : 0x1::type_name::get<T0>(),
        };
        let v3 = PositionData<T0>{
            pool           : v0,
            position       : arg2,
            position_owner : 0x2::object::uid_to_address(&v2.id),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        save_position<T0>(arg0, v3);
        0x2::transfer::public_transfer<PositionOwner>(v2, arg7);
        destroy_zero_or_transfer<T0>(0x2::coin::from_balance<T0>(arg5, arg8), arg0.treasury);
        destroy_zero_or_transfer<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(arg6, arg8), arg0.treasury);
    }

    public fun treasury_collect_fee<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_package_version(arg0);
        let v0 = arg0.treasury_fee;
        let v1 = position_mut<T0>(arg0);
        assert!(v1.pool == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 13906836235927683071);
        let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v1.position);
        let v6 = v5;
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut v6, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v0, v3));
        let v8 = CollectFee{
            pool                 : v1.pool,
            position_owner       : v1.position_owner,
            position             : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v1.position),
            owner_meme_amount    : 0,
            owner_sui_amount     : 0,
            treasury_meme_amount : v2,
            treasury_sui_amount  : 0x2::balance::value<0x2::sui::SUI>(&v7),
        };
        0x2::event::emit<CollectFee>(v8);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.sui_balance, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg4), arg0.treasury);
    }

    public fun update_position_owner<T0>(arg0: &mut XPumpConfig, arg1: &Admin, arg2: address) {
        let v0 = position_mut<T0>(arg0);
        let v1 = UpdatePositionOwner{
            old_position_owner : v0.position_owner,
            new_position_owner : arg2,
            meme               : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<UpdatePositionOwner>(v1);
        v0.position_owner = arg2;
    }

    // decompiled from Move bytecode v6
}

