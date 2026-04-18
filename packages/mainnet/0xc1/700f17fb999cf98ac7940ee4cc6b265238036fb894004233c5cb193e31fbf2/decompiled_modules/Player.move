module 0xc1700f17fb999cf98ac7940ee4cc6b265238036fb894004233c5cb193e31fbf2::Player {
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

