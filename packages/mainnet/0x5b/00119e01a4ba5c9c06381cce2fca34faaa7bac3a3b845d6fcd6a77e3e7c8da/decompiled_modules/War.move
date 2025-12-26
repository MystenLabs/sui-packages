module 0x5b00119e01a4ba5c9c06381cce2fca34faaa7bac3a3b845d6fcd6a77e3e7c8da::War {
    struct Battle has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        cohort_id: u64,
        destination_id: u64,
        proof: u64,
    }

    public fun Clash(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Battle{
            patarian_id    : arg0,
            phantom_addr   : 0x2::tx_context::sender(arg4),
            cohort_id      : arg1,
            destination_id : arg2,
            proof          : arg3,
        };
        0x2::event::emit<Battle>(v0);
    }

    // decompiled from Move bytecode v6
}

