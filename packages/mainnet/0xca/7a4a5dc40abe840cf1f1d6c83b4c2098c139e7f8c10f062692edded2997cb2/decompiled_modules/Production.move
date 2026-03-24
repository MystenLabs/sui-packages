module 0xca7a4a5dc40abe840cf1f1d6c83b4c2098c139e7f8c10f062692edded2997cb2::Production {
    struct Level has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        group_no: u16,
        type_no: u16,
        level: u8,
        proof: u64,
    }

    public fun Speed(arg0: u64, arg1: u16, arg2: u16, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Level{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg5),
            group_no     : arg1,
            type_no      : arg2,
            level        : arg3,
            proof        : arg4,
        };
        0x2::event::emit<Level>(v0);
    }

    // decompiled from Move bytecode v6
}

