module 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::evaluator {
    struct MinOrderPriceUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        price: u128,
    }

    struct MaxOrderPriceUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        price: u128,
    }

    struct StepSizeUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        size: u128,
    }

    struct TickSizeUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        size: u128,
    }

    struct MtbLongUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        mtb: u128,
    }

    struct MtbShortUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        mtb: u128,
    }

    struct MaxQtyLimitUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        qty: u128,
    }

    struct MaxQtyMarketUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        qty: u128,
    }

    struct MinQtyUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        qty: u128,
    }

    struct MaxAllowedOIOpenUpdateEvent has copy, drop {
        id: 0x2::object::ID,
        maxAllowedOIOpen: vector<u128>,
    }

    struct TradeChecks has copy, drop, store {
        minPrice: u128,
        maxPrice: u128,
        tickSize: u128,
        minQty: u128,
        maxQtyLimit: u128,
        maxQtyMarket: u128,
        stepSize: u128,
        mtbLong: u128,
        mtbShort: u128,
        maxAllowedOIOpen: vector<u128>,
    }

    public(friend) fun initialize(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: vector<u128>) : TradeChecks {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 0);
        0x1::vector::append<u128>(&mut v0, arg9);
        let v1 = TradeChecks{
            minPrice         : arg0,
            maxPrice         : arg1,
            tickSize         : arg2,
            minQty           : arg3,
            maxQtyLimit      : arg4,
            maxQtyMarket     : arg5,
            stepSize         : arg6,
            mtbLong          : arg7,
            mtbShort         : arg8,
            maxAllowedOIOpen : v0,
        };
        verify_pre_init_checks(v1);
        v1
    }

    public(friend) fun set_max_oi_open(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: vector<u128>) {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 0);
        0x1::vector::append<u128>(&mut v0, arg2);
        arg1.maxAllowedOIOpen = v0;
        let v1 = MaxAllowedOIOpenUpdateEvent{
            id               : arg0,
            maxAllowedOIOpen : v0,
        };
        0x2::event::emit<MaxAllowedOIOpenUpdateEvent>(v1);
    }

    public(friend) fun set_max_price(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.minPrice, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::max_price_greater_than_min_price());
        arg1.maxPrice = arg2;
        let v0 = MaxOrderPriceUpdateEvent{
            id    : arg0,
            price : arg2,
        };
        0x2::event::emit<MaxOrderPriceUpdateEvent>(v0);
    }

    public(friend) fun set_max_qty_limit(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.minQty, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::max_limit_qty_greater_than_min_qty());
        arg1.maxQtyLimit = arg2;
        let v0 = MaxQtyLimitUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MaxQtyLimitUpdateEvent>(v0);
    }

    public(friend) fun set_max_qty_market(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.minQty, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::max_market_qty_less_than_min_qty());
        arg1.maxQtyMarket = arg2;
        let v0 = MaxQtyMarketUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MaxQtyMarketUpdateEvent>(v0);
    }

    public(friend) fun set_min_price(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_price_greater_than_zero());
        assert!(arg2 < arg1.maxPrice, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_price_less_than_max_price());
        arg1.minPrice = arg2;
        let v0 = MinOrderPriceUpdateEvent{
            id    : arg0,
            price : arg2,
        };
        0x2::event::emit<MinOrderPriceUpdateEvent>(v0);
    }

    public(friend) fun set_min_qty(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 < arg1.maxQtyLimit && arg2 < arg1.maxQtyMarket, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_qty_less_than_max_qty());
        assert!(arg2 > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_qty_greater_than_zero());
        arg1.minQty = arg2;
        let v0 = MinQtyUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MinQtyUpdateEvent>(v0);
    }

    public(friend) fun set_mtb_long(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::mtb_long_greater_than_zero());
        arg1.mtbLong = arg2;
        let v0 = MtbLongUpdateEvent{
            id  : arg0,
            mtb : arg2,
        };
        0x2::event::emit<MtbLongUpdateEvent>(v0);
    }

    public(friend) fun set_mtb_short(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 13);
        assert!(arg2 < 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint(), 14);
        arg1.mtbShort = arg2;
        let v0 = MtbShortUpdateEvent{
            id  : arg0,
            mtb : arg2,
        };
        0x2::event::emit<MtbShortUpdateEvent>(v0);
    }

    public(friend) fun set_step_size(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::step_size_greater_than_zero());
        arg1.stepSize = arg2;
        let v0 = StepSizeUpdateEvent{
            id   : arg0,
            size : arg2,
        };
        0x2::event::emit<StepSizeUpdateEvent>(v0);
    }

    public(friend) fun set_tick_size(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::tick_size_greater_than_zero());
        arg1.tickSize = arg2;
        let v0 = TickSizeUpdateEvent{
            id   : arg0,
            size : arg2,
        };
        0x2::event::emit<TickSizeUpdateEvent>(v0);
    }

    public fun tickSize(arg0: TradeChecks) : u128 {
        arg0.tickSize
    }

    public fun verify_market_take_bound_checks(arg0: TradeChecks, arg1: u128, arg2: u128, arg3: bool) {
        if (arg3) {
            assert!(arg1 <= arg2 + 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(arg2, arg0.mtbLong), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_price_greater_than_mtb_long());
        } else {
            assert!(arg1 >= arg2 - 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_mul(arg2, arg0.mtbShort), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_price_greater_than_mtb_short());
        };
    }

    public fun verify_min_max_price(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 >= arg0.minPrice, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_price_less_than_min_price());
        assert!(arg1 <= arg0.maxPrice, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_price_greater_than_max_price());
    }

    public fun verify_min_max_qty_checks(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 >= arg0.minQty, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_qty_less_than_min_qty());
        assert!(arg1 <= arg0.maxQtyLimit, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_qty_greater_than_limit_qty());
        assert!(arg1 <= arg0.maxQtyMarket, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_qty_greater_than_market_qty());
    }

    public fun verify_oi_open_for_account(arg0: TradeChecks, arg1: u128, arg2: u128, arg3: u64) {
        let v0 = 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_div(0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint(), arg1);
        let v1 = if (v0 % 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint() > 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::half_base_uint()) {
            0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::ceil(v0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint())
        } else {
            v0 / 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint() * 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint()
        };
        let v2 = v1 / 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint();
        if ((v2 as u64) > 0x1::vector::length<u128>(&arg0.maxAllowedOIOpen)) {
            return
        };
        assert!(arg2 <= *0x1::vector::borrow<u128>(&arg0.maxAllowedOIOpen, (v2 as u64)), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::oi_open_greater_than_max_allowed(arg3));
    }

    fun verify_pre_init_checks(arg0: TradeChecks) {
        assert!(arg0.minPrice > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_price_greater_than_zero());
        assert!(arg0.minPrice < arg0.maxPrice, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_price_less_than_max_price());
        assert!(arg0.stepSize > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::step_size_greater_than_zero());
        assert!(arg0.tickSize > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::tick_size_greater_than_zero());
        assert!(arg0.mtbLong > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::mtb_long_greater_than_zero());
        assert!(arg0.mtbShort > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::mtb_short_greater_than_zero());
        assert!(arg0.mtbShort < 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::library::base_uint(), 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::mtb_short_less_than_hundred_percent());
        assert!(arg0.maxQtyLimit > arg0.minQty, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::max_limit_qty_greater_than_min_qty());
        assert!(arg0.maxQtyMarket > arg0.minQty, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::max_market_qty_less_than_min_qty());
        assert!(arg0.minQty < arg0.maxQtyLimit && arg0.minQty < arg0.maxQtyMarket, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_qty_less_than_max_qty());
        assert!(arg0.minQty > 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::min_qty_greater_than_zero());
    }

    public fun verify_price_checks(arg0: TradeChecks, arg1: u128) {
        verify_min_max_price(arg0, arg1);
        verify_tick_size(arg0, arg1);
    }

    public fun verify_qty_checks(arg0: TradeChecks, arg1: u128) {
        verify_min_max_qty_checks(arg0, arg1);
        verify_step_size(arg0, arg1);
    }

    public fun verify_step_size(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 % arg0.stepSize == 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_qty_step_size_not_allowed());
    }

    public fun verify_tick_size(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 % arg0.tickSize == 0, 0xc9c748d29f143d6801744a902e7743ba4973b78772ac7c00d6d313f818a5e3f7::error::trade_price_tick_size_not_allowed());
    }

    // decompiled from Move bytecode v6
}

