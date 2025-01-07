module 0xe5d01346b252aeba103f26cd43aaf1ad0789df78da804985e07a64dad6f42a3c::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xe5d01346b252aeba103f26cd43aaf1ad0789df78da804985e07a64dad6f42a3c::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

