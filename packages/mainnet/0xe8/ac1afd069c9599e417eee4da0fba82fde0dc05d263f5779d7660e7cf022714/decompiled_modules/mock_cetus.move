module 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::mock_cetus {
    struct MockCetusPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        token_a_amount: u64,
        token_b_amount: u64,
    }

    public fun amount_a<T0, T1>(arg0: &MockCetusPosition<T0, T1>) : u64 {
        arg0.token_a_amount
    }

    public fun amount_b<T0, T1>(arg0: &MockCetusPosition<T0, T1>) : u64 {
        arg0.token_b_amount
    }

    public fun calculate_cetus_position_value<T0, T1>(arg0: &MockCetusPosition<T0, T1>, arg1: &0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : u256 {
        0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((arg0.token_a_amount as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) + 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_utils::mul_with_oracle_price((arg0.token_b_amount as u256), 0xe8ac1afd069c9599e417eee4da0fba82fde0dc05d263f5779d7660e7cf022714::vault_oracle::get_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun create_mock_position<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : MockCetusPosition<T0, T1> {
        MockCetusPosition<T0, T1>{
            id             : 0x2::object::new(arg0),
            coin_type_a    : 0x1::type_name::get<T0>(),
            coin_type_b    : 0x1::type_name::get<T1>(),
            token_a_amount : 0,
            token_b_amount : 0,
        }
    }

    public fun set_token_amount<T0, T1>(arg0: &mut MockCetusPosition<T0, T1>, arg1: u64, arg2: u64) {
        arg0.token_a_amount = arg1;
        arg0.token_b_amount = arg2;
    }

    // decompiled from Move bytecode v6
}

