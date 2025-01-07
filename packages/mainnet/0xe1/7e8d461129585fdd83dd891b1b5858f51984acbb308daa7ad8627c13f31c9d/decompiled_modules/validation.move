module 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::validation {
    public fun validate_borrow(arg0: &mut 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::get_index(arg0, arg1);
        let v4 = 0xc6db883ff9207f42f4ea3ba98763bb517c2e37bd674eddd20c6c575f35954392::ray_math::ray_mul(v0, v2);
        let v5 = 0xc6db883ff9207f42f4ea3ba98763bb517c2e37bd674eddd20c6c575f35954392::ray_math::ray_mul(v1, v3);
        assert!(v5 + (arg2 as u256) < v4, 44006);
        assert!(0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0xc6db883ff9207f42f4ea3ba98763bb517c2e37bd674eddd20c6c575f35954392::ray_math::ray_div(v5 + (arg2 as u256), v4), 44005);
    }

    public fun validate_deposit(arg0: &mut 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::get_total_supply(arg0, arg1);
        assert!(0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::get_supply_cap_ceiling(arg0, arg1) >= (v0 + (arg2 as u256)) * 0xc6db883ff9207f42f4ea3ba98763bb517c2e37bd674eddd20c6c575f35954392::ray_math::ray(), 44004);
    }

    public fun validate_liquidate(arg0: &mut 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_repay(arg0: &mut 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_withdraw(arg0: &mut 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0x4ec66701891aea9d189b5dbf8c5258343bba705ea6081f5ee4d5823465b25a22::storage::get_total_supply(arg0, arg1);
        assert!(v0 >= v1 + (arg2 as u256), 44006);
    }

    // decompiled from Move bytecode v6
}

