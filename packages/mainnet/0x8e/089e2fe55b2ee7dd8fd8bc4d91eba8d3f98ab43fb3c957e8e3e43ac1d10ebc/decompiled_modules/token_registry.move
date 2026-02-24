module 0x8e089e2fe55b2ee7dd8fd8bc4d91eba8d3f98ab43fb3c957e8e3e43ac1d10ebc::token_registry {
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

