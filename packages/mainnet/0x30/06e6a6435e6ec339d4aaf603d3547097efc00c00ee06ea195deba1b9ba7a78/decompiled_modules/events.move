module 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::events {
    struct SwapCompletedEvent has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
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

    public(friend) fun emit_swap_completed_event(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = SwapCompletedEvent{
            swapper    : 0x2::tx_context::sender(arg4),
            type_in    : 0x1::ascii::string(arg0),
            amount_in  : arg1,
            type_out   : 0x1::ascii::string(arg2),
            amount_out : arg3,
        };
        0x2::event::emit<SwapCompletedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

