module 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::system_core_storage {
    struct Storage has key {
        id: 0x2::object::UID,
        app_cap: 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::app_manager::AppCap,
    }

    public(friend) fun get_app_cap(arg0: &Storage) : &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::app_manager::AppCap {
        &arg0.app_cap
    }

    public fun initialize_cap_with_governance(arg0: &0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::genesis::GovernanceCap, arg1: &mut 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::app_manager::TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id      : 0x2::object::new(arg2),
            app_cap : 0x231d0ed62482f321f446dfc0ba02e01ca620df870da4c313b11e9cb4d0621d89::app_manager::register_cap_with_governance(arg0, arg1, arg2),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    // decompiled from Move bytecode v6
}

