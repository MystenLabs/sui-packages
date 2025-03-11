module 0xa959fd58a6c4ccda0c9b45051f66cc89bf6b5b0f58d06e156f2b87b7a7409e00::switchboard_adaptor {
    public fun get_switchboard_price(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) : (u128, u64) {
        let v0 = 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::current_result(arg0);
        let v1 = 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::result(v0);
        assert!(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::decimal::neg(v1) == false, 1);
        (0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::decimal::value(v1), 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::timestamp_ms(v0))
    }

    // decompiled from Move bytecode v6
}

