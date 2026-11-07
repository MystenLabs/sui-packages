module 0x8071c8b619162782768749ee2e89694140a7fda8ad791b57b07363949c45be50::lwap_orders_guard {
    public fun assert_avg_fill_within(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionSummary, arg1: bool, arg2: u256) {
        let (v0, v1) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::filled_base_and_quote(arg0, arg1);
        assert_avg_fill_within_amounts(v0, v1, arg1, arg2);
    }

    public(friend) fun assert_avg_fill_within_amounts(arg0: u256, arg1: u256, arg2: bool, arg3: u256) {
        assert!(arg3 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 7101);
        if (arg0 == 0) {
            return
        };
        let v0 = arg1 * 1000000000000000000;
        if (arg2 == true) {
            assert!(v0 / arg0 >= arg3, 7100);
        } else {
            let v1 = if (v0 % arg0 == 0) {
                v0 / arg0
            } else {
                v0 / arg0 + 1
            };
            assert!(v1 <= arg3, 7100);
        };
    }

    // decompiled from Move bytecode v7
}

