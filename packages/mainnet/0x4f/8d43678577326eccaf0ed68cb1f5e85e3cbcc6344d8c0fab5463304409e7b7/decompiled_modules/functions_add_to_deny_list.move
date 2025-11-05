module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::functions_add_to_deny_list {
    public(friend) fun add_to_deny_list<T0>(arg0: &0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::cap_deny_list_manager::DenyListManagerCap, arg1: &mut 0x2::coin::DenyCapV2<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<T0>(arg2, arg1, arg3, arg4);
        0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::events_deny_list::emit_deny_list_event(0x1::string::utf8(b"add_to_deny_list"), arg3, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"Address added to deny list"));
    }

    // decompiled from Move bytecode v6
}

