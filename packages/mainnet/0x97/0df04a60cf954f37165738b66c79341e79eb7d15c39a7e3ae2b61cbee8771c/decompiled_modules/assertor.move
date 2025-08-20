module 0x970df04a60cf954f37165738b66c79341e79eb7d15c39a7e3ae2b61cbee8771c::assertor {
    public fun assert_house<T0>(arg0: &0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg1: u64) {
        assert!(arg1 > 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::house_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg0)), 1);
    }

    // decompiled from Move bytecode v6
}

