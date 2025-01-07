module 0x4433ab096a71cbcdf70183f465e613955526f321039d9a76be0bd98c5da75382::hasui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun rate_precision() : u64 {
        1000000
    }

    public fun update_price(arg0: &mut 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<0x2::sui::SUI>(arg0, arg2);
        let v2 = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::borrow_single_oracle_mut<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(arg0);
        let v3 = Rule{dummy_field: false};
        0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::update_oracle_price_with_rule<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI, Rule>(v2, v3, arg2, mul_and_div(0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::single_oracle::precision<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>(v2), mul_and_div(v0, 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1), rate_precision()), v1));
    }

    // decompiled from Move bytecode v6
}

