module 0x87c19e834bcdbafedf3b42c9420b443476839ef8f5d059bd9599cd596af2afc::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

