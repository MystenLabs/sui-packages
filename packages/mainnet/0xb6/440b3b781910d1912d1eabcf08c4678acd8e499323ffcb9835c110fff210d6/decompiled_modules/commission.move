module 0xb6440b3b781910d1912d1eabcf08c4678acd8e499323ffcb9835c110fff210d6::commission {
    struct Commission has copy, drop, store {
        partner: address,
        commission_type: 0xb6440b3b781910d1912d1eabcf08c4678acd8e499323ffcb9835c110fff210d6::commission_type::CommissionType,
        value: u64,
        on_input: bool,
        direct_transfer: bool,
    }

    public fun commission_type(arg0: &Commission) : 0xb6440b3b781910d1912d1eabcf08c4678acd8e499323ffcb9835c110fff210d6::commission_type::CommissionType {
        arg0.commission_type
    }

    public fun is_direct_transfer(arg0: &Commission) : bool {
        arg0.direct_transfer
    }

    public fun new(arg0: address, arg1: 0xb6440b3b781910d1912d1eabcf08c4678acd8e499323ffcb9835c110fff210d6::commission_type::CommissionType, arg2: u64, arg3: bool, arg4: bool) : Commission {
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

