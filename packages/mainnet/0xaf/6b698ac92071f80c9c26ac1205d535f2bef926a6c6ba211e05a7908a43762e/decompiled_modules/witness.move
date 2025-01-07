module 0xaf6b698ac92071f80c9c26ac1205d535f2bef926a6c6ba211e05a7908a43762e::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x48d3daabc09550916c9a9b043130a4b019d910e4b7b1511786cd2a942edea58a, @0xfb2e3af00c510c2814f59d60349a9d5a20785583a3f6410122a0783a4fc3695b, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0x63654a8f1083a71c6f1fa3d2b8f13c97e38bbfc0070884232229be282663587d];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x48d3daabc09550916c9a9b043130a4b019d910e4b7b1511786cd2a942edea58a, @0xfb2e3af00c510c2814f59d60349a9d5a20785583a3f6410122a0783a4fc3695b, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0x63654a8f1083a71c6f1fa3d2b8f13c97e38bbfc0070884232229be282663587d]
    }

    // decompiled from Move bytecode v6
}

