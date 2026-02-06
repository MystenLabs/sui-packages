module 0x110d9cd601eb1d31e24ddc1390ef4af9f1994df998ac51d5cc00c0a109ec14c::events {
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

    struct AliasLinked has copy, drop {
        user: address,
        alias: address,
    }

    struct AliasUnlinked has copy, drop {
        user: address,
        alias: address,
    }

    public(friend) fun emit_alias_linked(arg0: address, arg1: address) {
        let v0 = AliasLinked{
            user  : arg0,
            alias : arg1,
        };
        let v1 = Event<AliasLinked>{pos0: v0};
        0x2::event::emit<Event<AliasLinked>>(v1);
    }

    public(friend) fun emit_alias_unlinked(arg0: address, arg1: address) {
        let v0 = AliasUnlinked{
            user  : arg0,
            alias : arg1,
        };
        let v1 = Event<AliasUnlinked>{pos0: v0};
        0x2::event::emit<Event<AliasUnlinked>>(v1);
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

