module 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::validation {
    public fun validate_borrow(arg0: &mut 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::get_total_supply(arg0, arg1);
        assert!(v1 + (arg2 as u256) < v0, 44006);
        assert!(0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray_div(v1 + (arg2 as u256), v0), 44005);
    }

    public fun validate_deposit(arg0: &mut 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::get_total_supply(arg0, arg1);
        assert!(0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::get_supply_cap_ceiling(arg0, arg1) >= (v0 + (arg2 as u256)) * 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::ray_math::ray(), 44004);
    }

    public fun validate_liquidate(arg0: &mut 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_repay(arg0: &mut 0x3029c1fcf34899b5e20824aa6cbb8fec07de3c5ab9a317d676db273a26d0dbd2::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    // decompiled from Move bytecode v6
}

