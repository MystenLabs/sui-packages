module 0x1b0fc1c00112a7e58c00a96f7dc499257b32bd33c5a607e59b55278a4443bc31::Energy {
    struct Flux has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        solar: u64,
        reactor: u64,
        satellite: u64,
        proof: u64,
    }

    public fun Declaration(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Flux{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg5),
            solar        : arg1,
            reactor      : arg2,
            satellite    : arg3,
            proof        : arg4,
        };
        0x2::event::emit<Flux>(v0);
    }

    // decompiled from Move bytecode v6
}

