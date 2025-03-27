module 0x7bf2eb537f39b7dfb00783a7d0f691c71675c5c010d29537ef95085dae5fe72b::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

