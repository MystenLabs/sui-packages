module 0xf685083345809db413027dcba3bdd768e082028af7ed34456f9d4c94f0fe9b1c::Planet {
    struct Patarix has copy, drop {
        patarian: address,
        phantom: address,
        version: u64,
        proof: u64,
    }

    struct Patarian has copy, drop {
        id: u64,
        addr: address,
        proof: u64,
    }

    struct Phantom has copy, drop {
        patarian_id: u64,
        id: u64,
        addr: address,
        version: u64,
        proof: u64,
    }

    struct Pateron has copy, drop {
        id: u64,
        diameter: u64,
        gravity: u64,
        temp_min: u64,
        temp_max: u64,
        day_length: u64,
        proof: u64,
    }

    struct Settler has copy, drop {
        pateron_id: u64,
        patarian_id: u64,
        phantom_id: u64,
        proof: u64,
    }

    public fun EstablishPatarian(arg0: u64, arg1: address, arg2: u64) {
        let v0 = Patarian{
            id    : arg0,
            addr  : arg1,
            proof : arg2,
        };
        0x2::event::emit<Patarian>(v0);
    }

    public fun EstablishPateron(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = Pateron{
            id         : arg0,
            diameter   : arg1,
            gravity    : arg2,
            temp_min   : arg3,
            temp_max   : arg4,
            day_length : arg5,
            proof      : arg6,
        };
        0x2::event::emit<Pateron>(v0);
    }

    public fun EstablishPhantom(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Phantom{
            patarian_id : arg0,
            id          : arg1,
            addr        : 0x2::tx_context::sender(arg4),
            version     : arg2,
            proof       : arg3,
        };
        0x2::event::emit<Phantom>(v0);
    }

    public fun EstablishSettler(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = Settler{
            pateron_id  : arg0,
            patarian_id : arg1,
            phantom_id  : arg2,
            proof       : arg3,
        };
        0x2::event::emit<Settler>(v0);
    }

    public fun Genesis(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Patarix{
            patarian : 0x2::tx_context::sender(arg3),
            phantom  : arg0,
            version  : arg1,
            proof    : arg2,
        };
        0x2::event::emit<Patarix>(v0);
    }

    // decompiled from Move bytecode v6
}

