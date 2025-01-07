module 0x833a64724a500ad978480083c048ecc802fa5f6c59f622baf8b9531c3dfe8091::commission {
    struct Commission has copy, drop, store {
        partner: address,
        type: u8,
        value: u64,
        on_input: bool,
    }

    public fun new(arg0: address, arg1: u8, arg2: u64, arg3: bool) : Commission {
        if (arg1 != 0x833a64724a500ad978480083c048ecc802fa5f6c59f622baf8b9531c3dfe8091::commission_type::percentage() && arg1 != 0x833a64724a500ad978480083c048ecc802fa5f6c59f622baf8b9531c3dfe8091::commission_type::flat() || arg2 == 0) {
            abort 0
        };
        Commission{
            partner  : arg0,
            type     : arg1,
            value    : arg2,
            on_input : arg3,
        }
    }

    public fun on_input(arg0: &Commission) : bool {
        arg0.on_input
    }

    public fun partner(arg0: &Commission) : address {
        arg0.partner
    }

    public fun type(arg0: &Commission) : u8 {
        arg0.type
    }

    public fun value(arg0: &Commission) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

