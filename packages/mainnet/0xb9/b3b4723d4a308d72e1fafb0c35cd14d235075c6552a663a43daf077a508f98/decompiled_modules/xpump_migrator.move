module 0xb9b3b4723d4a308d72e1fafb0c35cd14d235075c6552a663a43daf077a508f98::xpump_migrator {
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
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct PositionData has store {
        pool: address,
        dev: address,
        position: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position,
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

    struct CollectFee has copy, drop {
        pool: address,
        dev: address,
        meme_amount: u64,
        sui_amount: u64,
    }

    public fun collect_fee<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = position_mut<T0>(arg0);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == v0.dev, 13906835355459387391);
        let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v0.position);
        let v6 = CollectFee{
            pool        : v0.pool,
            dev         : v1,
            meme_amount : v2,
            sui_amount  : v3,
        };
        0x2::event::emit<CollectFee>(v6);
        (0x2::coin::from_balance<T0>(v4, arg4), 0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4))
    }

    public fun position<T0>(arg0: &XPumpConfig) : &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        &get_position<T0>(arg0).position
    }

    fun destroy_zero_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    fun get_position<T0>(arg0: &XPumpConfig) : &PositionData {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow<PositionKey, PositionData>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XPumpConfig{
            id               : 0x2::object::new(arg0),
            initialize_price : 63901395939770060,
            treasury         : @0x881d835c410f33a1decd8067ce04f6c2ec63eaca196235386b44d315c2152797,
            reward_value     : 1000000000,
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<XPumpConfig>(v0);
        0x2::transfer::public_transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate_to_existing_pool<T0>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::get_decimals<T0>(arg5) == 9, 0);
        assert!(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::total_supply<T0>(arg4) == 1000000000000000000, 1);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, 0x2::sui::SUI>(arg2) == 10000, 13906835071991545855);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, 0x2::sui::SUI>(arg2) == 200, 13906835076286513151);
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
        let v13 = PositionData{
            pool     : v7,
            dev      : v1,
            position : v6,
        };
        save_position<T0>(arg0, v13);
        destroy_zero_or_transfer<T0>(0x2::coin::from_balance<T0>(v10, arg7), @0x0);
        destroy_zero_or_transfer<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg7), arg0.treasury);
        v5
    }

    public fun migrate_to_new_pool<T0, T1>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::get_decimals<T0>(arg5) == 9, 0);
        assert!(0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::total_supply<T0>(arg3) == 1000000000000000000, 1);
        let v0 = Witness{dummy_field: false};
        let (v1, v2, v3) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::destroy<T0, 0x2::sui::SUI, Witness>(arg6, v0);
        let v4 = v3;
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, arg0.reward_value), arg8);
        let v6 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<T0>(arg5), 0x2::url::new_unsafe_from_bytes(b""));
        let v7 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<0x2::sui::SUI>(arg4), 0x2::url::new_unsafe_from_bytes(b""));
        let (v8, v9, v10, v11, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<T0, 0x2::sui::SUI, T1>(arg2, arg1, pool_name<T0>(arg5), b"", 0x1::ascii::into_bytes(0x2::coin::get_symbol<T0>(arg5)), 0x2::coin::get_decimals<T0>(arg5), 0x1::ascii::into_bytes(0x2::url::inner_url(&v6)), 0x1::ascii::into_bytes(0x2::coin::get_symbol<0x2::sui::SUI>(arg4)), 0x2::coin::get_decimals<0x2::sui::SUI>(arg4), 0x1::ascii::into_bytes(0x2::url::inner_url(&v7)), 200, 10000, arg0.initialize_price, 0x2::coin::into_balance<T1>(arg7), 4294523696, 443600, v2, v4, 0x2::balance::value<0x2::sui::SUI>(&v4), false, arg8);
        let v14 = v9;
        let v15 = v8;
        let v16 = 0x2::object::id_to_address(&v15);
        let v17 = NewPool{
            pool         : v16,
            tick_spacing : 200,
            meme         : 0x1::type_name::get<T0>(),
            meme_amount  : v10,
            sui_amount   : v11,
            position     : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v14),
            dev          : v1,
        };
        0x2::event::emit<NewPool>(v17);
        let v18 = PositionData{
            pool     : v16,
            dev      : v1,
            position : v14,
        };
        save_position<T0>(arg0, v18);
        destroy_zero_or_transfer<T0>(0x2::coin::from_balance<T0>(v12, arg8), @0x0);
        destroy_zero_or_transfer<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(v13, arg8), arg0.treasury);
        v5
    }

    fun pool_name<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : vector<u8> {
        let v0 = b"xPump-";
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::coin::get_name<T0>(arg0)));
        0x1::vector::append<u8>(&mut v0, b"/");
        0x1::vector::append<u8>(&mut v0, b"SUI");
        v0
    }

    public fun position_dev<T0>(arg0: &XPumpConfig) : address {
        get_position<T0>(arg0).dev
    }

    fun position_mut<T0>(arg0: &mut XPumpConfig) : &mut PositionData {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow_mut<PositionKey, PositionData>(&mut arg0.id, v0)
    }

    public fun position_pool<T0>(arg0: &XPumpConfig) : address {
        get_position<T0>(arg0).pool
    }

    fun save_position<T0>(arg0: &mut XPumpConfig, arg1: PositionData) {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::add<PositionKey, PositionData>(&mut arg0.id, v0, arg1);
    }

    public fun set_initialize_price(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u128) {
        assert!(arg2 != 0, 13906835510078210047);
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

    // decompiled from Move bytecode v6
}

