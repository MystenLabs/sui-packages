module 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::router {
    struct RouterConfig has key {
        id: 0x2::object::UID,
        admin: address,
        creation_fee: u64,
        trade_fee: u64,
        min_trade_fee: u64,
        min_trade_value: u64,
        ghost_sui_reserves: u64,
        token_supply: u64,
        dex_migration_threshold: u64,
        dex_migration_value: u64,
        creator_reward: u64,
        FlowX: bool,
        Aftermath: bool,
        Kriya: bool,
        Magma: bool,
    }

    struct ConfigUpdatedEvent has copy, drop {
        admin: address,
        creation_fee: u64,
        trade_fee: u64,
        min_trade_fee: u64,
        min_trade_value: u64,
        ghost_sui_reserves: u64,
        token_supply: u64,
        dex_migration_threshold: u64,
        timestamp: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x2::url::Url>,
        decimals: u8,
        creator: address,
        token_supply: u64,
        ghost_sui_reserves: u64,
        dex_target: vector<u8>,
        telegram: vector<u8>,
        twitter: vector<u8>,
        website: vector<u8>,
        timestamp: u64,
    }

    struct DexMigrationEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        token_migrated: u64,
        sui_migrated: u64,
        dex_target: vector<u8>,
        sui_id: 0x2::object::ID,
        migrated_coin_id: 0x2::object::ID,
    }

    fun calculate_max_input(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 10000;
        let v1 = arg0 * v0 / (v0 - arg1);
        let v2 = arg0 + arg2;
        if (v2 > v1) {
            v2
        } else {
            v1
        }
    }

    public entry fun create_and_prebuy<T0>(arg0: &RouterConfig, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.creation_fee, 9);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 8);
        assert!(0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::dex_integration::validate_name(arg7, arg0.FlowX, arg0.Aftermath, arg0.Kriya, arg0.Magma), 11);
        let v0 = calculate_max_input(arg0.dex_migration_threshold, arg0.trade_fee, arg0.min_trade_fee) + arg0.creation_fee;
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, 0x2::coin::value<0x2::sui::SUI>(&arg3) - v0, arg8), 0x2::tx_context::sender(arg8));
        };
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.creation_fee, arg8);
        let v2 = 0x2::coin::get_decimals<T0>(arg2);
        let v3 = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::create_pool<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.token_supply * 0x1::u64::pow(10, v2), arg8), arg0.ghost_sui_reserves, v2, arg7, arg8);
        let v4 = PoolCreatedEvent{
            pool_id            : 0x2::object::id<0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>>(&v3),
            token_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            symbol             : 0x2::coin::get_symbol<T0>(arg2),
            name               : 0x2::coin::get_name<T0>(arg2),
            description        : 0x2::coin::get_description<T0>(arg2),
            image_url          : 0x2::coin::get_icon_url<T0>(arg2),
            decimals           : v2,
            creator            : 0x2::tx_context::sender(arg8),
            token_supply       : arg0.token_supply,
            ghost_sui_reserves : arg0.ghost_sui_reserves,
            dex_target         : arg7,
            telegram           : arg4,
            twitter            : arg5,
            website            : arg6,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::event::emit<PoolCreatedEvent>(v4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            let (v5, v6) = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_manager::swap_a_to_b<T0>(arg0.trade_fee, arg0.min_trade_fee, &mut v3, arg3, b"", arg8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, arg0.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg8));
            let v7 = &mut v3;
            handle_liquidity_migration<T0>(v7, arg0, arg8);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        0x2::transfer::public_share_object<0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>>(v3);
    }

    fun handle_liquidity_migration<T0>(arg0: &mut 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>, arg1: &RouterConfig, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_a<T0>(arg0) >= arg1.dex_migration_threshold) {
            0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::complete_pool<T0>(arg0);
            let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::borrow_mut_coin_a<T0>(arg0)), arg2);
            let v1 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::borrow_mut_coin_b<T0>(arg0)), arg2);
            let v2 = DexMigrationEvent{
                pool_id          : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_pool_id<T0>(arg0),
                token_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                token_migrated   : 0x2::coin::value<T0>(&v1),
                sui_migrated     : arg1.dex_migration_value,
                dex_target       : 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_dex_target<T0>(arg0),
                sui_id           : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v0),
                migrated_coin_id : 0x2::object::id<0x2::coin::Coin<T0>>(&v1),
            };
            0x2::event::emit<DexMigrationEvent>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg1.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) - arg1.dex_migration_value, arg2), arg1.admin);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1.creator_reward, arg2), 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::get_creator<T0>(arg0));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterConfig{
            id                      : 0x2::object::new(arg0),
            admin                   : 0x2::tx_context::sender(arg0),
            creation_fee            : 690000000,
            trade_fee               : 99,
            min_trade_fee           : 1000000,
            min_trade_value         : 2000000,
            ghost_sui_reserves      : 1500000000000,
            token_supply            : 10000000000,
            dex_migration_threshold : 3333000000000,
            dex_migration_value     : 3000100000000,
            creator_reward          : 50000000000,
            FlowX                   : true,
            Aftermath               : true,
            Kriya                   : false,
            Magma                   : false,
        };
        0x2::transfer::share_object<RouterConfig>(v0);
    }

    public entry fun swap_a_to_b<T0>(arg0: &RouterConfig, arg1: &mut 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.min_trade_value, 7);
        assert!(!0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::is_completed<T0>(arg1), 10);
        let v0 = calculate_max_input(arg0.dex_migration_threshold - 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::balance_a<T0>(arg1), arg0.trade_fee, arg0.min_trade_fee);
        if (v0 < 0x2::coin::value<0x2::sui::SUI>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 0x2::coin::value<0x2::sui::SUI>(&arg2) - v0, arg4), 0x2::tx_context::sender(arg4));
        };
        let (v1, v2) = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_manager::swap_a_to_b<T0>(arg0.trade_fee, arg0.min_trade_fee, arg1, arg2, arg3, arg4);
        handle_liquidity_migration<T0>(arg1, arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun swap_b_to_a<T0>(arg0: &RouterConfig, arg1: &mut 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.min_trade_value, 7);
        assert!(!0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::is_completed<T0>(arg1), 10);
        let (v0, v1) = 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::swap_manager::swap_b_to_a<T0>(arg0.trade_fee, arg0.min_trade_fee, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_config(arg0: &mut RouterConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: bool, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg14) == arg0.admin, 4);
        arg0.creation_fee = arg1;
        arg0.trade_fee = arg2;
        arg0.min_trade_fee = arg3;
        arg0.min_trade_value = arg4;
        arg0.ghost_sui_reserves = arg5;
        arg0.token_supply = arg6;
        arg0.dex_migration_threshold = arg7;
        arg0.dex_migration_value = arg8;
        arg0.creator_reward = arg9;
        arg0.FlowX = arg10;
        arg0.Aftermath = arg11;
        arg0.Kriya = arg12;
        arg0.Magma = arg13;
        let v0 = ConfigUpdatedEvent{
            admin                   : arg0.admin,
            creation_fee            : arg1,
            trade_fee               : arg2,
            min_trade_fee           : arg3,
            min_trade_value         : arg4,
            ghost_sui_reserves      : arg5,
            token_supply            : arg6,
            dex_migration_threshold : arg7,
            timestamp               : 0x2::tx_context::epoch_timestamp_ms(arg14),
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    public entry fun update_migrated<T0>(arg0: &mut RouterConfig, arg1: &mut 0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::Pool<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        0x272269b3935219eafe12b6f8e3d0551d49b88c8e576ad078cb6e97d3932b52f0::pool_factory::set_dex_pool_id<T0>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

