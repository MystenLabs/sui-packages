module 0x71f87e824caa08684bb018087c2fd2b07b1059065858729f8857d3c55d8e638f::Research {
    struct Doctrine has copy, drop {
        patarian_id: u64,
        phantom_id: u64,
        phantom_addr: address,
        version: u64,
        group_no: u16,
        type_no: u16,
        next_level: u16,
        proof: u64,
    }

    public fun EvolveDoctrine(arg0: u64, arg1: u64, arg2: u64, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Doctrine{
            patarian_id  : arg0,
            phantom_id   : arg1,
            phantom_addr : 0x2::tx_context::sender(arg7),
            version      : arg2,
            group_no     : arg3,
            type_no      : arg4,
            next_level   : arg5,
            proof        : arg6,
        };
        0x2::event::emit<Doctrine>(v0);
    }

    // decompiled from Move bytecode v6
}

