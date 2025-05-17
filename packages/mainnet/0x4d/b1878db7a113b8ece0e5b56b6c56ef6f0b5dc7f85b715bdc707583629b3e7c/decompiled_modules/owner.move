module 0xeb294b9401a7b6df0000b9f4cb67322d0fcdd12dd05ef9bd28529d41dbf07d22::owner {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x36685e6637aaa174a417d5c0c1d9bad609660c2386bf70923a307b4f24931564, @0x79a6b1ff95be95f09e80f56eac42c0234ff46ad6f25e5c0ff977ff3fe0e6e178, @0x16f104612be1a7ba1799895bc54e1f5c930869058ca7a16cbb1d34a0987b9148, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x36685e6637aaa174a417d5c0c1d9bad609660c2386bf70923a307b4f24931564, @0x79a6b1ff95be95f09e80f56eac42c0234ff46ad6f25e5c0ff977ff3fe0e6e178, @0x16f104612be1a7ba1799895bc54e1f5c930869058ca7a16cbb1d34a0987b9148, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922]
    }

    // decompiled from Move bytecode v6
}

