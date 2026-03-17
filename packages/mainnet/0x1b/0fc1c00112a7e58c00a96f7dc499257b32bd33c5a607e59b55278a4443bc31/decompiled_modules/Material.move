module 0x1b0fc1c00112a7e58c00a96f7dc499257b32bd33c5a607e59b55278a4443bc31::Material {
    struct Capita has copy, drop {
        patarian_id: u64,
        phantom_addr: address,
        ferra: u64,
        cyra: u64,
        suistra: u64,
        proof: u64,
    }

    public fun Declaration(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Capita{
            patarian_id  : arg0,
            phantom_addr : 0x2::tx_context::sender(arg5),
            ferra        : arg1,
            cyra         : arg2,
            suistra      : arg3,
            proof        : arg4,
        };
        0x2::event::emit<Capita>(v0);
    }

    // decompiled from Move bytecode v6
}

