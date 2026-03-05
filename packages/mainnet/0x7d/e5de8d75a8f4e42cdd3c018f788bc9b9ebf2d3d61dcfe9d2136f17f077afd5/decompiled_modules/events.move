module 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::events {
    struct SwapCompletedEventV3 has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        router_fee_recipient: address,
        fee_types: vector<0x1::ascii::String>,
        fee_amounts: vector<u64>,
    }

    struct AuthorizedAppEvent has copy, drop {
        app_id: address,
    }

    struct DeauthorizedAppEvent has copy, drop {
        app_id: address,
    }

    struct SwapCompletedEvent has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        router_fee_recipient: address,
        router_fee: u64,
        referrer: 0x1::option::Option<address>,
    }

    struct SwapCompletedEventV2 has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        router_fee_recipient: address,
        type_fee: 0x1::ascii::String,
        router_fee: u64,
        referrer: 0x1::option::Option<address>,
    }

    public(friend) fun emit_authorized_app_event(arg0: &0x2::object::UID) {
        let v0 = AuthorizedAppEvent{app_id: 0x2::object::uid_to_address(arg0)};
        0x2::event::emit<AuthorizedAppEvent>(v0);
    }

    public(friend) fun emit_deauthorized_app_event(arg0: &0x2::object::UID) {
        let v0 = DeauthorizedAppEvent{app_id: 0x2::object::uid_to_address(arg0)};
        0x2::event::emit<DeauthorizedAppEvent>(v0);
    }

    public(friend) fun emit_swap_completed_event(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: bool, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = vector[];
        if (arg2 > 0) {
            if (arg6 > 0) {
                if (arg3) {
                    if (arg4 == arg0) {
                        arg2 = arg2 + arg6;
                        arg6 = 0;
                    };
                } else if (arg4 == b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI") {
                    arg2 = arg2 + arg6;
                    arg6 = 0;
                };
            };
            if (arg3) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(arg0));
            } else {
                0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>()));
            };
            0x1::vector::push_back<u64>(&mut v1, arg2);
        };
        if (arg6 > 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(arg4));
            0x1::vector::push_back<u64>(&mut v1, arg6);
        };
        let v2 = SwapCompletedEventV3{
            swapper              : 0x2::tx_context::sender(arg8),
            type_in              : 0x1::ascii::string(arg0),
            amount_in            : arg1,
            type_out             : 0x1::ascii::string(arg4),
            amount_out           : arg5,
            router_fee_recipient : arg7,
            fee_types            : v0,
            fee_amounts          : v1,
        };
        0x2::event::emit<SwapCompletedEventV3>(v2);
    }

    // decompiled from Move bytecode v6
}

