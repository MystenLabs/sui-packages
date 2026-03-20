module 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::u64 {
    public fun pow10_u64(arg0: u8) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 3) {
            1000
        } else if (arg0 == 4) {
            10000
        } else if (arg0 == 5) {
            100000
        } else if (arg0 == 6) {
            1000000
        } else if (arg0 == 7) {
            10000000
        } else if (arg0 == 8) {
            100000000
        } else if (arg0 == 9) {
            1000000000
        } else if (arg0 == 10) {
            10000000000
        } else if (arg0 == 11) {
            100000000000
        } else if (arg0 == 12) {
            1000000000000
        } else if (arg0 == 13) {
            10000000000000
        } else if (arg0 == 14) {
            100000000000000
        } else if (arg0 == 15) {
            1000000000000000
        } else if (arg0 == 16) {
            10000000000000000
        } else if (arg0 == 17) {
            100000000000000000
        } else {
            assert!(arg0 == 18, 10);
            1000000000000000000
        }
    }

    // decompiled from Move bytecode v6
}

