module 0x97374512f7599704b7b9d66d5fcf7071c1f299c1691ef0db1956702e5045177a::Planet {
    struct Catalyst has copy, drop {
        player: address,
        ghost_operator: address,
        operator_level: u64,
    }

    public fun Genesis(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Catalyst{
            player         : 0x2::tx_context::sender(arg2),
            ghost_operator : arg0,
            operator_level : arg1,
        };
        0x2::event::emit<Catalyst>(v0);
    }

    // decompiled from Move bytecode v6
}

