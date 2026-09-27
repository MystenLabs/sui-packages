module 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::burn_curve {
    public fun burn_bps(arg0: u64) : u64 {
        if (arg0 <= 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::rflh_burn_curve_start()) {
            0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::min_burn_bps()
        } else if (arg0 >= 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::rflh_soft_cap()) {
            0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::max_burn_bps()
        } else {
            0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::min_burn_bps() + ((((arg0 - 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::rflh_burn_curve_start()) as u128) * ((0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::max_burn_bps() - 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::min_burn_bps()) as u128) / ((0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::rflh_soft_cap() - 0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::rflh_burn_curve_start()) as u128)) as u64)
        }
    }

    public fun split_rflh_loss(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (((arg0 as u128) * (burn_bps(arg1) as u128) / (0xedd66c50fc690e695a2ff1376c78d430195c03a2e769f2b9d11e0f2d47d12c62::constants::bps_denominator() as u128)) as u64);
        (v0, arg0 - v0)
    }

    // decompiled from Move bytecode v7
}

