module 0x62362520d413d202452c5ddf7e5f6945404af914c12c6b6c6ed0816d48bb28c::reader {
    public fun current<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: bool) : (u128, u128, u64, u64, u64, u64) {
        assert!(0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_pool_type<T0, T1>(arg0) == 100, 1);
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<T0, T1>(arg0);
        let v3 = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_direction<T0, T1>(arg0);
        assert!(v3 == 200 || v3 == 201, 2);
        let (v4, v5, v6, v7) = if (arg1 && v3 == 200 || v3 == 201) {
            let v8 = 1000000000000;
            (v8 - (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0)) * (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0)) * (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0)), v8, 0, 1)
        } else {
            let v9 = 100000000;
            (0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0), 10000, v9 - (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0)) * (10000 - 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0)), v9)
        };
        let (v10, v11) = if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        ((v10 as u128), (v11 as u128), v4, v5, v6, v7)
    }

    public fun current_stable<T0, T1>(arg0: &0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: bool) : (u64, u64, u64, u64, u64, u64, u64, u64, u8, u8, bool, u8) {
        let (v0, v1, _) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::get_amounts<T0, T1>(arg0);
        let (v3, v4, v5, v6) = if (arg1) {
            (v0, v1, 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_stable_x_scale<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_stable_y_scale<T0, T1>(arg0))
        } else {
            (v1, v0, 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_stable_y_scale<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_stable_x_scale<T0, T1>(arg0))
        };
        (v3, v4, v5, v6, 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_stable_amp<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_admin<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_lp<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_th<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_pool_type<T0, T1>(arg0), 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_fee_direction<T0, T1>(arg0), arg1, 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::pool_get_freeze<T0, T1>(arg0))
    }

    // decompiled from Move bytecode v7
}

