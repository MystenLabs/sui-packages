module 0x562d2a3d730ce953fc63c73dd1847529a8f2041bf343327430eaedc0a9ccfac0::War {
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

