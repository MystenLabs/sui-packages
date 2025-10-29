module 0xf6b468748dced8435f4407d0ecb0457b921a2e89266a60862e36dbf243c71841::math_u64 {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 == 0) {
            return 0
        };
        if (arg3) {
            (((v0 - 1) / (arg2 as u128) + 1) as u64)
        } else {
            ((v0 / (arg2 as u128)) as u64)
        }
    }

    // decompiled from Move bytecode v6
}

