module 0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::percentage_math {
    fun percent_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1);
        let v0 = arg1 / 2;
        assert!(arg0 <= (0x2::address::max() - v0) / 10000, 1201);
        0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::safe_math::div(0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::safe_math::add(0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::safe_math::mul(arg0, 10000), v0), arg1)
    }

    public fun percent_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= (0x2::address::max() - 5000) / arg1, 1201);
        0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::safe_math::div(0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::safe_math::add(0xb15405910efec3c68adc7ddf708a021960467dd1974449fcd4b568a121ad053b::safe_math::mul(arg0, arg1), 5000), 10000)
    }

    // decompiled from Move bytecode v6
}

