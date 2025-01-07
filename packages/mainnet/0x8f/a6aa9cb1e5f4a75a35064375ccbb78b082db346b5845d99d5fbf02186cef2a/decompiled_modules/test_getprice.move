module 0x8fa6aa9cb1e5f4a75a35064375ccbb78b082db346b5845d99d5fbf02186cef2a::test_getprice {
    struct DebtorInfo has copy, drop {
        price: u64,
        precision: u64,
    }

    public entry fun getprice_sui(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0x2::clock::Clock, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        0x8fa6aa9cb1e5f4a75a35064375ccbb78b082db346b5845d99d5fbf02186cef2a::update_price::update_price_sui(arg0, arg1, arg2, arg3);
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<0x2::sui::SUI>(arg0, arg1);
        let v2 = DebtorInfo{
            price     : v0,
            precision : v1,
        };
        0x2::event::emit<DebtorInfo>(v2);
    }

    // decompiled from Move bytecode v6
}

