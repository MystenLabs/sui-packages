module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::policy_allowlist {
    public fun seal_approve(arg0: &0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form, arg1: address) : bool {
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::is_admin(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

