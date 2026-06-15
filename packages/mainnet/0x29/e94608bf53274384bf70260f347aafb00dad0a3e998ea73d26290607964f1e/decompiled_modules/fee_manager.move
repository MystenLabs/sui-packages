module 0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::fee_manager {
    struct MarketFeeConfig has copy, drop, store {
        taker_fee_bps: u64,
        maker_rebate_bps: u64,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
        market_configs: 0x2::table::Table<vector<u8>, MarketFeeConfig>,
        default_taker_fee_bps: u64,
        default_maker_rebate_bps: u64,
        treasury_split_bps: u64,
        insurance_fund_split_bps: u64,
        routed_balances: 0x2::table::Table<address, u128>,
        treasury_balance: u128,
        insurance_fund_balance: u128,
        total_taker_fees_collected: u128,
        total_maker_rebates_paid: u128,
    }

    struct TakerFeeCollected has copy, drop {
        trader: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        notional_value: u64,
        fee_bps: u64,
        fee_amount: u64,
    }

    struct MakerRebatePaid has copy, drop {
        maker: address,
        market_id: 0x2::object::ID,
        symbol: vector<u8>,
        notional_value: u64,
        rebate_bps: u64,
        rebate_amount: u64,
    }

    struct FeeDistributed has copy, drop {
        fee_amount: u64,
        treasury_amount: u64,
        insurance_fund_amount: u64,
    }

    struct MarketFeeConfigUpdated has copy, drop {
        symbol: vector<u8>,
        taker_fee_bps: u64,
        maker_rebate_bps: u64,
    }

    struct DefaultFeeConfigUpdated has copy, drop {
        taker_fee_bps: u64,
        maker_rebate_bps: u64,
    }

    struct DistributionSplitUpdated has copy, drop {
        treasury_split_bps: u64,
        insurance_fund_split_bps: u64,
    }

    public(friend) fun accrue_liquidation_fee(arg0: &mut FeeCollector, arg1: address, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: u64) {
        if (arg5 == 0) {
            return
        };
        let v0 = if (arg4 == 0) {
            0
        } else {
            (((arg5 as u128) * 10000 / (arg4 as u128)) as u64)
        };
        distribute_fee(arg0, arg1, arg2, arg3, arg4, v0, arg5);
    }

    public(friend) fun collect_taker_fee(arg0: &mut FeeCollector, arg1: address, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64) : u64 {
        let v0 = get_taker_fee_bps(arg0, arg3);
        assert!(get_maker_rebate_bps(arg0, arg3) <= v0, 2);
        let v1 = compute_taker_fee(arg4, v0);
        if (v1 > 0) {
            distribute_fee(arg0, arg1, arg2, arg3, arg4, v0, v1);
        };
        v1
    }

    public fun compute_maker_rebate(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun compute_taker_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun default_maker_rebate_bps(arg0: &FeeCollector) : u64 {
        arg0.default_maker_rebate_bps
    }

    public fun default_taker_fee_bps(arg0: &FeeCollector) : u64 {
        arg0.default_taker_fee_bps
    }

    fun distribute_fee(arg0: &mut FeeCollector, arg1: address, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64) {
        let (v0, v1) = split_fee(arg0, arg6);
        let v2 = (v0 as u128);
        let v3 = (v1 as u128);
        arg0.treasury_balance = arg0.treasury_balance + v2;
        arg0.insurance_fund_balance = arg0.insurance_fund_balance + v3;
        arg0.total_taker_fees_collected = arg0.total_taker_fees_collected + (arg6 as u128);
        let v4 = TakerFeeCollected{
            trader         : arg1,
            market_id      : arg2,
            symbol         : arg3,
            notional_value : arg4,
            fee_bps        : arg5,
            fee_amount     : arg6,
        };
        0x2::event::emit<TakerFeeCollected>(v4);
        let v5 = FeeDistributed{
            fee_amount            : arg6,
            treasury_amount       : (v2 as u64),
            insurance_fund_amount : (v3 as u64),
        };
        0x2::event::emit<FeeDistributed>(v5);
    }

    public fun get_maker_rebate_bps(arg0: &FeeCollector, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1)) {
            0x2::table::borrow<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1).maker_rebate_bps
        } else {
            arg0.default_maker_rebate_bps
        }
    }

    public fun get_taker_fee_bps(arg0: &FeeCollector, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1)) {
            0x2::table::borrow<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1).taker_fee_bps
        } else {
            arg0.default_taker_fee_bps
        }
    }

    public fun has_market_config(arg0: &FeeCollector, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollector{
            id                         : 0x2::object::new(arg0),
            market_configs             : 0x2::table::new<vector<u8>, MarketFeeConfig>(arg0),
            default_taker_fee_bps      : 5,
            default_maker_rebate_bps   : 2,
            treasury_split_bps         : 6000,
            insurance_fund_split_bps   : 4000,
            routed_balances            : 0x2::table::new<address, u128>(arg0),
            treasury_balance           : 0,
            insurance_fund_balance     : 0,
            total_taker_fees_collected : 0,
            total_maker_rebates_paid   : 0,
        };
        0x2::transfer::share_object<FeeCollector>(v0);
    }

    public fun insurance_fund_balance(arg0: &FeeCollector) : u128 {
        arg0.insurance_fund_balance
    }

    public fun insurance_fund_split_bps(arg0: &FeeCollector) : u64 {
        arg0.insurance_fund_split_bps
    }

    public fun market_config_maker_rebate_bps(arg0: &FeeCollector, arg1: vector<u8>) : u64 {
        0x2::table::borrow<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1).maker_rebate_bps
    }

    public fun market_config_taker_fee_bps(arg0: &FeeCollector, arg1: vector<u8>) : u64 {
        0x2::table::borrow<vector<u8>, MarketFeeConfig>(&arg0.market_configs, arg1).taker_fee_bps
    }

    public(friend) fun pay_maker_rebate(arg0: &mut FeeCollector, arg1: address, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64) : u64 {
        let v0 = get_maker_rebate_bps(arg0, arg3);
        assert!(v0 <= get_taker_fee_bps(arg0, arg3), 2);
        let v1 = compute_maker_rebate(arg4, v0);
        if (v1 > 0) {
            arg0.total_maker_rebates_paid = arg0.total_maker_rebates_paid + (v1 as u128);
            let v2 = MakerRebatePaid{
                maker          : arg1,
                market_id      : arg2,
                symbol         : arg3,
                notional_value : arg4,
                rebate_bps     : v0,
                rebate_amount  : v1,
            };
            0x2::event::emit<MakerRebatePaid>(v2);
        };
        v1
    }

    public(friend) fun route_balance(arg0: &mut FeeCollector, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        if (0x2::table::contains<address, u128>(&arg0.routed_balances, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u128>(&mut arg0.routed_balances, arg1);
            *v0 = *v0 + (arg2 as u128);
        } else {
            0x2::table::add<address, u128>(&mut arg0.routed_balances, arg1, (arg2 as u128));
        };
    }

    public(friend) fun route_to_treasury(arg0: &mut FeeCollector, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        arg0.treasury_balance = arg0.treasury_balance + (arg1 as u128);
    }

    public fun routed_balance(arg0: &FeeCollector, arg1: address) : u128 {
        if (0x2::table::contains<address, u128>(&arg0.routed_balances, arg1)) {
            *0x2::table::borrow<address, u128>(&arg0.routed_balances, arg1)
        } else {
            0
        }
    }

    public fun set_default_fee_config(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut FeeCollector, arg2: u64, arg3: u64) {
        assert!(arg2 <= 100, 0);
        assert!(arg3 <= 50, 1);
        assert!(arg3 <= arg2, 2);
        arg1.default_taker_fee_bps = arg2;
        arg1.default_maker_rebate_bps = arg3;
        let v0 = DefaultFeeConfigUpdated{
            taker_fee_bps    : arg2,
            maker_rebate_bps : arg3,
        };
        0x2::event::emit<DefaultFeeConfigUpdated>(v0);
    }

    public fun set_distribution_split(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut FeeCollector, arg2: u64, arg3: u64) {
        assert!(arg2 + arg3 == 10000, 3);
        arg1.treasury_split_bps = arg2;
        arg1.insurance_fund_split_bps = arg3;
        let v0 = DistributionSplitUpdated{
            treasury_split_bps       : arg2,
            insurance_fund_split_bps : arg3,
        };
        0x2::event::emit<DistributionSplitUpdated>(v0);
    }

    public fun set_market_fee_config(arg0: &0x60df2030f7245e1caf1b23d507406032ddcbeb4aeadd793c273cd1a04ffd47bb::admin_config::AdminCap, arg1: &mut FeeCollector, arg2: vector<u8>, arg3: u64, arg4: u64) {
        assert!(arg3 <= 100, 0);
        assert!(arg4 <= 50, 1);
        assert!(arg4 <= arg3, 2);
        if (0x2::table::contains<vector<u8>, MarketFeeConfig>(&arg1.market_configs, arg2)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, MarketFeeConfig>(&mut arg1.market_configs, arg2);
            v0.taker_fee_bps = arg3;
            v0.maker_rebate_bps = arg4;
        } else {
            let v1 = MarketFeeConfig{
                taker_fee_bps    : arg3,
                maker_rebate_bps : arg4,
            };
            0x2::table::add<vector<u8>, MarketFeeConfig>(&mut arg1.market_configs, arg2, v1);
        };
        let v2 = MarketFeeConfigUpdated{
            symbol           : arg2,
            taker_fee_bps    : arg3,
            maker_rebate_bps : arg4,
        };
        0x2::event::emit<MarketFeeConfigUpdated>(v2);
    }

    public fun split_fee(arg0: &FeeCollector, arg1: u64) : (u64, u64) {
        let v0 = (arg1 as u128) * (arg0.treasury_split_bps as u128) / 10000;
        ((v0 as u64), (((arg1 as u128) - v0) as u64))
    }

    public fun total_maker_rebates_paid(arg0: &FeeCollector) : u128 {
        arg0.total_maker_rebates_paid
    }

    public fun total_taker_fees_collected(arg0: &FeeCollector) : u128 {
        arg0.total_taker_fees_collected
    }

    public fun treasury_balance(arg0: &FeeCollector) : u128 {
        arg0.treasury_balance
    }

    public fun treasury_split_bps(arg0: &FeeCollector) : u64 {
        arg0.treasury_split_bps
    }

    // decompiled from Move bytecode v7
}

