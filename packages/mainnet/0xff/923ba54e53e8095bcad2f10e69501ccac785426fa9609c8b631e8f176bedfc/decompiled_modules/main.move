module 0xff923ba54e53e8095bcad2f10e69501ccac785426fa9609c8b631e8f176bedfc::main {
    struct ReceiptTokenPrice has copy, drop {
        rate: u64,
        deposit_token_price: u128,
        receipt_token_price: u128,
    }

    public fun base_div(arg0: u128, arg1: u128) : u128 {
        arg0 * 1000000000 / arg1
    }

    fun get_oracle_base(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 600);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u128)
    }

    fun get_oracle_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, 600);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128)
    }

    public fun get_pyth_oracle_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u128 {
        base_div(get_oracle_price(arg0, arg1), (0x1::u128::pow(10, (get_oracle_base(arg0, arg1) as u8)) as u128))
    }

    entry fun get_receipt_token_price<T0, T1>(arg0: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_vault_rate<T0, T1>(arg0);
        let v1 = get_pyth_oracle_price(arg1, arg2);
        let v2 = ReceiptTokenPrice{
            rate                : v0,
            deposit_token_price : v1,
            receipt_token_price : base_div(v1, (v0 as u128)),
        };
        0x2::event::emit<ReceiptTokenPrice>(v2);
    }

    public fun safe_cast_u128_to_u64(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            0
        } else {
            (arg0 as u64)
        }
    }

    public fun safe_cast_u128_to_u64_with_default(arg0: u128, arg1: u64) : u64 {
        if (arg0 > 18446744073709551615) {
            arg1
        } else {
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

