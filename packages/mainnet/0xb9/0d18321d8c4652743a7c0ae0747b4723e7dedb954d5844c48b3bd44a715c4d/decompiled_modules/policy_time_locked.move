module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::policy_time_locked {
    public fun seal_approve(arg0: &0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form, arg1: u64) : bool {
        let v0 = 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::close_epoch(arg0);
        0x1::option::is_some<u64>(&v0) && arg1 >= *0x1::option::borrow<u64>(&v0)
    }

    // decompiled from Move bytecode v7
}

