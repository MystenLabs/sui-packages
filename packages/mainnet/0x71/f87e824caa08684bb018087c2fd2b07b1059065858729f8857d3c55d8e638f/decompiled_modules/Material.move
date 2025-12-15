module 0x71f87e824caa08684bb018087c2fd2b07b1059065858729f8857d3c55d8e638f::Material {
    struct Capita has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        ferra: u64,
        cyra: u64,
        suistra: u64,
    }

    public fun Declaration(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Capita{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg4),
            ferra        : arg1,
            cyra         : arg2,
            suistra      : arg3,
        };
        0x2::event::emit<Capita>(v0);
    }

    // decompiled from Move bytecode v6
}

