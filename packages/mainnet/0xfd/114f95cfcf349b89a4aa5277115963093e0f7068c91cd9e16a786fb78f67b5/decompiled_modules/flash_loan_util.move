module 0xfd114f95cfcf349b89a4aa5277115963093e0f7068c91cd9e16a786fb78f67b5::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

