module 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Protocol has key {
        id: 0x2::object::UID,
        version: u64,
        platform_fee_recipient: address,
        launch_fee_sui: u64,
        launch_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
    }

    struct PoolKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolRecord has store {
        pool_id: 0x2::object::ID,
        token_address: 0x1::string::String,
        quote_address: 0x1::string::String,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        protocol_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        uri: 0x1::string::String,
        description: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        website: 0x1::string::String,
        created_by: address,
        real_quote_reserves: 0x2::balance::Balance<T1>,
        creator_fee_balance: 0x2::balance::Balance<T1>,
        platform_fee_balance: 0x2::balance::Balance<T1>,
        creator_fee_recipient: address,
        platform_fee_recipient: address,
        real_token_reserves: 0x2::balance::Balance<T0>,
        virtual_token_reserves: u64,
        virtual_quote_reserves: u64,
        lp_token_reserves: 0x2::balance::Balance<T0>,
        fair_launch_quote_amount: u64,
        quote_raw_per_sui: u64,
        quote_decimals: u8,
        bond_mode: u8,
        is_completed: bool,
        is_migrated: bool,
        migration_event_emitted: bool,
        migration_pool_id: 0x2::object::ID,
        lp_type: u8,
    }

    struct ProtocolCreatedEvent has copy, drop {
        protocol_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        launch_fee_sui: u64,
        platform_fee_recipient: address,
        trading_fee: u64,
    }

    struct ProtocolChangedEvent has copy, drop {
        launch_fee_sui: u64,
        paused: bool,
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
        quote_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        creator_fee_recipient: address,
        platform_fee_recipient: address,
        real_quote_reserves: u64,
        real_token_reserves: u64,
        virtual_quote_reserves: u64,
        virtual_token_reserves: u64,
        lp_token_reserves: u64,
        fair_launch_quote_amount: u64,
        quote_raw_per_sui: u64,
        quote_decimals: u8,
        bond_mode: u8,
        launch_fee_sui: u64,
        trading_fee: u64,
        token_supply: u64,
        lp_type: u8,
    }

    struct TradedEvent has copy, drop {
        is_buy: bool,
        user: address,
        token_address: 0x1::string::String,
        quote_address: 0x1::string::String,
        quote_amount: u64,
        token_amount: u64,
        fee_amount: u64,
        real_quote_reserves: u64,
        real_token_reserves: u64,
        virtual_quote_reserves: u64,
        virtual_token_reserves: u64,
        lp_token_reserves: u64,
        is_completed: bool,
        pool_id: 0x2::object::ID,
    }

    struct PoolCompletedEvent has copy, drop {
        token_address: 0x1::string::String,
        quote_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
    }

    struct PoolMigratedEvent has copy, drop {
        token_address: 0x1::string::String,
        quote_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
    }

    struct MigrationAssetsWithdrawnEvent has copy, drop {
        token_address: 0x1::string::String,
        quote_address: 0x1::string::String,
        pool_id: 0x2::object::ID,
        token_amount: u64,
        quote_amount: u64,
    }

    struct LaunchFeesCollectedEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeesDistributedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_address: 0x1::string::String,
        quote_address: 0x1::string::String,
        creator_recipient: address,
        creator_amount: u64,
        platform_recipient: address,
        platform_amount: u64,
        triggered_by: address,
    }

    fun assert_pool<T0, T1>(arg0: &Protocol, arg1: &Pool<T0, T1>) {
        assert!(arg1.protocol_id == 0x2::object::id<Protocol>(arg0), 0);
        assert!(registered_pool_id<T0>(arg0) == 0x2::object::id<Pool<T0, T1>>(arg1), 20);
    }

    public fun buy<T0, T1>(arg0: &Protocol, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
    }

    fun buy_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.virtual_quote_reserves;
        let v1 = arg0.virtual_token_reserves;
        arg0.virtual_quote_reserves = v0 + 0x2::coin::value<T1>(&arg1);
        arg0.virtual_token_reserves = v1 - arg2;
        check_lp_value(v0, v1, arg0.virtual_quote_reserves, arg0.virtual_token_reserves);
        0x2::balance::join<T1>(&mut arg0.real_quote_reserves, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.real_token_reserves, arg2), arg3)
    }

    public fun buy_with_return<T0, T1>(arg0: &Protocol, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        check_protocol(arg0);
        assert_pool<T0, T1>(arg0, arg1);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 10000;
        assert!(!arg1.is_completed, 11);
        let v3 = 0x2::balance::value<T0>(&arg1.real_token_reserves);
        let (v4, v5, v6) = if (arg5) {
            assert!(v1 >= arg3, 8);
            let v7 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg3, v2, 1000000);
            let v8 = arg3 - v7;
            let v9 = 0x1::u64::min(v8, 0x1::u64::min(arg1.fair_launch_quote_amount - 0x2::balance::value<T1>(&arg1.real_quote_reserves), 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_liquidity_cost(v3, arg1.virtual_quote_reserves, arg1.virtual_token_reserves)));
            let v10 = 0x1::u64::min(0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_token_return(v9, arg1.virtual_quote_reserves, arg1.virtual_token_reserves), v3);
            let v11 = if (v9 == v8) {
                v7
            } else {
                0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v9, 1000000, 1000000 - v2) - v9
            };
            assert!(v10 >= arg4, 6);
            (v11, v9, v10)
        } else {
            assert!(arg3 <= v3, 9);
            let v12 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_liquidity_cost(arg3, arg1.virtual_quote_reserves, arg1.virtual_token_reserves);
            assert!(v12 <= arg1.fair_launch_quote_amount - 0x2::balance::value<T1>(&arg1.real_quote_reserves), 7);
            let v13 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v12, 1000000, 1000000 - v2) - v12;
            assert!((v12 as u128) + (v13 as u128) <= (arg4 as u128), 7);
            (v13, v12, arg3)
        };
        assert!(v5 > 0 && v6 > 0, 2);
        assert!((v1 as u128) >= (v5 as u128) + (v4 as u128), 8);
        let v14 = 0x2::coin::split<T1>(&mut arg2, v4, arg7);
        let v15 = 0x2::coin::split<T1>(&mut arg2, v5, arg7);
        let v16 = buy_internal<T0, T1>(arg1, v15, v6, arg7);
        credit_trading_fee<T0, T1>(arg1, v14);
        if (0x2::balance::value<T0>(&arg1.real_token_reserves) == 0 || 0x2::balance::value<T1>(&arg1.real_quote_reserves) >= arg1.fair_launch_quote_amount) {
            complete_pool<T0, T1>(arg1);
        };
        let v17 = TradedEvent{
            is_buy                 : true,
            user                   : v0,
            token_address          : type_label<T0>(),
            quote_address          : type_label<T1>(),
            quote_amount           : v5,
            token_amount           : v6,
            fee_amount             : v4,
            real_quote_reserves    : 0x2::balance::value<T1>(&arg1.real_quote_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            virtual_quote_reserves : arg1.virtual_quote_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            lp_token_reserves      : 0x2::balance::value<T0>(&arg1.lp_token_reserves),
            is_completed           : arg1.is_completed,
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::event::emit<TradedEvent>(v17);
        (arg2, v16)
    }

    fun charge_exact_or_refund<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 8);
        0x2::coin::split<T0>(arg0, arg1, arg2)
    }

    fun check_lp_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 1);
    }

    fun check_protocol(arg0: &Protocol) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 16);
    }

    public fun collect_launch_fees(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 0);
        assert!(arg3 != @0x0, 21);
        let v0 = if (arg2 == 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg1.launch_fee_vault)
        } else {
            0x1::u64::min(arg2, 0x2::balance::value<0x2::sui::SUI>(&arg1.launch_fee_vault))
        };
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.launch_fee_vault, v0), arg4), arg3);
        let v1 = LaunchFeesCollectedEvent{
            amount    : v0,
            recipient : arg3,
        };
        0x2::event::emit<LaunchFeesCollectedEvent>(v1);
    }

    fun complete_pool<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.is_completed = true;
        let v0 = PoolCompletedEvent{
            token_address : type_label<T0>(),
            quote_address : type_label<T1>(),
            pool_id       : 0x2::object::id<Pool<T0, T1>>(arg0),
        };
        0x2::event::emit<PoolCompletedEvent>(v0);
    }

    public fun constants() : (u8, u64, u64, u64, u64, u64, u8, u8, u64, u64) {
        (6, 1000000000000000, 800000000000000, 200000000000000, 1066666666666667, 2000000000, 0, 1, 3200, 6400)
    }

    public fun create<T0, T1>(arg0: &mut Protocol, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &mut 0x2::coin_registry::Currency<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u8, arg6: u8, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: u8, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        check_protocol(arg0);
        assert!(!pool_exists<T0>(arg0), 12);
        assert!(0x1::string::length(&arg7) > 0 && 0x1::string::length(&arg7) <= 128, 4);
        assert!(0x1::string::length(&arg8) > 0 && 0x1::string::length(&arg8) <= 32, 4);
        assert!(0x1::string::length(&arg9) <= 300, 4);
        assert!(0x1::string::length(&arg10) <= 1000, 4);
        assert!(0x1::string::length(&arg11) <= 500, 4);
        assert!(0x1::string::length(&arg12) <= 500, 4);
        assert!(0x1::string::length(&arg13) <= 500, 4);
        let (v0, v1) = 0x2::coin_registry::borrow_legacy_metadata<T0>(arg2, arg16);
        0x2::coin_registry::return_borrowed_legacy_metadata<T0>(arg2, v0, v1, arg16);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg2), 24);
        let v2 = 0x2::coin_registry::treasury_cap_id<T0>(arg2);
        let v3 = &v2;
        let v4 = if (0x1::option::is_some<0x2::object::ID>(v3)) {
            let v5 = 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&arg1);
            0x1::option::borrow<0x2::object::ID>(v3) == &v5
        } else {
            false
        };
        assert!(v4, 25);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 5);
        assert!(0x2::coin_registry::decimals<T0>(arg2) == 6, 14);
        assert!(0x2::coin_registry::name<T0>(arg2) == arg7, 19);
        assert!(0x2::coin_registry::symbol<T0>(arg2) == arg8, 19);
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 14);
        if (0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            assert!(arg4 == 1000000000, 14);
        };
        let (v6, v7) = derive_quote_parameters(arg4, arg6);
        let v8 = &mut arg3;
        let v9 = charge_exact_or_refund<0x2::sui::SUI>(v8, arg0.launch_fee_sui, arg16);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.launch_fee_vault, 0x2::coin::into_balance<0x2::sui::SUI>(v9));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg16));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v10 = Pool<T0, T1>{
            id                       : 0x2::object::new(arg16),
            protocol_id              : 0x2::object::id<Protocol>(arg0),
            name                     : arg7,
            symbol                   : arg8,
            uri                      : arg9,
            description              : arg10,
            twitter                  : arg11,
            telegram                 : arg12,
            website                  : arg13,
            created_by               : 0x2::tx_context::sender(arg16),
            real_quote_reserves      : 0x2::balance::zero<T1>(),
            creator_fee_balance      : 0x2::balance::zero<T1>(),
            platform_fee_balance     : 0x2::balance::zero<T1>(),
            creator_fee_recipient    : 0x2::tx_context::sender(arg16),
            platform_fee_recipient   : arg0.platform_fee_recipient,
            real_token_reserves      : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, 800000000000000, arg16)),
            virtual_token_reserves   : 1066666666666667,
            virtual_quote_reserves   : v7,
            lp_token_reserves        : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, 200000000000000, arg16)),
            fair_launch_quote_amount : v6,
            quote_raw_per_sui        : arg4,
            quote_decimals           : arg5,
            bond_mode                : arg6,
            is_completed             : false,
            is_migrated              : false,
            migration_event_emitted  : false,
            migration_pool_id        : 0x2::object::id_from_address(@0x0),
            lp_type                  : arg14,
        };
        let v11 = 0x2::object::id<Pool<T0, T1>>(&v10);
        let v12 = PoolKey<T0>{dummy_field: false};
        let v13 = PoolRecord{
            pool_id       : v11,
            token_address : type_label<T0>(),
            quote_address : type_label<T1>(),
        };
        0x2::dynamic_field::add<PoolKey<T0>, PoolRecord>(&mut arg0.id, v12, v13);
        0x2::transfer::share_object<Pool<T0, T1>>(v10);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v14 = CreatedEvent{
            name                     : arg7,
            symbol                   : arg8,
            uri                      : arg9,
            description              : arg10,
            twitter                  : arg11,
            telegram                 : arg12,
            website                  : arg13,
            token_address            : type_label<T0>(),
            quote_address            : type_label<T1>(),
            pool_id                  : v11,
            created_by               : 0x2::tx_context::sender(arg16),
            creator_fee_recipient    : 0x2::tx_context::sender(arg16),
            platform_fee_recipient   : arg0.platform_fee_recipient,
            real_quote_reserves      : 0,
            real_token_reserves      : 800000000000000,
            virtual_quote_reserves   : v7,
            virtual_token_reserves   : 1066666666666667,
            lp_token_reserves        : 200000000000000,
            fair_launch_quote_amount : v6,
            quote_raw_per_sui        : arg4,
            quote_decimals           : arg5,
            bond_mode                : arg6,
            launch_fee_sui           : arg0.launch_fee_sui,
            trading_fee              : 10000,
            token_supply             : 1000000000000000,
            lp_type                  : arg14,
        };
        0x2::event::emit<CreatedEvent>(v14);
    }

    fun credit_trading_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        let (v0, v1) = split_fee_amount(0x2::coin::value<T1>(&arg1));
        let v2 = 0x2::coin::into_balance<T1>(arg1);
        assert!(0x2::balance::value<T1>(&v2) == v1, 23);
        0x2::balance::join<T1>(&mut arg0.creator_fee_balance, 0x2::balance::split<T1>(&mut v2, v0));
        0x2::balance::join<T1>(&mut arg0.platform_fee_balance, v2);
    }

    fun derive_quote_parameters(arg0: u64, arg1: u8) : (u64, u64) {
        assert!(arg0 > 0, 14);
        let v0 = ((arg0 as u128) * (target_sui_for_mode(arg1) as u128) + 2) / 3 * 3;
        assert!(v0 + v0 / 3 <= 18446744073709551615, 15);
        let v1 = (v0 as u64);
        (v1, v1 / 3)
    }

    public fun distribute_fees<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T1>(&arg0.creator_fee_balance);
        let v1 = 0x2::balance::value<T1>(&arg0.platform_fee_balance);
        assert!(v0 > 0 || v1 > 0, 22);
        let v2 = arg0.creator_fee_recipient;
        let v3 = arg0.platform_fee_recipient;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.creator_fee_balance, v0), arg1), v2);
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.platform_fee_balance, v1), arg1), v3);
        };
        let v4 = FeesDistributedEvent{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            token_address      : type_label<T0>(),
            quote_address      : type_label<T1>(),
            creator_recipient  : v2,
            creator_amount     : v0,
            platform_recipient : v3,
            platform_amount    : v1,
            triggered_by       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<FeesDistributedEvent>(v4);
    }

    public fun has_pool<T0>(arg0: &Protocol) : bool {
        pool_exists<T0>(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = Protocol{
            id                     : 0x2::object::new(arg0),
            version                : 1,
            platform_fee_recipient : v0,
            launch_fee_sui         : 2000000000,
            launch_fee_vault       : 0x2::balance::zero<0x2::sui::SUI>(),
            paused                 : false,
        };
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<Protocol>(v2);
        let v3 = ProtocolCreatedEvent{
            protocol_id            : 0x2::object::id<Protocol>(&v2),
            admin_cap_id           : 0x2::object::id<AdminCap>(&v1),
            launch_fee_sui         : 2000000000,
            platform_fee_recipient : v0,
            trading_fee            : 10000,
        };
        0x2::event::emit<ProtocolCreatedEvent>(v3);
    }

    public fun is_paused(arg0: &Protocol) : bool {
        arg0.paused
    }

    public fun launch_fee_balance(arg0: &Protocol) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.launch_fee_vault)
    }

    public fun launch_fee_sui(arg0: &Protocol) : u64 {
        arg0.launch_fee_sui
    }

    public fun migrate_pool_with_return<T0, T1>(arg0: &AdminCap, arg1: &Protocol, arg2: &mut Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.version == 1, 0);
        assert_pool<T0, T1>(arg1, arg2);
        assert!(arg2.is_completed, 3);
        assert!(!arg2.is_migrated, 17);
        arg2.is_migrated = true;
        let v0 = 0x2::balance::value<T0>(&arg2.real_token_reserves);
        let v1 = 0x2::balance::value<T0>(&arg2.lp_token_reserves);
        let v2 = 0x2::balance::split<T0>(&mut arg2.real_token_reserves, v0);
        0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg2.lp_token_reserves, v1));
        let v3 = 0x2::balance::value<T1>(&arg2.real_quote_reserves);
        let v4 = MigrationAssetsWithdrawnEvent{
            token_address : type_label<T0>(),
            quote_address : type_label<T1>(),
            pool_id       : 0x2::object::id<Pool<T0, T1>>(arg2),
            token_amount  : v0 + v1,
            quote_amount  : v3,
        };
        0x2::event::emit<MigrationAssetsWithdrawnEvent>(v4);
        (0x2::coin::from_balance<T0>(v2, arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.real_quote_reserves, v3), arg3))
    }

    public fun platform_fee_recipient(arg0: &Protocol) : address {
        arg0.platform_fee_recipient
    }

    public fun pool_completed<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        arg0.is_completed
    }

    fun pool_exists<T0>(arg0: &Protocol) : bool {
        let v0 = PoolKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<PoolKey<T0>, PoolRecord>(&arg0.id, v0)
    }

    public fun pool_fee_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T1>(&arg0.creator_fee_balance), 0x2::balance::value<T1>(&arg0.platform_fee_balance))
    }

    public fun pool_fee_recipients<T0, T1>(arg0: &Pool<T0, T1>) : (address, address) {
        (arg0.creator_fee_recipient, arg0.platform_fee_recipient)
    }

    public fun pool_id<T0>(arg0: &Protocol) : 0x2::object::ID {
        registered_pool_id<T0>(arg0)
    }

    public fun pool_migrated<T0, T1>(arg0: &AdminCap, arg1: &Protocol, arg2: &mut Pool<T0, T1>, arg3: 0x2::object::ID) {
        assert!(arg1.version == 1, 0);
        assert_pool<T0, T1>(arg1, arg2);
        assert!(arg2.is_completed, 3);
        assert!(arg2.is_migrated, 18);
        assert!(!arg2.migration_event_emitted, 17);
        assert!(arg3 != 0x2::object::id_from_address(@0x0), 18);
        arg2.migration_event_emitted = true;
        arg2.migration_pool_id = arg3;
        let v0 = PoolMigratedEvent{
            token_address : type_label<T0>(),
            quote_address : type_label<T1>(),
            pool_id       : 0x2::object::id<Pool<T0, T1>>(arg2),
            clmm_pool_id  : arg3,
        };
        0x2::event::emit<PoolMigratedEvent>(v0);
    }

    public fun pool_migration_state<T0, T1>(arg0: &Pool<T0, T1>) : (bool, bool, 0x2::object::ID) {
        (arg0.is_migrated, arg0.migration_event_emitted, arg0.migration_pool_id)
    }

    public fun protocol_version(arg0: &Protocol) : u64 {
        arg0.version
    }

    public fun quote_buy_exact_in<T0, T1>(arg0: &Protocol, arg1: &Pool<T0, T1>, arg2: u64) : (u64, u64, u64) {
        check_protocol(arg0);
        assert_pool<T0, T1>(arg0, arg1);
        assert!(!arg1.is_completed, 11);
        assert!(arg2 > 0, 2);
        let v0 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg2, 10000, 1000000);
        let v1 = arg2 - v0;
        let v2 = 0x2::balance::value<T0>(&arg1.real_token_reserves);
        let v3 = 0x1::u64::min(v1, 0x1::u64::min(arg1.fair_launch_quote_amount - 0x2::balance::value<T1>(&arg1.real_quote_reserves), 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_liquidity_cost(v2, arg1.virtual_quote_reserves, arg1.virtual_token_reserves)));
        assert!(v3 > 0, 2);
        let v4 = 0x1::u64::min(0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_token_return(v3, arg1.virtual_quote_reserves, arg1.virtual_token_reserves), v2);
        assert!(v4 > 0, 2);
        let v5 = if (v3 == v1) {
            v0
        } else {
            0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v3, 1000000, 1000000 - 10000) - v3
        };
        (v4, v3, v5)
    }

    public fun quote_buy_exact_out<T0, T1>(arg0: &Protocol, arg1: &Pool<T0, T1>, arg2: u64) : (u64, u64) {
        check_protocol(arg0);
        assert_pool<T0, T1>(arg0, arg1);
        assert!(!arg1.is_completed, 11);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.real_token_reserves), 9);
        let v0 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_liquidity_cost(arg2, arg1.virtual_quote_reserves, arg1.virtual_token_reserves);
        assert!(v0 > 0, 2);
        assert!(v0 <= arg1.fair_launch_quote_amount - 0x2::balance::value<T1>(&arg1.real_quote_reserves), 7);
        let v1 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v0, 1000000, 1000000 - 10000);
        (v1, v1 - v0)
    }

    public fun quote_sell_exact_in<T0, T1>(arg0: &Protocol, arg1: &Pool<T0, T1>, arg2: u64) : (u64, u64) {
        check_protocol(arg0);
        assert_pool<T0, T1>(arg0, arg1);
        assert!(!arg1.is_completed, 11);
        assert!(arg2 > 0, 2);
        let v0 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_quote_return(arg2, arg1.virtual_quote_reserves, arg1.virtual_token_reserves);
        let v1 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v0, 10000, 1000000);
        assert!(v0 > v1, 2);
        assert!(v0 <= 0x2::balance::value<T1>(&arg1.real_quote_reserves), 10);
        (v0 - v1, v1)
    }

    public fun quote_sell_exact_out<T0, T1>(arg0: &Protocol, arg1: &Pool<T0, T1>, arg2: u64) : (u64, u64) {
        check_protocol(arg0);
        assert_pool<T0, T1>(arg0, arg1);
        assert!(!arg1.is_completed, 11);
        assert!(arg2 > 0, 2);
        let v0 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg2, 1000000, 1000000 - 10000);
        assert!(v0 < arg1.virtual_quote_reserves, 10);
        assert!(v0 <= 0x2::balance::value<T1>(&arg1.real_quote_reserves), 10);
        (0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v0, arg1.virtual_token_reserves, arg1.virtual_quote_reserves - v0), v0 - arg2)
    }

    fun registered_pool_id<T0>(arg0: &Protocol) : 0x2::object::ID {
        assert!(pool_exists<T0>(arg0), 20);
        let v0 = PoolKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<PoolKey<T0>, PoolRecord>(&arg0.id, v0).pool_id
    }

    public fun sell<T0, T1>(arg0: &Protocol, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_with_return<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v2);
    }

    fun sell_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = arg0.virtual_quote_reserves;
        let v1 = arg0.virtual_token_reserves;
        arg0.virtual_token_reserves = v1 + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_quote_reserves = v0 - arg2;
        check_lp_value(v0, v1, arg0.virtual_quote_reserves, arg0.virtual_token_reserves);
        0x2::balance::join<T0>(&mut arg0.real_token_reserves, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.real_quote_reserves, arg2), arg3)
    }

    public fun sell_with_return<T0, T1>(arg0: &Protocol, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        check_protocol(arg0);
        assert_pool<T0, T1>(arg0, arg1);
        assert!(arg3 > 0 && 0x2::coin::value<T0>(&arg2) > 0, 2);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!arg1.is_completed, 11);
        let (v1, v2, v3) = if (arg5) {
            let v4 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::curves::calculate_quote_return(arg3, arg1.virtual_quote_reserves, arg1.virtual_token_reserves);
            let v5 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v4, 10000, 1000000);
            assert!(v4 - v5 >= arg4, 6);
            (v5, v4, arg3)
        } else {
            let v6 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(arg3, 1000000, 1000000 - 10000);
            assert!(v6 < arg1.virtual_quote_reserves, 10);
            let v7 = 0x962accc69fe553b71093e4f20a142329329bf0ee802e4f08a5da552f7c19da86::full_math_u64::mul_div_ceil(v6, arg1.virtual_token_reserves, arg1.virtual_quote_reserves - v6);
            assert!(v7 <= arg4, 7);
            (v6 - arg3, v6, v7)
        };
        assert!(v3 > 0 && v2 > v1, 2);
        assert!(0x2::coin::value<T0>(&arg2) >= v3, 8);
        assert!(0x2::balance::value<T1>(&arg1.real_quote_reserves) >= v2, 10);
        let v8 = 0x2::coin::split<T0>(&mut arg2, v3, arg7);
        let v9 = sell_internal<T0, T1>(arg1, v8, v2, arg7);
        let v10 = TradedEvent{
            is_buy                 : false,
            user                   : v0,
            token_address          : type_label<T0>(),
            quote_address          : type_label<T1>(),
            quote_amount           : v2,
            token_amount           : v3,
            fee_amount             : v1,
            real_quote_reserves    : 0x2::balance::value<T1>(&arg1.real_quote_reserves),
            real_token_reserves    : 0x2::balance::value<T0>(&arg1.real_token_reserves),
            virtual_quote_reserves : arg1.virtual_quote_reserves,
            virtual_token_reserves : arg1.virtual_token_reserves,
            lp_token_reserves      : 0x2::balance::value<T0>(&arg1.lp_token_reserves),
            is_completed           : arg1.is_completed,
            pool_id                : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::event::emit<TradedEvent>(v10);
        credit_trading_fee<T0, T1>(arg1, 0x2::coin::split<T1>(&mut v9, v1, arg7));
        (v9, arg2)
    }

    fun split_fee_amount(arg0: u64) : (u64, u64) {
        let v0 = arg0 / 2;
        (v0, arg0 - v0)
    }

    fun target_sui_for_mode(arg0: u8) : u64 {
        if (arg0 == 0) {
            3200
        } else {
            assert!(arg0 == 1, 13);
            6400
        }
    }

    public fun trading_fee() : u64 {
        10000
    }

    fun type_label<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())))
    }

    public fun update_protocol(arg0: &AdminCap, arg1: &mut Protocol, arg2: u64, arg3: bool) {
        assert!(arg1.version == 1, 0);
        arg1.launch_fee_sui = arg2;
        arg1.paused = arg3;
        let v0 = ProtocolChangedEvent{
            launch_fee_sui : arg2,
            paused         : arg3,
        };
        0x2::event::emit<ProtocolChangedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

