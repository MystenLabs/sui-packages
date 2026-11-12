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

    public fun max_allowed_oi_open(arg0: &TradeChecks) : vector<u128> {
        arg0.max_allowed_oi_open
    }

    public fun max_price(arg0: &TradeChecks) : u128 {
        arg0.max_price
    }

    public fun max_qty_limit(arg0: &TradeChecks) : u128 {
        arg0.max_qty_limit
    }

    public fun max_qty_market(arg0: &TradeChecks) : u128 {
        arg0.max_qty_market
    }

    public fun min_price(arg0: &TradeChecks) : u128 {
        arg0.min_price
    }

    public fun min_qty(arg0: &TradeChecks) : u128 {
        arg0.min_qty
    }

    public fun mtb_long(arg0: &TradeChecks) : u128 {
        arg0.mtb_long
    }

    public fun mtb_short(arg0: &TradeChecks) : u128 {
        arg0.mtb_short
    }

    public fun new_trade_checks(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: vector<u128>) : TradeChecks {
        let v0 = vector[0];
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
        validate_trade_checks(&v1);
        v1
    }

    public(friend) fun set_max_oi_open(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: vector<u128>) {
        let v0 = vector[0];
        0x1::vector::append<u128>(&mut v0, arg2);
        arg1.max_allowed_oi_open = v0;
        let v1 = MaxAllowedOIOpenUpdateEvent{
            id                  : arg0,
            max_allowed_oi_open : v0,
        };
        0x2::event::emit<MaxAllowedOIOpenUpdateEvent>(v1);
    }

    public(friend) fun set_max_price(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.min_price, 9);
        arg1.max_price = arg2;
        let v0 = MaxOrderPriceUpdateEvent{
            id    : arg0,
            price : arg2,
        };
        0x2::event::emit<MaxOrderPriceUpdateEvent>(v0);
    }

    public(friend) fun set_max_qty_limit(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.min_qty, 15);
        arg1.max_qty_limit = arg2;
        let v0 = MaxQtyLimitUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MaxQtyLimitUpdateEvent>(v0);
    }

    public(friend) fun set_max_qty_market(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > arg1.min_qty, 16);
        arg1.max_qty_market = arg2;
        let v0 = MaxQtyMarketUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MaxQtyMarketUpdateEvent>(v0);
    }

    public(friend) fun set_min_price(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 1);
        assert!(arg2 < arg1.max_price, 2);
        arg1.min_price = arg2;
        let v0 = MinOrderPriceUpdateEvent{
            id    : arg0,
            price : arg2,
        };
        0x2::event::emit<MinOrderPriceUpdateEvent>(v0);
    }

    public(friend) fun set_min_qty(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 < arg1.max_qty_limit && arg2 < arg1.max_qty_market, 17);
        assert!(arg2 > 0, 18);
        arg1.min_qty = arg2;
        let v0 = MinQtyUpdateEvent{
            id  : arg0,
            qty : arg2,
        };
        0x2::event::emit<MinQtyUpdateEvent>(v0);
    }

    public(friend) fun set_mtb_long(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 12);
        arg1.mtb_long = arg2;
        let v0 = MtbLongUpdateEvent{
            id  : arg0,
            mtb : arg2,
        };
        0x2::event::emit<MtbLongUpdateEvent>(v0);
    }

    public(friend) fun set_mtb_short(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 13);
        assert!(arg2 < 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::base_uint(), 14);
        arg1.mtb_short = arg2;
        let v0 = MtbShortUpdateEvent{
            id  : arg0,
            mtb : arg2,
        };
        0x2::event::emit<MtbShortUpdateEvent>(v0);
    }

    public(friend) fun set_step_size(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 10);
        arg1.step_size = arg2;
        let v0 = StepSizeUpdateEvent{
            id   : arg0,
            size : arg2,
        };
        0x2::event::emit<StepSizeUpdateEvent>(v0);
    }

    public(friend) fun set_tick_size(arg0: 0x2::object::ID, arg1: &mut TradeChecks, arg2: u128) {
        assert!(arg2 > 0, 11);
        arg1.tick_size = arg2;
        let v0 = TickSizeUpdateEvent{
            id   : arg0,
            size : arg2,
        };
        0x2::event::emit<TickSizeUpdateEvent>(v0);
    }

    public fun step_size(arg0: &TradeChecks) : u128 {
        arg0.step_size
    }

    public fun tick_size_ref(arg0: &TradeChecks) : u128 {
        arg0.tick_size
    }

    public fun trade_checks_hash(arg0: &TradeChecks) : vector<u8> {
        0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::math::get_hash(0x1::bcs::to_bytes<TradeChecks>(arg0))
    }

    public(friend) fun validate_trade_checks(arg0: &TradeChecks) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::validate(arg0.min_price, arg0.max_price, arg0.tick_size, arg0.min_qty, arg0.max_qty_limit, arg0.max_qty_market, arg0.step_size, arg0.mtb_long, arg0.mtb_short);
    }

    public(friend) fun verify_market_take_bound_checks(arg0: &TradeChecks, arg1: u128, arg2: u128, arg3: bool) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::verify_mtb(arg0.mtb_long, arg0.mtb_short, arg1, arg2, arg3);
    }

    public(friend) fun verify_min_max_price(arg0: &TradeChecks, arg1: u128) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::verify_min_max_price(arg0.min_price, arg0.max_price, arg1);
    }

    public(friend) fun verify_oi_open_for_account(arg0: &TradeChecks, arg1: u128, arg2: u128, arg3: u64, arg4: bool) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::verify_oi_open(&arg0.max_allowed_oi_open, arg1, arg2, arg3, arg4);
    }

    public(friend) fun verify_price_checks(arg0: &TradeChecks, arg1: u128) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::verify_price(arg0.min_price, arg0.max_price, arg0.tick_size, arg1);
    }

    public(friend) fun verify_qty_checks(arg0: &TradeChecks, arg1: u128, arg2: bool) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::verify_qty(arg0.min_qty, arg0.max_qty_limit, arg0.max_qty_market, arg0.step_size, arg1, arg2);
    }

    public(friend) fun verify_qty_checks_liquidation(arg0: &TradeChecks, arg1: u128) {
        0xaf6a713d4881d3f8061740dcd18b7cc0c1cb52d9776a3619db3b937719838174::trade_checks::verify_qty_liquidation(arg0.min_qty, arg0.step_size, arg1);
    }

    // decompiled from Move bytecode v7
}

