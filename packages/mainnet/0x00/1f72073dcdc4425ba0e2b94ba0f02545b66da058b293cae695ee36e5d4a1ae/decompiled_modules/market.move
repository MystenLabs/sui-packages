module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::market {
    struct MarketList has key {
        id: 0x2::object::UID,
        total: u64,
    }

    struct Market<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        max_leverage: u8,
        insurance_fee: u64,
        margin_fee: u64,
        fund_fee: u64,
        fund_fee_manual: bool,
        spread_fee: u64,
        spread_fee_manual: bool,
        status: u8,
        long_position_total: u64,
        short_position_total: u64,
        symbol: 0x1::string::String,
        icon: 0x2::url::Url,
        description: 0x1::string::String,
        officer: u8,
        pool: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::Pool<T0, T1>,
        size: u64,
        opening_price: u64,
        pyth_id: 0x2::object::ID,
    }

    struct Price has copy, drop {
        buy_price: u64,
        sell_price: u64,
        real_price: u64,
        spread: u64,
    }

    public fun create_market<T0>(arg0: &mut MarketList, arg1: &0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 307);
        assert!(0x1::vector::length<u8>(&arg2) < 20, 315);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 318);
        assert!(0x1::vector::length<u8>(&arg3) < 280, 319);
        assert!(0x1::vector::length<u8>(&arg4) < 180, 316);
        assert!(!0x1::vector::is_empty<u8>(&arg4), 308);
        assert!(arg5 > 0, 311);
        assert!(arg6 > 0, 317);
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_inner(&v0);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::create_scale_admin(v1, arg8);
        let v2 = Market<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::Scale, T0>{
            id                   : v0,
            max_leverage         : 125,
            insurance_fee        : 5,
            margin_fee           : 10000,
            fund_fee             : 1,
            fund_fee_manual      : false,
            spread_fee           : 1000,
            spread_fee_manual    : false,
            status               : 1,
            long_position_total  : 0,
            short_position_total : 0,
            symbol               : 0x1::string::utf8(arg2),
            icon                 : 0x2::url::new_unsafe_from_bytes(arg3),
            description          : 0x1::string::utf8(arg4),
            officer              : 2,
            pool                 : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::create_pool_<T0>(arg1),
            size                 : arg5,
            opening_price        : arg6,
            pyth_id              : arg7,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Market<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::Scale, T0>>(&mut arg0.id, v1, v2);
        arg0.total = arg0.total + 1;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::create<Market<0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::Scale, T0>>(v1);
        v1
    }

    public(friend) fun dec_long_position_total<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.long_position_total = arg0.long_position_total - arg1;
    }

    public(friend) fun dec_short_position_total<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.short_position_total = arg0.short_position_total - arg1;
    }

    public fun get_buy_price(arg0: &Price) : u64 {
        arg0.buy_price
    }

    public fun get_curr_position_total<T0, T1>(arg0: &Market<T0, T1>, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.long_position_total
        } else {
            arg0.short_position_total
        }
    }

    public fun get_denominator() : u64 {
        10000
    }

    public fun get_description<T0, T1>(arg0: &Market<T0, T1>) : &0x1::string::String {
        &arg0.description
    }

    public fun get_direction_price(arg0: &Price, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.buy_price
        } else {
            arg0.sell_price
        }
    }

    public fun get_dominant_direction<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        if (arg0.long_position_total == arg0.short_position_total) {
            3
        } else if (arg0.long_position_total > arg0.short_position_total) {
            1
        } else {
            2
        }
    }

    public fun get_exposure<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::math::max(arg0.long_position_total, arg0.short_position_total) - 0x2::math::min(arg0.long_position_total, arg0.short_position_total)
    }

    public fun get_fund_fee<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        if (arg0.fund_fee_manual) {
            return arg0.fund_fee
        };
        let v0 = get_total_liquidity<T0, T1>(arg0);
        let v1 = get_exposure<T0, T1>(arg0);
        if (v1 == 0 || v0 == 0) {
            return 0
        };
        let v2 = v1 * 10000 / v0;
        if (v2 <= 1000) {
            return 3
        };
        if (v2 > 1000 && v2 <= 2000) {
            return 5
        };
        if (v2 > 2000 && v2 <= 3000) {
            return 7
        };
        if (v2 > 3000 && v2 <= 4000) {
            return 10
        };
        if (v2 > 4000 && v2 <= 5000) {
            return 20
        };
        if (v2 > 5000 && v2 <= 6000) {
            return 40
        };
        70
    }

    public fun get_insurance_fee<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.insurance_fee
    }

    public fun get_list_uid(arg0: &MarketList) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_list_uid_mut(arg0: &mut MarketList) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_long_position_total<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.long_position_total
    }

    public fun get_margin_fee<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.margin_fee
    }

    public fun get_matket_total(arg0: &MarketList) : u64 {
        arg0.total
    }

    public fun get_max_leverage<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        arg0.max_leverage
    }

    public fun get_max_position_total<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::math::max(arg0.long_position_total, arg0.short_position_total)
    }

    public fun get_max_value() : u64 {
        1844674407370955
    }

    public fun get_min_position_total<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x2::math::min(arg0.long_position_total, arg0.short_position_total)
    }

    public fun get_officer<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        arg0.officer
    }

    public fun get_opening_price_value<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.opening_price
    }

    public fun get_pool<T0, T1>(arg0: &Market<T0, T1>) : &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::Pool<T0, T1> {
        &arg0.pool
    }

    public(friend) fun get_pool_mut<T0, T1>(arg0: &mut Market<T0, T1>) : &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::Pool<T0, T1> {
        &mut arg0.pool
    }

    public fun get_price<T0, T1>(arg0: &Market<T0, T1>, arg1: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root) : Price {
        get_price_<T0, T1>(arg0, get_pyth_price(arg1, arg0.pyth_id))
    }

    fun get_price_<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : Price {
        let v0 = get_spread_fee<T0, T1>(arg0, arg1) * arg1;
        let v1 = v0 / 2;
        Price{
            buy_price  : (arg1 * 10000 + v1) / 10000,
            sell_price : (arg1 * 10000 - v1) / 10000,
            real_price : arg1,
            spread     : v0,
        }
    }

    public fun get_price_by_real<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : Price {
        get_price_<T0, T1>(arg0, arg1)
    }

    public fun get_pyth_price(arg0: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg1: 0x2::object::ID) : u64 {
        let (v0, _) = 0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::get_price(arg0, arg1);
        v0
    }

    public fun get_real_price(arg0: &Price) : u64 {
        arg0.real_price
    }

    public fun get_sell_price(arg0: &Price) : u64 {
        arg0.sell_price
    }

    public fun get_short_position_total<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.short_position_total
    }

    public fun get_size<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        arg0.size
    }

    public fun get_spread(arg0: &Price) : u64 {
        arg0.spread
    }

    public fun get_spread_fee<T0, T1>(arg0: &Market<T0, T1>, arg1: u64) : u64 {
        if (arg0.spread_fee_manual) {
            return arg0.spread_fee
        };
        assert!(arg0.opening_price > 0, 317);
        let v0 = (0x2::math::max(arg1, arg0.opening_price) - 0x2::math::min(arg1, arg0.opening_price)) * 10000 / arg0.opening_price;
        if (v0 <= 300) {
            return 30
        };
        if (v0 > 300 && v0 <= 1000) {
            return v0 / 10
        };
        150
    }

    public fun get_status<T0, T1>(arg0: &Market<T0, T1>) : u8 {
        arg0.status
    }

    public fun get_symbol<T0, T1>(arg0: &Market<T0, T1>) : &0x1::string::String {
        &arg0.symbol
    }

    public fun get_total_liquidity<T0, T1>(arg0: &Market<T0, T1>) : u64 {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::get_vault_balance<T0, T1>(&arg0.pool) + 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::pool::get_profit_balance<T0, T1>(&arg0.pool)
    }

    public fun get_uid<T0, T1>(arg0: &Market<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_uid_mut<T0, T1>(arg0: &mut Market<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun inc_long_position_total<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.long_position_total = arg0.long_position_total + arg1;
    }

    public(friend) fun inc_short_position_total<T0, T1>(arg0: &mut Market<T0, T1>, arg1: u64) {
        arg0.short_position_total = arg0.short_position_total + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<MarketList>(new_market_list(arg0));
    }

    fun new_market_list(arg0: &mut 0x2::tx_context::TxContext) : MarketList {
        MarketList{
            id    : 0x2::object::new(arg0),
            total : 0,
        }
    }

    public fun trigger_update_opening_price<T0, T1>(arg0: &mut Market<T0, T1>, arg1: &0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle::Root, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_pyth_price(arg1, arg0.pyth_id);
        assert!(v0 > 0, 313);
        arg0.opening_price = v0;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg0.id));
    }

    public fun update_description<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 308);
        arg1.description = 0x1::string::utf8(arg2);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_fund_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(arg2 > 0 && arg2 <= 10000, 312);
        arg1.fund_fee = arg2;
        arg1.fund_fee_manual = arg3;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_icon<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 318);
        assert!(0x1::vector::length<u8>(&arg2) < 280, 319);
        arg1.icon = 0x2::url::new_unsafe_from_bytes(arg2);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_insurance_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(arg2 > 0 && arg2 <= 10000, 304);
        arg1.insurance_fee = arg2;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_margin_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(arg2 > 0 && arg2 <= 10000, 305);
        arg1.margin_fee = arg2;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_max_leverage<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(arg2 > 0 && arg2 < 255, 302);
        arg1.max_leverage = arg2;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_officer<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::AdminCap, arg1: &mut Market<T0, T1>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < 4, 314);
        arg1.officer = arg2;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_spread_fee<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(arg2 > 0 && arg2 <= 10000, 303);
        arg1.spread_fee = arg2;
        arg1.spread_fee_manual = arg3;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    public fun update_status<T0, T1>(arg0: &mut 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::ScaleAdminCap, arg1: &mut Market<T0, T1>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::admin::is_super_admin(arg0, &v0, 0x2::object::uid_to_inner(&mut arg1.id)), 309);
        assert!(arg2 > 0 && arg2 <= 3, 306);
        arg1.status = arg2;
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Market<T0, T1>>(0x2::object::uid_to_inner(&arg1.id));
    }

    // decompiled from Move bytecode v6
}

