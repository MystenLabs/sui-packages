module 0xca7a4a5dc40abe840cf1f1d6c83b4c2098c139e7f8c10f062692edded2997cb2::Player {
    struct Settings has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        kind: u16,
        value: u64,
        proof: u64,
    }

    public fun Apply(arg0: u64, arg1: u16, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Settings{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg4),
            kind         : arg1,
            value        : arg2,
            proof        : arg3,
        };
        0x2::event::emit<Settings>(v0);
    }

    // decompiled from Move bytecode v6
}

