module 0xc05b6b646c0ec2da351584ab5d7e6c0d18c6ff7cb0551a42b8042a21625b0d3f::witness_rule {
    struct Rule<phantom T0: drop> has drop {
        dummy_field: bool,
    }

    public fun add<T0: store + key, T1: drop>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule<T1>{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule<T1>, bool>(v0, arg0, arg1, true);
    }

    public fun prove<T0: store + key, T1: drop>(arg0: T1, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::transfer_policy::has_rule<T0, Rule<T1>>(arg1), 0);
        let v0 = Rule<T1>{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule<T1>>(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

