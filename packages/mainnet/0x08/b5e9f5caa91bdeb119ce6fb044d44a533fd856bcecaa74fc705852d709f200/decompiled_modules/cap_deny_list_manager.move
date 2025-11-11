module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager {
    struct DenyListManagerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new_deny_list_manager_cap(arg0: &mut 0x2::tx_context::TxContext) : DenyListManagerCap {
        DenyListManagerCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

