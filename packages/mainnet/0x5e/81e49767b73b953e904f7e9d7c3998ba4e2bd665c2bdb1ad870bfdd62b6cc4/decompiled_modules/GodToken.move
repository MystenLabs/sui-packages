module 0x5e81e49767b73b953e904f7e9d7c3998ba4e2bd665c2bdb1ad870bfdd62b6cc4::GodToken {
    struct GodToken has store, key {
        id: 0x2::object::UID,
        balance: u64,
        total_supply: u64,
    }

    public fun initialize_token(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : GodToken {
        GodToken{
            id           : 0x2::object::new(arg1),
            balance      : arg0,
            total_supply : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

