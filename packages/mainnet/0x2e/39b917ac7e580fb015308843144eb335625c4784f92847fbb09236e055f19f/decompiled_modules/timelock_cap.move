module 0x2e39b917ac7e580fb015308843144eb335625c4784f92847fbb09236e055f19f::timelock_cap {
    struct TimelockCap has store, key {
        id: 0x2::object::UID,
    }

    struct TimelockTicket has drop {
        cap_id: 0x2::object::ID,
    }

    public(friend) fun delete(arg0: TimelockCap) {
        let TimelockCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TimelockCap {
        TimelockCap{id: 0x2::object::new(arg0)}
    }

    public fun cap_id(arg0: &TimelockTicket) : 0x2::object::ID {
        arg0.cap_id
    }

    public(friend) fun new_ticket(arg0: &TimelockCap) : TimelockTicket {
        TimelockTicket{cap_id: 0x2::object::id<TimelockCap>(arg0)}
    }

    // decompiled from Move bytecode v7
}

