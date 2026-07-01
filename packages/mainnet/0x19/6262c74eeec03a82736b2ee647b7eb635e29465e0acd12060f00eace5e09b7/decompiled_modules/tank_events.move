module 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::tank_events {
    struct Deposite has copy, drop {
        tank_type: 0x1::ascii::String,
        usdl_amount: u64,
    }

    struct Withdraw has copy, drop {
        tank_type: 0x1::ascii::String,
        usdl_amount: u64,
        collateral_amount: u64,
        yeast_amount: u64,
    }

    struct Absorb has copy, drop {
        tank_type: 0x1::ascii::String,
        usdl_amount: u64,
        collateral_amount: u64,
    }

    struct TankUpdate has copy, drop {
        tank_type: 0x1::ascii::String,
        current_epoch: u64,
        current_scale: u64,
        current_p: u64,
    }

    struct CollectYEAST has copy, drop {
        tank_type: 0x1::ascii::String,
        yeast_amount: u64,
    }

    public(friend) fun emit_absorb<T0>(arg0: u64, arg1: u64) {
        let v0 = Absorb{
            tank_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            usdl_amount       : arg0,
            collateral_amount : arg1,
        };
        0x2::event::emit<Absorb>(v0);
    }

    public(friend) fun emit_collect_yeast<T0>(arg0: u64) {
        let v0 = CollectYEAST{
            tank_type    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            yeast_amount : arg0,
        };
        0x2::event::emit<CollectYEAST>(v0);
    }

    public(friend) fun emit_deposit<T0>(arg0: u64) {
        let v0 = Deposite{
            tank_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            usdl_amount : arg0,
        };
        0x2::event::emit<Deposite>(v0);
    }

    public(friend) fun emit_tank_update<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = TankUpdate{
            tank_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            current_epoch : arg0,
            current_scale : arg1,
            current_p     : arg2,
        };
        0x2::event::emit<TankUpdate>(v0);
    }

    public(friend) fun emit_withdraw<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = Withdraw{
            tank_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            usdl_amount       : arg0,
            collateral_amount : arg1,
            yeast_amount      : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v7
}

