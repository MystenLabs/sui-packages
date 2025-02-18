module 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission {
    struct Commission has copy, drop, store {
        partner: address,
        commission_type: 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission_type::CommissionType,
        value: u64,
        on_input: bool,
        direct_transfer: bool,
    }

    public fun commission_type(arg0: &Commission) : 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission_type::CommissionType {
        arg0.commission_type
    }

    public fun is_direct_transfer(arg0: &Commission) : bool {
        arg0.direct_transfer
    }

    public fun new(arg0: address, arg1: 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission_type::CommissionType, arg2: u64, arg3: bool, arg4: bool) : Commission {
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

