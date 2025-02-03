module 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

