module 0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::auth {
    struct Auth<phantom T0, phantom T1> has drop {
        pos0: address,
    }

    public fun addr<T0, T1>(arg0: &Auth<T0, T1>) : address {
        arg0.pos0
    }

    public(friend) fun new<T0, T1: drop>(arg0: &0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::roles::Roles, arg1: address) : Auth<T0, T1> {
        assert!(0x3840f0fbf2cbe35894b7ae8c55a534c64a77fea85565826733353f22bae57a83::roles::has_role<T1>(arg0, arg1), 13835058239965757441);
        Auth<T0, T1>{pos0: arg1}
    }

    // decompiled from Move bytecode v7
}

