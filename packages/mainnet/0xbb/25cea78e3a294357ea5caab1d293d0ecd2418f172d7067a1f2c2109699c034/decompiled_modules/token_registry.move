module 0xbb25cea78e3a294357ea5caab1d293d0ecd2418f172d7067a1f2c2109699c034::token_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        supply: u64,
        fee_bps: u16,
    }

    public entry fun create_token(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Token{
            id      : 0x2::object::new(arg4),
            creator : 0x2::tx_context::sender(arg4),
            name    : arg0,
            symbol  : arg1,
            supply  : arg2,
            fee_bps : arg3,
        };
        0x2::transfer::share_object<Token>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

