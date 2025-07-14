module 0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_amm {
    struct TIDE_AMM has drop {
        dummy_field: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TidePool has key {
        id: 0x2::object::UID,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        virtual_x_liquidity: u256,
        blacklist: 0x2::table::Table<address, bool>,
        fee_x: u256,
        fee_y: u256,
        decimals_x: u256,
        decimals_y: u256,
        max_age: u64,
        max_deviation_percentage: u256,
        x_y_paused: bool,
        y_x_paused: bool,
        version: u64,
        feed_x: address,
        feed_y: address,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    public fun swap<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x1::type_name::get<T0>() == arg0.x) {
            swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
        } else {
            swap_y_to_x<T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5)
        }
    }

    fun balance<T0>(arg0: &TidePool) : &0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)
    }

    public fun new<T0, T1>(arg0: &mut Registry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: u256, arg4: address, arg5: address, arg6: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg7: &mut 0x2::tx_context::TxContext) : TidePool {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg6, 1);
        let v0 = TidePool{
            id                       : 0x2::object::new(arg7),
            x                        : 0x1::type_name::get<T0>(),
            y                        : 0x1::type_name::get<T1>(),
            virtual_x_liquidity      : arg3,
            blacklist                : 0x2::table::new<address, bool>(arg7),
            fee_x                    : 0,
            fee_y                    : 0,
            decimals_x               : 0x1::u256::pow(10, 0x2::coin::get_decimals<T0>(arg1)),
            decimals_y               : 0x1::u256::pow(10, 0x2::coin::get_decimals<T1>(arg2)),
            max_age                  : 0,
            max_deviation_percentage : 0,
            x_y_paused               : false,
            y_x_paused               : false,
            version                  : 1,
            feed_x                   : arg4,
            feed_y                   : arg5,
        };
        let v1 = &mut v0;
        add_zero_balances<T0, T1>(v1);
        0x1::vector::push_back<address>(&mut arg0.pools, 0x2::object::uid_to_address(&v0.id));
        0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_events::emit_new_pool(0x2::object::uid_to_address(&v0.id), v0.x, v0.y, v0.feed_x, v0.feed_y);
        v0
    }

    public fun add_to_blacklist(arg0: &mut TidePool, arg1: address, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        0x2::table::add<address, bool>(&mut arg0.blacklist, arg1, true);
    }

    fun add_zero_balances<T0, T1>(arg0: &mut TidePool) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        let v1 = BalanceKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v1, 0x2::balance::zero<T1>());
    }

    fun assert_package_version(arg0: &TidePool) {
        assert!(arg0.version == 1, 4);
    }

    fun assert_types<T0, T1>(arg0: &TidePool) {
        assert!(0x1::type_name::get<T0>() == arg0.x && 0x1::type_name::get<T1>() == arg0.y, 13906835587387621375);
    }

    fun balance_mut<T0>(arg0: &mut TidePool) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun balances<T0, T1>(arg0: &TidePool) : (u64, u64) {
        (0x2::balance::value<T0>(balance<T0>(arg0)), 0x2::balance::value<T1>(balance<T1>(arg0)))
    }

    fun calculate_fee_x_amount(arg0: &TidePool, arg1: u64) : u64 {
        (0x1::u256::divide_and_round_up((arg1 as u256) * arg0.fee_x, arg0.decimals_x) as u64)
    }

    fun calculate_fee_y_amount(arg0: &TidePool, arg1: u64) : u64 {
        (0x1::u256::divide_and_round_up((arg1 as u256) * arg0.fee_y, arg0.decimals_y) as u64)
    }

    fun denormalize_x_amount(arg0: u256, arg1: &TidePool) : u64 {
        ((arg0 * arg1.decimals_x / 1000000000000000000) as u64)
    }

    fun denormalize_y_amount(arg0: u256, arg1: &TidePool) : u64 {
        ((arg0 * arg1.decimals_y / 1000000000000000000) as u64)
    }

    public fun deposit<T0, T1>(arg0: &mut TidePool, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg3, 1);
        let v0 = balance_mut<T0>(arg0);
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(balance_mut<T1>(arg0), 0x2::coin::into_balance<T1>(arg2));
    }

    fun get_normalized_balances<T0, T1>(arg0: &TidePool) : (u256, u256) {
        ((0x2::balance::value<T0>(balance<T0>(arg0)) as u256) * 1000000000000000000 / arg0.decimals_x, (0x2::balance::value<T1>(balance<T1>(arg0)) as u256) * 1000000000000000000 / arg0.decimals_y)
    }

    fun get_normalized_prices(arg0: &TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u256, u256) {
        (0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_price::parse_price_info_object(arg2, arg1, arg0.feed_x, arg0.max_age, arg0.max_deviation_percentage), 0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_price::parse_price_info_object(arg3, arg1, arg0.feed_y, arg0.max_age, arg0.max_deviation_percentage))
    }

    fun get_virtual_balances<T0, T1>(arg0: &TidePool, arg1: u256, arg2: u256) : (u256, u256) {
        let (v0, _) = get_normalized_balances<T0, T1>(arg0);
        let v2 = v0 + arg0.virtual_x_liquidity;
        (v2, v2 * arg1 / arg2)
    }

    fun init(arg0: TIDE_AMM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::ACL<TIDE_AMM>>(0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::default<TIDE_AMM>(&arg0, arg1));
        0x2::package::claim_and_keep<TIDE_AMM>(arg0, arg1);
        let v0 = Registry{
            id    : 0x2::object::new(arg1),
            pools : vector[],
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun invariant<T0, T1>(arg0: &TidePool, arg1: u256, arg2: u256) : u256 {
        let (v0, v1) = get_normalized_balances<T0, T1>(arg0);
        v0 * arg1 / 1000000000000000000 + v1 * arg2 / 1000000000000000000
    }

    fun normalize_x_amount(arg0: &TidePool, arg1: u64) : u256 {
        (arg1 as u256) * 1000000000000000000 / arg0.decimals_x
    }

    fun normalize_y_amount(arg0: &TidePool, arg1: u64) : u256 {
        (arg1 as u256) * 1000000000000000000 / arg0.decimals_y
    }

    public fun quote<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : (u64, u64, u64) {
        let (v0, v1) = get_normalized_prices(arg0, arg1, arg2, arg3);
        if (v0 == 0 || v1 == 0) {
            return (0, 0, 0)
        };
        if (0x1::type_name::get<T0>() == arg0.x) {
            quote_x_to_y<T0, T1>(arg0, v0, v1, arg4)
        } else {
            quote_y_to_x<T1, T0>(arg0, v0, v1, arg4)
        }
    }

    fun quote_x_to_y<T0, T1>(arg0: &TidePool, arg1: u256, arg2: u256, arg3: u64) : (u64, u64, u64) {
        if (arg0.x_y_paused) {
            return (0, 0, 0)
        };
        let (_, v1) = get_normalized_balances<T0, T1>(arg0);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = get_virtual_balances<T0, T1>(arg0, arg1, arg2);
        assert!((v1 as u256) != 0, 1);
        let v4 = if (v2 != 0) {
            if (v3 != 0) {
                v3 > (v1 as u256)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 0);
        let v5 = v2 * (v1 as u256);
        let v6 = if (v5 == 0) {
            0
        } else {
            1 + (v5 - 1) / (v3 - (v1 as u256))
        };
        let v7 = 0x1::u256::min(v6, normalize_x_amount(arg0, arg3));
        assert!(v7 != 0, 1);
        assert!(v2 != 0 && v3 != 0, 0);
        let v8 = denormalize_y_amount(v3 * v7 / (v2 + v7), arg0);
        if (v8 > 0x2::balance::value<T1>(balance<T1>(arg0)) || v8 == 0) {
            return (0, 0, 0)
        };
        let v9 = calculate_fee_y_amount(arg0, v8);
        if (v9 == 0 && arg0.fee_y != 0) {
            return (0, 0, 0)
        };
        (denormalize_x_amount(v7, arg0), v8 - v9, v9)
    }

    fun quote_y_to_x<T0, T1>(arg0: &TidePool, arg1: u256, arg2: u256, arg3: u64) : (u64, u64, u64) {
        if (arg0.y_x_paused) {
            return (0, 0, 0)
        };
        let (v0, _) = get_normalized_balances<T0, T1>(arg0);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = get_virtual_balances<T0, T1>(arg0, arg1, arg2);
        assert!((v0 as u256) != 0, 1);
        let v4 = if (v3 != 0) {
            if (v2 != 0) {
                v2 > (v0 as u256)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 0);
        let v5 = v3 * (v0 as u256);
        let v6 = if (v5 == 0) {
            0
        } else {
            1 + (v5 - 1) / (v2 - (v0 as u256))
        };
        let v7 = 0x1::u256::min(v6, normalize_y_amount(arg0, arg3));
        assert!(v7 != 0, 1);
        assert!(v3 != 0 && v2 != 0, 0);
        let v8 = denormalize_x_amount(v2 * v7 / (v3 + v7), arg0);
        if (v8 > 0x2::balance::value<T0>(balance<T0>(arg0)) || v8 == 0) {
            return (0, 0, 0)
        };
        let v9 = calculate_fee_x_amount(arg0, v8);
        if (v9 == 0 && arg0.fee_x != 0) {
            return (0, 0, 0)
        };
        (denormalize_y_amount(v7, arg0), v8 - v9, v9)
    }

    public fun remove_from_blacklist(arg0: &mut TidePool, arg1: address, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        0x2::table::remove<address, bool>(&mut arg0.blacklist, arg1);
    }

    public fun set_fee_x(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        arg0.fee_x = arg1;
    }

    public fun set_fee_y(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        arg0.fee_y = arg1;
    }

    public fun set_max_age(arg0: &mut TidePool, arg1: u64, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.max_age = arg1;
    }

    public fun set_max_deviation_percentage(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.max_deviation_percentage = arg1;
    }

    public fun set_pause_x_y(arg0: &mut TidePool, arg1: bool, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        arg0.x_y_paused = arg1;
    }

    public fun set_pause_y_x(arg0: &mut TidePool, arg1: bool, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        arg0.y_x_paused = arg1;
    }

    public fun set_virtual_x_liquidity(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 2);
        arg0.virtual_x_liquidity = arg1;
    }

    public fun share(arg0: TidePool) {
        0x2::transfer::share_object<TidePool>(arg0);
    }

    fun swap_x_to_y<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_package_version(arg0);
        assert_types<T0, T1>(arg0);
        let (v0, v1) = get_normalized_prices(arg0, arg1, arg2, arg3);
        let v2 = 0x2::coin::value<T0>(&arg4);
        let v3 = if (v2 == 0) {
            true
        } else if (0x2::table::contains<address, bool>(&arg0.blacklist, 0x2::tx_context::sender(arg5))) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v3) {
            return (arg4, 0x2::coin::zero<T1>(arg5))
        };
        let (v4, v5, v6) = quote_x_to_y<T0, T1>(arg0, v0, v1, v2);
        if (v4 == 0) {
            return (arg4, 0x2::coin::zero<T1>(arg5))
        };
        let v7 = invariant<T0, T1>(arg0, v0, v1);
        let v8 = balance_mut<T0>(arg0);
        0x2::balance::join<T0>(v8, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v4, arg5)));
        let v9 = balance_mut<T1>(arg0);
        assert!(invariant<T0, T1>(arg0, v0, v1) >= v7, 5);
        0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_events::emit_swap(0x2::object::uid_to_address(&arg0.id), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v4, v5, v6, v0, v1, 0x2::balance::value<T0>(balance<T0>(arg0)), 0x2::balance::value<T1>(balance<T1>(arg0)));
        (arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v9, v5), arg5))
    }

    fun swap_y_to_x<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert_package_version(arg0);
        assert_types<T0, T1>(arg0);
        let (v0, v1) = get_normalized_prices(arg0, arg1, arg2, arg3);
        let v2 = 0x2::coin::value<T1>(&arg4);
        let v3 = if (v2 == 0) {
            true
        } else if (0x2::table::contains<address, bool>(&arg0.blacklist, 0x2::tx_context::sender(arg5))) {
            true
        } else if (v0 == 0) {
            true
        } else {
            v1 == 0
        };
        if (v3) {
            return (arg4, 0x2::coin::zero<T0>(arg5))
        };
        let (v4, v5, v6) = quote_y_to_x<T0, T1>(arg0, v0, v1, v2);
        if (v4 == 0) {
            return (arg4, 0x2::coin::zero<T0>(arg5))
        };
        let v7 = invariant<T0, T1>(arg0, v0, v1);
        let v8 = balance_mut<T1>(arg0);
        0x2::balance::join<T1>(v8, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v4, arg5)));
        let v9 = balance_mut<T0>(arg0);
        assert!(invariant<T0, T1>(arg0, v0, v1) >= v7, 5);
        0x863370f42741e28dbe3293276c3477ffa8ef5137c24ccb4c7eeee2eafeb570c0::tide_events::emit_swap(0x2::object::uid_to_address(&arg0.id), 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>(), v4, v5, v6, v0, v1, 0x2::balance::value<T0>(balance<T0>(arg0)), 0x2::balance::value<T1>(balance<T1>(arg0)));
        (arg4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, v5), arg5))
    }

    public fun virtual_balances<T0, T1>(arg0: &TidePool, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (u256, u256) {
        let (v0, v1) = get_normalized_prices(arg0, arg1, arg2, arg3);
        get_virtual_balances<T0, T1>(arg0, v0, v1)
    }

    public fun withdraw<T0, T1>(arg0: &mut TidePool, arg1: u64, arg2: u64, arg3: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg3, 1);
        let v0 = balance_mut<T0>(arg0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(balance_mut<T1>(arg0), arg2), arg4))
    }

    // decompiled from Move bytecode v6
}

