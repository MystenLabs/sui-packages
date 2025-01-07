module 0x81e6aae3e928834616437b68813bb5ffba17b9ad1d5212bfdd777a57fba87d81::update_price {
    public fun update_price_cetus(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock, arg2: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::update_price_from_supra<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg0, arg1, arg2, 93);
    }

    // decompiled from Move bytecode v6
}

