module 0x32a06e67e9f0c2fdab8127e20a3c2282ae62ebfdec3f058d248c73c336ea44d8::witness {
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

