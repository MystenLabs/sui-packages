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

    struct Ticks has store {
        min: u32,
        max: u32,
    }

    struct LiquidityMarginKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TicksKey has copy, drop, store {
        dummy_field: bool,
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
        let v1 = arg0.treasury;
        let v2 = position_mut<T0>(arg0);
        assert!(arg4.position == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v2.position), 13906835583092654079);
        assert!(arg4.pool == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 13906835587387621375);
        collect_fee_internal<T0>(v2, arg1, arg2, arg3, arg4, v0, v1, arg5)
    }

    public fun position<T0>(arg0: &XPumpConfig) : &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        &get_position<T0>(arg0).position
    }

    public fun add_liquidity_to_existing_pool<T0>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 13906835445653700607
    }

    fun assert_package_version(arg0: &XPumpConfig) {
        assert!(arg0.package_version == 4, 2);
    }

    public fun collect_all_fees<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &PositionOwner, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = collect_fee<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        if (has_position_v2<T0>(arg0)) {
            0x2::coin::join<0x2::sui::SUI>(&mut v0, collect_fee_v2_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5));
        };
        v0
    }

    fun collect_fee_internal<T0>(arg0: &mut PositionData<T0>, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &PositionOwner, arg5: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let (v0, v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut arg0.position);
        let v4 = v3;
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v4, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg5, v1));
        let v6 = CollectFee{
            pool                 : arg0.pool,
            position_owner       : 0x2::object::uid_to_address(&arg4.id),
            position             : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position),
            owner_meme_amount    : 0,
            owner_sui_amount     : 0x2::balance::value<0x2::sui::SUI>(&v4) + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
            treasury_meme_amount : v0,
            treasury_sui_amount  : 0x2::balance::value<0x2::sui::SUI>(&v5),
        };
        0x2::event::emit<CollectFee>(v6);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg7), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg7), arg6);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg7)
    }

    fun collect_fee_v2_internal<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &PositionOwner, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = arg0.treasury_fee;
        let v1 = arg0.treasury;
        let v2 = position_mut_v2<T0>(arg0);
        collect_fee_internal<T0>(v2, arg1, arg2, arg3, arg4, v0, v1, arg5)
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
        assert!(v3 == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0.position), 13906835772071215103);
        assert!(v2 == v0.pool, 13906835776366182399);
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

    fun get_liquidity_margin(arg0: &XPumpConfig) : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS {
        let v0 = LiquidityMarginKey{dummy_field: false};
        *0x2::dynamic_field::borrow<LiquidityMarginKey, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(&arg0.id, v0)
    }

    fun get_position<T0>(arg0: &XPumpConfig) : &PositionData<T0> {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow<PositionKey, PositionData<T0>>(&arg0.id, v0)
    }

    fun get_ticks(arg0: &XPumpConfig) : &Ticks {
        let v0 = TicksKey{dummy_field: false};
        0x2::dynamic_field::borrow<TicksKey, Ticks>(&arg0.id, v0)
    }

    fun has_position_v2<T0>(arg0: &XPumpConfig) : bool {
        let v0 = PositionKeyV2{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::exists_<PositionKeyV2>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = XPumpConfig{
            id               : 0x2::object::new(arg0),
            initialize_price : 63901395939770060,
            treasury         : @0x881d835c410f33a1decd8067ce04f6c2ec63eaca196235386b44d315c2152797,
            reward_value     : 1000000000,
            treasury_fee     : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(5000),
            package_version  : 4,
        };
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<XPumpConfig>(v0);
        0x2::transfer::public_transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate_to_existing_pool<T0>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 13906835501488275455
    }

    public fun migrate_to_new_pool<T0, T1>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 13906834865833115647
    }

    public fun migrate_to_new_pool_v2<T0, T1, T2>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, T1>, arg7: 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 13906834925962657791
    }

    public fun migrate_to_new_pool_v3<T0, T1, T2>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, T1>, arg7: 0x2::coin::Coin<T2>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_package_version(arg0);
        assert!(0x2::coin::get_decimals<T0>(arg4) == 9, 0);
        let v0 = Witness{dummy_field: false};
        let (v1, v2, v3) = 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::destroy<T0, T1, Witness>(arg6, v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v4, arg0.reward_value), arg8);
        let v7 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<T0>(arg4), 0x2::url::new_unsafe_from_bytes(b""));
        let v8 = 0x1::option::destroy_with_default<0x2::url::Url>(0x2::coin::get_icon_url<T1>(arg5), 0x2::url::new_unsafe_from_bytes(b""));
        let v9 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, T1, T2>(arg2, arg1, pool_name<T0>(arg4), b"", 0x1::ascii::into_bytes(0x2::coin::get_symbol<T0>(arg4)), 0x2::coin::get_decimals<T0>(arg4), 0x1::ascii::into_bytes(0x2::url::inner_url(&v7)), 0x1::ascii::into_bytes(0x2::coin::get_symbol<T1>(arg5)), 0x2::coin::get_decimals<T1>(arg5), 0x1::ascii::into_bytes(0x2::url::inner_url(&v8)), 200, 10000, (0x7ec68f4115dc2944426239b13ce6804dd9971b24069fb4efe88360d29b17f0ce::math::sqrt_down((0x2::balance::value<T1>(&v4) as u256) * 0x1::u256::pow(2, 128) / ((0x2::balance::value<T0>(&v5) - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(get_liquidity_margin(arg0), 0x2::balance::value<T0>(&v5))) as u256)) as u128), 0x2::coin::into_balance<T2>(arg7), arg8);
        let v10 = get_ticks(arg0);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, &mut v9, v10.min, v10.max, arg8);
        let (v12, v13, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg2, arg1, &mut v9, &mut v11, v5, v4, 0x2::balance::value<T1>(&v4), false);
        share_pool_and_save_position<T0, T1>(arg0, v9, v11, v12, v13, v14, v15, v1, arg8);
        v6
    }

    public fun migrate_to_new_pool_with_liquidity<T0, T1>(arg0: &mut XPumpConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &0x2::clock::Clock, arg3: &0xa204bd0d48d49fc7b8b05c8ef3f3ae63d1b22d157526a88b91391b41e6053157::ipx_coin_standard::IPXTreasuryStandard, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: 0x779829966a2e8642c310bed79e6ba603e5acd3c31b25d7d4511e2c9303d6e3ef::memez_fun::MemezMigrator<T0, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<T1>, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        abort 13906835385524158463
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

    fun position_mut_v2<T0>(arg0: &mut XPumpConfig) : &mut PositionData<T0> {
        let v0 = PositionKeyV2{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow_mut<PositionKeyV2, PositionData<T0>>(&mut arg0.id, v0)
    }

    public fun position_pool<T0>(arg0: &XPumpConfig) : address {
        get_position<T0>(arg0).pool
    }

    fun save_position<T0>(arg0: &mut XPumpConfig, arg1: PositionData<T0>) {
        let v0 = PositionKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::add<PositionKey, PositionData<T0>>(&mut arg0.id, v0, arg1);
    }

    public fun set_initialize_price(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u128) {
        assert!(arg2 != 0, 13906836223042781183);
        let v0 = SetInitializePrice{
            pos0 : arg0.initialize_price,
            pos1 : arg2,
        };
        0x2::event::emit<SetInitializePrice>(v0);
        arg0.initialize_price = arg2;
    }

    public fun set_liquidity_margin(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u64) {
        let v0 = LiquidityMarginKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<LiquidityMarginKey>(&arg0.id, v0)) {
            let v1 = LiquidityMarginKey{dummy_field: false};
            0x2::dynamic_field::add<LiquidityMarginKey, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(&mut arg0.id, v1, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0));
        };
        let v2 = LiquidityMarginKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<LiquidityMarginKey, 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS>(&mut arg0.id, v2) = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg2);
    }

    public fun set_package_version(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u64) {
        arg0.package_version = arg2;
    }

    public fun set_reward_value(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u64) {
        let v0 = SetRewardValue{
            pos0 : arg0.reward_value,
            pos1 : arg2,
        };
        0x2::event::emit<SetRewardValue>(v0);
        arg0.reward_value = arg2;
    }

    public fun set_tick_spacing(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u32, arg3: u32) {
        abort 13906836420611276799
    }

    public fun set_ticks(arg0: &mut XPumpConfig, arg1: &Admin, arg2: u32, arg3: u32) {
        let v0 = TicksKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<TicksKey>(&arg0.id, v0)) {
            let v1 = TicksKey{dummy_field: false};
            let v2 = Ticks{
                min : arg2,
                max : arg3,
            };
            0x2::dynamic_field::add<TicksKey, Ticks>(&mut arg0.id, v1, v2);
        };
        let v3 = TicksKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<TicksKey, Ticks>(&mut arg0.id, v3);
        v4.min = arg2;
        v4.max = arg3;
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

    fun share_pool_and_save_position<T0, T1>(arg0: &mut XPumpConfig, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(&arg1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, T1>(arg1);
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
        destroy_zero_or_transfer<T1>(0x2::coin::from_balance<T1>(arg6, arg8), arg0.treasury);
    }

    public fun treasury_collect_fee<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_package_version(arg0);
        let v0 = arg0.treasury_fee;
        let v1 = position_mut<T0>(arg0);
        assert!(v1.pool == 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>>(arg2), 13906835870855462911);
        let (v2, v3, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v1.position);
        let v6 = v5;
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut v6, 0x1::u64::min(0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(v0, v3), 0x2::balance::value<0x2::sui::SUI>(&v6)));
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

    public fun treasury_collect_position_v2_fee<T0>(arg0: &mut XPumpConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &Admin, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = position_mut_v2<T0>(arg0);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, 0x2::sui::SUI>(arg3, arg1, arg2, &mut v0.position);
        let v5 = CollectFee{
            pool                 : v0.pool,
            position_owner       : v0.position_owner,
            position             : 0x2::object::id_address<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0.position),
            owner_meme_amount    : 0,
            owner_sui_amount     : 0,
            treasury_meme_amount : v1,
            treasury_sui_amount  : v2,
        };
        0x2::event::emit<CollectFee>(v5);
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg5))
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

