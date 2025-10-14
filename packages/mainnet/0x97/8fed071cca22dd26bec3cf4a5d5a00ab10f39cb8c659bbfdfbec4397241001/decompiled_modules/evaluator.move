module 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::evaluator {
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
        max_allowed_oi_open: vector<u128>,
    }

    struct TradeChecks has copy, drop, store {
        min_price: u128,
        max_price: u128,
        tick_size: u128,
        min_qty: u128,
        max_qty_limit: u128,
        max_qty_market: u128,
        step_size: u128,
        mtb_long: u128,
        mtb_short: u128,
        max_allowed_oi_open: vector<u128>,
    }

    public(friend) fun new_trade_checks(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: vector<u128>) : TradeChecks {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 0);
        0x1::vector::append<u128>(&mut v0, arg9);
        let v1 = TradeChecks{
            min_price           : arg0,
            max_price           : arg1,
            tick_size           : arg2,
            min_qty             : arg3,
            max_qty_limit       : arg4,
            max_qty_market      : arg5,
            step_size           : arg6,
            mtb_long            : arg7,
            mtb_short           : arg8,
            max_allowed_oi_open : v0,
        };
        verify_pre_init_checks(v1);
        v1
    }

    public(friend) fun set_max_oi_open(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: vector<u128>) {
        let v0 = 0x1::vector::empty<u128>();
        0x1::vector::push_back<u128>(&mut v0, 0);
        0x1::vector::append<u128>(&mut v0, arg2);
        arg1.max_allowed_oi_open = v0;
        let v1 = MaxAllowedOIOpenUpdateEvent{
            id                  : arg0,
            max_allowed_oi_open : v0,
        };
        0x2::event::emit<MaxAllowedOIOpenUpdateEvent>(v1);
    }

    public(friend) fun set_max_price(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.min_price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::max_price_greater_than_min_price());
        arg1.max_price = arg2;
        let v0 = MaxOrderPriceUpdateEvent{
            id    : arg0,
            price : arg2,
        };
        0x2::event::emit<MaxOrderPriceUpdateEvent>(v0);
    }

    public(friend) fun set_max_qty_limit(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.min_qty, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::max_limit_qty_greater_than_min_qty());
        arg1.max_qty_limit = arg2;
        let v0 = MaxQtyLimitUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MaxQtyLimitUpdateEvent>(v0);
    }

    public(friend) fun set_max_qty_market(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.min_qty, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::max_market_qty_less_than_min_qty());
        arg1.max_qty_market = arg2;
        let v0 = MaxQtyMarketUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MaxQtyMarketUpdateEvent>(v0);
    }

    public(friend) fun set_min_price(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_price_greater_than_zero());
        assert!(arg2 < arg1.max_price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_price_less_than_max_price());
        arg1.min_price = arg2;
        let v0 = MinOrderPriceUpdateEvent{
            id    : arg0,
            price : arg2,
        };
        0x2::event::emit<MinOrderPriceUpdateEvent>(v0);
    }

    public(friend) fun set_min_qty(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 < arg1.max_qty_limit && arg2 < arg1.max_qty_market, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_qty_less_than_max_qty());
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_qty_greater_than_zero());
        arg1.min_qty = arg2;
        let v0 = MinQtyUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MinQtyUpdateEvent>(v0);
    }

    public(friend) fun set_mtb_long(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mtb_long_greater_than_zero());
        arg1.mtb_long = arg2;
        let v0 = MtbLongUpdateEvent{
            id  : arg0,
            mtb : arg2,
        };
        0x2::event::emit<MtbLongUpdateEvent>(v0);
    }

    public(friend) fun set_mtb_short(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mtb_short_greater_than_zero());
        assert!(arg2 < 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mtb_short_less_than_hundred_percent());
        arg1.mtb_short = arg2;
        let v0 = MtbShortUpdateEvent{
            id  : arg0,
            mtb : arg2,
        };
        0x2::event::emit<MtbShortUpdateEvent>(v0);
    }

    public(friend) fun set_step_size(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::step_size_greater_than_zero());
        arg1.step_size = arg2;
        let v0 = StepSizeUpdateEvent{
            id   : arg0,
            size : arg2,
        };
        0x2::event::emit<StepSizeUpdateEvent>(v0);
    }

    public(friend) fun set_tick_size(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::tick_size_greater_than_zero());
        arg1.tick_size = arg2;
        let v0 = TickSizeUpdateEvent{
            id   : arg0,
            size : arg2,
        };
        0x2::event::emit<TickSizeUpdateEvent>(v0);
    }

    public(friend) fun tick_size(arg0: TradeChecks) : u128 {
        arg0.tick_size
    }

    public(friend) fun verify_market_take_bound_checks(arg0: TradeChecks, arg1: u128, arg2: u128, arg3: bool) {
        if (arg3) {
            assert!(arg1 <= arg2 + 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg2, arg0.mtb_long), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_price_greater_than_mtb_long());
        } else {
            assert!(arg1 >= arg2 - 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_mul(arg2, arg0.mtb_short), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_price_greater_than_mtb_short());
        };
    }

    public(friend) fun verify_min_max_price(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 >= arg0.min_price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_price_less_than_min_price());
        assert!(arg1 <= arg0.max_price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_price_greater_than_max_price());
    }

    public(friend) fun verify_min_max_qty_checks(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 >= arg0.min_qty, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_qty_less_than_min_qty());
        assert!(arg1 <= arg0.max_qty_limit, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_qty_greater_than_limit_qty());
        assert!(arg1 <= arg0.max_qty_market, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_qty_greater_than_market_qty());
    }

    public(friend) fun verify_oi_open_for_account(arg0: TradeChecks, arg1: u128, arg2: u128, arg3: u64, arg4: bool) {
        let v0 = 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_div(0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), arg1);
        let v1 = if (v0 % 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint() > 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::half_base_uint()) {
            0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::ceil(v0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint())
        } else {
            v0 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint() * 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint()
        };
        let v2 = v1 / 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint();
        if ((v2 as u64) >= 0x1::vector::length<u128>(&arg0.max_allowed_oi_open)) {
            return
        };
        let v3 = *0x1::vector::borrow<u128>(&arg0.max_allowed_oi_open, (v2 as u64));
        let v4 = v3;
        if (arg4) {
            v4 = v3 * 5;
        };
        assert!(arg2 <= v4, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::oi_open_greater_than_max_allowed(arg3));
    }

    fun verify_pre_init_checks(arg0: TradeChecks) {
        assert!(arg0.min_price > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_price_greater_than_zero());
        assert!(arg0.min_price < arg0.max_price, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_price_less_than_max_price());
        assert!(arg0.step_size > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::step_size_greater_than_zero());
        assert!(arg0.tick_size > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::tick_size_greater_than_zero());
        assert!(arg0.mtb_long > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mtb_long_greater_than_zero());
        assert!(arg0.mtb_short > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mtb_short_greater_than_zero());
        assert!(arg0.mtb_short < 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::library::base_uint(), 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::mtb_short_less_than_hundred_percent());
        assert!(arg0.min_qty > 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_qty_greater_than_zero());
        assert!(arg0.min_qty < arg0.max_qty_limit && arg0.min_qty < arg0.max_qty_market, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::min_qty_less_than_max_qty());
    }

    public(friend) fun verify_price_checks(arg0: TradeChecks, arg1: u128) {
        verify_min_max_price(arg0, arg1);
        verify_tick_size(arg0, arg1);
    }

    public(friend) fun verify_qty_checks(arg0: TradeChecks, arg1: u128) {
        verify_min_max_qty_checks(arg0, arg1);
        verify_step_size(arg0, arg1);
    }

    public(friend) fun verify_qty_checks_liquidation(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 >= arg0.min_qty, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_qty_less_than_min_qty());
        verify_step_size(arg0, arg1);
    }

    public(friend) fun verify_step_size(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 % arg0.step_size == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_qty_step_size_not_allowed());
    }

    public(friend) fun verify_tick_size(arg0: TradeChecks, arg1: u128) {
        assert!(arg1 % arg0.tick_size == 0, 0x978fed071cca22dd26bec3cf4a5d5a00ab10f39cb8c659bbfdfbec4397241001::error::trade_price_tick_size_not_allowed());
    }

    // decompiled from Move bytecode v6
}

