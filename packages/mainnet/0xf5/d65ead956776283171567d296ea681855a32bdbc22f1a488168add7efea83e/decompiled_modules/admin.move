module 0xf5d65ead956776283171567d296ea681855a32bdbc22f1a488168add7efea83e::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        creator: address,
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = AdminCapCreated{
            admin_cap_id : 0x2::object::uid_to_inner(&v0.id),
            creator      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminCapCreated>(v1);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun get_admin_cap_id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = AdminCapCreated{
            admin_cap_id : 0x2::object::uid_to_inner(&v1.id),
            creator      : v0,
        };
        0x2::event::emit<AdminCapCreated>(v2);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

