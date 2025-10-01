module 0x11da80425fb389d1090743a2a33a48c479f4fd218a25db2cdc072b768a47ce5::native_drop_type {
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

