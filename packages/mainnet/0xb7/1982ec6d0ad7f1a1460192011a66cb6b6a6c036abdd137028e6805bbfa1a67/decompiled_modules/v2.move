module 0x8a86e5403656ecc9167ee9129428f967af7fe08994ecc67328372c4a9587caac::v2 {
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
    }

    public entry fun create_pair<T0, T1>(arg0: &mut PairRegistry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        assert!((0x2::coin::get_decimals<T0>(arg1) as u64) + arg5 == (0x2::coin::get_decimals<T1>(arg2) as u64) + arg6, 7);
        let v0 = TradingPair<T0, T1>{
            id                : 0x2::object::new(arg9),
            reserve_x         : 0x2::balance::zero<T0>(),
            reserve_y         : 0x2::balance::zero<T1>(),
            concentration     : arg7,
            big_k             : 0,
            target_x          : 0,
            mult_x            : 0,
            mult_y            : 0,
            fee_millionth     : arg8,
            x_price_id        : 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3),
            y_price_id        : 0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4),
            x_retain_decimals : arg5,
            y_retain_decimals : arg6,
            cumulative_volume : 0,
            volumes           : vector[0, 0, 0, 0, 0, 0, 0, 0],
            times             : vector[0, 0, 0, 0, 0, 0, 0, 0],
        };
        0x1::vector::push_back<address>(&mut arg0.pair_ids, 0x2::object::id_address<TradingPair<T0, T1>>(&v0));
        0x2::transfer::share_object<TradingPair<T0, T1>>(v0);
    }

    public fun deposit<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
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

    public fun quote_x_to_y<T0, T1>(arg0: &TradingPair<T0, T1>, arg1: u64) : (u64, u64) {
        quote_x_to_y_((arg1 as u128), (arg0.target_x as u128), (get_target_y<T0, T1>(arg0) as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, 0, 0)
    }

    fun quote_x_to_y_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u128) : (u64, u64) {
        let v0 = arg1 * arg3;
        let v1 = v0 * arg2 * arg3;
        let v2 = v0 + arg4 - arg1;
        let v3 = ((v1 / v2 - v1 / (v2 + arg0)) as u64);
        assert!((v3 as u128) < arg5, 3);
        let v4 = v3 * arg6 / 1000000;
        (v3 - v4, v4)
    }

    public fun quote_y_to_x<T0, T1>(arg0: &TradingPair<T0, T1>, arg1: u64) : (u64, u64) {
        quote_y_to_x_((arg1 as u128), (arg0.target_x as u128), (get_target_y<T0, T1>(arg0) as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, 0, 0)
    }

    fun quote_y_to_x_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u64, arg7: u128, arg8: u128) : (u64, u64) {
        let v0 = arg1 * arg3;
        let v1 = v0 * arg2 * arg3;
        let v2 = v0 + arg4 - arg1;
        let v3 = ((v2 - v1 / (v1 / v2 + (arg0 as u128))) as u64);
        assert!((v3 as u128) < arg4, 2);
        let v4 = v3 * arg6 / 1000000;
        (v3 - v4, v4)
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        update_price<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let (v0, _) = quote_x_to_y<T0, T1>(arg0, 0x2::coin::value<T0>(&arg5));
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg5));
        let v2 = 0x2::balance::split<T1>(&mut arg0.reserve_y, v0);
        let v3 = v0 * arg0.mult_y / 1000000;
        update_volume_record<T0, T1>(arg0, arg1, v3);
        0x2::coin::from_balance<T1>(v2, arg6)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        update_price<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        let (v0, _) = quote_y_to_x<T0, T1>(arg0, 0x2::coin::value<T1>(&arg5));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg5));
        let v2 = 0x2::balance::split<T0>(&mut arg0.reserve_x, v0);
        let v3 = v0 * arg0.mult_x / 1000000;
        update_volume_record<T0, T1>(arg0, arg1, v3);
        0x2::coin::from_balance<T0>(v2, arg6)
    }

    public entry fun update_concentration<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        assert!(arg1 < 2000, 0);
        assert!(arg1 >= 1, 0);
        arg0.concentration = arg1;
    }

    public entry fun update_fee_millionth<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x5267e890b08fefb7d4f39cfb147963132fb2e35236951541c93c4e7ffb7302dd, 1);
        arg0.fee_millionth = arg1;
    }

    public entry fun update_price<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3) == arg0.x_price_id, 4);
        assert!(0x2::object::id_address<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg4) == arg0.y_price_id, 4);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg2, arg3, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg2, arg4, arg1);
        arg0.mult_x = normalize_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0), arg0.x_retain_decimals);
        arg0.mult_y = normalize_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1), arg0.y_retain_decimals);
    }

    fun update_volume_record<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64) {
        arg0.cumulative_volume = arg0.cumulative_volume + arg2;
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000 / 21600;
        let v1 = v0 % 8;
        *0x1::vector::borrow_mut<u64>(&mut arg0.volumes, v1) = arg0.cumulative_volume;
        *0x1::vector::borrow_mut<u64>(&mut arg0.times, v1) = v0 * 21600;
    }

    public fun withdraw<T0, T1>(arg0: &mut TradingPair<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        arg0.target_x = arg0.target_x - arg1;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, arg1), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, arg2), arg3))
    }

    // decompiled from Move bytecode v6
}

