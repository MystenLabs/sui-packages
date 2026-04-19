module 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Configuration<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        platform_fee: u64,
        deployment_fee: u64,
        initial_virtual_quote_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        protocol_vault: 0x2::balance::Balance<T0>,
        fair_launch_quote_amount: u64,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        real_quote_reserves: 0x2::balance::Balance<T1>,
        real_token_reserves: 0x2::balance::Balance<T0>,
        virtual_token_reserves: u64,
        virtual_quote_reserves: u64,
        remain_token_reserves: 0x2::balance::Balance<T0>,
        is_completed: bool,
        lp_type: u8,
    }

    struct InitAdminEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    struct InitConfigEvent has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
    }

    struct ConfigChangedEvent has copy, drop {
        platform_fee: u64,
        deployment_fee: u64,
        initial_virtual_quote_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        fair_launch_quote_amount: u64,
    }

    struct CreatedEvent has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        uri: 0x1::string::String,
        description: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        token_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        real_quote_reserves: u64,
        real_token_reserves: u64,
        virtual_quote_reserves: u64,
        virtual_token_reserves: u64,
        remain_token_reserves: u64,
        is_completed: bool,
        deployment_fee: u64,
        token_supply: u64,
        lp_type: u8,
    }

    struct PoolCompletedEvent has copy, drop {
        token_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
    }

    struct PoolMigratedEvent has copy, drop {
        token_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
    }

    struct TradedEvent has copy, drop {
        is_buy: bool,
        user: address,
        token_address: 0x1::string::String,
        quote_amount: u64,
        token_amount: u64,
        fee_amount: u64,
        real_quote_reserves: u64,
        real_token_reserves: u64,
        virtual_quote_reserves: u64,
        virtual_token_reserves: u64,
        remain_token_reserves: u64,
        is_completed: bool,
        pool_id: 0x2::object::ID,
    }

    struct OwnershipTransferredEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    fun borrow_pool<T0, T1>(arg0: &Configuration<T1>) : &Pool<T0, T1> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0, T1>>(&arg0.id, pool_key<T0>())
    }

    fun borrow_pool_mut<T0, T1>(arg0: &mut Configuration<T1>) : &mut Pool<T0, T1> {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, pool_key<T0>())
    }

    public fun buy<T0, T1>(arg0: &mut Configuration<T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
    }

    fun buy_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 2);
        arg0.virtual_quote_reserves = arg0.virtual_quote_reserves + 0x2::coin::value<T1>(&arg1);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg2;
        check_lp_value_is_increased_or_not_changed(arg0.virtual_quote_reserves, arg0.virtual_token_reserves, arg0.virtual_quote_reserves, arg0.virtual_token_reserves);
        0x2::balance::join<T1>(&mut arg0.real_quote_reserves, 0x2::coin::into_balance<T1>(arg1));
        assert!(0x2::balance::value<T0>(&arg0.real_token_reserves) >= arg2, 9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.real_token_reserves, arg2), arg3)
    }

    public fun buy_with_return<T0, T1>(arg0: &mut Configuration<T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        check_version(arg0.version);
        assert!(arg2 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.fair_launch_quote_amount;
        let v2 = borrow_pool<T0, T1>(arg0);
        assert!(!v2.is_completed, 13);
        let v3 = v2.virtual_token_reserves - 0x2::balance::value<T0>(&v2.remain_token_reserves);
        let (v4, v5, v6) = if (arg4) {
            let v7 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(arg2, arg0.platform_fee, 1000000);
            let v8 = arg2 - v7;
            let v9 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves::calculate_token_return(v8, v2.virtual_quote_reserves, v2.virtual_token_reserves);
            assert!(v9 >= arg3, 6);
            assert!(v3 >= v9, 9);
            (v7, v8, v9)
        } else {
            let v10 = 0x1::u64::min(arg2, v3);
            let v11 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves::calculate_liquidity_cost(v10, v2.virtual_quote_reserves, v2.virtual_token_reserves);
            let v4 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(v11, arg0.platform_fee, 1000000);
            assert!(v11 <= arg3, 7);
            (v4, v11, v10)
        };
        assert!(0x2::coin::value<T1>(&arg1) >= v5 + v4, 8);
        0x2::balance::join<T1>(&mut arg0.protocol_vault, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v4, arg6)));
        let v12 = 0x2::coin::split<T1>(&mut arg1, v5, arg6);
        let v13 = borrow_pool_mut<T0, T1>(arg0);
        let v14 = buy_internal<T0, T1>(v13, v12, v6, arg6);
        if (v3 == v6 || 0x2::balance::value<T1>(&v13.real_quote_reserves) >= v1) {
            complete_pool<T0, T1>(v13, arg5, arg6);
        };
        let v15 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : pool_label<T0>(),
            quote_amount           : v5,
            token_amount           : v6,
            fee_amount             : v4,
            real_quote_reserves    : 0x2::balance::value<T1>(&v13.real_quote_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&v13.real_token_reserves),
            virtual_quote_reserves : v13.virtual_quote_reserves,
            virtual_token_reserves : v13.virtual_token_reserves,
            remain_token_reserves  : 0x2::balance::value<T0>(&v13.remain_token_reserves),
            is_completed           : v13.is_completed,
            pool_id                : 0x2::object::id<Pool<T0, T1>>(v13),
        };
        0x2::event::emit<TradedEvent>(v15);
        (arg1, v14)
    }

    fun charge_exact_or_refund<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 8);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    fun check_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 1);
    }

    fun check_version(arg0: u64) {
        assert!(arg0 == 1, 0);
    }

    public fun collect_protocol_fee<T0>(arg0: &AdminCap, arg1: &mut Configuration<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        let v0 = 0x2::balance::value<T0>(&arg1.protocol_vault);
        let v1 = if (arg2 > v0) {
            v0
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_vault, v1), arg4), arg3);
    }

    fun complete_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.is_completed = true;
        let v0 = PoolCompletedEvent{
            token_address : pool_label<T0>(),
            pool_id       : 0x2::object::id<Pool<T0, T1>>(arg0),
        };
        0x2::event::emit<PoolCompletedEvent>(v0);
    }

    public fun create<T0, T1>(arg0: &mut Configuration<T1>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u8, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0.version);
        assert!(!pool_exists<T0, T1>(arg0), 15);
        assert!(0x1::string::length(&arg5) <= 300, 4);
        assert!(0x1::string::length(&arg6) <= 1000, 4);
        assert!(0x1::string::length(&arg7) <= 500, 4);
        assert!(0x1::string::length(&arg8) <= 500, 4);
        assert!(0x1::string::length(&arg9) <= 500, 4);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 5);
        let v0 = &mut arg2;
        let v1 = charge_exact_or_refund<T1>(v0, arg0.deployment_fee, arg12);
        0x2::balance::join<T1>(&mut arg0.protocol_vault, 0x2::coin::into_balance<T1>(v1));
        if (0x2::coin::value<T1>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        let v2 = Pool<T0, T1>{
            id                     : 0x2::object::new(arg12),
            real_quote_reserves    : 0x2::balance::zero<T1>(),
            real_token_reserves    : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12)),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_quote_reserves : arg0.initial_virtual_quote_reserves,
            remain_token_reserves  : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg12)),
            is_completed           : false,
            lp_type                : arg10,
        };
        let v3 = CreatedEvent{
            name                   : arg3,
            symbol                 : arg4,
            uri                    : arg5,
            description            : arg6,
            twitter                : arg7,
            telegram               : arg8,
            website                : arg9,
            token_address          : pool_label<T0>(),
            pool_id                : 0x2::object::id<Pool<T0, T1>>(&v2),
            created_by             : 0x2::tx_context::sender(arg12),
            real_quote_reserves    : 0,
            real_token_reserves    : 0x2::balance::value<T0>(&v2.real_token_reserves),
            virtual_quote_reserves : v2.virtual_quote_reserves,
            virtual_token_reserves : v2.virtual_token_reserves,
            remain_token_reserves  : 0x2::balance::value<T0>(&v2.remain_token_reserves),
            is_completed           : false,
            deployment_fee         : arg0.deployment_fee,
            token_supply           : arg0.initial_virtual_token_reserves,
            lp_type                : arg10,
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, pool_key<T0>(), v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        0x2::event::emit<CreatedEvent>(v3);
    }

    public fun default_test_config_values() : (u64, u64, u64, u64, u64, u8, u64) {
        (10000, 10000000, 500000000000, 10000000000000000, 2000000000000000, 6, 2000000000000)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = InitAdminEvent{admin_cap_id: 0x2::object::id<AdminCap>(&v0)};
        0x2::event::emit<InitAdminEvent>(v1);
    }

    public fun init_config<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration<T0>{
            id                             : 0x2::object::new(arg8),
            version                        : 1,
            admin                          : 0x2::tx_context::sender(arg8),
            platform_fee                   : arg1,
            deployment_fee                 : arg2,
            initial_virtual_quote_reserves : arg3,
            initial_virtual_token_reserves : arg4,
            remain_token_reserves          : arg5,
            token_decimals                 : arg6,
            protocol_vault                 : 0x2::balance::zero<T0>(),
            fair_launch_quote_amount       : arg7,
        };
        0x2::transfer::public_share_object<Configuration<T0>>(v0);
        let v1 = InitConfigEvent{
            config_id : 0x2::object::id<Configuration<T0>>(&v0),
            admin     : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<InitConfigEvent>(v1);
    }

    public fun init_config_v2<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration<T0>{
            id                             : 0x2::object::new(arg7),
            version                        : 1,
            admin                          : 0x2::tx_context::sender(arg7),
            platform_fee                   : arg0,
            deployment_fee                 : arg1,
            initial_virtual_quote_reserves : arg2,
            initial_virtual_token_reserves : arg3,
            remain_token_reserves          : arg4,
            token_decimals                 : arg5,
            protocol_vault                 : 0x2::balance::zero<T0>(),
            fair_launch_quote_amount       : arg6,
        };
        0x2::transfer::public_share_object<Configuration<T0>>(v0);
        let v1 = InitConfigEvent{
            config_id : 0x2::object::id<Configuration<T0>>(&v0),
            admin     : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<InitConfigEvent>(v1);
    }

    public fun migrate_pool_with_return<T0, T1>(arg0: &AdminCap, arg1: &mut Configuration<T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_version(arg1.version);
        let v0 = borrow_pool_mut<T0, T1>(arg1);
        assert!(v0.is_completed, 3);
        let v1 = 0x2::balance::split<T0>(&mut v0.real_token_reserves, 0x2::balance::value<T0>(&v0.real_token_reserves));
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut v0.remain_token_reserves, 0x2::balance::value<T0>(&v0.remain_token_reserves)));
        (0x2::coin::from_balance<T0>(v1, arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.real_quote_reserves, 0x2::balance::value<T1>(&v0.real_quote_reserves)), arg2))
    }

    fun pool_exists<T0, T1>(arg0: &Configuration<T1>) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, Pool<T0, T1>>(&arg0.id, pool_key<T0>())
    }

    fun pool_key<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun pool_label<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(pool_key<T0>()))
    }

    public fun pool_migrated<T0, T1>(arg0: &AdminCap, arg1: &mut Configuration<T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_pool_mut<T0, T1>(arg1);
        assert!(v0.is_completed, 3);
        let v1 = PoolMigratedEvent{
            token_address : pool_label<T0>(),
            pool_id       : 0x2::object::id<Pool<T0, T1>>(v0),
            clmm_pool_id  : arg2,
        };
        0x2::event::emit<PoolMigratedEvent>(v1);
    }

    public fun quote_buy_exact_in<T0, T1>(arg0: &Configuration<T1>, arg1: u64) : (u64, u64) {
        check_version(arg0.version);
        let v0 = borrow_pool<T0, T1>(arg0);
        let v1 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(arg1, arg0.platform_fee, 1000000);
        (0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves::calculate_token_return(arg1 - v1, v0.virtual_quote_reserves, v0.virtual_token_reserves), v1)
    }

    public fun quote_sell_exact_in<T0, T1>(arg0: &Configuration<T1>, arg1: u64) : (u64, u64) {
        check_version(arg0.version);
        let v0 = borrow_pool<T0, T1>(arg0);
        let v1 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves::calculate_quote_return(arg1, v0.virtual_quote_reserves, v0.virtual_token_reserves);
        let v2 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(v1, arg0.platform_fee, 1000000);
        (v1 - v2, v2)
    }

    public fun sell<T0, T1>(arg0: &mut Configuration<T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
    }

    fun sell_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_quote_reserves = arg0.virtual_quote_reserves - arg2;
        check_lp_value_is_increased_or_not_changed(arg0.virtual_quote_reserves, arg0.virtual_token_reserves, arg0.virtual_quote_reserves, arg0.virtual_token_reserves);
        0x2::balance::join<T0>(&mut arg0.real_token_reserves, 0x2::coin::into_balance<T0>(arg1));
        assert!(0x2::balance::value<T1>(&arg0.real_quote_reserves) >= arg2, 10);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.real_quote_reserves, arg2), arg3)
    }

    public fun sell_with_return<T0, T1>(arg0: &mut Configuration<T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        check_version(arg0.version);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = borrow_pool<T0, T1>(arg0);
        assert!(!v2.is_completed, 13);
        let (v3, v4, v5) = if (arg4) {
            let v6 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves::calculate_quote_return(arg2, v2.virtual_quote_reserves, v2.virtual_token_reserves);
            let v7 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(v6, arg0.platform_fee, 1000000);
            assert!(v6 - v7 >= arg3, 6);
            (v7, v6, arg2)
        } else {
            let v8 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::full_math_u64::mul_div_ceil(arg2, arg0.platform_fee, 1000000);
            let v9 = arg2 + v8;
            let v10 = 0x1509d0b869b83352312d6f82df54fd7f2908b5888802c0c806d2cb5e2dde76f2::curves::calculate_token_return(v9, v2.virtual_quote_reserves, v2.virtual_token_reserves);
            assert!(v10 <= arg3, 7);
            (v8, v9, v10)
        };
        assert!(v0 >= v5, 8);
        let v11 = 0x2::coin::split<T0>(&mut arg1, v5, arg6);
        let v12 = borrow_pool_mut<T0, T1>(arg0);
        let v13 = sell_internal<T0, T1>(v12, v11, v4, arg6);
        0x2::balance::join<T1>(&mut arg0.protocol_vault, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v13, v3, arg6)));
        let v14 = TradedEvent{
            is_buy                 : false,
            user                   : v1,
            token_address          : pool_label<T0>(),
            quote_amount           : v4,
            token_amount           : v5,
            fee_amount             : v3,
            real_quote_reserves    : 0x2::balance::value<T1>(&v12.real_quote_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&v12.real_token_reserves),
            virtual_quote_reserves : v12.virtual_quote_reserves,
            virtual_token_reserves : v12.virtual_token_reserves,
            remain_token_reserves  : 0x2::balance::value<T0>(&v12.remain_token_reserves),
            is_completed           : v12.is_completed,
            pool_id                : 0x2::object::id<Pool<T0, T1>>(v12),
        };
        0x2::event::emit<TradedEvent>(v14);
        (v13, arg1)
    }

    public fun transfer_admin<T0>(arg0: &AdminCap, arg1: &mut Configuration<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        arg1.admin = arg2;
        let v0 = OwnershipTransferredEvent{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<OwnershipTransferredEvent>(v0);
    }

    public fun update_config<T0>(arg0: &AdminCap, arg1: &mut Configuration<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_version(arg1.version);
        arg1.platform_fee = arg2;
        arg1.deployment_fee = arg3;
        arg1.initial_virtual_quote_reserves = arg4;
        arg1.initial_virtual_token_reserves = arg5;
        arg1.remain_token_reserves = arg6;
        arg1.token_decimals = arg7;
        arg1.fair_launch_quote_amount = arg8;
        let v0 = ConfigChangedEvent{
            platform_fee                   : arg2,
            deployment_fee                 : arg3,
            initial_virtual_quote_reserves : arg4,
            initial_virtual_token_reserves : arg5,
            remain_token_reserves          : arg6,
            token_decimals                 : arg7,
            fair_launch_quote_amount       : arg8,
        };
        0x2::event::emit<ConfigChangedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

