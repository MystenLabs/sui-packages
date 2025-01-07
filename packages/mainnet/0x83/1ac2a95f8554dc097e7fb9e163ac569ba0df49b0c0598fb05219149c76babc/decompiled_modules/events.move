module 0x831ac2a95f8554dc097e7fb9e163ac569ba0df49b0c0598fb05219149c76babc::events {
    struct TradeIn {
        dummy_field: bool,
    }

    struct TradeOut {
        dummy_field: bool,
    }

    struct TradeEvent<phantom T0> has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        protocol_fee: u64,
        execute_trade: bool,
    }

    struct TradeFailure<phantom T0> has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        message: 0x1::string::String,
    }

    struct LiquidityDepositFailureEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        amount_in: u64,
    }

    struct LiquidityDepositEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        amount_in: u64,
        lpt: u64,
    }

    struct LiquidityWithdrawalEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_out: 0x1::type_name::TypeName,
        lpt: u64,
        amounts_out: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fees: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct FeeCollectionEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        admin: address,
        fee_collector: address,
        collected_fees: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public(friend) fun fee_collection_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = FeeCollectionEvent{
            ramm_id        : arg0,
            admin          : arg1,
            fee_collector  : arg2,
            collected_fees : arg3,
        };
        0x2::event::emit<FeeCollectionEvent>(v0);
    }

    public(friend) fun liquidity_deposit_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) {
        let v0 = LiquidityDepositEvent{
            ramm_id   : arg0,
            trader    : arg1,
            token_in  : arg2,
            amount_in : arg3,
            lpt       : arg4,
        };
        0x2::event::emit<LiquidityDepositEvent>(v0);
    }

    public(friend) fun liquidity_deposit_failure_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = LiquidityDepositFailureEvent{
            ramm_id   : arg0,
            trader    : arg1,
            token_in  : arg2,
            amount_in : arg3,
        };
        0x2::event::emit<LiquidityDepositFailureEvent>(v0);
    }

    public(friend) fun liquidity_withdrawal_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg5: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = LiquidityWithdrawalEvent{
            ramm_id     : arg0,
            trader      : arg1,
            token_out   : arg2,
            lpt         : arg3,
            amounts_out : arg4,
            fees        : arg5,
        };
        0x2::event::emit<LiquidityWithdrawalEvent>(v0);
    }

    public(friend) fun trade_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64, arg7: bool) {
        let v0 = TradeEvent<T0>{
            ramm_id       : arg0,
            trader        : arg1,
            token_in      : arg2,
            token_out     : arg3,
            amount_in     : arg4,
            amount_out    : arg5,
            protocol_fee  : arg6,
            execute_trade : arg7,
        };
        0x2::event::emit<TradeEvent<T0>>(v0);
    }

    public(friend) fun trade_failure_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: 0x1::string::String) {
        let v0 = TradeFailure<T0>{
            ramm_id   : arg0,
            trader    : arg1,
            token_in  : arg2,
            token_out : arg3,
            amount_in : arg4,
            message   : arg5,
        };
        0x2::event::emit<TradeFailure<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

