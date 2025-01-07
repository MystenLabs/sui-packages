module 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::validation {
    public fun validate_borrow(arg0: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::get_total_supply(arg0, arg1);
        assert!(v1 + (arg2 as u256) < v0, 44005);
        assert!(0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x9797ab8550aee44759adb138af7463822f032d9eda386cc49401cd5c1cb8db4a::ray_math::ray_div(v1 + (arg2 as u256), v0 + v1), 44004);
    }

    public fun validate_deposit(arg0: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::get_total_supply(arg0, arg1);
        assert!(0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::get_supply_cap_ceiling(arg0, arg1) >= v0 + (arg2 as u256), 44004);
    }

    public fun validate_liquidate(arg0: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_repay(arg0: &mut 0xe35f634b757251eca416105462c1da91b725d2a5119a7f78cad1683bfab160b4::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    // decompiled from Move bytecode v6
}

