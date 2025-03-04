module 0x35b869203b965cf3c2142543b8c668a10815704aa2b62ed9fb09c0ef2d14038e::flash_loan_util {
    public fun calc_flash_loan_fee(arg0: u64) : u64 {
        arg0 * 6 / 10000
    }

    // decompiled from Move bytecode v6
}

