module 0xc4dbbf049829ed9c00745d78c24df4ffbbbb354e5ec8bef208b10d3a0730adf8::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

