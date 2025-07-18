module 0x42c3bf71685b1d3758a1c576e978b784f6d0251652abc319601d654e0c7b7d2c::protocol_event {
    struct Swapped has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Deposited has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Withdrawn has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Claimed has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Borrowed has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    struct Repaid has copy, drop {
        protocol: 0x1::string::String,
        fund: 0x2::object::ID,
        input_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_type: 0x1::type_name::TypeName,
        output_amount: u64,
    }

    public(friend) fun emit_borrowed_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Borrowed{
            protocol      : arg0,
            fund          : arg1,
            input_type    : arg2,
            input_amount  : arg3,
            output_type   : arg4,
            output_amount : arg5,
        };
        0x2::event::emit<Borrowed>(v0);
    }

    public(friend) fun emit_claimed_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Claimed{
            protocol      : arg0,
            fund          : arg1,
            input_type    : arg2,
            input_amount  : arg3,
            output_type   : arg4,
            output_amount : arg5,
        };
        0x2::event::emit<Claimed>(v0);
    }

    public(friend) fun emit_deposited_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Deposited{
            protocol      : arg0,
            fund          : arg1,
            input_type    : arg2,
            input_amount  : arg3,
            output_type   : arg4,
            output_amount : arg5,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_repaid_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Repaid{
            protocol      : arg0,
            fund          : arg1,
            input_type    : arg2,
            input_amount  : arg3,
            output_type   : arg4,
            output_amount : arg5,
        };
        0x2::event::emit<Repaid>(v0);
    }

    public(friend) fun emit_swapped_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Swapped{
            protocol      : arg0,
            fund          : arg1,
            input_type    : arg2,
            input_amount  : arg3,
            output_type   : arg4,
            output_amount : arg5,
        };
        0x2::event::emit<Swapped>(v0);
    }

    public(friend) fun emit_withdrawn_event(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Withdrawn{
            protocol      : arg0,
            fund          : arg1,
            input_type    : arg2,
            input_amount  : arg3,
            output_type   : arg4,
            output_amount : arg5,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

