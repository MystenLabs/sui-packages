module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::bounty {
    public fun approve_response(arg0: &mut 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::WAL> {
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::approve_response(arg0, arg1, arg2)
    }

    public fun deposit(arg0: &mut 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form, arg1: 0x2::coin::Coin<0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::WAL>) {
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::deposit_bounty(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

