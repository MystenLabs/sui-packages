module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::response {
    struct TradingResponse has drop {
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        action: u8,
        sender: address,
        order_id: 0x1::option::Option<u64>,
        position_id: 0x1::option::Option<u64>,
        pnl_amount: u64,
        pnl_is_profit: bool,
        fee_amount: u64,
        returned_collateral_amount: u64,
        input_collateral_amount: u64,
        position_collateral_amount: u64,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        execution_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
    }

    public fun account_id(arg0: &TradingResponse) : 0x2::object::ID {
        arg0.account_id
    }

    public fun action(arg0: &TradingResponse) : u8 {
        arg0.action
    }

    public fun execution_price(arg0: &TradingResponse) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.execution_price
    }

    public fun fee_amount(arg0: &TradingResponse) : u64 {
        arg0.fee_amount
    }

    public fun input_collateral_amount(arg0: &TradingResponse) : u64 {
        arg0.input_collateral_amount
    }

    public fun is_long(arg0: &TradingResponse) : bool {
        arg0.is_long
    }

    public fun market_id(arg0: &TradingResponse) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: address, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg14: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : TradingResponse {
        TradingResponse{
            market_id                  : arg0,
            account_id                 : arg1,
            action                     : arg2,
            sender                     : arg3,
            order_id                   : arg4,
            position_id                : arg5,
            pnl_amount                 : arg6,
            pnl_is_profit              : arg7,
            fee_amount                 : arg8,
            returned_collateral_amount : arg9,
            input_collateral_amount    : arg10,
            position_collateral_amount : arg11,
            is_long                    : arg12,
            size                       : arg13,
            execution_price            : arg14,
        }
    }

    public fun order_id(arg0: &TradingResponse) : 0x1::option::Option<u64> {
        arg0.order_id
    }

    public fun pnl_amount(arg0: &TradingResponse) : u64 {
        arg0.pnl_amount
    }

    public fun pnl_is_profit(arg0: &TradingResponse) : bool {
        arg0.pnl_is_profit
    }

    public fun position_collateral_amount(arg0: &TradingResponse) : u64 {
        arg0.position_collateral_amount
    }

    public fun position_id(arg0: &TradingResponse) : 0x1::option::Option<u64> {
        arg0.position_id
    }

    public fun returned_collateral_amount(arg0: &TradingResponse) : u64 {
        arg0.returned_collateral_amount
    }

    public fun sender(arg0: &TradingResponse) : address {
        arg0.sender
    }

    public fun size(arg0: &TradingResponse) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.size
    }

    // decompiled from Move bytecode v7
}

