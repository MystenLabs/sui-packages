module 0x3b848d34b60087ecbbb70631126b08b9a13a212537eac0386826cbe4fc70fa46::legacy {
    struct UpdateEvent has copy, drop {
        value: u128,
        timestamp: u64,
    }

    public fun example_legacy(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) {
        let v0 = 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::current_result(arg0);
        let v1 = UpdateEvent{
            value     : 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::decimal::value(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::result(v0)),
            timestamp : 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::min_timestamp_ms(v0),
        };
        0x2::event::emit<UpdateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

