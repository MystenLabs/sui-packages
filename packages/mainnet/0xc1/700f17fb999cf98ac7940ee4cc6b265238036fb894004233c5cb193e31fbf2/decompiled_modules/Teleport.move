module 0xc1700f17fb999cf98ac7940ee4cc6b265238036fb894004233c5cb193e31fbf2::Teleport {
    struct Bridge has copy, drop {
        player_addr: address,
        chain: vector<u8>,
        addr: vector<u8>,
    }

    public fun Cross(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Bridge{
            player_addr : 0x2::tx_context::sender(arg2),
            chain       : arg0,
            addr        : arg1,
        };
        0x2::event::emit<Bridge>(v0);
    }

    // decompiled from Move bytecode v6
}

