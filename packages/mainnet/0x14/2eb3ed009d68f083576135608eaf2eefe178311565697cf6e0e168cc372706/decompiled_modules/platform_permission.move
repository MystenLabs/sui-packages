module 0x142eb3ed009d68f083576135608eaf2eefe178311565697cf6e0e168cc372706::platform_permission {
    struct Platform has store, key {
        id: 0x2::object::UID,
        permission: 0x2::table::Table<address, u64>,
        platform_address: address,
    }

    struct PermissionUpdated has copy, drop, store {
        user: address,
    }

    public entry fun give_permission(arg0: &mut Platform, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.permission, 0x2::tx_context::sender(arg2))) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.permission, 0x2::tx_context::sender(arg2)) = 0x2::clock::timestamp_ms(arg1) + 2592000000;
        } else {
            0x2::table::add<address, u64>(&mut arg0.permission, 0x2::tx_context::sender(arg2), 0x2::clock::timestamp_ms(arg1) + 2592000000);
        };
        let v0 = PermissionUpdated{user: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<PermissionUpdated>(v0);
    }

    public(friend) fun has_permission(arg0: &Platform, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : bool {
        if (0x2::tx_context::sender(arg3) != arg0.platform_address) {
            return false
        };
        if (0x2::table::contains<address, u64>(&arg0.permission, arg1)) {
            return *0x2::table::borrow<address, u64>(&arg0.permission, arg1) > 0x2::clock::timestamp_ms(arg2)
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Platform{
            id               : 0x2::object::new(arg0),
            permission       : 0x2::table::new<address, u64>(arg0),
            platform_address : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Platform>(v0);
    }

    public entry fun update_platform_address(arg0: &mut Platform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.platform_address == 0x2::tx_context::sender(arg2), 0);
        arg0.platform_address = arg1;
    }

    // decompiled from Move bytecode v6
}

