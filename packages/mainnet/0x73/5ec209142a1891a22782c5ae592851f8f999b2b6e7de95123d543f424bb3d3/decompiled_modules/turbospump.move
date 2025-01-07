module 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::turbospump {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        deployment_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        protocol_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        fair_launch_sui_amount: u64,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        real_sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        real_token_reserves: 0x2::balance::Balance<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::balance::Balance<T0>,
        is_completed: bool,
        token_supply: 0x1::option::Option<0x2::balance::Supply<T0>>,
        lp_type: u8,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
    }

    struct ConfigChangedEvent has copy, drop, store {
        platform_fee: u64,
        deployment_fee: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        fair_launch_sui_amount: u64,
    }

    struct CreatedEvent has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::string::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        remain_token_reserves: u64,
        is_completed: bool,
        deployment_fee: u64,
        token_supply: u64,
        lp_type: u8,
    }

    struct PoolCompletedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
    }

    struct PoolMigratedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
    }

    struct TradedEvent has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        fee_amount: u64,
        real_sui_reserves: u64,
        real_token_reserves: u64,
        virtual_sui_reserves: u64,
        virtual_token_reserves: u64,
        remain_token_reserves: u64,
        is_completed: bool,
        pool_id: 0x2::object::ID,
    }

    struct OwnershipTransferredEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = buy_with_return<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
    }

    fun buy_internal<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 2);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg2;
        check_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        assert!(0x2::balance::value<T0>(&arg0.real_token_reserves) >= arg2, 9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.real_token_reserves, arg2), arg3)
    }

    public fun buy_with_return<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 13);
        assert!(arg2 > 0, 2);
        let v3 = v2.virtual_token_reserves - 0x2::balance::value<T0>(&v2.remain_token_reserves);
        let (v4, v5, v6) = if (arg4) {
            let v7 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(arg2, arg0.platform_fee, 1000000);
            let v8 = arg2 - v7;
            let v9 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::curves::calculate_token_return(v8, v2.virtual_sui_reserves, v2.virtual_token_reserves);
            assert!(v9 >= arg3, 6);
            assert!(v3 >= v9, 9);
            (v7, v8, v9)
        } else {
            let v10 = 0x1::u64::min(arg2, v3);
            let v11 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::curves::calculate_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v10);
            assert!(v11 <= arg3, 7);
            (0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(v11, arg0.platform_fee, 1000000), v11, v10)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v5 + v4, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_vault, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg6)));
        let v12 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v5, arg6);
        let v13 = buy_internal<T0>(v2, v12, v6, arg6);
        if (v3 == v6 || 0x2::balance::value<0x2::sui::SUI>(&v2.real_sui_reserves) >= arg0.fair_launch_sui_amount) {
            complete_pool<T0>(v2, arg0.admin, arg5, arg6);
        };
        let v14 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : 0x1::type_name::into_string(v1),
            sui_amount             : v5,
            token_amount           : v6,
            fee_amount             : v4,
            real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&v2.real_sui_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&v2.real_token_reserves),
            virtual_sui_reserves   : v2.virtual_sui_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            remain_token_reserves  : 0x2::balance::value<T0>(&v2.remain_token_reserves),
            is_completed           : v2.is_completed,
            pool_id                : 0x2::object::id<Pool<T0>>(v2),
        };
        0x2::event::emit<TradedEvent>(v14);
        (arg1, v13)
    }

    fun check_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 1);
    }

    fun check_version(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public fun collect_pool_with_return<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        assert!(v1.is_completed, 3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.real_token_reserves, arg2), arg4), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, arg3), arg4))
    }

    public entry fun collect_protocol_fee(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.protocol_vault);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.protocol_vault, v1), arg4), arg3);
    }

    fun complete_pool<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        let v0 = PoolCompletedEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            pool_id       : 0x2::object::id<Pool<T0>>(arg0),
        };
        0x2::event::emit<PoolCompletedEvent>(v0);
    }

    public fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::string::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0.version);
        assert!(0x1::ascii::length(&arg5) <= 300, 4);
        assert!(0x1::string::length(&arg6) <= 1000, 4);
        assert!(0x1::ascii::length(&arg7) <= 500, 4);
        assert!(0x1::ascii::length(&arg8) <= 500, 4);
        assert!(0x1::ascii::length(&arg9) <= 500, 4);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg0.deployment_fee, 12);
        let v1 = Pool<T0>{
            id                     : 0x2::object::new(arg12),
            real_sui_reserves      : 0x2::balance::zero<0x2::sui::SUI>(),
            real_token_reserves    : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12)),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg12)),
            is_completed           : false,
            token_supply           : 0x1::option::none<0x2::balance::Supply<T0>>(),
            lp_type                : arg10,
        };
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0x1::type_name::get<Pool<T0>>();
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v4 = CreatedEvent{
            name                   : arg3,
            symbol                 : arg4,
            uri                    : arg5,
            description            : arg6,
            twitter                : arg7,
            telegram               : arg8,
            website                : arg9,
            token_address          : 0x1::type_name::into_string(v2),
            bonding_curve          : 0x1::type_name::get_module(&v3),
            pool_id                : 0x2::object::id<Pool<T0>>(&v1),
            created_by             : 0x2::tx_context::sender(arg12),
            real_sui_reserves      : 0,
            real_token_reserves    : 0x2::balance::value<T0>(&v1.real_token_reserves),
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            remain_token_reserves  : arg0.remain_token_reserves,
            is_completed           : false,
            deployment_fee         : v0,
            token_supply           : arg0.initial_virtual_token_reserves,
            lp_type                : arg10,
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v2), v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        0x2::event::emit<CreatedEvent>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Configuration{
            id                             : 0x2::object::new(arg0),
            version                        : 1,
            admin                          : @0x0,
            platform_fee                   : 5000,
            deployment_fee                 : 500000000,
            initial_virtual_sui_reserves   : 1500000000000,
            initial_virtual_token_reserves : 10000000000000000,
            remain_token_reserves          : 2000000000000000,
            token_decimals                 : 6,
            protocol_vault                 : 0x2::balance::zero<0x2::sui::SUI>(),
            fair_launch_sui_amount         : 6000000000000,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<Configuration>(v1);
        let v2 = InitConfigEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            config_id    : 0x2::object::id<Configuration>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v2);
    }

    public fun migrate_pool_with_return<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        assert!(v1.is_completed, 3);
        let v2 = 0x2::balance::split<T0>(&mut v1.real_token_reserves, 0x2::balance::value<T0>(&v1.real_token_reserves));
        0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut v1.remain_token_reserves, 0x2::balance::value<T0>(&v1.remain_token_reserves)));
        (0x2::coin::from_balance<T0>(v2, arg2), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, 0x2::balance::value<0x2::sui::SUI>(&v1.real_sui_reserves)), arg2))
    }

    public entry fun migrate_version(arg0: &AdminCap, arg1: &mut Configuration) {
        let v0 = arg1.version;
        assert!(v0 < 1, 0);
        arg1.version = 1;
        let v1 = SetPackageVersion{
            new_version : 1,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public fun pool_migrated<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        assert!(v1.is_completed, 3);
        let v2 = PoolMigratedEvent{
            token_address : 0x1::type_name::into_string(v0),
            pool_id       : 0x2::object::id<Pool<T0>>(v1),
            clmm_pool_id  : arg2,
        };
        0x2::event::emit<PoolMigratedEvent>(v2);
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg0.version);
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = sell_with_return<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
    }

    fun sell_internal<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg2;
        check_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::balance::join<T0>(&mut arg0.real_token_reserves, 0x2::coin::into_balance<T0>(arg1));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserves) >= arg2, 10);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2), arg3)
    }

    public fun sell_with_return<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        check_version(arg0.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v0));
        assert!(!v1.is_completed, 13);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 2);
        let (v3, v4, v5) = if (arg4) {
            let v6 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::curves::calculate_sui_return(arg2, v1.virtual_sui_reserves, v1.virtual_token_reserves);
            let v7 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(v6, arg0.platform_fee, 1000000);
            assert!(v6 - v7 >= arg3, 6);
            (v7, v6, arg2)
        } else {
            let v8 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::full_math_u64::mul_div_ceil(arg2, arg0.platform_fee, 1000000);
            let v9 = arg2 + v8;
            let v10 = 0x735ec209142a1891a22782c5ae592851f8f999b2b6e7de95123d543f424bb3d3::curves::calculate_token_return(v9, v1.virtual_sui_reserves, v1.virtual_token_reserves);
            assert!(v10 < arg3, 7);
            (v8, v9, v10)
        };
        assert!(v2 >= v5, 11);
        let v11 = 0x2::coin::split<T0>(&mut arg1, v5, arg6);
        let v12 = sell_internal<T0>(v1, v11, v4, arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_vault, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v12, v3, arg6)));
        let v13 = TradedEvent{
            is_buy                 : false,
            user                   : 0x2::tx_context::sender(arg6),
            token_address          : 0x1::type_name::into_string(v0),
            sui_amount             : v4,
            token_amount           : v2,
            fee_amount             : v3,
            real_sui_reserves      : 0x2::balance::value<0x2::sui::SUI>(&v1.real_sui_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&v1.real_token_reserves),
            virtual_sui_reserves   : v1.virtual_sui_reserves,
            virtual_token_reserves : v1.virtual_token_reserves,
            remain_token_reserves  : 0x2::balance::value<T0>(&v1.remain_token_reserves),
            is_completed           : v1.is_completed,
            pool_id                : 0x2::object::id<Pool<T0>>(v1),
        };
        0x2::event::emit<TradedEvent>(v13);
        (v12, arg1)
    }

    public entry fun skim<T0>(arg0: &AdminCap, arg1: &mut Configuration, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg1.id, 0x1::type_name::get_address(&v0));
        assert!(v1.is_completed, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.real_sui_reserves, 0x2::balance::value<0x2::sui::SUI>(&v1.real_sui_reserves)), arg2), arg1.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.real_token_reserves, 0x2::balance::value<T0>(&v1.real_token_reserves)), arg2), arg1.admin);
    }

    public entry fun transfer_admin(arg0: &AdminCap, arg1: &mut Configuration, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        arg1.admin = arg2;
        let v0 = OwnershipTransferredEvent{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        arg1.platform_fee = arg2;
        arg1.deployment_fee = arg3;
        arg1.initial_virtual_sui_reserves = arg4;
        arg1.initial_virtual_token_reserves = arg5;
        arg1.remain_token_reserves = arg6;
        arg1.token_decimals = arg7;
        arg1.fair_launch_sui_amount = arg8;
        let v0 = ConfigChangedEvent{
            platform_fee                   : arg2,
            deployment_fee                 : arg3,
            initial_virtual_sui_reserves   : arg4,
            initial_virtual_token_reserves : arg5,
            remain_token_reserves          : arg6,
            token_decimals                 : arg7,
            fair_launch_sui_amount         : arg8,
        };
        0x2::event::emit<ConfigChangedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

