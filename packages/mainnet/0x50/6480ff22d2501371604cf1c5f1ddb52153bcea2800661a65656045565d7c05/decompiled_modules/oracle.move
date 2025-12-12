module 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::oracle {
    public fun get_price(arg0: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: u64) : u256 {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg3);
        0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price::newest_price_from_sources_above_confidence(arg0, arg1, v0, 0, arg4, true, arg2)
    }

    // decompiled from Move bytecode v6
}

