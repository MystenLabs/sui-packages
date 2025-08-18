module 0x50e1a5b9a07973579540ccc2d068a88484469fbf95dcbb3d064927b0e26c14ad::encounter_log {
    struct Encounter has store, key {
        id: 0x2::object::UID,
        sender: address,
        receiver: address,
        timestamp: u64,
    }

    public entry fun burn_expired_encounter(arg0: Encounter, arg1: &mut 0x2::tx_context::TxContext) {
        let Encounter {
            id        : v0,
            sender    : _,
            receiver  : _,
            timestamp : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_info(arg0: &Encounter) : (address, address, u64) {
        (arg0.sender, arg0.receiver, arg0.timestamp)
    }

    public fun hello() : u64 {
        42
    }

    public entry fun log_encounter(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Encounter{
            id        : 0x2::object::new(arg2),
            sender    : 0x2::tx_context::sender(arg2),
            receiver  : arg0,
            timestamp : arg1,
        };
        0x2::transfer::public_transfer<Encounter>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun log_encounters(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = Encounter{
                id        : 0x2::object::new(arg2),
                sender    : v0,
                receiver  : *0x1::vector::borrow<address>(&arg0, v1),
                timestamp : arg1,
            };
            0x2::transfer::public_transfer<Encounter>(v2, v0);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

