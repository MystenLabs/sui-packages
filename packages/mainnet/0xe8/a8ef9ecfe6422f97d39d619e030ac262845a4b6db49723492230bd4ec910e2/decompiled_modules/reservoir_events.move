module 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::reservoir_events {
    struct ChargeReservior<phantom T0> has copy, drop {
        inflow_amount: u64,
        buck_amount: u64,
    }

    struct DischargeReservior<phantom T0> has copy, drop {
        outflow_amount: u64,
        buck_amount: u64,
    }

    public(friend) fun emit_charge_reservoir<T0>(arg0: u64, arg1: u64) {
        let v0 = ChargeReservior<T0>{
            inflow_amount : arg0,
            buck_amount   : arg1,
        };
        0x2::event::emit<ChargeReservior<T0>>(v0);
    }

    public(friend) fun emit_discharge_reservoir<T0>(arg0: u64, arg1: u64) {
        let v0 = DischargeReservior<T0>{
            outflow_amount : arg0,
            buck_amount    : arg1,
        };
        0x2::event::emit<DischargeReservior<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

