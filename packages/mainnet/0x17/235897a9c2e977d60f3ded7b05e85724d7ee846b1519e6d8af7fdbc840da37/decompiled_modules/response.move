module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::response {
    struct TradingResponse {
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        action: u8,
        sender: address,
        position_id: 0x1::option::Option<u64>,
        pnl_amount: u64,
        pnl_is_profit: bool,
        fee_amount: u64,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_amount: u64,
        execution_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun account_id(arg0: &TradingResponse) : 0x2::object::ID {
        arg0.account_id
    }

    public fun action(arg0: &TradingResponse) : u8 {
        arg0.action
    }

    public fun add_witness<T0: drop>(arg0: &mut TradingResponse, arg1: T0) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.witnesses, &v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_witness_already_exists();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
    }

    public fun collateral_amount(arg0: &TradingResponse) : u64 {
        arg0.collateral_amount
    }

    public(friend) fun destroy(arg0: TradingResponse) : (0x2::object::ID, 0x2::object::ID, u8, address, 0x1::option::Option<u64>, u64, bool, u64, bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let TradingResponse {
            market_id         : v0,
            account_id        : v1,
            action            : v2,
            sender            : v3,
            position_id       : v4,
            pnl_amount        : v5,
            pnl_is_profit     : v6,
            fee_amount        : v7,
            is_long           : v8,
            size              : v9,
            collateral_amount : v10,
            execution_price   : v11,
            witnesses         : v12,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    public fun execution_price(arg0: &TradingResponse) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.execution_price
    }

    public fun fee_amount(arg0: &TradingResponse) : u64 {
        arg0.fee_amount
    }

    public fun is_long(arg0: &TradingResponse) : bool {
        arg0.is_long
    }

    public fun market_id(arg0: &TradingResponse) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: address, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: bool, arg7: u64, arg8: bool, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: u64, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : TradingResponse {
        TradingResponse{
            market_id         : arg0,
            account_id        : arg1,
            action            : arg2,
            sender            : arg3,
            position_id       : arg4,
            pnl_amount        : arg5,
            pnl_is_profit     : arg6,
            fee_amount        : arg7,
            is_long           : arg8,
            size              : arg9,
            collateral_amount : arg10,
            execution_price   : arg11,
            witnesses         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun pnl_amount(arg0: &TradingResponse) : u64 {
        arg0.pnl_amount
    }

    public fun pnl_is_profit(arg0: &TradingResponse) : bool {
        arg0.pnl_is_profit
    }

    public fun position_id(arg0: &TradingResponse) : 0x1::option::Option<u64> {
        arg0.position_id
    }

    public fun sender(arg0: &TradingResponse) : address {
        arg0.sender
    }

    public fun size(arg0: &TradingResponse) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.size
    }

    public fun witnesses(arg0: &TradingResponse) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    // decompiled from Move bytecode v7
}

