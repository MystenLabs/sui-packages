module 0x84456b9b6500a638779ed4e92d7aea6cbd95f7105907262b79c78861944e8188::auth {
    struct Auth<phantom T0, phantom T1> has drop {
        pos0: address,
    }

    public fun addr<T0, T1>(arg0: &Auth<T0, T1>) : address {
        arg0.pos0
    }

    public(friend) fun new<T0, T1: drop>(arg0: &0x84456b9b6500a638779ed4e92d7aea6cbd95f7105907262b79c78861944e8188::roles::Roles, arg1: address) : Auth<T0, T1> {
        assert!(0x84456b9b6500a638779ed4e92d7aea6cbd95f7105907262b79c78861944e8188::roles::has_role<T1>(arg0, arg1), 13835058239965757441);
        Auth<T0, T1>{pos0: arg1}
    }

    // decompiled from Move bytecode v7
}

