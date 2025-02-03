module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math {
    public fun add(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) + (arg1 as u128)) as u64)
    }

    public fun add_3(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) + (arg1 as u128) + (arg2 as u128)) as u64)
    }

    public fun add_as_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) + (arg1 as u128)
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun divide_as_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun divide_as_u64(arg0: u128, arg1: u128) : u64 {
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun multiply_as_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun safe_multiply_divide(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= (0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::u64_max() as u128), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::error::overflow());
        (v0 as u64)
    }

    public fun sub(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg0 >= arg1) {
            (true, arg0 - arg1)
        } else {
            (false, arg1 - arg0)
        }
    }

    // decompiled from Move bytecode v6
}

