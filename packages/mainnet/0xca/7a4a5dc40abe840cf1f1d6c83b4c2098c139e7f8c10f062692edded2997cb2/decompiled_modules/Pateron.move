module 0xca7a4a5dc40abe840cf1f1d6c83b4c2098c139e7f8c10f062692edded2997cb2::Pateron {
    struct Anchor has copy, drop {
        pateron_no: u64,
        phantom_id: u64,
        phantom_addr: address,
        version: u64,
        proof: u64,
    }

    struct Leave has copy, drop {
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

    public fun Release(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Leave{
            pateron_no   : arg0,
            phantom_id   : arg1,
            phantom_addr : 0x2::tx_context::sender(arg4),
            version      : arg2,
            proof        : arg3,
        };
        0x2::event::emit<Leave>(v0);
    }

    // decompiled from Move bytecode v6
}

