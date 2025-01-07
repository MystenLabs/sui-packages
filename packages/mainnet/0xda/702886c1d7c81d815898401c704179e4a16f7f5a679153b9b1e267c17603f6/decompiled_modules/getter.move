module 0xda702886c1d7c81d815898401c704179e4a16f7f5a679153b9b1e267c17603f6::getter {
    public entry fun testfun1() : u64 {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun testfun2() : u64 {
        let v0 = 0;
        while (v0 < 100000) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun testfun3() : u64 {
        let v0 = 0;
        while (v0 < 1000000) {
            v0 = v0 + 1;
        };
        v0
    }

    public entry fun testfun4() : u64 {
        let v0 = 0;
        while (v0 < 10000000) {
            v0 = v0 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

