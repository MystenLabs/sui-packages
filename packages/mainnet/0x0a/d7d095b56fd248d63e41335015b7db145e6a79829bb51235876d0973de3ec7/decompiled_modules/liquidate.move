module 0xad7d095b56fd248d63e41335015b7db145e6a79829bb51235876d0973de3ec7::liquidate {
    public fun liquidate<T0>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun update_package_version2<T0>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::AdminCap, arg1: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: u64) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::update_package_version<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

