module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::root_cap_registry {
    struct CapRegistry has store, key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        treasury: 0x2::object::ID,
        deny_list_manager: 0x2::object::ID,
        deny_list: 0x2::object::ID,
    }

    public(friend) fun get_admin(arg0: &CapRegistry) : 0x2::object::ID {
        arg0.admin
    }

    public(friend) fun get_deny_list(arg0: &CapRegistry) : 0x2::object::ID {
        arg0.deny_list
    }

    public(friend) fun get_deny_list_manager(arg0: &CapRegistry) : 0x2::object::ID {
        arg0.deny_list_manager
    }

    public(friend) fun get_treasury(arg0: &CapRegistry) : 0x2::object::ID {
        arg0.treasury
    }

    public(friend) fun new_cap_registry<T0: drop>(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap, arg4: &0x2::coin::DenyCapV2<T0>) : CapRegistry {
        CapRegistry{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::object::id<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin::YldsAdminCap>(arg1),
            treasury          : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(arg2),
            deny_list_manager : 0x2::object::id<0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_deny_list_manager::DenyListManagerCap>(arg3),
            deny_list         : 0x2::object::id<0x2::coin::DenyCapV2<T0>>(arg4),
        }
    }

    // decompiled from Move bytecode v6
}

