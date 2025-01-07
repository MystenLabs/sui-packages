module 0x2f7f677a73f9a203eaef9876a8e71b7312942462130baf899f9caca9092c3412::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

