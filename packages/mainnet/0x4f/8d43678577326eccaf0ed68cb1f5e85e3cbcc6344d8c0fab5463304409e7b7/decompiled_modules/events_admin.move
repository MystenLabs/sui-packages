module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::events_admin {
    struct AdminEvent has copy, drop {
        action: 0x1::string::String,
        admin: address,
        details: 0x1::string::String,
    }

    public(friend) fun emit_admin_event(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String) {
        let v0 = AdminEvent{
            action  : arg0,
            admin   : arg1,
            details : arg2,
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public(friend) fun get_action(arg0: &AdminEvent) : 0x1::string::String {
        arg0.action
    }

    public(friend) fun get_admin(arg0: &AdminEvent) : address {
        arg0.admin
    }

    public(friend) fun get_details(arg0: &AdminEvent) : 0x1::string::String {
        arg0.details
    }

    // decompiled from Move bytecode v6
}

