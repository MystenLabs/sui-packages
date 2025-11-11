module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_burn {
    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
        total_supply_after: u64,
    }

    public(friend) fun emit_burn_event(arg0: u64, arg1: address, arg2: u64) {
        let v0 = BurnEvent{
            amount             : arg0,
            burner             : arg1,
            total_supply_after : arg2,
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public(friend) fun get_amount(arg0: &BurnEvent) : u64 {
        arg0.amount
    }

    public(friend) fun get_burner(arg0: &BurnEvent) : address {
        arg0.burner
    }

    public(friend) fun get_total_supply_after(arg0: &BurnEvent) : u64 {
        arg0.total_supply_after
    }

    // decompiled from Move bytecode v6
}

