module 0x196262c74eeec03a82736b2ee647b7eb635e29465e0acd12060f00eace5e09b7::reservoir_events {
    struct ChargeReservior<phantom T0> has copy, drop {
        inflow_amount: u64,
        usdl_amount: u64,
    }

    struct DischargeReservior<phantom T0> has copy, drop {
        outflow_amount: u64,
        usdl_amount: u64,
    }

    public(friend) fun emit_charge_reservoir<T0>(arg0: u64, arg1: u64) {
        let v0 = ChargeReservior<T0>{
            inflow_amount : arg0,
            usdl_amount   : arg1,
        };
        0x2::event::emit<ChargeReservior<T0>>(v0);
    }

    public(friend) fun emit_discharge_reservoir<T0>(arg0: u64, arg1: u64) {
        let v0 = DischargeReservior<T0>{
            outflow_amount : arg0,
            usdl_amount    : arg1,
        };
        0x2::event::emit<DischargeReservior<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

