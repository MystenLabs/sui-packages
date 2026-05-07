module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::policy_token_gated {
    public fun seal_approve(arg0: address, arg1: u64) : bool {
        arg1 > 0
    }

    // decompiled from Move bytecode v7
}

