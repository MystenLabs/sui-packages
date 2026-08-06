module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::card_program {
    struct CardProgram<phantom T0> has store, key {
        id: 0x2::object::UID,
        brand: 0x1::string::String,
        close_card_fee_usd: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
        code: vector<u8>,
        enabled: bool,
        funding_type: u8,
        open_card_fee_usd: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
        transaction_fee_usd: 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::Decimal,
        transaction_fee_bps: u64,
    }

    struct SpendingLimits<phantom T0> has store {
        daily_limit_usd: u64,
        monthly_limit_usd: u64,
    }

    struct CardProgramKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun brand<T0>(arg0: &CardProgram<T0>) : 0x1::string::String {
        arg0.brand
    }

    public fun calculate_transaction_fees<T0>(arg0: &CardProgram<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::to_u64(arg0.transaction_fee_usd);
        let v1 = arg1 * arg0.transaction_fee_bps / 10000;
        (v0, v1, v0 + v1)
    }

    public fun card_limits<T0>(arg0: &CardProgram<T0>) : &SpendingLimits<T0> {
        let v0 = CardProgramKey{dummy_field: false};
        0x2::dynamic_field::borrow<CardProgramKey, SpendingLimits<T0>>(&arg0.id, v0)
    }

    public fun close_card_fee_usd<T0>(arg0: &CardProgram<T0>) : u64 {
        0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::to_u64(arg0.close_card_fee_usd)
    }

    public fun code<T0>(arg0: &CardProgram<T0>) : vector<u8> {
        arg0.code
    }

    public(friend) fun create_card_program<T0>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : CardProgram<T0> {
        validate_inputs(arg2, arg6);
        CardProgram<T0>{
            id                  : 0x2::object::new(arg8),
            brand               : arg0,
            close_card_fee_usd  : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg4),
            code                : arg1,
            enabled             : arg7,
            funding_type        : arg2,
            open_card_fee_usd   : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg3),
            transaction_fee_usd : 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg5),
            transaction_fee_bps : arg6,
        }
    }

    public(friend) fun create_spending_limits<T0>(arg0: &mut CardProgram<T0>, arg1: u64, arg2: u64) {
        let v0 = SpendingLimits<T0>{
            daily_limit_usd   : arg1,
            monthly_limit_usd : arg2,
        };
        let v1 = CardProgramKey{dummy_field: false};
        0x2::dynamic_field::add<CardProgramKey, SpendingLimits<T0>>(&mut arg0.id, v1, v0);
    }

    public fun daily_limit_usd<T0>(arg0: &SpendingLimits<T0>) : u64 {
        arg0.daily_limit_usd
    }

    public fun enabled<T0>(arg0: &CardProgram<T0>) : bool {
        arg0.enabled
    }

    public fun funding_type<T0>(arg0: &CardProgram<T0>) : u8 {
        arg0.funding_type
    }

    public fun is_credit_card<T0>(arg0: &CardProgram<T0>) : bool {
        arg0.funding_type == 2
    }

    public fun is_debit_card<T0>(arg0: &CardProgram<T0>) : bool {
        arg0.funding_type == 1
    }

    public fun monthly_limit_usd<T0>(arg0: &SpendingLimits<T0>) : u64 {
        arg0.monthly_limit_usd
    }

    public fun open_card_fee_usd<T0>(arg0: &CardProgram<T0>) : u64 {
        0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::to_u64(arg0.open_card_fee_usd)
    }

    public(friend) fun set_brand<T0>(arg0: &mut CardProgram<T0>, arg1: 0x1::string::String) {
        arg0.brand = arg1;
    }

    public(friend) fun set_close_card_fee_usd<T0>(arg0: &mut CardProgram<T0>, arg1: u64) {
        arg0.close_card_fee_usd = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg1);
    }

    public(friend) fun set_code<T0>(arg0: &mut CardProgram<T0>, arg1: vector<u8>) {
        arg0.code = arg1;
    }

    public(friend) fun set_enabled<T0>(arg0: &mut CardProgram<T0>, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun set_open_card_fee_usd<T0>(arg0: &mut CardProgram<T0>, arg1: u64) {
        arg0.open_card_fee_usd = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg1);
    }

    public(friend) fun set_transaction_fee_bps<T0>(arg0: &mut CardProgram<T0>, arg1: u64) {
        assert!(arg1 <= 10000, 3);
        arg0.transaction_fee_bps = arg1;
    }

    public(friend) fun set_transaction_fee_usd<T0>(arg0: &mut CardProgram<T0>, arg1: u64) {
        arg0.transaction_fee_usd = 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::from(arg1);
    }

    public fun transaction_fee_bps<T0>(arg0: &CardProgram<T0>) : u64 {
        arg0.transaction_fee_bps
    }

    public fun transaction_fee_usd<T0>(arg0: &CardProgram<T0>) : u64 {
        0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal::to_u64(arg0.transaction_fee_usd)
    }

    public(friend) fun validate_inputs(arg0: u8, arg1: u64) {
        assert!(arg0 >= 1 && arg0 <= 2, 1);
        assert!(arg1 <= 10000, 3);
    }

    // decompiled from Move bytecode v6
}

