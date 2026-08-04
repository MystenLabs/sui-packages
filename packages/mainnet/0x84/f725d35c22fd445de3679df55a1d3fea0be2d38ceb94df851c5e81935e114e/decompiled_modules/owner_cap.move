module 0x84f725d35c22fd445de3679df55a1d3fea0be2d38ceb94df851c5e81935e114e::owner_cap {
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

