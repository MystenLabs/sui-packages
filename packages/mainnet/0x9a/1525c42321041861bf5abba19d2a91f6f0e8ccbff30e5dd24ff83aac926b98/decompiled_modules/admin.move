module 0x9a1525c42321041861bf5abba19d2a91f6f0e8ccbff30e5dd24ff83aac926b98::admin {
    struct AdminCapAddEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        receipt: address,
    }

    struct AdminCapRemoveEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = AdminCapAddEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            receipt      : arg1,
        };
        0x2::event::emit<AdminCapAddEvent>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = AdminCapAddEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v1),
            receipt      : v0,
        };
        0x2::event::emit<AdminCapAddEvent>(v2);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public entry fun remove_admin_cap(arg0: AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        let v1 = AdminCapRemoveEvent{admin_cap_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<AdminCapRemoveEvent>(v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

