module 0x965906ae23f812374687c269ec67bf3bb17bdc475049d91017824d309b0e124f::witness_rule_marketplace {
    struct Rule<phantom T0: drop> has drop {
        dummy_field: bool,
    }

    public fun add<T0, T1: drop>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule<T1>{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule<T1>, bool>(v0, arg0, arg1, true);
    }

    public fun confirm<T0, T1: drop>(arg0: T1, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        assert!(0x2::transfer_policy::has_rule<T0, Rule<T1>>(arg1), 9223372208653467649);
        let v0 = Rule<T1>{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule<T1>>(v0, arg2);
    }

    public fun remove<T0, T1: drop>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, Rule<T1>, bool>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

