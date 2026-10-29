module 0xa7397ceb1e6ba129bad0ddc1217bbc12b3556029e91489624e09e1bc43e862e2::trade_checks {
    public fun validate(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128) {
        assert!(arg0 > 0, 1);
        assert!(arg0 < arg1, 2);
        assert!(arg6 > 0, 10);
        assert!(arg2 > 0, 11);
        assert!(arg7 > 0, 12);
        assert!(arg8 > 0, 13);
        assert!(arg8 < 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint(), 14);
        assert!(arg3 > 0, 18);
        assert!(arg3 < arg4 && arg3 < arg5, 17);
    }

    public fun verify_min_max_price(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg2 >= arg0, 3);
        assert!(arg2 <= arg1, 4);
    }

    public fun verify_mtb(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: bool) {
        if (arg4) {
            assert!(arg2 <= arg3 + 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg3, arg0), 23);
        } else {
            assert!(arg2 >= arg3 - 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_mul(arg3, arg1), 24);
        };
    }

    public fun verify_oi_open(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u64, arg4: bool) {
        let v0 = 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_div(0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint(), arg1);
        let v1 = if (v0 % 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint() > 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::half_base_uint()) {
            0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::ceil(v0, 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint())
        } else {
            v0 / 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint() * 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint()
        };
        let v2 = v1 / 0x563807d1621a032da5ab08e37d15236c1eca2b7e4319191b5ec8dc83251d5c41::math::base_uint();
        assert!((v2 as u64) < 0x1::vector::length<u128>(arg0), arg3 + 40);
        let v3 = *0x1::vector::borrow<u128>(arg0, (v2 as u64));
        let v4 = v3;
        if (arg4) {
            v4 = v3 * 5;
        };
        assert!(arg2 <= v4, arg3 + 25);
    }

    public fun verify_price(arg0: u128, arg1: u128, arg2: u128, arg3: u128) {
        verify_min_max_price(arg0, arg1, arg3);
        assert!(arg3 % arg2 == 0, 5);
    }

    public fun verify_qty(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: bool) {
        assert!(arg4 >= arg0, 19);
        assert!(arg4 <= arg1, 20);
        if (arg5) {
            assert!(arg4 <= arg2, 21);
        };
        assert!(arg4 % arg3 == 0, 22);
    }

    public fun verify_qty_liquidation(arg0: u128, arg1: u128, arg2: u128) {
        assert!(arg2 >= arg0, 19);
        assert!(arg2 % arg1 == 0, 22);
    }

    // decompiled from Move bytecode v7
}

