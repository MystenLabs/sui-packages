module 0x35e21f1c60b4972894c00f93e2e92b641ae861d7965690aa87f07881b401bcd9::switchboard_adaptor {
    public fun get_switchboard_price(arg0: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) : (u128, u64) {
        let v0 = 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::current_result(arg0);
        let v1 = 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::result(v0);
        assert!(0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::decimal::neg(v1) == false, 1);
        (0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::decimal::value(v1), 0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::timestamp_ms(v0))
    }

    // decompiled from Move bytecode v6
}

