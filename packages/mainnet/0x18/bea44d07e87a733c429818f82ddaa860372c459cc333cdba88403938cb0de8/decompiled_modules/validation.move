module 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::validation {
    public fun validate_borrow(arg0: &mut 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::get_total_supply(arg0, arg1);
        assert!(v1 + (arg2 as u256) < v0, 44006);
        assert!(0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::get_borrow_cap_ceiling_ratio(arg0, arg1) >= 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray_div(v1 + (arg2 as u256), v0), 44005);
    }

    public fun validate_deposit(arg0: &mut 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, _) = 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::get_total_supply(arg0, arg1);
        assert!(0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::get_supply_cap_ceiling(arg0, arg1) >= (v0 + (arg2 as u256)) * 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray(), 44004);
    }

    public fun validate_liquidate(arg0: &mut 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_repay(arg0: &mut 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
    }

    public fun validate_withdraw(arg0: &mut 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::Storage, arg1: u8, arg2: u64) {
        assert!(arg2 != 0, 44001);
        let (v0, v1) = 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage::get_total_supply(arg0, arg1);
        assert!(v0 >= v1 + (arg2 as u256), 44006);
    }

    // decompiled from Move bytecode v6
}

