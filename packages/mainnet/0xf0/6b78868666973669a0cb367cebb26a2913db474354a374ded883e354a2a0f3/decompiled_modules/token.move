module 0xf06b78868666973669a0cb367cebb26a2913db474354a374ded883e354a2a0f3::token {
    struct BenchToken has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct TokenMinted has copy, drop {
        token_id: 0x2::object::ID,
        value: u64,
        to: address,
    }

    struct TokenBurned has copy, drop {
        token_id: 0x2::object::ID,
        value: u64,
    }

    public fun burn(arg0: BenchToken) {
        let BenchToken {
            id    : v0,
            value : v1,
        } = arg0;
        let v2 = v0;
        let v3 = TokenBurned{
            token_id : 0x2::object::uid_to_inner(&v2),
            value    : v1,
        };
        0x2::event::emit<TokenBurned>(v3);
        0x2::object::delete(v2);
    }

    public fun mint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BenchToken{
            id    : 0x2::object::new(arg1),
            value : arg0,
        };
        let v1 = TokenMinted{
            token_id : 0x2::object::id<BenchToken>(&v0),
            value    : arg0,
            to       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenMinted>(v1);
        0x2::transfer::transfer<BenchToken>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun send(arg0: BenchToken, arg1: address) {
        0x2::transfer::transfer<BenchToken>(arg0, arg1);
    }

    public fun value(arg0: &BenchToken) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

