module 0x9a1854e6421ef2ef8c94babceb2999e9e08449d947f304db71dcc49996ab363e::cap {
    struct MintCap has key {
        id: 0x2::object::UID,
    }

    public fun burn_mint_cap(arg0: MintCap) {
        let MintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

