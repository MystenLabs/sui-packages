module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::tank_events {
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

