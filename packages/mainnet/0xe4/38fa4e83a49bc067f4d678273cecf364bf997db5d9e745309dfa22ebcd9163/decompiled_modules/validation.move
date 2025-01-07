module 0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::validation {
    public fun validate_borrow(arg0: &mut 0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::storage::get_total_supply(arg0, arg1);
        assert!(0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0xf62046a601d34fe8b0b567d91652a8620a4f8ccf0da4bd6b501553c50571f35c::ray_math::ray_div(v1 + (arg2 as u256), v0 + v1), 44004);
    }

    public fun validate_deposit(arg0: &mut 0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::storage::get_total_supply(arg0, arg1);
        assert!(0xe438fa4e83a49bc067f4d678273cecf364bf997db5d9e745309dfa22ebcd9163::storage::get_supply_cap_ceiling(arg0, arg1) >= v0 + (arg2 as u256), 44004);
    }

    // decompiled from Move bytecode v6
}

