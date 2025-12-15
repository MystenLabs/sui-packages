module 0x71f87e824caa08684bb018087c2fd2b07b1059065858729f8857d3c55d8e638f::Energy {
    struct Flux has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        solar: u64,
        reactor: u64,
        satellite: u64,
    }

    public fun Declaration(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Flux{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg4),
            solar        : arg1,
            reactor      : arg2,
            satellite    : arg3,
        };
        0x2::event::emit<Flux>(v0);
    }

    // decompiled from Move bytecode v6
}

