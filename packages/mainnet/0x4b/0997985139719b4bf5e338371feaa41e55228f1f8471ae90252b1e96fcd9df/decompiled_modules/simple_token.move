module 0x4b0997985139719b4bf5e338371feaa41e55228f1f8471ae90252b1e96fcd9df::simple_token {
    struct Token has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public entry fun create_and_transfer_token(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        transfer_token(create_token(arg0, arg2), arg1);
    }

    public fun create_token(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Token {
        assert!(arg0 > 0, 1);
        Token{
            id    : 0x2::object::new(arg1),
            value : arg0,
        }
    }

    public fun transfer_token(arg0: Token, arg1: address) {
        0x2::transfer::transfer<Token>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

