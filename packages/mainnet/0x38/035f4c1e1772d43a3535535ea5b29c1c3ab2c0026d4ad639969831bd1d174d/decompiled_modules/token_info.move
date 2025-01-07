module 0x38035f4c1e1772d43a3535535ea5b29c1c3ab2c0026d4ad639969831bd1d174d::token_info {
    struct TokenInfo<phantom T0> has store {
        swap_rate: u64,
        max_native_swap_amount: u64,
        swap_enabled: bool,
    }

    public fun destroy<T0>(arg0: TokenInfo<T0>) {
        let TokenInfo {
            swap_rate              : _,
            max_native_swap_amount : _,
            swap_enabled           : _,
        } = arg0;
    }

    public fun disable_swap<T0>(arg0: &mut TokenInfo<T0>) {
        arg0.swap_enabled = false;
    }

    public fun enable_swap<T0>(arg0: &mut TokenInfo<T0>) {
        arg0.swap_enabled = true;
    }

    public fun is_swap_enabled<T0>(arg0: &TokenInfo<T0>) : bool {
        arg0.swap_enabled
    }

    public fun max_native_swap_amount<T0>(arg0: &TokenInfo<T0>) : u64 {
        arg0.max_native_swap_amount
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: bool) : TokenInfo<T0> {
        TokenInfo<T0>{
            swap_rate              : arg0,
            max_native_swap_amount : arg1,
            swap_enabled           : arg2,
        }
    }

    public fun swap_rate<T0>(arg0: &TokenInfo<T0>) : u64 {
        arg0.swap_rate
    }

    public fun update_max_native_swap_amount<T0>(arg0: &mut TokenInfo<T0>, arg1: u64) {
        arg0.max_native_swap_amount = arg1;
    }

    public fun update_swap_rate<T0>(arg0: &mut TokenInfo<T0>, arg1: u64) {
        arg0.swap_rate = arg1;
    }

    // decompiled from Move bytecode v6
}

