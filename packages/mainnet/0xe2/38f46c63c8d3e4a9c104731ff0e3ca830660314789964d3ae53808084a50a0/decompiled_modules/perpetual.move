module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual {
    struct FundingRate has copy, drop, store {
        timestamp: u64,
        rate: 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number,
    }

    struct Perpetual has copy, drop, store {
        id: address,
        symbol: 0x1::string::String,
        imr: u64,
        mmr: u64,
        step_size: u64,
        tick_size: u64,
        min_trade_qty: u64,
        max_trade_qty: u64,
        min_trade_price: u64,
        max_trade_price: u64,
        max_notional_at_open: vector<u64>,
        mtb_long: u64,
        mtb_short: u64,
        maker_fee: u64,
        taker_fee: u64,
        max_funding_rate: u64,
        insurance_pool_ratio: u64,
        insurance_pool: address,
        fee_pool: address,
        trading_status: bool,
        trading_start_time: u64,
        delist: bool,
        delisting_price: u64,
        isolated_only: bool,
        base_asset_symbol: 0x1::string::String,
        base_asset_name: 0x1::string::String,
        base_asset_decimals: u64,
        max_limit_order_quantity: u64,
        max_market_order_quantity: u64,
        default_leverage: u64,
        oracle_price: u64,
        funding: FundingRate,
    }

    public fun create_funding_rate(arg0: u64, arg1: u64, arg2: bool) : FundingRate {
        FundingRate{
            timestamp : arg0,
            rate      : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(arg1, arg2),
        }
    }

    public(friend) fun create_perpetual(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u64>, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: address, arg19: address, arg20: bool, arg21: 0x1::string::String, arg22: 0x1::string::String, arg23: u64, arg24: u64, arg25: u64, arg26: u64) : Perpetual {
        assert!(arg17 > 1735714800000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_trade_start_time());
        let v0 = Perpetual{
            id                        : arg0,
            symbol                    : arg1,
            imr                       : arg2,
            mmr                       : arg3,
            step_size                 : arg4,
            tick_size                 : arg5,
            min_trade_qty             : arg6,
            max_trade_qty             : arg7,
            min_trade_price           : arg8,
            max_trade_price           : arg9,
            max_notional_at_open      : arg10,
            mtb_long                  : arg11,
            mtb_short                 : arg12,
            maker_fee                 : arg13,
            taker_fee                 : arg14,
            max_funding_rate          : arg15,
            insurance_pool_ratio      : arg16,
            insurance_pool            : arg18,
            fee_pool                  : arg19,
            trading_status            : true,
            trading_start_time        : arg17,
            delist                    : false,
            delisting_price           : 0,
            isolated_only             : arg20,
            base_asset_symbol         : arg21,
            base_asset_name           : arg22,
            base_asset_decimals       : arg23,
            max_limit_order_quantity  : arg24,
            max_market_order_quantity : arg25,
            default_leverage          : arg26,
            oracle_price              : 0,
            funding                   : create_funding_rate(0, 0, true),
        };
        let v1 = &mut v0;
        set_imr(v1, arg2);
        let v2 = &mut v0;
        set_mmr(v2, arg3);
        assert!(arg4 == arg6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        let v3 = &mut v0;
        set_step_size_and_min_trade_qty(v3, arg4);
        let v4 = &mut v0;
        set_tick_size(v4, arg5);
        let v5 = &mut v0;
        set_max_trade_qty(v5, arg7);
        let v6 = &mut v0;
        set_min_trade_price(v6, arg8);
        let v7 = &mut v0;
        set_max_trade_price(v7, arg9);
        let v8 = &mut v0;
        set_mtb(v8, arg11, true);
        let v9 = &mut v0;
        set_mtb(v9, arg12, false);
        let v10 = &mut v0;
        set_fee(v10, arg13, true);
        let v11 = &mut v0;
        set_fee(v11, arg14, false);
        let v12 = &mut v0;
        set_max_allowed_oi_open(v12, arg10);
        let v13 = &mut v0;
        set_max_funding_rate(v13, arg15);
        let v14 = &mut v0;
        set_insurance_pool_liquidation_premium_percentage(v14, arg16);
        let v15 = &mut v0;
        set_insurance_pool_address(v15, arg18);
        let v16 = &mut v0;
        set_fee_pool_address(v16, arg19);
        let v17 = 0x1::string::length(&arg1);
        assert!(v17 >= 3 && v17 <= 12, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        v0
    }

    public(friend) fun delist(arg0: &mut Perpetual, arg1: u64) {
        assert!(!arg0.delist, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::already_delisted());
        let v0 = if (arg1 >= arg0.min_trade_price) {
            if (arg1 <= arg0.max_trade_price) {
                arg1 % arg0.tick_size == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_oracle_price());
        arg0.delist = true;
        arg0.delisting_price = arg1;
    }

    public fun get_current_funding(arg0: &Perpetual) : FundingRate {
        arg0.funding
    }

    public fun get_delist_status(arg0: &Perpetual) : bool {
        arg0.delist
    }

    public fun get_fee_pool_address(arg0: &Perpetual) : address {
        arg0.fee_pool
    }

    public fun get_fees(arg0: &Perpetual) : (u64, u64) {
        (arg0.maker_fee, arg0.taker_fee)
    }

    public fun get_funding_rate(arg0: &FundingRate) : 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number {
        arg0.rate
    }

    public fun get_funding_timestamp(arg0: &FundingRate) : u64 {
        arg0.timestamp
    }

    public fun get_imr(arg0: &Perpetual) : u64 {
        arg0.imr
    }

    public fun get_insurance_pool_address(arg0: &Perpetual) : address {
        arg0.insurance_pool
    }

    public fun get_insurance_pool_ratio(arg0: &Perpetual) : u64 {
        arg0.insurance_pool_ratio
    }

    public fun get_isolated_only(arg0: &Perpetual) : bool {
        arg0.isolated_only
    }

    public fun get_max_trade_qty(arg0: &Perpetual) : u64 {
        arg0.max_trade_qty
    }

    public fun get_min_trade_qty(arg0: &Perpetual) : u64 {
        arg0.min_trade_qty
    }

    public fun get_mmr(arg0: &Perpetual) : u64 {
        arg0.mmr
    }

    public fun get_oracle_price(arg0: &Perpetual) : u64 {
        arg0.oracle_price
    }

    public fun get_perpetual_address(arg0: &Perpetual) : address {
        arg0.id
    }

    public fun get_step_size(arg0: &Perpetual) : u64 {
        arg0.step_size
    }

    public fun get_symbol(arg0: &Perpetual) : 0x1::string::String {
        arg0.symbol
    }

    public fun get_tick_size(arg0: &Perpetual) : u64 {
        arg0.tick_size
    }

    public fun get_trading_status(arg0: &Perpetual) : bool {
        arg0.trading_status
    }

    public fun max_allowed_oi_open(arg0: &Perpetual) : vector<u64> {
        arg0.max_notional_at_open
    }

    public fun perpetual_values(arg0: &Perpetual) : (address, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, vector<u64>, u64, u64, u64, u64, u64, u64, address, address, u64, bool, bool, u64, u64, bool) {
        (arg0.id, arg0.symbol, arg0.imr, arg0.mmr, arg0.step_size, arg0.tick_size, arg0.min_trade_qty, arg0.max_trade_qty, arg0.min_trade_price, arg0.max_trade_price, arg0.max_notional_at_open, arg0.mtb_long, arg0.mtb_short, arg0.maker_fee, arg0.taker_fee, arg0.max_funding_rate, arg0.insurance_pool_ratio, arg0.insurance_pool, arg0.fee_pool, arg0.trading_start_time, arg0.delist, arg0.trading_status, arg0.oracle_price, arg0.delisting_price, arg0.isolated_only)
    }

    public(friend) fun replicate_perp_data(arg0: &mut Perpetual, arg1: &Perpetual) : vector<u8> {
        arg0.id = arg1.id;
        arg0.symbol = arg1.symbol;
        arg0.imr = arg1.imr;
        arg0.mmr = arg1.mmr;
        arg0.step_size = arg1.step_size;
        arg0.tick_size = arg1.tick_size;
        arg0.min_trade_qty = arg1.min_trade_qty;
        arg0.max_trade_qty = arg1.max_trade_qty;
        arg0.min_trade_price = arg1.min_trade_price;
        arg0.max_trade_price = arg1.max_trade_price;
        arg0.max_notional_at_open = arg1.max_notional_at_open;
        arg0.mtb_long = arg1.mtb_long;
        arg0.mtb_short = arg1.mtb_short;
        arg0.maker_fee = arg1.maker_fee;
        arg0.taker_fee = arg1.taker_fee;
        arg0.max_funding_rate = arg1.max_funding_rate;
        arg0.insurance_pool_ratio = arg1.insurance_pool_ratio;
        arg0.insurance_pool = arg1.insurance_pool;
        arg0.fee_pool = arg1.fee_pool;
        arg0.trading_status = arg1.trading_status;
        arg0.trading_start_time = arg1.trading_start_time;
        arg0.delist = arg1.delist;
        arg0.delisting_price = arg1.delisting_price;
        arg0.isolated_only = arg1.isolated_only;
        arg0.base_asset_symbol = arg1.base_asset_symbol;
        arg0.base_asset_name = arg1.base_asset_name;
        arg0.base_asset_decimals = arg1.base_asset_decimals;
        arg0.max_limit_order_quantity = arg1.max_limit_order_quantity;
        arg0.max_market_order_quantity = arg1.max_market_order_quantity;
        arg0.default_leverage = arg1.default_leverage;
        if (arg0.delist) {
            arg0.oracle_price = arg0.delisting_price;
        };
        0x2::bcs::to_bytes<Perpetual>(arg1)
    }

    public(friend) fun set_fee(arg0: &mut Perpetual, arg1: u64, arg2: bool) {
        assert!(arg1 >= 0 && arg1 <= 30000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        if (arg2) {
            arg0.maker_fee = arg1;
        } else {
            arg0.taker_fee = arg1;
        };
    }

    public(friend) fun set_fee_pool_address(arg0: &mut Perpetual, arg1: address) {
        assert!(arg1 != @0x0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::can_not_be_zero_address());
        arg0.fee_pool = arg1;
    }

    public(friend) fun set_imr(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 20000000 && arg1 <= 500000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg1 >= arg0.mmr, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.imr = arg1;
    }

    public(friend) fun set_insurance_pool_address(arg0: &mut Perpetual, arg1: address) {
        assert!(arg1 != @0x0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::can_not_be_zero_address());
        arg0.insurance_pool = arg1;
    }

    public(friend) fun set_insurance_pool_liquidation_premium_percentage(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 10000000 && arg1 <= 500000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        arg0.insurance_pool_ratio = arg1;
    }

    public(friend) fun set_isolated_only(arg0: &mut Perpetual, arg1: bool) {
        arg0.isolated_only = arg1;
    }

    public(friend) fun set_max_allowed_oi_open(arg0: &mut Perpetual, arg1: vector<u64>) {
        arg0.max_notional_at_open = arg1;
        while (0x1::vector::length<u64>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg1);
            assert!(v0 >= 1000000000000 && v0 <= 10000000000000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        };
    }

    public(friend) fun set_max_funding_rate(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 1000000 && arg1 <= 50000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        arg0.max_funding_rate = arg1;
    }

    public(friend) fun set_max_trade_price(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 10000 && arg1 <= 100000000000000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg1 >= arg0.min_trade_price && arg1 % arg0.tick_size == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.max_trade_price = arg1;
    }

    public(friend) fun set_max_trade_qty(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 1000 && arg1 <= 100000000000000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg1 > arg0.min_trade_qty && arg1 % arg0.step_size == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.max_trade_qty = arg1;
    }

    public(friend) fun set_min_trade_price(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 10000 && arg1 <= 100000000000000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg1 <= arg0.max_trade_price && arg1 % arg0.tick_size == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.min_trade_price = arg1;
    }

    public(friend) fun set_mmr(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 10000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg1 <= arg0.imr, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.mmr = arg1;
    }

    public(friend) fun set_mtb(arg0: &mut Perpetual, arg1: u64, arg2: bool) {
        assert!(arg1 >= 1000000 && arg1 <= 200000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        if (arg2) {
            arg0.mtb_long = arg1;
        } else {
            arg0.mtb_short = arg1;
        };
    }

    public(friend) fun set_step_size_and_min_trade_qty(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 1000 && arg1 <= 1000000000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg1 < arg0.max_trade_qty, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.step_size = arg1;
        arg0.min_trade_qty = arg1;
    }

    public(friend) fun set_tick_size(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 >= 1000 && arg1 <= 1000000000000, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::out_of_config_value_bounds());
        assert!(arg0.min_trade_price % arg1 == 0 && arg0.max_trade_price % arg1 == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        arg0.tick_size = arg1;
    }

    public(friend) fun set_trading_status(arg0: &mut Perpetual, arg1: bool) {
        arg0.trading_status = arg1;
    }

    public(friend) fun update_funding_rate(arg0: &mut Perpetual, arg1: u64, arg2: bool, arg3: u64) {
        assert!(arg0.funding.timestamp < arg3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_funding_time());
        assert!(arg1 <= arg0.max_funding_rate, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::funding_rate_exceeds_max_allowed_limit());
        arg0.funding = create_funding_rate(arg3, arg1, arg2);
    }

    public(friend) fun update_oracle_price(arg0: &mut Perpetual, arg1: u64) {
        assert!(arg1 % arg0.tick_size == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_oracle_price());
        assert!(!arg0.delist, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::already_delisted());
        arg0.oracle_price = arg1;
    }

    // decompiled from Move bytecode v6
}

