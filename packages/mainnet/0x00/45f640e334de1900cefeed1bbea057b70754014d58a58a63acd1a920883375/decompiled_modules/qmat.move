module 0x45f640e334de1900cefeed1bbea057b70754014d58a58a63acd1a920883375::qmat {
    public fun dot(arg0: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>, arg1: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>) : 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational {
        let v0 = 0x1::vector::length<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg0);
        assert!(0x1::vector::length<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg1) == v0, 1);
        let v1 = 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::from_int(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::zero());
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::add(v1, 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::mul(*0x1::vector::borrow<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg0, v2), *0x1::vector::borrow<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg1, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun matmul(arg0: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>, arg1: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>, arg2: u64, arg3: u64, arg4: u64) : vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational> {
        assert!(0x1::vector::length<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg0) == arg2 * arg3, 1);
        assert!(0x1::vector::length<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg1) == arg3 * arg4, 1);
        let v0 = arg2 * arg4;
        assert!(v0 <= 262144, 3);
        let v1 = 0x1::vector::empty<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(&mut v1, row_col(arg0, arg1, v2 / arg4, v2 % arg4, arg3, arg4));
            v2 = v2 + 1;
        };
        v1
    }

    fun row_col(arg0: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>, arg1: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational {
        let v0 = 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::from_int(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i128::zero());
        let v1 = 0;
        while (v1 < arg4) {
            v0 = 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::add(v0, 0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::mul(*0x1::vector::borrow<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg0, arg2 * arg4 + v1), *0x1::vector::borrow<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg1, v1 * arg5 + arg3)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun transpose(arg0: &vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>, arg1: u64, arg2: u64) : vector<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational> {
        assert!(0x1::vector::length<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg0) == arg1 * arg2, 1);
        let v0 = 0x1::vector::empty<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>();
        let v1 = 0;
        while (v1 < arg2 * arg1) {
            0x1::vector::push_back<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(&mut v0, *0x1::vector::borrow<0x99468efa8bf0755745d11371636ec7c2a087b793d9eeec40dec412d668247359::irational::IRational>(arg0, v1 % arg1 * arg2 + v1 / arg1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

