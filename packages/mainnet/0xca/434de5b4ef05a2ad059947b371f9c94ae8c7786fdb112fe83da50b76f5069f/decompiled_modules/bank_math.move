module 0xca434de5b4ef05a2ad059947b371f9c94ae8c7786fdb112fe83da50b76f5069f::bank_math {
    public(friend) fun assert_output(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 + arg1 >= arg2, 0);
    }

    public(friend) fun compute_amount_to_deploy(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u128) * ((arg0 + arg1) as u128) / 10000 - (arg1 as u128)) as u64)
    }

    public(friend) fun compute_amount_to_recall(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg2 - (((arg3 as u128) * ((arg0 + arg2 - arg1) as u128) / 10000) as u64)
    }

    public(friend) fun compute_recall_for_pending_withdraw(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert_output(arg0, arg2, arg1);
        if (arg1 > arg0 || (compute_utilisation_bps(arg0 - arg1, arg2) as u64) > arg3 + arg4) {
            return compute_amount_to_recall(arg0, arg1, arg2, arg3)
        };
        0
    }

    public(friend) fun compute_utilisation_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 + arg1 > 0, 1);
        (((arg1 as u128) * 10000 / ((arg0 + arg1) as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

