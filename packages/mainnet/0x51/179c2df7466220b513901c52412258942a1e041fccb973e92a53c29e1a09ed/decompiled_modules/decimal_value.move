module 0x51179c2df7466220b513901c52412258942a1e041fccb973e92a53c29e1a09ed::decimal_value {
    struct DecimalValue has copy, drop, store {
        value: u64,
        decimal: u8,
    }

    public fun decimal(arg0: &DecimalValue) : u8 {
        arg0.decimal
    }

    public fun new(arg0: u64, arg1: u8) : DecimalValue {
        DecimalValue{
            value   : arg0,
            decimal : arg1,
        }
    }

    public fun value(arg0: &DecimalValue) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

