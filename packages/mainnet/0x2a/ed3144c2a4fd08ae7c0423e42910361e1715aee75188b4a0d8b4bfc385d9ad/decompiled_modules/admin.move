module 0x2aed3144c2a4fd08ae7c0423e42910361e1715aee75188b4a0d8b4bfc385d9ad::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManageCap has key {
        id: 0x2::object::UID,
        whitelisted_addresses: vector<address>,
    }

    public fun add_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        if (!0x1::vector::contains<address>(&arg1.whitelisted_addresses, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.whitelisted_addresses, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AdminCap>(v0);
        let v1 = ManageCap{
            id                    : 0x2::object::new(arg0),
            whitelisted_addresses : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<ManageCap>(v1);
    }

    public fun is_whitelisted_manager(arg0: &ManageCap, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun remove_whitelisted_manager(arg0: &AdminCap, arg1: &mut ManageCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.whitelisted_addresses, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.whitelisted_addresses, v1);
        };
    }

    // decompiled from Move bytecode v6
}

