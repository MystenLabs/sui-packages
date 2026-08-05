module 0xe4a1ae70f574250c4f0abc4ed9eaa03d68a4b471d7734421e852637a476b4f90::owner_cap {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        owned_id: address,
    }

    public(friend) fun create_owner_cap(arg0: &0x2::object::UID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{
            id       : 0x2::object::new(arg2),
            owned_id : 0x2::object::uid_to_address(arg0),
        };
        0x2::transfer::transfer<OwnerCap>(v0, arg1);
    }

    public(friend) fun destroy_cap(arg0: OwnerCap) {
        let OwnerCap {
            id       : v0,
            owned_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun is_owned(arg0: &0x2::object::UID, arg1: &OwnerCap) {
        assert!(arg1.owned_id == 0x2::object::uid_to_address(arg0), 0);
    }

    // decompiled from Move bytecode v7
}

