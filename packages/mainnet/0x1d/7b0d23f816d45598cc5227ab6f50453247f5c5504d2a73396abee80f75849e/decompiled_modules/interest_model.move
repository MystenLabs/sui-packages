module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::interest_model {
    struct InterestModel has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        rate_level: u64,
        min_loan_amount: u64,
        std_rate_per_sec: 0x1::fixed_point32::FixedPoint32,
        max_rate: 0x1::fixed_point32::FixedPoint32,
        mid_point: 0x1::fixed_point32::FixedPoint32,
        mid_point_rate: 0x1::fixed_point32::FixedPoint32,
        high_point: 0x1::fixed_point32::FixedPoint32,
        high_point_rate: 0x1::fixed_point32::FixedPoint32,
        accrual_amount_factor: 0x1::fixed_point32::FixedPoint32,
    }

    public(friend) fun add_interest_model<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::TableKeys<0x1::type_name::TypeName, InterestModel>) {
        assert!(arg3 <= arg5, 6000);
        assert!(arg4 <= arg6, 6002);
        assert!(arg6 <= arg7, 6003);
        assert!(arg2 <= arg4, 6001);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = InterestModel{
            coin_type             : v0,
            rate_level            : arg0,
            min_loan_amount       : arg1,
            std_rate_per_sec      : 0x1::fixed_point32::create_from_rational(arg2, arg9),
            max_rate              : 0x1::fixed_point32::create_from_rational(arg7, arg9),
            mid_point             : 0x1::fixed_point32::create_from_rational(arg3, arg9),
            mid_point_rate        : 0x1::fixed_point32::create_from_rational(arg4, arg9),
            high_point            : 0x1::fixed_point32::create_from_rational(arg5, arg9),
            high_point_rate       : 0x1::fixed_point32::create_from_rational(arg6, arg9),
            accrual_amount_factor : 0x1::fixed_point32::create_from_rational(arg8, arg9),
        };
        if (0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::is_present<0x1::type_name::TypeName, InterestModel>(arg10, v0)) {
            0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::delete<0x1::type_name::TypeName, InterestModel>(arg10, v0);
        };
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::add_key_value_pair<0x1::type_name::TypeName, InterestModel>(arg10, v0, v1);
    }

    public fun calculate_rate(arg0: &InterestModel, arg1: 0x1::fixed_point32::FixedPoint32) : (0x1::fixed_point32::FixedPoint32, u64) {
        let InterestModel {
            coin_type             : _,
            rate_level            : v1,
            min_loan_amount       : _,
            std_rate_per_sec      : v3,
            max_rate              : v4,
            mid_point             : v5,
            mid_point_rate        : v6,
            high_point            : v7,
            high_point_rate       : v8,
            accrual_amount_factor : _,
        } = *arg0;
        let v10 = if (0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::is_lesser_than_or_equal(arg1, v5)) {
            0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::sum(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::product(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::quotient(arg1, v5), 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(v6, v3)), v3)
        } else if (0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::is_lesser_than_or_equal(arg1, v7)) {
            0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::sum(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::product(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::quotient(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(arg1, v5), 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(v7, v5)), 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(v7, v5)), v6)
        } else {
            0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::sum(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::product(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::quotient(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(arg1, v7), 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::convert_from_u64(1), v7)), 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::f32::diff(v4, v8)), v8)
        };
        (v10, v1)
    }

    public fun get_accrual_amount_factor(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.accrual_amount_factor
    }

    public fun get_coin_type(arg0: &InterestModel) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun get_high_point(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.high_point
    }

    public fun get_high_point_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.high_point_rate
    }

    public fun get_max_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.max_rate
    }

    public fun get_mid_point(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.mid_point
    }

    public fun get_mid_point_rate(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.mid_point_rate
    }

    public fun get_min_loan_amount(arg0: &InterestModel) : u64 {
        arg0.min_loan_amount
    }

    public fun get_rate_level(arg0: &InterestModel) : u64 {
        arg0.rate_level
    }

    public fun get_std_rate_per_sec(arg0: &InterestModel) : 0x1::fixed_point32::FixedPoint32 {
        arg0.std_rate_per_sec
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) : 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::TableKeys<0x1::type_name::TypeName, InterestModel> {
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::table_keys::new<0x1::type_name::TypeName, InterestModel>(arg0)
    }

    // decompiled from Move bytecode v6
}

