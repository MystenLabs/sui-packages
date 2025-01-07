module 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::validation {
    public fun validate_borrow(arg0: &mut 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::get_total_supply(arg0, arg1);
        let (v2, v3) = 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::get_index(arg0, arg1);
        let v4 = 0x7e0b56af1d17e3c7c45e9965e6a44345ae25a4a5918a8ee585d8e91475c4bc7::ray_math::ray_mul(v0, v2);
        let v5 = 0x7e0b56af1d17e3c7c45e9965e6a44345ae25a4a5918a8ee585d8e91475c4bc7::ray_math::ray_mul(v1, v3);
        assert!(v5 + (arg2 as u256) < v4, 44006);
        assert!(0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x7e0b56af1d17e3c7c45e9965e6a44345ae25a4a5918a8ee585d8e91475c4bc7::ray_math::ray_div(v5 + (arg2 as u256), v4), 44005);
    }

    public fun validate_deposit(arg0: &mut 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::get_total_supply(arg0, arg1);
        assert!(0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::get_supply_cap_ceiling(arg0, arg1) >= (v0 + (arg2 as u256)) * 0x7e0b56af1d17e3c7c45e9965e6a44345ae25a4a5918a8ee585d8e91475c4bc7::ray_math::ray(), 44004);
    }

    public fun validate_liquidate(arg0: &mut 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_repay(arg0: &mut 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_withdraw(arg0: &mut 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xd3f2ffd49eef54baacedd3139de035984b3c4ffe4c5d60c4ebd907cd80fbf09::storage::get_total_supply(arg0, arg1);
        assert!(v0 >= v1 + (arg2 as u256), 44006);
    }

    // decompiled from Move bytecode v6
}

