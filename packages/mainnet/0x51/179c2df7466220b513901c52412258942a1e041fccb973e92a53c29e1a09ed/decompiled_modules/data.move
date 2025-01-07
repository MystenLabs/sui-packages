module 0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::data {
    struct Data<T0> has copy, drop {
        value: T0,
        metadata: Metadata,
    }

    struct Metadata has copy, drop {
        ticker: 0x1::string::String,
        sequence_number: u64,
        timestamp: u64,
        oracle: address,
        identifier: 0x1::string::String,
    }

    public fun new<T0>(arg0: T0, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: address, arg5: 0x1::string::String) : Data<T0> {
        let v0 = Metadata{
            ticker          : arg1,
            sequence_number : arg2,
            timestamp       : arg3,
            oracle          : arg4,
            identifier      : arg5,
        };
        Data<T0>{
            value    : arg0,
            metadata : v0,
        }
    }

    public fun oracle_address<T0>(arg0: &Data<T0>) : &address {
        &arg0.metadata.oracle
    }

    public fun timestamp<T0>(arg0: &Data<T0>) : u64 {
        arg0.metadata.timestamp
    }

    public fun value<T0>(arg0: &Data<T0>) : &T0 {
        &arg0.value
    }

    // decompiled from Move bytecode v6
}

