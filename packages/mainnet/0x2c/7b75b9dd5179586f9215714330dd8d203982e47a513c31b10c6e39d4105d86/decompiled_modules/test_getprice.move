module 0x2c7b75b9dd5179586f9215714330dd8d203982e47a513c31b10c6e39d4105d86::test_getprice {
    struct DebtorInfo has copy, drop {
        price: u64,
        precision: u64,
    }

    public fun emit_debtor_info<T0>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg0, arg1);
        let v2 = DebtorInfo{
            price     : v0,
            precision : v1,
        };
        0x2::event::emit<DebtorInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

