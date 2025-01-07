module 0xd88ebdabeaead893d6ce24259bf596627ff4d209b9e1541c2eb7997fa90651d2::deepbook {
    public fun get_input_quantity(arg0: u64, arg1: u64) : u64 {
        arg1 - arg1 % arg0
    }

    // decompiled from Move bytecode v6
}

