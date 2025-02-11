module 0x7182b166c2461a4eda64f06b95dd69326bc9001656cc413b255eaa845ada8767::events {
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

    // decompiled from Move bytecode v6
}

