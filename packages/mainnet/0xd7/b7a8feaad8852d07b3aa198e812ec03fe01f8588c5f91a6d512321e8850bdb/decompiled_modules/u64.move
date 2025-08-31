module 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

