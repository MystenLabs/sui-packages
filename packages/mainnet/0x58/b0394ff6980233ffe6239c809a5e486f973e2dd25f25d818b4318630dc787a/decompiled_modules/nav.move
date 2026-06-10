module 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::nav {
    public(friend) fun share_price_scaled<T0>(arg0: &0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>) : u128 {
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::share_price_scaled(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::total_shares<T0>(arg0), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::last_reported_nav_scaled<T0>(arg0))
    }

    fun crystallize_performance_fee<T0>(arg0: &mut 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>, arg1: &0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::registry::VaultRegistry, arg2: u128, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::total_shares<T0>(arg0);
        if (v0 == 0 || arg2 == 0) {
            return
        };
        let v1 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::high_water_mark_scaled<T0>(arg0);
        if (0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::share_price_scaled(v0, arg2) <= v1) {
            return
        };
        let v2 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::mul_div(v1, v0, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::shares_scale());
        if (arg2 <= v2) {
            return
        };
        let v3 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::mul_div(arg2 - v2, (0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::performance_fee_bps<T0>(arg0) as u128), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::bps_denominator());
        if (v3 == 0) {
            return
        };
        if (arg2 <= v3) {
            return
        };
        let v4 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::mul_div(v3, v0, arg2 - v3);
        if (v4 == 0) {
            return
        };
        let v5 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::mul_div(v4, (0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::registry::protocol_fee_bps(arg1) as u128), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::bps_denominator());
        let v6 = v4 - v5;
        if (v6 > 0) {
            0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::accrue_fee_shares_to<T0>(arg0, 0, v6);
        };
        if (v5 > 0) {
            0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::accrue_fee_shares_to<T0>(arg0, 1, v5);
        };
        let v7 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::share_price_scaled(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::total_shares<T0>(arg0), arg2);
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::set_high_water_mark<T0>(arg0, v7);
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_performance_fee(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_performance_fee(0x2::object::id<0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>>(arg0), v6, v5, v7, arg3));
    }

    public entry fun report_nav<T0>(arg0: &mut 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>, arg1: &0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::registry::VaultRegistry, arg2: u128, arg3: u128, arg4: u128, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::assert_registry_active<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg7) == 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::oracle_authority<T0>(arg0), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::not_oracle_authority());
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 > 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::last_nav_timestamp_ms<T0>(arg0), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::nav_timestamp_not_monotonic());
        let v1 = (0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::idle_usdc_value<T0>(arg0) as u128);
        let v2 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::usdc_to_nav_scaled(v1 + arg2 + arg3 + arg4);
        assert!(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::deviation_within_bps(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::last_reported_nav_scaled<T0>(arg0), v2, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::nav_deviation_bps_per_update<T0>(arg0)), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::nav_deviation_exceeded());
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::accrue_management_fee_internal<T0>(arg0, arg6, arg7);
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::set_nav_components<T0>(arg0, v2, arg2, arg3, arg4, v0);
        crystallize_performance_fee<T0>(arg0, arg1, v2, v0, arg7);
        if (0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::is_ramping<T0>(arg0) != arg5) {
            0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::set_ramping<T0>(arg0, arg5);
            0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_ramping_flipped(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_ramping_flipped(0x2::object::id<0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>>(arg0), arg5, v0));
        };
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_nav_reported(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_nav_reported(0x2::object::id<0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>>(arg0), v2, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::share_price_scaled(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::total_shares<T0>(arg0), v2), v1, arg2, arg3, arg4, v0));
    }

    // decompiled from Move bytecode v7
}

