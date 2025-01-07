module 0x750609092b363433b91782dc611688edb1249a93c2616a1971aa3a6c3bd3c0b7::DeerBucks {
    struct Token has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        decimals: u8,
        total_supply: u64,
        remaining_supply: u64,
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64) : Token {
        Token{
            id               : 0x2::object::new(arg0),
            name             : arg1,
            symbol           : arg2,
            description      : arg3,
            decimals         : arg4,
            total_supply     : arg5,
            remaining_supply : arg5,
        }
    }

    public fun remaining_supply(arg0: &Token) : u64 {
        arg0.remaining_supply
    }

    public fun total_supply(arg0: &Token) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

