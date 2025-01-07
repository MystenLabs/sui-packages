module 0x1a8a07592c0140d60cfd770d0d14ef62c8b7bc69d3b752e3109e52bf7cd0da12::owner {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0xc059126eb221e862600f83206dadd8bc631900417c75a158ebee67b8d1e26704, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0xdfbbf3c6fc87d1118097add687ba791d0b6ccde2e02c9eeabcf19db2829d9adb];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0xc059126eb221e862600f83206dadd8bc631900417c75a158ebee67b8d1e26704, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0xdfbbf3c6fc87d1118097add687ba791d0b6ccde2e02c9eeabcf19db2829d9adb]
    }

    public fun get_owner() : address {
        @0xdfbbf3c6fc87d1118097add687ba791d0b6ccde2e02c9eeabcf19db2829d9adb
    }

    // decompiled from Move bytecode v6
}

