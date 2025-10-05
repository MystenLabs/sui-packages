module 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::validation {
    public fun validate_borrow<T0>(arg0: &mut 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_coin_type(arg0, arg1), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_coin_type());
        assert!(arg2 != 0, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_amount());
        let (v0, v1) = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_index(arg0, arg1);
        let v4 = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray_mul(v0, v2);
        let v5 = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray_mul(v1, v3);
        assert!(v5 + arg2 < v4, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::insufficient_balance());
        assert!(0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray_div(v5 + arg2, v4), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::exceeded_maximum_borrow_cap());
    }

    public fun validate_deposit<T0>(arg0: &mut 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_coin_type(arg0, arg1), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_coin_type());
        assert!(arg2 != 0, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_amount());
        let (v0, _) = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_total_supply(arg0, arg1);
        let (v2, _) = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_index(arg0, arg1);
        assert!(0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_supply_cap_ceiling(arg0, arg1) >= (0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray_mul(v0, v2) + arg2) * 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray(), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::exceeded_maximum_deposit_cap());
    }

    public fun validate_liquidate<T0, T1>(arg0: &mut 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::Storage, arg1: u8, arg2: u8, arg3: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_coin_type(arg0, arg1), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_coin_type());
        assert!(0x1::type_name::into_string(0x1::type_name::get<T1>()) == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_coin_type(arg0, arg2), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_coin_type());
        assert!(arg3 != 0, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_amount());
    }

    public fun validate_repay<T0>(arg0: &mut 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_coin_type(arg0, arg1), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_coin_type());
        assert!(arg2 != 0, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_amount());
    }

    public fun validate_withdraw<T0>(arg0: &mut 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::Storage, arg1: u8, arg2: u256) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_coin_type(arg0, arg1), 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_coin_type());
        assert!(arg2 != 0, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::invalid_amount());
        let (v0, v1) = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::storage::get_index(arg0, arg1);
        assert!(0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray_mul(v0, v2) >= 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::ray_math::ray_mul(v1, v3) + arg2, 0x1b2c86418de6e6626eacf219f95a0da0b07ee857134a746d05ec6728a030db24::error::insufficient_balance());
    }

    // decompiled from Move bytecode v6
}

