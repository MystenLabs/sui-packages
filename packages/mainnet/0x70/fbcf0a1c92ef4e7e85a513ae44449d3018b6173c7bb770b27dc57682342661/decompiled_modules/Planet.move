module 0x70fbcf0a1c92ef4e7e85a513ae44449d3018b6173c7bb770b27dc57682342661::Planet {
    struct Catalyst has copy, drop {
        player: address,
        ghost_operator: address,
        operator_version: u64,
        proof: u64,
    }

    struct Inhabitor has copy, drop {
        player: address,
        proof: u64,
        diameter: u64,
        gravity: u64,
        temp_min: u64,
        temp_max: u64,
        day_length: u64,
    }

    public fun Genesis(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Catalyst{
            player           : 0x2::tx_context::sender(arg3),
            ghost_operator   : arg0,
            operator_version : arg1,
            proof            : arg2,
        };
        0x2::event::emit<Catalyst>(v0);
    }

    public fun Habitation(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Inhabitor{
            player     : 0x2::tx_context::sender(arg6),
            proof      : arg0,
            diameter   : arg1,
            gravity    : arg2,
            temp_min   : arg3,
            temp_max   : arg4,
            day_length : arg5,
        };
        0x2::event::emit<Inhabitor>(v0);
    }

    // decompiled from Move bytecode v6
}

