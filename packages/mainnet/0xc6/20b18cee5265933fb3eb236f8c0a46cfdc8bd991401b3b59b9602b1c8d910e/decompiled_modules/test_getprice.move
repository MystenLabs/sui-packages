module 0xc620b18cee5265933fb3eb236f8c0a46cfdc8bd991401b3b59b9602b1c8d910e::test_getprice {
    struct DebtorInfo has copy, drop {
        price: u64,
        precision: u64,
    }

    public entry fun emit_debtor_info<T0>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock) {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg0, arg1);
        let v2 = DebtorInfo{
            price     : v0,
            precision : v1,
        };
        0x2::event::emit<DebtorInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

