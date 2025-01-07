module 0xa404295c27e817d074d623d547c9d8f8711eb06ba1300676d7d9f58662fd0dda::move2024 {
    struct UpdateEvent has copy, drop {
        value: u128,
        timestamp: u64,
    }

    public fun example_move2024(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) {
        let v0 = 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::current_result(arg0);
        let v1 = UpdateEvent{
            value     : 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::decimal::value(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::result(v0)),
            timestamp : 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::min_timestamp_ms(v0),
        };
        0x2::event::emit<UpdateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

