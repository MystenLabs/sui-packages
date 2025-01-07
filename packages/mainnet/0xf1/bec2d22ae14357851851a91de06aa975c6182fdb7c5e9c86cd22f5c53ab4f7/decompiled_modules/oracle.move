module 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::oracle {
    struct TWAP has store {
        price_x_cumulative_last: u256,
        price_y_cumulative_last: u256,
        timestamp_last: u64,
    }

    struct Oracle<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        is_tracked_x: bool,
        tracked_coin_decimals: u8,
        twap: TWAP,
        price_x_cumulative_last: u256,
        price_y_cumulative_last: u256,
        price_x_average: u256,
        price_y_average: u256,
        timestamp_last: u64,
        prices: 0x2::table::Table<u64, u64>,
        observers: 0x2::table::Table<address, bool>,
    }

    public entry fun add_observer<T0, T1>(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Oracle<T0, T1>, arg2: address) {
        if (!0x2::table::contains<address, bool>(&arg1.observers, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.observers, arg2, true);
        };
    }

    public fun consult_x<T0, T1>(arg0: &Oracle<T0, T1>, arg1: u64) : u64 {
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point::decode(arg0.price_x_average * (arg1 as u256))
    }

    public fun consult_y<T0, T1>(arg0: &Oracle<T0, T1>, arg1: u64) : u64 {
        0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point::decode(arg0.price_y_average * (arg1 as u256))
    }

    public(friend) fun create<T0, T1>(arg0: bool, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TWAP{
            price_x_cumulative_last : 0,
            price_y_cumulative_last : 0,
            timestamp_last          : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::time_utils::to_seconds(0x2::clock::timestamp_ms(arg2)),
        };
        let v1 = Oracle<T0, T1>{
            id                      : 0x2::object::new(arg3),
            is_tracked_x            : arg0,
            tracked_coin_decimals   : arg1,
            twap                    : v0,
            price_x_cumulative_last : 0,
            price_y_cumulative_last : 0,
            price_x_average         : 0,
            price_y_average         : 0,
            timestamp_last          : 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::time_utils::to_seconds(0x2::clock::timestamp_ms(arg2)),
            prices                  : 0x2::table::new<u64, u64>(arg3),
            observers               : 0x2::table::new<address, bool>(arg3),
        };
        0x2::transfer::share_object<Oracle<T0, T1>>(v1);
    }

    public fun get_average_prices<T0, T1>(arg0: &Oracle<T0, T1>) : (u256, u256) {
        (arg0.price_x_average, arg0.price_y_average)
    }

    public fun get_current_cumulative_prices<T0, T1>(arg0: &Oracle<T0, T1>) : (u256, u256, u64) {
        (arg0.price_x_cumulative_last, arg0.price_y_cumulative_last, arg0.timestamp_last)
    }

    public fun get_current_cumulative_twap_prices<T0, T1>(arg0: &Oracle<T0, T1>) : (u256, u256, u64) {
        (arg0.twap.price_x_cumulative_last, arg0.twap.price_y_cumulative_last, arg0.twap.timestamp_last)
    }

    public fun get_price_at<T0, T1>(arg0: &Oracle<T0, T1>, arg1: u64) : u64 {
        *0x2::table::borrow<u64, u64>(&arg0.prices, arg1)
    }

    public fun is_tracked_x<T0, T1>(arg0: &Oracle<T0, T1>) : bool {
        arg0.is_tracked_x
    }

    public entry fun remove_observer<T0, T1>(arg0: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::admin_cap::AdminCap, arg1: &mut Oracle<T0, T1>, arg2: address) {
        if (0x2::table::contains<address, bool>(&arg1.observers, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.observers, arg2);
        };
    }

    public fun tracked_coin_decimals<T0, T1>(arg0: &Oracle<T0, T1>) : u8 {
        arg0.tracked_coin_decimals
    }

    public(friend) fun update<T0, T1>(arg0: &mut Oracle<T0, T1>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::Epoch, arg3: &0x2::clock::Clock) {
        update_twap_internal<T0, T1>(arg0, arg1, arg3);
        let v0 = arg0.twap.price_x_cumulative_last;
        let v1 = arg0.twap.price_y_cumulative_last;
        let v2 = arg0.twap.timestamp_last;
        let v3 = v2 - arg0.timestamp_last;
        if (v3 == 0) {
            return
        };
        arg0.price_x_average = (v0 - arg0.price_x_cumulative_last) / (v3 as u256);
        arg0.price_y_average = (v1 - arg0.price_y_cumulative_last) / (v3 as u256);
        arg0.price_x_cumulative_last = v0;
        arg0.price_y_cumulative_last = v1;
        arg0.timestamp_last = v2;
        let v4 = if (arg0.is_tracked_x) {
            consult_x<T0, T1>(arg0, 0x2::math::pow(10, arg0.tracked_coin_decimals))
        } else {
            consult_y<T0, T1>(arg0, 0x2::math::pow(10, arg0.tracked_coin_decimals))
        };
        if (!0x2::table::contains<u64, u64>(&arg0.prices, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2))) {
            0x2::table::add<u64, u64>(&mut arg0.prices, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2), v4);
        } else {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.prices, 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::epoch::epoch(arg2)) = v4;
        };
    }

    public fun update_twap<T0, T1>(arg0: &mut Oracle<T0, T1>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.observers, 0x2::tx_context::sender(arg3)), 0);
        update_twap_internal<T0, T1>(arg0, arg1, arg2);
    }

    fun update_twap_internal<T0, T1>(arg0: &mut Oracle<T0, T1>, arg1: &0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::get_reserves<T0, T1>(0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::borrow_pair<T0, T1>(arg1));
        let v2 = 0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::time_utils::to_seconds(0x2::clock::timestamp_ms(arg2));
        let v3 = v2 - arg0.twap.timestamp_last;
        if (v3 == 0) {
            return
        };
        let v4 = (0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point::uqdiv(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point::encode(v1), v0) as u256) * (v3 as u256);
        let v5 = (0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point::uqdiv(0xf1bec2d22ae14357851851a91de06aa975c6182fdb7c5e9c86cd22f5c53ab4f7::fixed_point::encode(v0), v1) as u256) * (v3 as u256);
        if (115792089237316195423570985008687907853269984665640564039457584007913129639935 - v4 < arg0.twap.price_x_cumulative_last) {
            arg0.twap.price_x_cumulative_last = 0;
        } else {
            arg0.twap.price_x_cumulative_last = arg0.twap.price_x_cumulative_last + v4;
        };
        if (115792089237316195423570985008687907853269984665640564039457584007913129639935 - v5 < arg0.twap.price_y_cumulative_last) {
            arg0.twap.price_y_cumulative_last = 0;
        } else {
            arg0.twap.price_y_cumulative_last = arg0.twap.price_y_cumulative_last + v5;
        };
        arg0.twap.timestamp_last = v2;
    }

    // decompiled from Move bytecode v6
}

