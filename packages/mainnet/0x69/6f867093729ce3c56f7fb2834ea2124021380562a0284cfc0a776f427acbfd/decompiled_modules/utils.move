module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::utils {
    public fun calc_assets(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        ((iou_usd_val(arg0, arg2, arg4) + (arg1 as u128) * (arg3 as u128)) as u64)
    }

    public fun calc_im(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg1 == 0) {
            ((((arg3 as u128) + (arg4 as u128)) / (arg5 as u128)) as u64)
        } else if (arg2) {
            (((arg3 as u128) / (arg5 as u128)) as u64)
        } else {
            (((arg4 as u128) / (arg5 as u128)) as u64)
        }
    }

    public fun calc_ltp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u256) * (arg2 as u256) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::ltp_scaling() as u256) / (arg0 as u256) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::kusd_scaling() as u256)) as u64)
    }

    public fun calc_mm(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::divide_as_u64(iou_usd_val(arg1, arg0, arg2), (arg3 as u128))
    }

    public fun calc_position(arg0: u64, arg1: u64, arg2: u64) : (u64, bool) {
        let (v0, v1) = if (arg0 + arg1 > arg2) {
            (true, arg0 + arg1 - arg2)
        } else {
            (false, arg2 - arg0 + arg1)
        };
        (v1, v0)
    }

    public fun db_price_scaling(arg0: u64) : u64 {
        ((1000000000 * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::kusd_scaling() as u128) / (arg0 as u128)) as u64)
    }

    public fun iou_usd_val(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::kusd_scaling() as u256) / (arg2 as u256) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::pr_price_scaling() as u256)) as u128)
    }

    public fun scale_db_to_pr_price(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::pr_price_scaling() as u128) / (db_price_scaling(arg1) as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

