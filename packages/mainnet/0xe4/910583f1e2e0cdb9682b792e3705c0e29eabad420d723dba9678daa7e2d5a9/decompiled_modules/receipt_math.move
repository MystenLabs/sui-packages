module 0xe4910583f1e2e0cdb9682b792e3705c0e29eabad420d723dba9678daa7e2d5a9::receipt_math {
    public(friend) fun profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 >= arg1, 0);
        let v0 = arg0 - arg1;
        assert!(v0 >= arg2, 1);
        v0
    }

    // decompiled from Move bytecode v7
}

