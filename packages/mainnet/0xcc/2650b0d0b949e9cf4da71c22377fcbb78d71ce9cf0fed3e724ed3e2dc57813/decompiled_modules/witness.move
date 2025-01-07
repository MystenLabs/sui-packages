module 0xcc2650b0d0b949e9cf4da71c22377fcbb78d71ce9cf0fed3e724ed3e2dc57813::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0xf8dada4dcff7fc584b894cdd21ce085908ff87981209eb33d84005c2d1d56e24, @0x127126d6bfd7b30df06b32fd1f21a8583796ac9ea5f085ff50c093afbcda22f4, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0xf8dada4dcff7fc584b894cdd21ce085908ff87981209eb33d84005c2d1d56e24, @0x127126d6bfd7b30df06b32fd1f21a8583796ac9ea5f085ff50c093afbcda22f4, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922]
    }

    // decompiled from Move bytecode v6
}

