module 0x1a901a7bbbb2a315d0ce7319c4aa659385f0432d0efb1b76e68404efcf32a3c3::Teleport {
    struct Bridge has copy, drop {
        player_addr: address,
        chain: u32,
        addr: vector<u8>,
    }

    public fun Cross(arg0: u32, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge{
            player_addr : 0x2::tx_context::sender(arg2),
            chain       : arg0,
            addr        : arg1,
        };
        0x2::event::emit<Bridge>(v0);
    }

    // decompiled from Move bytecode v6
}

