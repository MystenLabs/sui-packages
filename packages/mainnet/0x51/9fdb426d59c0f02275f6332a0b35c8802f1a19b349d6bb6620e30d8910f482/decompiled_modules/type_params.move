module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_params {
    struct OpenParams has copy, drop {
        fixed_amount: u64,
        deduction: u64,
        lower_mult: u32,
        upper_mult: u32,
        is_fixed_a: bool,
        slot: vector<u8>,
    }

    public(friend) fun open_deduction(arg0: &OpenParams) : u64 {
        arg0.deduction
    }

    public(friend) fun open_fixed_amount(arg0: &OpenParams) : u64 {
        arg0.fixed_amount
    }

    public(friend) fun open_is_fixed_a(arg0: &OpenParams) : bool {
        arg0.is_fixed_a
    }

    public(friend) fun open_lower_mult(arg0: &OpenParams) : u32 {
        arg0.lower_mult
    }

    public(friend) fun open_slot(arg0: &OpenParams) : vector<u8> {
        arg0.slot
    }

    public(friend) fun open_upper_mult(arg0: &OpenParams) : u32 {
        arg0.upper_mult
    }

    public(friend) fun to_open_params(arg0: vector<u8>) : OpenParams {
        let v0 = 0x2::bcs::new(arg0);
        OpenParams{
            fixed_amount : 0x2::bcs::peel_u64(&mut v0),
            deduction    : 0x2::bcs::peel_u64(&mut v0),
            lower_mult   : 0x2::bcs::peel_u32(&mut v0),
            upper_mult   : 0x2::bcs::peel_u32(&mut v0),
            is_fixed_a   : 0x2::bcs::peel_bool(&mut v0),
            slot         : 0x2::bcs::peel_vec_u8(&mut v0),
        }
    }

    // decompiled from Move bytecode v6
}

