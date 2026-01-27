module 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::manager_cap {
    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerCapCreated has copy, drop {
        cap_id: address,
    }

    public(friend) fun create_manager_cap(arg0: &mut 0x2::tx_context::TxContext) : ManagerCap {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        let v1 = ManagerCapCreated{cap_id: 0x2::object::id_address<ManagerCap>(&v0)};
        0x2::event::emit<ManagerCapCreated>(v1);
        v0
    }

    public fun manager_cap_id(arg0: &ManagerCap) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v6
}

