module 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2 {
    struct XLP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct YLP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PairRegistry has key {
        id: 0x2::object::UID,
        pair_ids: vector<address>,
    }

    struct TradingPair<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        concentration: u64,
        big_k: u128,
        target_x: u64,
        mult_x: u64,
        mult_y: u64,
        fee_millionth: u64,
        x_price_id: address,
        y_price_id: address,
        x_retain_decimals: u64,
        y_retain_decimals: u64,
        cumulative_volume: u64,
        volumes: vector<u64>,
        times: vector<u64>,
        target_y_based_lock: bool,
        target_y_reference: u64,
        pyth_mode: bool,
        pyth_y_add: u64,
        pyth_y_sub: u64,
    }

    struct TraderList has key {
        id: 0x2::object::UID,
        traders: vector<address>,
    }

    struct Borrow<phantom T0, phantom T1> {
        is_borrow_x: bool,
        borrow_amount: u64,
    }

    fun assert_trader(arg0: &TraderList, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&v0 == 0x1::vector::borrow<address>(&arg0.traders, arg1), 10);
    }

    public entry fun create_pair<T0, T1>(arg0: &mut PairRegistry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        assert!((0x2::coin::get_decimals<T0>(arg1) as u64) + arg5 == (0x2::coin::get_decimals<T1>(arg2) as u64) + arg6, 7);
        let v0 = TradingPair<T0, T1>{
            id                  : 0x2::object::new(arg10),
            reserve_x           : 0x2::balance::zero<T0>(),
            reserve_y           : 0x2::balance::zero<T1>(),
            concentration       : arg7,
            big_k               : 0,
            target_x            : 0,
            mult_x              : 0,
            mult_y              : 0,
            fee_millionth       : arg8,
            x_price_id          : 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3),
            y_price_id          : 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4),
            x_retain_decimals   : arg5,
            y_retain_decimals   : arg6,
            cumulative_volume   : 0,
            volumes             : vector[0, 0, 0, 0, 0, 0, 0, 0],
            times               : vector[0, 0, 0, 0, 0, 0, 0, 0],
            target_y_based_lock : false,
            target_y_reference  : 0,
            pyth_mode           : arg9,
            pyth_y_add          : 0,
            pyth_y_sub          : 0,
        };
        0x1::vector::push_back<address>(&mut arg0.pair_ids, 0x2::object::id_address<TradingPair<T0, T1>>(&v0));
        0x2::transfer::share_object<TradingPair<T0, T1>>(v0);
    }

    public fun deposit<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg2));
        arg0.target_x = arg0.target_x + 0x2::coin::value<T0>(&arg1);
    }

    fun get_target_y<T0, T1>(arg0: &TradingPair<T0, T1>) : u64 {
        (0x2::balance::value<T0>(&arg0.reserve_x) * arg0.mult_x + 0x2::balance::value<T1>(&arg0.reserve_y) * arg0.mult_y - arg0.target_x * arg0.mult_x) / arg0.mult_y
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PairRegistry{
            id       : 0x2::object::new(arg0),
            pair_ids : vector[],
        };
        0x2::transfer::share_object<PairRegistry>(v0);
    }

    entry fun init_trader_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        let v0 = TraderList{
            id      : 0x2::object::new(arg0),
            traders : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<TraderList>(v0);
    }

    fun is_target_y_locked<T0, T1>(arg0: &mut TradingPair<T0, T1>) : bool {
        let v0 = get_target_y<T0, T1>(arg0);
        let v1 = if (v0 > arg0.target_y_reference) {
            v0
        } else {
            arg0.target_y_reference
        };
        arg0.target_y_reference = v1;
        if ((arg0.target_y_reference - v0) * 10000 / arg0.target_y_reference > 500) {
            arg0.target_y_based_lock = true;
        };
        arg0.target_y_based_lock
    }

    entry fun lock<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.target_y_based_lock = true;
    }

    fun normalize_price(arg0: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: u64) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1);
        assert!(v1 >= arg2, 5);
        while (v1 > arg2) {
            v0 = v0 / 10;
            v1 = v1 - 1;
        };
        v0
    }

    public fun quote_x_to_y<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_target_y_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_x_to_y_((arg1 as u128), (arg0.target_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.mult_x as u128), (arg0.mult_y as u128))
        }
    }

    fun quote_x_to_y_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = v0 * v0 * arg6 / arg7;
        let v2 = v0 + arg3 - arg1;
        let v3 = ((v1 / v2 - v1 / (v2 + arg0)) as u64);
        assert!((v3 as u128) < arg4, 3);
        let v4 = v3 * arg5 / 1000000;
        (v3 - v4, v4)
    }

    public fun quote_y_to_x<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_target_y_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_y_to_x_((arg1 as u128), (arg0.target_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.mult_x as u128), (arg0.mult_y as u128))
        }
    }

    fun quote_y_to_x_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = v0 * v0 * arg6 / arg7;
        let v2 = v0 + arg3 - arg1;
        let v3 = ((v2 - v1 / (v1 / v2 + arg0)) as u64);
        assert!((v3 as u128) < arg3, 2);
        let v4 = v3 * arg5 / 1000000;
        (v3 - v4, v4)
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        update_price<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let (v0, _) = quote_x_to_y<T0, T1>(arg0, 0x2::coin::value<T0>(&arg5));
        assert!(v0 != 0, 8);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg5));
        let v2 = 0x2::balance::split<T1>(&mut arg0.reserve_y, v0);
        let v3 = v0 * arg0.mult_y / 1000000;
        update_volume_record<T0, T1>(arg0, arg1, v3);
        0x2::coin::from_balance<T1>(v2, arg6)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        update_price<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let (v0, _) = quote_y_to_x<T0, T1>(arg0, 0x2::coin::value<T1>(&arg5));
        assert!(v0 != 0, 8);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg5));
        let v2 = 0x2::balance::split<T0>(&mut arg0.reserve_x, v0);
        let v3 = v0 * arg0.mult_x / 1000000;
        update_volume_record<T0, T1>(arg0, arg1, v3);
        0x2::coin::from_balance<T0>(v2, arg6)
    }

    public fun trader_borrow<T0, T1>(arg0: &TraderList, arg1: u64, arg2: &mut TradingPair<T0, T1>, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>, Borrow<T0, T1>) {
        assert_trader(arg0, arg1, arg5);
        if (arg3) {
            let v2 = Borrow<T0, T1>{
                is_borrow_x   : true,
                borrow_amount : arg4,
            };
            (0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.reserve_x, arg4), arg5)), 0x1::option::none<0x2::coin::Coin<T1>>(), v2)
        } else {
            let v2 = Borrow<T0, T1>{
                is_borrow_x   : false,
                borrow_amount : arg4,
            };
            (0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.reserve_y, arg4), arg5)), v2)
        }
    }

    public fun trader_swap_and_repay<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: u64, arg3: Borrow<T0, T1>, arg4: 0x1::option::Option<0x2::coin::Coin<T0>>, arg5: 0x1::option::Option<0x2::coin::Coin<T1>>, arg6: &0x2::clock::Clock) {
        arg0.mult_x = arg1;
        arg0.mult_y = arg2;
        let Borrow {
            is_borrow_x   : v0,
            borrow_amount : v1,
        } = arg3;
        if (!v0) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg5);
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg4);
            let (v3, v4) = quote_x_to_y<T0, T1>(arg0, 0x2::coin::value<T0>(&v2));
            let v5 = v3 + v4;
            assert!(v1 <= v5, v5);
            0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(v2));
            let v6 = v3 * arg0.mult_y / 1000000;
            update_volume_record<T0, T1>(arg0, arg6, v6);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg4);
            let v7 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg5);
            let (v8, v9) = quote_y_to_x<T0, T1>(arg0, 0x2::coin::value<T1>(&v7));
            let v10 = v8 + v9;
            assert!(v1 <= v10, v10);
            0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(v7));
            let v11 = v8 * arg0.mult_x / 1000000;
            update_volume_record<T0, T1>(arg0, arg6, v11);
        };
    }

    public fun trader_swap_and_repay2<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: u64, arg3: Borrow<T0, T1>, arg4: u64, arg5: 0x1::option::Option<0x2::coin::Coin<T0>>, arg6: 0x1::option::Option<0x2::coin::Coin<T1>>, arg7: &0x2::clock::Clock) {
        arg0.mult_x = arg1;
        arg0.mult_y = arg2;
        let Borrow {
            is_borrow_x   : v0,
            borrow_amount : v1,
        } = arg3;
        if (!v0) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg6);
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg5);
            let (v3, v4) = quote_x_to_y<T0, T1>(arg0, 0x2::coin::value<T0>(&v2));
            let v5 = v3 + v4;
            assert!(v5 >= v1, v5);
            assert!(v5 >= arg4, v5);
            0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(v2));
            let v6 = v3 * arg0.mult_y / 1000000;
            update_volume_record<T0, T1>(arg0, arg7, v6);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg5);
            let v7 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg6);
            let (v8, v9) = quote_y_to_x<T0, T1>(arg0, 0x2::coin::value<T1>(&v7));
            let v10 = v8 + v9;
            assert!(v10 >= v1, v10);
            assert!(v10 >= arg4, v10);
            0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(v7));
            let v11 = v8 * arg0.mult_x / 1000000;
            update_volume_record<T0, T1>(arg0, arg7, v11);
        };
    }

    entry fun unlock<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.target_y_based_lock = false;
        arg0.target_y_reference = 0;
    }

    public entry fun update_concentration<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        assert!(arg1 < 20000, 0);
        assert!(arg1 >= 1, 0);
        arg0.concentration = arg1;
    }

    public entry fun update_fee_millionth<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.fee_millionth = arg1;
    }

    public entry fun update_mults<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd || 0x2::tx_context::sender(arg3) == @0x686e4a8131df355a638fc5e69ae884433e4e76c800ba6ce0e3f1c21eca7f186d, 1);
        arg0.mult_x = arg1;
        arg0.mult_y = arg2;
    }

    public entry fun update_price<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        if (!arg0.pyth_mode) {
            return
        };
        assert!(0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3) == arg0.x_price_id, 4);
        assert!(0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4) == arg0.y_price_id, 4);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg2, arg3, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg2, arg4, arg1);
        arg0.mult_x = normalize_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0), arg0.x_retain_decimals);
        arg0.mult_y = normalize_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1), arg0.y_retain_decimals) + arg0.pyth_y_add - arg0.pyth_y_sub;
    }

    public entry fun update_pyth_mode<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.pyth_mode = arg1;
        arg0.pyth_y_add = arg2;
        arg0.pyth_y_sub = arg3;
    }

    entry fun update_trader_list(arg0: &mut TraderList, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.traders = arg1;
    }

    fun update_volume_record<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) {
        arg0.cumulative_volume = arg0.cumulative_volume + arg2;
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000 / 21600;
        let v1 = v0 % 8;
        *0x1::vector::borrow_mut<u64>(&mut arg0.volumes, v1) = arg0.cumulative_volume;
        *0x1::vector::borrow_mut<u64>(&mut arg0.times, v1) = v0 * 21600;
    }

    public fun withdraw<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg3) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.target_x = arg0.target_x - arg1;
        arg0.target_y_reference = 0;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, arg2), arg3))
    }

    // decompiled from Move bytecode v6
}

