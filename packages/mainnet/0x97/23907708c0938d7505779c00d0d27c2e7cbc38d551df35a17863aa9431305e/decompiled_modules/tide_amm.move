module 0x9723907708c0938d7505779c00d0d27c2e7cbc38d551df35a17863aa9431305e::tide_amm {
    struct TIDE_AMM has drop {
        dummy_field: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Price has copy, drop, store {
        value: u128,
        max: u128,
        min: u128,
    }

    struct TidePool has key {
        id: 0x2::object::UID,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        amplifier: u128,
        target_x: u64,
        target_y: u64,
        price_x: Price,
        price_y: Price,
        fee_x: u128,
        fee_y: u128,
        decimals_x: u128,
        decimals_y: u128,
        last_update_ms: u64,
        max_update_delay_ms: u64,
        first_threshold: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        second_threshold: 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::BPS,
        locked: bool,
        version: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct SwapEvent has copy, drop {
        pool: address,
        coinIn: 0x1::type_name::TypeName,
        coinOut: 0x1::type_name::TypeName,
        amountIn: u64,
        amountOut: u64,
        fee: u64,
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

    public fun new<T0, T1>(arg0: &mut Registry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg4: &mut 0x2::tx_context::TxContext) : TidePool {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg3, 1);
        let v0 = TidePool{
            id                  : 0x2::object::new(arg4),
            x                   : 0x1::type_name::get<T0>(),
            y                   : 0x1::type_name::get<T1>(),
            amplifier           : 0,
            target_x            : 0,
            target_y            : 0,
            price_x             : empty_price(),
            price_y             : empty_price(),
            fee_x               : 0,
            fee_y               : 0,
            decimals_x          : 0x1::u128::pow(10, 0x2::coin::get_decimals<T0>(arg1)),
            decimals_y          : 0x1::u128::pow(10, 0x2::coin::get_decimals<T1>(arg2)),
            last_update_ms      : 0,
            max_update_delay_ms : 0,
            first_threshold     : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0),
            second_threshold    : 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(0),
            locked              : false,
            version             : 1,
        };
        let v1 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        let v2 = BalanceKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v2, 0x2::balance::zero<T1>());
        let v3 = FeeKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<FeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, 0x2::balance::zero<T0>());
        let v4 = FeeKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<FeeKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v4, 0x2::balance::zero<T1>());
        0x1::vector::push_back<address>(&mut arg0.pools, 0x2::object::uid_to_address(&v0.id));
        v0
    }

    fun assert_package_version(arg0: &TidePool) {
        assert!(arg0.version == 1, 4);
    }

    fun assert_types<T0, T1>(arg0: &TidePool) {
        assert!(0x1::type_name::get<T0>() == arg0.x && 0x1::type_name::get<T1>() == arg0.y, 13906836124258533375);
    }

    fun balance_mut<T0>(arg0: &mut TidePool) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    public fun deposit<T0, T1>(arg0: &mut TidePool, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg3, 1);
        arg0.target_x = arg0.target_x + 0x2::coin::value<T0>(&arg1);
        let v0 = balance_mut<T0>(arg0);
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(balance_mut<T1>(arg0), 0x2::coin::into_balance<T1>(arg2));
    }

    fun empty_price() : Price {
        Price{
            value : 0,
            max   : 0,
            min   : 0,
        }
    }

    fun fee_mut<T0>(arg0: &mut TidePool) : &mut 0x2::balance::Balance<T0> {
        let v0 = FeeKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FeeKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
    }

    fun get_target_y(arg0: &TidePool) : u64 {
        (((arg0.target_x as u128) * arg0.price_x.value / arg0.price_y.value) as u64)
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

    fun is_price_stale(arg0: &TidePool, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.last_update_ms >= arg0.max_update_delay_ms
    }

    public fun quote<T0, T1>(arg0: &TidePool, arg1: u64) : (u64, u64) {
        if (0x1::type_name::get<T0>() == arg0.x) {
            quote_x_to_y<T0, T1>(arg0, arg1)
        } else {
            quote_y_to_x<T1, T0>(arg0, arg1)
        }
    }

    fun quote_x_to_y<T0, T1>(arg0: &TidePool, arg1: u64) : (u64, u64) {
        assert_types<T0, T1>(arg0);
        let v0 = get_target_y(arg0);
        let v1 = (((arg1 as u128) * 1000000000 / arg0.decimals_x * arg0.price_x.value * arg0.decimals_y / arg0.price_y.value / 1000000000) as u64);
        assert!((arg1 as u128) != 0, 1);
        assert!((0x2::balance::value<T0>(balance<T0>(arg0)) as u128) * arg0.amplifier != 0 && (0x2::balance::value<T1>(balance<T1>(arg0)) as u128) * arg0.amplifier != 0, 0);
        let v2 = (((0x2::balance::value<T1>(balance<T1>(arg0)) as u128) * arg0.amplifier * (arg1 as u128) / ((0x2::balance::value<T0>(balance<T0>(arg0)) as u128) * arg0.amplifier + (arg1 as u128))) as u64);
        if (v0 - v1 >= v0 - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.first_threshold, v0)) {
            let v5 = (0x1::u128::divide_and_round_up((v1 as u128) * arg0.fee_y, arg0.decimals_y) as u64);
            (v1 - v5, v5)
        } else {
            let (v6, v7) = if (v0 - v2 >= v0 - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.second_threshold, v0)) {
                let v8 = (0x1::u128::divide_and_round_up((v2 as u128) * arg0.fee_y, arg0.decimals_y) as u64);
                (v8, v2 - v8)
            } else {
                (0, 0)
            };
            (v7, v6)
        }
    }

    fun quote_y_to_x<T0, T1>(arg0: &TidePool, arg1: u64) : (u64, u64) {
        assert_types<T0, T1>(arg0);
        let v0 = (((arg1 as u128) * 1000000000 / arg0.decimals_y * arg0.price_y.value * arg0.decimals_x / arg0.price_x.value / 1000000000) as u64);
        assert!((arg1 as u128) != 0, 1);
        assert!((0x2::balance::value<T1>(balance<T1>(arg0)) as u128) * arg0.amplifier != 0 && (0x2::balance::value<T0>(balance<T0>(arg0)) as u128) * arg0.amplifier != 0, 0);
        let v1 = (((0x2::balance::value<T0>(balance<T0>(arg0)) as u128) * arg0.amplifier * (arg1 as u128) / ((0x2::balance::value<T1>(balance<T1>(arg0)) as u128) * arg0.amplifier + (arg1 as u128))) as u64);
        if (arg0.target_x - v0 >= arg0.target_x - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.first_threshold, arg0.target_x)) {
            let v4 = (0x1::u128::divide_and_round_up((v0 as u128) * arg0.fee_x, arg0.decimals_x) as u64);
            (v0 - v4, v4)
        } else {
            let (v5, v6) = if (arg0.target_x - v1 >= arg0.target_x - 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::calc_up(arg0.second_threshold, arg0.target_x)) {
                let v7 = (0x1::u128::divide_and_round_up((v1 as u128) * arg0.fee_x, arg0.decimals_x) as u64);
                (v7, v1 - v7)
            } else {
                (0, 0)
            };
            (v6, v5)
        }
    }

    public fun set_amplifier(arg0: &mut TidePool, arg1: u128, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.amplifier = arg1;
    }

    public fun set_fee_x(arg0: &mut TidePool, arg1: u128, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.fee_x = arg1;
    }

    public fun set_fee_y(arg0: &mut TidePool, arg1: u128, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.fee_y = arg1;
    }

    public fun set_first_threshold(arg0: &mut TidePool, arg1: u64, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        arg0.first_threshold = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg1);
    }

    public fun set_max_prices(arg0: &mut TidePool, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg6: &mut 0x2::tx_context::TxContext) {
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

    public fun set_prices(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: u128, arg3: u128, arg4: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg4, 2);
        assert!(arg0.price_x.min <= arg2 && arg2 <= arg0.price_x.max, 2);
        assert!(arg0.price_y.min <= arg3 && arg3 <= arg0.price_y.max, 2);
        arg0.price_x.value = (arg2 as u128);
        arg0.price_y.value = (arg3 as u128);
        arg0.last_update_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun set_second_threshold(arg0: &mut TidePool, arg1: u64, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg2, 1);
        assert!(arg1 > 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::value(arg0.first_threshold), 13906835145005989887);
        arg0.second_threshold = 0xec50242b14f7ffdc37fb91ade8490cdce2f876e7e9c3c3d7d7d98e944397d8f2::bps::new(arg1);
    }

    public fun share(arg0: TidePool) {
        0x2::transfer::share_object<TidePool>(arg0);
    }

    fun swap_x_to_y<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2) = quote_x_to_y<T0, T1>(arg0, v0);
        if (v1 == 0 || is_price_stale(arg0, arg1)) {
            return (arg2, 0x2::coin::zero<T1>(arg3))
        };
        let v3 = balance_mut<T0>(arg0);
        0x2::balance::join<T0>(v3, 0x2::coin::into_balance<T0>(arg2));
        let v4 = balance_mut<T1>(arg0);
        let v5 = 0x2::balance::split<T1>(v4, v1);
        let v6 = SwapEvent{
            pool      : 0x2::object::uid_to_address(&arg0.id),
            coinIn    : 0x1::type_name::get<T0>(),
            coinOut   : 0x1::type_name::get<T1>(),
            amountIn  : v0,
            amountOut : v1,
            fee       : v2,
        };
        0x2::event::emit<SwapEvent>(v6);
        0x2::balance::join<T1>(fee_mut<T1>(arg0), 0x2::balance::split<T1>(&mut v5, v2));
        (0x2::coin::zero<T0>(arg3), 0x2::coin::from_balance<T1>(v5, arg3))
    }

    fun swap_y_to_x<T0, T1>(arg0: &mut TidePool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert_package_version(arg0);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2) = quote_y_to_x<T0, T1>(arg0, v0);
        if (v1 == 0 || is_price_stale(arg0, arg1)) {
            return (arg2, 0x2::coin::zero<T0>(arg3))
        };
        let v3 = balance_mut<T1>(arg0);
        0x2::balance::join<T1>(v3, 0x2::coin::into_balance<T1>(arg2));
        let v4 = balance_mut<T0>(arg0);
        let v5 = 0x2::balance::split<T0>(v4, v1);
        let v6 = fee_mut<T0>(arg0);
        0x2::balance::join<T0>(v6, 0x2::balance::split<T0>(&mut v5, v2));
        let v7 = SwapEvent{
            pool      : 0x2::object::uid_to_address(&arg0.id),
            coinIn    : 0x1::type_name::get<T1>(),
            coinOut   : 0x1::type_name::get<T0>(),
            amountIn  : v0,
            amountOut : v1,
            fee       : v2,
        };
        0x2::event::emit<SwapEvent>(v7);
        (0x2::coin::zero<T1>(arg3), 0x2::coin::from_balance<T0>(v5, arg3))
    }

    public fun withdraw<T0, T1>(arg0: &mut TidePool, arg1: u64, arg2: u64, arg3: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<TIDE_AMM>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::assert_has_role<TIDE_AMM>(arg3, 1);
        arg0.target_x = arg0.target_x - arg1;
        arg0.target_y = arg0.target_y - arg2;
        let v0 = balance_mut<T0>(arg0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(balance_mut<T1>(arg0), arg2), arg4))
    }

    // decompiled from Move bytecode v6
}

