module 0x3044567506ec56ce6d2e9f1c36b141c4518fade2cab42dfd029af66681fa0671::liquidate {
    public fun liquidate<T0>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun claim_reward_non_entry2<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::IncentiveBal<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::claim_reward_non_entry<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun update_package_version2<T0>(arg0: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::AdminCap, arg1: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: u64) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::update_package_version<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

