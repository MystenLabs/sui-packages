module 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction {
    struct Function has copy, drop, store {
        package_id: address,
        module_name: 0x1::ascii::String,
        name: 0x1::ascii::String,
    }

    struct MoveCall has copy, drop, store {
        function: Function,
        arguments: vector<vector<u8>>,
        type_arguments: vector<0x1::ascii::String>,
    }

    struct Transaction has copy, drop, store {
        is_final: bool,
        move_calls: vector<MoveCall>,
    }

    public fun new_function(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : Function {
        Function{
            package_id  : arg0,
            module_name : arg1,
            name        : arg2,
        }
    }

    public fun new_function_from_bcs(arg0: &mut 0x2::bcs::BCS) : Function {
        Function{
            package_id  : 0x2::bcs::peel_address(arg0),
            module_name : 0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0)),
            name        : 0x1::ascii::string(0x2::bcs::peel_vec_u8(arg0)),
        }
    }

    public fun new_move_call(arg0: Function, arg1: vector<vector<u8>>, arg2: vector<0x1::ascii::String>) : MoveCall {
        MoveCall{
            function       : arg0,
            arguments      : arg1,
            type_arguments : arg2,
        }
    }

    public fun new_move_call_from_bcs(arg0: &mut 0x2::bcs::BCS) : MoveCall {
        let v0 = new_function_from_bcs(arg0);
        let v1 = 0x2::bcs::peel_vec_vec_u8(arg0);
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_vec_length(arg0)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v2, peel_type(arg0));
            v3 = v3 + 1;
        };
        MoveCall{
            function       : v0,
            arguments      : v1,
            type_arguments : v2,
        }
    }

    public fun new_transaction(arg0: bool, arg1: vector<MoveCall>) : Transaction {
        Transaction{
            is_final   : arg0,
            move_calls : arg1,
        }
    }

    public fun new_transaction_from_bcs(arg0: &mut 0x2::bcs::BCS) : Transaction {
        let v0 = 0x2::bcs::peel_bool(arg0);
        let v1 = 0x1::vector::empty<MoveCall>();
        let v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(arg0)) {
            0x1::vector::push_back<MoveCall>(&mut v1, new_move_call_from_bcs(arg0));
            v2 = v2 + 1;
        };
        Transaction{
            is_final   : v0,
            move_calls : v1,
        }
    }

    public fun package_id<T0>() : address {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get_address(&v0);
        0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)))
    }

    fun peel_type(arg0: &mut 0x2::bcs::BCS) : 0x1::ascii::String {
        let v0 = 0x1::ascii::try_string(0x2::bcs::peel_vec_u8(arg0));
        assert!(0x1::option::is_some<0x1::ascii::String>(&v0), 9223372629560262657);
        0x1::option::extract<0x1::ascii::String>(&mut v0)
    }

    // decompiled from Move bytecode v6
}

