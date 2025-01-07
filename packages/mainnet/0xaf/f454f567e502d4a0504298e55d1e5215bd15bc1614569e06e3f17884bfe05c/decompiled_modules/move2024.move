module 0xaff454f567e502d4a0504298e55d1e5215bd15bc1614569e06e3f17884bfe05c::move2024 {
    struct UpdateEvent has copy, drop {
        value: u128,
        timestamp: u64,
    }

    public fun example_move2024(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::Aggregator) {
        let v0 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::current_result(arg0);
        let v1 = UpdateEvent{
            value     : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::value(0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::result(v0)),
            timestamp : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::min_timestamp_ms(v0),
        };
        0x2::event::emit<UpdateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

