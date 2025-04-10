module 0x2d27e9476a6f8c37697aabc29a07ae1cbc1f601b3c3afe50ee0181d79693b07f::math_helper {
    public fun ageb_u128(arg0: u128, arg1: u128) {
        assert!(arg0 >= arg1, 2);
    }

    public fun ageb_u256(arg0: u256, arg1: u256) {
        assert!(arg0 >= arg1, 3);
    }

    public fun ageb_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    // decompiled from Move bytecode v6
}

