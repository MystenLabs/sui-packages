module 0xa2db58e1eb25189471def3a3a2a0293087f9eb59da262f27c6a45240f91e011e::restricted_token {
    struct Token has key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun create_token(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Token {
        Token{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    public fun transfer_token(arg0: Token, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Token>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

