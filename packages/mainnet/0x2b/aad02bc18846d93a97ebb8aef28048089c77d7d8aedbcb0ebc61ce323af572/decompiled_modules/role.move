module 0x2baad02bc18846d93a97ebb8aef28048089c77d7d8aedbcb0ebc61ce323af572::role {
    struct ROLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    struct MasterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id    : 0x2::object::new(arg0),
            epoch : 0x2::tx_context::epoch(arg0),
        }
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap {
            id    : v0,
            epoch : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun grant_admin_cap(arg0: &MasterAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(create_admin_cap(arg2), arg1);
    }

    fun init(arg0: ROLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterAdminCap{id: 0x2::object::new(arg1)};
        let v1 = create_admin_cap(arg1);
        0x2::transfer::transfer<MasterAdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun verify_admin_cap(arg0: &AdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.epoch == 0x2::tx_context::epoch(arg1), 1);
    }

    // decompiled from Move bytecode v6
}

