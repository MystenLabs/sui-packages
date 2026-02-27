module 0x7c7d56d2e3321305bf41b37700f013f952adc08165364b780e46620e2bf431c0::validate {
    public(friend) fun data(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &0x1::string::String) {
        assert!(range(arg0, 3, 4096), 2);
        assert!(*0x1::vector::borrow<u8>(0x1::string::as_bytes(arg0), 2) == 63, 2);
        assert!(range(arg1, 1, 64), 3);
        assert!(range(arg2, 1, 256), 4);
        image(arg3);
        sequence(arg4);
    }

    public(friend) fun image(arg0: &0x1::string::String) {
        assert!(range(arg0, 0, 1024), 5);
    }

    fun range(arg0: &0x1::string::String, arg1: u64, arg2: u64) : bool {
        0x1::string::length(arg0) >= arg1 && 0x1::string::length(arg0) <= arg2
    }

    public(friend) fun sequence(arg0: &0x1::string::String) {
        assert!(range(arg0, 0, 1024), 6);
    }

    public(friend) fun signal(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) == 16, 7);
        let v1 = 0;
        while (v1 < 16) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            let v3 = v2 >= 48 && v2 <= 57;
            let v4 = v2 >= 97 && v2 <= 102;
            assert!(v3 || v4, 7);
            v1 = v1 + 1;
        };
    }

    public(friend) fun src(arg0: &0x1::string::String) {
        assert!(range(arg0, 1, 98304), 1);
    }

    // decompiled from Move bytecode v6
}

