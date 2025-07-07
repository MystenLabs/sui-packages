module 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_pyth {
    public(friend) fun calc_amount_out(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg6, arg5);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg6, arg5);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v4);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5);
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v4);
        assert!(v2 > 0, 1000);
        assert!(v6 > 0, 1001);
        calc_amount_out_internal(v2, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8), arg2, v6, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v7) as u8), arg3, arg4)
    }

    public(friend) fun calc_amount_out_internal(arg0: u64, arg1: u8, arg2: u8, arg3: u64, arg4: u8, arg5: u8, arg6: u64) : u64 {
        let v0 = arg1 + arg2;
        let v1 = arg4 + arg5;
        let (v2, v3) = if (v0 >= v1) {
            (1, 0x1::u256::pow(10, v0 - v1))
        } else {
            (0x1::u256::pow(10, v1 - v0), 1)
        };
        (((arg6 as u256) * (arg0 as u256) * v2 / (arg3 as u256) * v3) as u64)
    }

    // decompiled from Move bytecode v6
}

