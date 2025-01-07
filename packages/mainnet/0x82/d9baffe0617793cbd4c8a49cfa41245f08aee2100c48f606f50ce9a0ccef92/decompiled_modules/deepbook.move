module 0x82d9baffe0617793cbd4c8a49cfa41245f08aee2100c48f606f50ce9a0ccef92::deepbook {
    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

