module 0xbb96386e0846c3375de22c6918c0ba7019c5ae42589ec9c841cc92041272b5eb::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0xbc803f9c6a465ed476086142f51729f0c9643efcebebd0423944fe625918dd73];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0xbc803f9c6a465ed476086142f51729f0c9643efcebebd0423944fe625918dd73]
    }

    public fun get_owner() : address {
        @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922
    }

    // decompiled from Move bytecode v6
}

