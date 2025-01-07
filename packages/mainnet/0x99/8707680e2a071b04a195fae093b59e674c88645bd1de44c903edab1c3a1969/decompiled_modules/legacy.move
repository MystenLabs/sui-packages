module 0x998707680e2a071b04a195fae093b59e674c88645bd1de44c903edab1c3a1969::legacy {
    struct UpdateEvent has copy, drop {
        value: u128,
        timestamp: u64,
    }

    public fun example_legacy(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::Aggregator) {
        let v0 = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::current_result(arg0);
        let v1 = UpdateEvent{
            value     : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::value(0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::result(v0)),
            timestamp : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::min_timestamp_ms(v0),
        };
        0x2::event::emit<UpdateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

