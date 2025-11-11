module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::functions_add_to_deny_list {
    public(friend) fun add_to_deny_list<T0>(arg0: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap, arg1: &mut 0x2::coin::DenyCapV2<T0>, arg2: &mut 0x2::deny_list::DenyList, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<T0>(arg2, arg1, arg3, arg4);
        0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_deny_list::emit_deny_list_event(0x1::string::utf8(b"add_to_deny_list"), arg3, 0x2::tx_context::sender(arg4), 0x1::string::utf8(b"Address added to deny list"));
    }

    // decompiled from Move bytecode v6
}

