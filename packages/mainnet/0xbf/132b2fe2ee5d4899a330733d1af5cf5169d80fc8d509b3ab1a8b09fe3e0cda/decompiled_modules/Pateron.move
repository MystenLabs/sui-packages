module 0xbf132b2fe2ee5d4899a330733d1af5cf5169d80fc8d509b3ab1a8b09fe3e0cda::Pateron {
    struct Anchor has copy, drop {
        pateron_no: u64,
        phantom_id: u64,
        phantom_addr: address,
        version: u64,
        proof: u64,
    }

    struct Drop has copy, drop {
        pateron_no: u64,
        phantom_id: u64,
        phantom_addr: address,
        version: u64,
        proof: u64,
    }

    public fun Focus(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Anchor{
            pateron_no   : arg0,
            phantom_id   : arg1,
            phantom_addr : 0x2::tx_context::sender(arg4),
            version      : arg2,
            proof        : arg3,
        };
        0x2::event::emit<Anchor>(v0);
    }

    public fun Leave(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Drop{
            pateron_no   : arg0,
            phantom_id   : arg1,
            phantom_addr : 0x2::tx_context::sender(arg4),
            version      : arg2,
            proof        : arg3,
        };
        0x2::event::emit<Drop>(v0);
    }

    // decompiled from Move bytecode v6
}

