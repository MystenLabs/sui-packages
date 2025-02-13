module 0x81420bd3231c91485250a92bdd22bc00e645ed2f3688461eec1dff3d78708d9e::bank_math {
    public(friend) fun assert_output(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 + arg1 >= arg2, 1);
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
        assert!(arg0 + arg1 > 0, 2);
        arg1 * 10000 / (arg0 + arg1)
    }

    // decompiled from Move bytecode v6
}

