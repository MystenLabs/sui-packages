module 0x3cfee2f688d0ef9b9235d78211eb05d339232cca84f38c94f905d098a62ff036::Army {
    struct Phalanx has copy, drop {
        patarian_id: u64,
        phantom_id: u64,
        phantom_addr: address,
        version: u64,
        group_no: u16,
        type_no: u16,
        count: u16,
        proof: u64,
    }

    public fun DeployPhalanx(arg0: u64, arg1: u64, arg2: u64, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Phalanx{
            patarian_id  : arg0,
            phantom_id   : arg1,
            phantom_addr : 0x2::tx_context::sender(arg7),
            version      : arg2,
            group_no     : arg3,
            type_no      : arg4,
            count        : arg5,
            proof        : arg6,
        };
        0x2::event::emit<Phalanx>(v0);
    }

    // decompiled from Move bytecode v6
}

