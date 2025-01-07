module 0x21535b1dd8d3285dc8486394a9f8c6173c1934185dd8a4c1c194036aaba6d9ba::tank_events {
    struct Deposite has copy, drop {
        tank_type: 0x1::ascii::String,
        buck_amount: u64,
    }

    struct Withdraw has copy, drop {
        tank_type: 0x1::ascii::String,
        buck_amount: u64,
        collateral_amount: u64,
        bkt_amount: u64,
    }

    struct Absorb has copy, drop {
        tank_type: 0x1::ascii::String,
        buck_amount: u64,
        collateral_amount: u64,
    }

    struct CollectBKT has copy, drop {
        tank_type: 0x1::ascii::String,
        bkt_amount: u64,
    }

    public(friend) fun emit_absorb<T0>(arg0: u64, arg1: u64) {
        let v0 = Absorb{
            tank_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buck_amount       : arg0,
            collateral_amount : arg1,
        };
        0x2::event::emit<Absorb>(v0);
    }

    public(friend) fun emit_collect_bkt<T0>(arg0: u64) {
        let v0 = CollectBKT{
            tank_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bkt_amount : arg0,
        };
        0x2::event::emit<CollectBKT>(v0);
    }

    public(friend) fun emit_deposit<T0>(arg0: u64) {
        let v0 = Deposite{
            tank_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buck_amount : arg0,
        };
        0x2::event::emit<Deposite>(v0);
    }

    public(friend) fun emit_withdraw<T0>(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = Withdraw{
            tank_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            buck_amount       : arg0,
            collateral_amount : arg1,
            bkt_amount        : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

