module 0x6315cdc2fb51f03681f94f90b1c97b667385dedea8ac8f7d96dfe4df8d249f4c::trust_quote {
    struct TrustQuote<phantom T0, phantom T1> {
        amount_in: u64,
        amount_out: u64,
        provider: 0x1::string::String,
        timestamp: u64,
    }

    public fun amount_in<T0, T1>(arg0: &TrustQuote<T0, T1>) : u64 {
        arg0.amount_in
    }

    public fun amount_out<T0, T1>(arg0: &TrustQuote<T0, T1>) : u64 {
        arg0.amount_out
    }

    public fun destroy_trust_quote<T0, T1>(arg0: TrustQuote<T0, T1>) {
        let TrustQuote {
            amount_in  : _,
            amount_out : _,
            provider   : _,
            timestamp  : _,
        } = arg0;
    }

    public(friend) fun new_trust_quote<T0, T1>(arg0: u64, arg1: u64, arg2: 0x1::string::String, arg3: u64) : TrustQuote<T0, T1> {
        TrustQuote<T0, T1>{
            amount_in  : arg0,
            amount_out : arg1,
            provider   : arg2,
            timestamp  : arg3,
        }
    }

    public fun provider<T0, T1>(arg0: &TrustQuote<T0, T1>) : 0x1::string::String {
        arg0.provider
    }

    public fun timestamp<T0, T1>(arg0: &TrustQuote<T0, T1>) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

