module 0xaaad0b32f3a9d8a202f2a68f64d290024413aabfa9ef4c67c27948c81c81c3aa::fee {
    struct FEE has drop {
        dummy_field: bool,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        trading_fee_bps: u64,
        protocol_fee_bps: u64,
        settlement_fee_bps: u64,
        min_trade_amount: u64,
        creation_bond: u64,
        paused: bool,
        fee_recipient: address,
    }

    struct FeeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfigUpdated has copy, drop {
        trading_fee_bps: u64,
        protocol_fee_bps: u64,
        settlement_fee_bps: u64,
        min_trade_amount: u64,
        creation_bond: u64,
    }

    struct PausedToggled has copy, drop {
        paused: bool,
    }

    public fun assert_min_trade(arg0: &FeeConfig, arg1: u64) {
        assert!(arg1 >= arg0.min_trade_amount, 4);
    }

    public fun assert_not_paused(arg0: &FeeConfig) {
        assert!(!arg0.paused, 5);
    }

    public fun assert_version(arg0: &FeeConfig) {
        assert!(arg0.version == 1, 0);
    }

    public fun calc_lp_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        calc_total_fee(arg0, arg1) - calc_protocol_fee(arg0, arg1)
    }

    public fun calc_protocol_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        mul_div(arg1, arg0.protocol_fee_bps, 10000)
    }

    public fun calc_settlement_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        mul_div(arg1, arg0.settlement_fee_bps, 10000)
    }

    public fun calc_total_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        mul_div(arg1, arg0.trading_fee_bps, 10000)
    }

    public fun creation_bond(arg0: &FeeConfig) : u64 {
        arg0.creation_bond
    }

    public fun fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    fun init(arg0: FEE, arg1: &mut 0x2::tx_context::TxContext) {
        setup(arg1);
    }

    public fun is_paused(arg0: &FeeConfig) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &FeeAdminCap, arg1: &mut FeeConfig) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun min_trade_amount(arg0: &FeeConfig) : u64 {
        arg0.min_trade_amount
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun protocol_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public fun set_fee_recipient(arg0: &FeeAdminCap, arg1: &mut FeeConfig, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun set_fees(arg0: &FeeAdminCap, arg1: &mut FeeConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 0);
        assert!(arg2 <= 500, 1);
        assert!(arg3 <= arg2, 2);
        assert!(arg4 <= 500, 3);
        arg1.trading_fee_bps = arg2;
        arg1.protocol_fee_bps = arg3;
        arg1.settlement_fee_bps = arg4;
        let v0 = FeeConfigUpdated{
            trading_fee_bps    : arg2,
            protocol_fee_bps   : arg3,
            settlement_fee_bps : arg4,
            min_trade_amount   : arg1.min_trade_amount,
            creation_bond      : arg1.creation_bond,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    public fun set_limits(arg0: &FeeAdminCap, arg1: &mut FeeConfig, arg2: u64, arg3: u64) {
        assert!(arg1.version == 1, 0);
        arg1.min_trade_amount = arg2;
        arg1.creation_bond = arg3;
        let v0 = FeeConfigUpdated{
            trading_fee_bps    : arg1.trading_fee_bps,
            protocol_fee_bps   : arg1.protocol_fee_bps,
            settlement_fee_bps : arg1.settlement_fee_bps,
            min_trade_amount   : arg2,
            creation_bond      : arg3,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    public fun set_paused(arg0: &FeeAdminCap, arg1: &mut FeeConfig, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedToggled{paused: arg2};
        0x2::event::emit<PausedToggled>(v0);
    }

    public fun settlement_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.settlement_fee_bps
    }

    fun setup(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfig{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            trading_fee_bps    : 150,
            protocol_fee_bps   : 50,
            settlement_fee_bps : 0,
            min_trade_amount   : 1000000,
            creation_bond      : 5000000,
            paused             : false,
            fee_recipient      : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeConfig>(v0);
        let v1 = FeeAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FeeAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun trading_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.trading_fee_bps
    }

    public fun version(arg0: &FeeConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

