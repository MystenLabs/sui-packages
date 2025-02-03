module 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::interest_config {
    struct InterestConfig has copy, store {
        rate: 0x1::fixed_point32::FixedPoint32,
        rate_level: u64,
        factor: u64,
        updated_at: u64,
    }

    public(friend) fun add_coin_interest_config<T0>(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig>, arg1: 0x1::fixed_point32::FixedPoint32, arg2: u64, arg3: u64) {
        let v0 = InterestConfig{
            rate       : arg1,
            rate_level : arg2,
            factor     : 0x2::math::pow(10, 9),
            updated_at : arg3,
        };
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::add_key_value_pair<0x1::type_name::TypeName, InterestConfig>(arg0, 0x1::type_name::get<T0>(), v0);
    }

    public fun get_coin_factor(arg0: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig>, arg1: 0x1::type_name::TypeName) : u64 {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, InterestConfig>(arg0, arg1).factor
    }

    public fun get_coin_rate<T0>(arg0: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig>) : 0x1::fixed_point32::FixedPoint32 {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, InterestConfig>(arg0, 0x1::type_name::get<T0>()).rate
    }

    public fun get_coin_updated_at(arg0: &0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig>, arg1: 0x1::type_name::TypeName) : u64 {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_table<0x1::type_name::TypeName, InterestConfig>(arg0, arg1).updated_at
    }

    public fun get_factor(arg0: &InterestConfig) : u64 {
        arg0.factor
    }

    public fun get_rate(arg0: &InterestConfig) : 0x1::fixed_point32::FixedPoint32 {
        arg0.rate
    }

    public fun get_rate_level(arg0: &InterestConfig) : u64 {
        arg0.rate_level
    }

    public fun get_updated_at(arg0: &InterestConfig) : u64 {
        arg0.updated_at
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig> {
        0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::new<0x1::type_name::TypeName, InterestConfig>(arg0)
    }

    public(friend) fun set_coin_factor(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_mut_table<0x1::type_name::TypeName, InterestConfig>(arg0, arg1);
        if (v0.updated_at == arg2) {
            return
        };
        v0.factor = v0.factor + 0x1::fixed_point32::multiply_u64(v0.factor, 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::product(0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::f32::convert_from_u64(arg2 - v0.updated_at), v0.rate)) / v0.rate_level;
        v0.updated_at = arg2;
    }

    public(friend) fun set_coin_rate(arg0: &mut 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::TableKeys<0x1::type_name::TypeName, InterestConfig>, arg1: 0x1::type_name::TypeName, arg2: 0x1::fixed_point32::FixedPoint32, arg3: u64) {
        let v0 = 0x5c7f13d26fc5827c5e540537941de6e95f9a1b162ace0ea8d184afbe14a59547::table_keys::borrow_mut_table<0x1::type_name::TypeName, InterestConfig>(arg0, arg1);
        v0.rate = arg2;
        v0.rate_level = arg3;
    }

    // decompiled from Move bytecode v6
}

