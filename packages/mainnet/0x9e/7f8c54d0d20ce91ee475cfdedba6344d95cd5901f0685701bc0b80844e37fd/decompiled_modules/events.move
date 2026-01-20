module 0x9e7f8c54d0d20ce91ee475cfdedba6344d95cd5901f0685701bc0b80844e37fd::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct SolanaLinked has copy, drop {
        pos0: address,
        pos1: vector<u8>,
    }

    struct EvmLinked has copy, drop {
        pos0: address,
        pos1: vector<u8>,
    }

    struct SolanaUnlinked has copy, drop {
        pos0: address,
        pos1: vector<u8>,
    }

    struct EvmUnlinked has copy, drop {
        pos0: address,
        pos1: vector<u8>,
    }

    public(friend) fun emit_evm_linked(arg0: address, arg1: vector<u8>) {
        let v0 = EvmLinked{
            pos0 : arg0,
            pos1 : arg1,
        };
        let v1 = Event<EvmLinked>{pos0: v0};
        0x2::event::emit<Event<EvmLinked>>(v1);
    }

    public(friend) fun emit_evm_unlinked(arg0: address, arg1: vector<u8>) {
        let v0 = EvmUnlinked{
            pos0 : arg0,
            pos1 : arg1,
        };
        let v1 = Event<EvmUnlinked>{pos0: v0};
        0x2::event::emit<Event<EvmUnlinked>>(v1);
    }

    public(friend) fun emit_solana_linked(arg0: address, arg1: vector<u8>) {
        let v0 = SolanaLinked{
            pos0 : arg0,
            pos1 : arg1,
        };
        let v1 = Event<SolanaLinked>{pos0: v0};
        0x2::event::emit<Event<SolanaLinked>>(v1);
    }

    public(friend) fun emit_solana_unlinked(arg0: address, arg1: vector<u8>) {
        let v0 = SolanaUnlinked{
            pos0 : arg0,
            pos1 : arg1,
        };
        let v1 = Event<SolanaUnlinked>{pos0: v0};
        0x2::event::emit<Event<SolanaUnlinked>>(v1);
    }

    // decompiled from Move bytecode v6
}

