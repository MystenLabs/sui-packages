module 0xa5c58872c76ea54f8711ac9b7a4d24f08502a6a4f39f8365fe4c1974697c46f7::c {
    public fun a<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 1);
    }

    public fun d<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x2::balance::destroy_zero<T0>(arg0);
    }

    // decompiled from Move bytecode v6
}

