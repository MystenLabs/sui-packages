module 0x4db6f468e9e9072bf9f5f76676518ae93c45cf2d014465c29722e98502f7bfba::getter {
    public entry fun testfun1() {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
    }

    public entry fun testfun2() {
        let v0 = 0;
        while (v0 < 100000) {
            v0 = v0 + 1;
        };
    }

    public entry fun testfun3() {
        let v0 = 0;
        while (v0 < 1000000) {
            v0 = v0 + 1;
        };
    }

    public entry fun testfun4() {
        let v0 = 0;
        while (v0 < 10000000) {
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

