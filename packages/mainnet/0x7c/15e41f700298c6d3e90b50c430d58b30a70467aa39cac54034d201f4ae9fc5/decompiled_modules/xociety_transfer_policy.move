module 0x7c15e41f700298c6d3e90b50c430d58b30a70467aa39cac54034d201f4ae9fc5::xociety_transfer_policy {
    public fun create_policy_with_standard_royalty<T0: store + key>(arg0: &0x2::package::Publisher, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<T0>, 0x2::transfer_policy::TransferPolicyCap<T0>) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T0>(&mut v3, &v2, arg1, arg2);
        (v3, v2)
    }

    // decompiled from Move bytecode v6
}

