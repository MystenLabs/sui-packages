module 0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::proof_policy {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, bool>(v0, arg0, arg1, true);
    }

    public fun prove<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(0x2::transfer_policy::has_rule<T0, Rule>(arg0), 0);
        assert!(0xeb50689d6f268416d4861bc529ca79746dc0117ce11cb00a754b1ac082056170::verifier::verify_proof(arg2, arg3, arg4) == true, 1);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

