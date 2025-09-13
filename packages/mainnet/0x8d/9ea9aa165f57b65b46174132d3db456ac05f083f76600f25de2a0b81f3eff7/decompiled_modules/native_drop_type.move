module 0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::native_drop_type {
    struct NativeDropParams has copy, drop, store {
        receiver: address,
        amount: u64,
    }

    public fun native_drop_params_amount(arg0: &NativeDropParams) : u64 {
        arg0.amount
    }

    public fun native_drop_params_receiver(arg0: &NativeDropParams) : address {
        arg0.receiver
    }

    public fun new_native_drop_params(arg0: address, arg1: u64) : NativeDropParams {
        NativeDropParams{
            receiver : arg0,
            amount   : arg1,
        }
    }

    public fun unpack_native_drop_params(arg0: NativeDropParams) : (address, u64) {
        let NativeDropParams {
            receiver : v0,
            amount   : v1,
        } = arg0;
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

