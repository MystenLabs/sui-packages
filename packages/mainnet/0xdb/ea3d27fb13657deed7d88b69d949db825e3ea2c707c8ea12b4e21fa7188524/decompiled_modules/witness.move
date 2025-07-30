module 0xe9dbdcffd693470af302da6ed3d211862768d2b649746052b406c2518cc00fc0::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x48d3daabc09550916c9a9b043130a4b019d910e4b7b1511786cd2a942edea58a, @0xfb2e3af00c510c2814f59d60349a9d5a20785583a3f6410122a0783a4fc3695b, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0x16f104612be1a7ba1799895bc54e1f5c930869058ca7a16cbb1d34a0987b9148];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x48d3daabc09550916c9a9b043130a4b019d910e4b7b1511786cd2a942edea58a, @0xfb2e3af00c510c2814f59d60349a9d5a20785583a3f6410122a0783a4fc3695b, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922, @0x16f104612be1a7ba1799895bc54e1f5c930869058ca7a16cbb1d34a0987b9148]
    }

    // decompiled from Move bytecode v6
}

