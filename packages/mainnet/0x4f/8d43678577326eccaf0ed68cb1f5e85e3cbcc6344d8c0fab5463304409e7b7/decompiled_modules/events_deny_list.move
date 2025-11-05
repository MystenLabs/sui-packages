module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::events_deny_list {
    struct DenyListEvent has copy, drop {
        action: 0x1::string::String,
        target_address: address,
        manager: address,
        reason: 0x1::string::String,
    }

    public(friend) fun emit_deny_list_event(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: 0x1::string::String) {
        let v0 = DenyListEvent{
            action         : arg0,
            target_address : arg1,
            manager        : arg2,
            reason         : arg3,
        };
        0x2::event::emit<DenyListEvent>(v0);
    }

    public(friend) fun get_action(arg0: &DenyListEvent) : 0x1::string::String {
        arg0.action
    }

    public(friend) fun get_manager(arg0: &DenyListEvent) : address {
        arg0.manager
    }

    public(friend) fun get_reason(arg0: &DenyListEvent) : 0x1::string::String {
        arg0.reason
    }

    public(friend) fun get_target_address(arg0: &DenyListEvent) : address {
        arg0.target_address
    }

    // decompiled from Move bytecode v6
}

