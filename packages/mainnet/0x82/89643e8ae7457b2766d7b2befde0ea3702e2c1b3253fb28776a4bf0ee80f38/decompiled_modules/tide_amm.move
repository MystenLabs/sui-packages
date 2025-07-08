module 0x8289643e8ae7457b2766d7b2befde0ea3702e2c1b3253fb28776a4bf0ee80f38::tide_amm {
    struct TIDE_AMM has drop {
        dummy_field: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Price has copy, drop, store {
        value: u256,
        min: u256,
        max: u256,
    }

    struct TidePool has key {
        id: 0x2::object::UID,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        virtual_x_liquidity: u256,
        blacklist: 0x2::table::Table<address, bool>,
        price_x: Price,
        price_y: Price,
        fee_x: u256,
        fee_y: u256,
        decimals_x: u256,
        decimals_y: u256,
        last_update_ms: u64,
        max_update_delay_ms: u64,
        x_y_paused: bool,
        y_x_paused: bool,
        version: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    public fun swap<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x1::type_name::get<T0>() == arg0.x) {
            swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3)
        } else {
            swap_y_to_x<T1, T0>(arg0, arg1, arg2, arg3)
        }
    }

    fun balance<T0>(arg0: &TidePool) : &0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)
    }

    public fun new<T0, T1>(arg0: &mut Registry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: u256, arg4: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg5: &mut 0x2::tx_context::TxContext) : TidePool {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg4, 1);
        let v0 = TidePool{
            id                  : 0x2::object::new(arg5),
            x                   : 0x1::type_name::get<T0>(),
            y                   : 0x1::type_name::get<T1>(),
            virtual_x_liquidity : arg3,
            blacklist           : 0x2::table::new<address, bool>(arg5),
            price_x             : new_price(),
            price_y             : new_price(),
            fee_x               : 0,
            fee_y               : 0,
            decimals_x          : 0x1::u256::pow(10, 0x2::coin::get_decimals<T0>(arg1)),
            decimals_y          : 0x1::u256::pow(10, 0x2::coin::get_decimals<T1>(arg2)),
            last_update_ms      : 0,
            max_update_delay_ms : 0,
            x_y_paused          : false,
            y_x_paused          : false,
            version             : 1,
        };
        let v1 = &mut v0;
        add_zero_balances<T0, T1>(v1);
        0x1::vector::push_back<address>(&mut arg0.pools, 0x2::object::uid_to_address(&v0.id));
        0x8289643e8ae7457b2766d7b2befde0ea3702e2c1b3253fb28776a4bf0ee80f38::tide_events::emit_new_pool(0x2::object::uid_to_address(&v0.id), v0.x, v0.y);
        v0
    }

    public fun add_to_blacklist(arg0: &mut TidePool, arg1: address, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
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
        assert!(0x1::type_name::get<T0>() == arg0.x && 0x1::type_name::get<T1>() == arg0.y, 13906835677581934591);
    }

    fun balance_mut<T0>(arg0: &mut TidePool) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun balances<T0, T1>(arg0: &TidePool) : (u64, u64) {
        (0x2::balance::value<T0>(balance<T0>(arg0)), 0x2::balance::value<T1>(balance<T1>(arg0)))
    }

    fun calculate_fee_x_amount(arg0: &TidePool, arg1: u64) : u64 {
        (0x1::u256::min(0x1::u256::divide_and_round_up((arg1 as u256) * arg0.fee_x, arg0.decimals_x), 1) as u64)
    }

    fun calculate_fee_y_amount(arg0: &TidePool, arg1: u64) : u64 {
        (0x1::u256::min(0x1::u256::divide_and_round_up((arg1 as u256) * arg0.fee_y, arg0.decimals_y), 1) as u64)
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

    fun init(arg0: TIDE_AMM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::ACL<TIDE_AMM>>(0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::default<TIDE_AMM>(&arg0, arg1));
        0x2::package::claim_and_keep<TIDE_AMM>(arg0, arg1);
        let v0 = Registry{
            id    : 0x2::object::new(arg1),
            pools : vector[],
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun invariant<T0, T1>(arg0: &TidePool) : u256 {
        let (v0, v1) = get_normalized_balances<T0, T1>(arg0);
        v0 * arg0.price_x.value / 1000000000000000000 + v1 * arg0.price_y.value / 1000000000000000000
    }

    fun is_price_stale(arg0: &TidePool, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.last_update_ms > arg0.max_update_delay_ms
    }

    fun new_price() : Price {
        Price{
            value : 0,
            min   : 0,
            max   : 0,
        }
    }

    fun normalize_x_amount(arg0: &TidePool, arg1: u64) : u256 {
        (arg1 as u256) * 1000000000000000000 / arg0.decimals_x
    }

    fun normalize_y_amount(arg0: &TidePool, arg1: u64) : u256 {
        (arg1 as u256) * 1000000000000000000 / arg0.decimals_y
    }

    public fun pause_x_y(arg0: &mut TidePool, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg1, 1);
        arg0.x_y_paused = true;
    }

    public fun pause_y_x(arg0: &mut TidePool, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg1, 1);
        arg0.y_x_paused = true;
    }

    public fun quote<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64, u64) {
        if (is_price_stale(arg0, arg1)) {
            return (0, 0, 0)
        };
        if (0x1::type_name::get<T0>() == arg0.x) {
            quote_x_to_y<T0, T1>(arg0, arg2)
        } else {
            quote_y_to_x<T1, T0>(arg0, arg2)
        }
    }

    fun quote_x_to_y<T0, T1>(arg0: &TidePool, arg1: u64) : (u64, u64, u64) {
        assert_types<T0, T1>(arg0);
        if (arg0.x_y_paused) {
            return (0, 0, 0)
        };
        let (_, v1) = get_normalized_balances<T0, T1>(arg0);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = virtual_balances<T0, T1>(arg0);
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
        let v7 = 0x1::u256::min(v6, normalize_x_amount(arg0, arg1));
        assert!(v7 != 0, 1);
        assert!(v2 != 0 && v3 != 0, 0);
        let v8 = denormalize_y_amount(v3 * v7 / (v2 + v7), arg0);
        if (v8 > 0x2::balance::value<T1>(balance<T1>(arg0)) || v8 == 0) {
            return (0, 0, 0)
        };
        let v9 = calculate_fee_y_amount(arg0, v8);
        (denormalize_x_amount(v7, arg0), v8 - v9, v9)
    }

    fun quote_y_to_x<T0, T1>(arg0: &TidePool, arg1: u64) : (u64, u64, u64) {
        assert_types<T0, T1>(arg0);
        if (arg0.y_x_paused) {
            return (0, 0, 0)
        };
        let (v0, _) = get_normalized_balances<T0, T1>(arg0);
        if (v0 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = virtual_balances<T0, T1>(arg0);
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
        let v7 = 0x1::u256::min(v6, normalize_y_amount(arg0, arg1));
        assert!(v7 != 0, 1);
        assert!(v3 != 0 && v2 != 0, 0);
        let v8 = denormalize_x_amount(v2 * v7 / (v3 + v7), arg0);
        if (v8 > 0x2::balance::value<T0>(balance<T0>(arg0)) || v8 == 0) {
            return (0, 0, 0)
        };
        let v9 = calculate_fee_x_amount(arg0, v8);
        (denormalize_y_amount(v7, arg0), v8 - v9, v9)
    }

    public fun remove_from_blacklist(arg0: &mut TidePool, arg1: address, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        0x2::table::remove<address, bool>(&mut arg0.blacklist, arg1);
    }

    public fun set_fee_x(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.fee_x = arg1;
    }

    public fun set_fee_y(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.fee_y = arg1;
    }

    public fun set_max_prices(arg0: &mut TidePool, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != 0 && arg4 != 0, 2);
        assert!(arg1 > arg3 && arg2 > arg4, 2);
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg5, 1);
        arg0.price_x.max = arg1;
        arg0.price_y.max = arg2;
        arg0.price_x.min = arg3;
        arg0.price_y.min = arg4;
    }

    public fun set_max_update_delay_ms(arg0: &mut TidePool, arg1: u64, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.max_update_delay_ms = arg1;
    }

    public fun set_prices(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: u256, arg3: u256, arg4: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg4, 2);
        assert!(arg0.price_x.min <= arg2 && arg2 <= arg0.price_x.max, 2);
        assert!(arg0.price_y.min <= arg3 && arg3 <= arg0.price_y.max, 2);
        arg0.price_x.value = arg2;
        arg0.price_y.value = arg3;
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun set_virtual_x_liquidity(arg0: &mut TidePool, arg1: u256, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.virtual_x_liquidity = arg1;
    }

    public fun share(arg0: TidePool) {
        0x2::transfer::share_object<TidePool>(arg0);
    }

    fun swap_x_to_y<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_package_version(arg0);
        let v0 = invariant<T0, T1>(arg0);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let v2 = if (v1 == 0) {
            true
        } else if (is_price_stale(arg0, arg1)) {
            true
        } else {
            0x2::table::contains<address, bool>(&arg0.blacklist, 0x2::tx_context::sender(arg3))
        };
        if (v2) {
            return (arg2, 0x2::coin::zero<T1>(arg3))
        };
        let (v3, v4, v5) = quote_x_to_y<T0, T1>(arg0, v1);
        if (v3 == 0) {
            return (arg2, 0x2::coin::zero<T1>(arg3))
        };
        let v6 = balance_mut<T0>(arg0);
        0x2::balance::join<T0>(v6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v3, arg3)));
        let v7 = balance_mut<T1>(arg0);
        assert!(invariant<T0, T1>(arg0) >= v0, 5);
        0x8289643e8ae7457b2766d7b2befde0ea3702e2c1b3253fb28776a4bf0ee80f38::tide_events::emit_swap(0x2::object::uid_to_address(&arg0.id), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v3, v4, v5, 0x2::balance::value<T0>(balance<T0>(arg0)), 0x2::balance::value<T1>(balance<T1>(arg0)));
        (arg2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v7, v4), arg3))
    }

    fun swap_y_to_x<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert_package_version(arg0);
        let v0 = invariant<T0, T1>(arg0);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = if (v1 == 0) {
            true
        } else if (is_price_stale(arg0, arg1)) {
            true
        } else {
            0x2::table::contains<address, bool>(&arg0.blacklist, 0x2::tx_context::sender(arg3))
        };
        if (v2) {
            return (arg2, 0x2::coin::zero<T0>(arg3))
        };
        let (v3, v4, v5) = quote_y_to_x<T0, T1>(arg0, v1);
        if (v3 == 0) {
            return (arg2, 0x2::coin::zero<T0>(arg3))
        };
        let v6 = balance_mut<T1>(arg0);
        0x2::balance::join<T1>(v6, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v3, arg3)));
        let v7 = balance_mut<T0>(arg0);
        assert!(invariant<T0, T1>(arg0) >= v0, 5);
        0x8289643e8ae7457b2766d7b2befde0ea3702e2c1b3253fb28776a4bf0ee80f38::tide_events::emit_swap(0x2::object::uid_to_address(&arg0.id), 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>(), v3, v4, v5, 0x2::balance::value<T0>(balance<T0>(arg0)), 0x2::balance::value<T1>(balance<T1>(arg0)));
        (arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v7, v4), arg3))
    }

    public fun unpause_x_y(arg0: &mut TidePool, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg1, 1);
        arg0.x_y_paused = false;
    }

    public fun unpause_y_x(arg0: &mut TidePool, arg1: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg1, 1);
        arg0.y_x_paused = false;
    }

    public fun virtual_balances<T0, T1>(arg0: &TidePool) : (u256, u256) {
        let (v0, _) = get_normalized_balances<T0, T1>(arg0);
        let v2 = (v0 as u256) + arg0.virtual_x_liquidity;
        (v2, v2 * arg0.price_x.value / arg0.price_y.value)
    }

    public fun withdraw<T0, T1>(arg0: &mut TidePool, arg1: u64, arg2: u64, arg3: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg3, 1);
        let v0 = balance_mut<T0>(arg0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(balance_mut<T1>(arg0), arg2), arg4))
    }

    // decompiled from Move bytecode v6
}

