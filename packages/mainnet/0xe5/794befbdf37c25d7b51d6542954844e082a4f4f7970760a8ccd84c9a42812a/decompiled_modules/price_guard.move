module 0xe5794befbdf37c25d7b51d6542954844e082a4f4f7970760a8ccd84c9a42812a::price_guard {
    public fun assert_deadline(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0, 2);
    }

    public fun assert_price(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1 > 0 && arg1 <= arg2, 0);
        assert_deadline(arg3, arg4);
        assert!(arg0 >= arg1 && arg0 <= arg2, 1);
    }

    // decompiled from Move bytecode v7
}

