module 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission {
    struct Commission has copy, drop, store {
        partner: address,
        commission_type: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission_type::CommissionType,
        value: u64,
        on_input: bool,
        direct_transfer: bool,
    }

    public fun commission_type(arg0: &Commission) : 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission_type::CommissionType {
        arg0.commission_type
    }

    public fun is_direct_transfer(arg0: &Commission) : bool {
        arg0.direct_transfer
    }

    public fun new(arg0: address, arg1: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::commission_type::CommissionType, arg2: u64, arg3: bool, arg4: bool) : Commission {
        Commission{
            partner         : arg0,
            commission_type : arg1,
            value           : arg2,
            on_input        : arg3,
            direct_transfer : arg4,
        }
    }

    public fun on_input(arg0: &Commission) : bool {
        arg0.on_input
    }

    public fun partner(arg0: &Commission) : address {
        arg0.partner
    }

    public fun value(arg0: &Commission) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

