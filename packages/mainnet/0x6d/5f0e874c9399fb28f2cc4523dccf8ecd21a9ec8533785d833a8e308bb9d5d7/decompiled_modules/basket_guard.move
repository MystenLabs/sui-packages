module 0x6d5f0e874c9399fb28f2cc4523dccf8ecd21a9ec8533785d833a8e308bb9d5d7::basket_guard {
    public fun assert_filled(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::SessionSummary, arg1: bool, arg2: u64) {
        assert_filled_amount(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_bid(arg0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::base_filled_ask(arg0), arg1, arg2);
    }

    public(friend) fun assert_filled_amount(arg0: u256, arg1: u256, arg2: bool, arg3: u64) {
        let v0 = if (arg2 == true) {
            arg1
        } else {
            arg0
        };
        assert!(v0 >= (arg3 as u256) * 1000000000, 7000);
    }

    // decompiled from Move bytecode v7
}

