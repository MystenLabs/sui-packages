module 0x3de4f9f9f203bab9ff13906b6c53450ac20382481668d33e959412ad716f98c2::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

