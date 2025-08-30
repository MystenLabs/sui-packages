module 0x12b82895ab660c2a8a1412d0e05c50ab204e190c7df0180e0566e7ae2e7fa641::bucket_adapter_event {
    struct BucketDepositEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct BucketWithdrawEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct BucketClaimEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun claim_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BucketClaimEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<BucketClaimEvent<T0>>(v0);
    }

    public fun deposit_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BucketDepositEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<BucketDepositEvent<T0>>(v0);
    }

    public fun withdraw_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BucketWithdrawEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<BucketWithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

