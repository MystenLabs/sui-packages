module 0xc99212f14aa23689af99bdc4dc81a8f4531edecf3d2f82e68625e3d8fef206e4::commission {
    struct Commission has copy, drop, store {
        partner: address,
        commission_type: 0xc99212f14aa23689af99bdc4dc81a8f4531edecf3d2f82e68625e3d8fef206e4::commission_type::CommissionType,
        value: u64,
        on_input: bool,
        direct_transfer: bool,
    }

    public fun commission_type(arg0: &Commission) : 0xc99212f14aa23689af99bdc4dc81a8f4531edecf3d2f82e68625e3d8fef206e4::commission_type::CommissionType {
        arg0.commission_type
    }

    public fun is_direct_transfer(arg0: &Commission) : bool {
        arg0.direct_transfer
    }

    public fun new(arg0: address, arg1: 0xc99212f14aa23689af99bdc4dc81a8f4531edecf3d2f82e68625e3d8fef206e4::commission_type::CommissionType, arg2: u64, arg3: bool, arg4: bool) : Commission {
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

