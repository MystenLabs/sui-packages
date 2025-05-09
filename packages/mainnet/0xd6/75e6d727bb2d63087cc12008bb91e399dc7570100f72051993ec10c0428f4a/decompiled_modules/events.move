module 0xe5099fcd45747074d0ef5eabce07a9bd1c3b0c1862435bf2a09c3a81e0604373::events {
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

    struct AuthorizedAppEvent has copy, drop {
        app_id: address,
    }

    struct DeauthorizedAppEvent has copy, drop {
        app_id: address,
    }

    public(friend) fun emit_authorized_app_event(arg0: &0x2::object::UID) {
        let v0 = AuthorizedAppEvent{app_id: 0x2::object::uid_to_address(arg0)};
        0x2::event::emit<AuthorizedAppEvent>(v0);
    }

    public(friend) fun emit_deauthorized_app_event(arg0: &0x2::object::UID) {
        let v0 = DeauthorizedAppEvent{app_id: 0x2::object::uid_to_address(arg0)};
        0x2::event::emit<DeauthorizedAppEvent>(v0);
    }

    public(friend) fun emit_swap_completed_event(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: address, arg5: vector<u8>, arg6: u64, arg7: 0x1::option::Option<address>, arg8: &0x2::tx_context::TxContext) {
        let v0 = SwapCompletedEventV2{
            swapper              : 0x2::tx_context::sender(arg8),
            type_in              : 0x1::ascii::string(arg0),
            amount_in            : arg1,
            type_out             : 0x1::ascii::string(arg2),
            amount_out           : arg3,
            router_fee_recipient : arg4,
            type_fee             : 0x1::ascii::string(arg5),
            router_fee           : arg6,
            referrer             : arg7,
        };
        0x2::event::emit<SwapCompletedEventV2>(v0);
    }

    // decompiled from Move bytecode v6
}

