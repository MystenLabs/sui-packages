module 0xbaa3e5a09aee1bc4d7c02d0fcf800a8b6f0119dab7138f2d288999fe3912e5f9::math {
    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = arg0;
        let v1 = arg1;
        let v2 = 1;
        while (v1 >= 1) {
            if (v1 % 2 == 0) {
                v0 = v0 * v0;
                v1 = v1 / 2;
                continue
            };
            v2 = v2 * v0;
            v1 = v1 - 1;
        };
        v2
    }

    // decompiled from Move bytecode v6
}

