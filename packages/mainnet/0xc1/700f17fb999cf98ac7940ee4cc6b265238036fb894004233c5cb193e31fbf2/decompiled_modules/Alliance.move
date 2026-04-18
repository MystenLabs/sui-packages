module 0xc1700f17fb999cf98ac7940ee4cc6b265238036fb894004233c5cb193e31fbf2::Alliance {
    struct Pact has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        pact_id: u64,
        name: address,
        tag: u64,
        proof: u64,
    }

    struct Motion has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        pact_id: u64,
        action: u8,
        action_addr: address,
        proof: u64,
    }

    public fun Execute(arg0: u64, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Motion{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg5),
            pact_id      : arg1,
            action       : arg2,
            action_addr  : arg3,
            proof        : arg4,
        };
        0x2::event::emit<Motion>(v0);
    }

    public fun Forge(arg0: u64, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Pact{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg5),
            pact_id      : arg1,
            name         : arg2,
            tag          : arg3,
            proof        : arg4,
        };
        0x2::event::emit<Pact>(v0);
    }

    // decompiled from Move bytecode v6
}

