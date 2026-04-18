module 0xc1700f17fb999cf98ac7940ee4cc6b265238036fb894004233c5cb193e31fbf2::Tactics {
    struct Model has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        kind: u16,
        method: u64,
        value: u64,
        proof: u64,
    }

    public fun Improve(arg0: u64, arg1: u16, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Model{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg5),
            kind         : arg1,
            method       : arg2,
            value        : arg3,
            proof        : arg4,
        };
        0x2::event::emit<Model>(v0);
    }

    // decompiled from Move bytecode v6
}

