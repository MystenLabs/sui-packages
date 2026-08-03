module 0x99123d5c90f1f45980efd48f9b60e2c4fe572d035ecbd9a061a8fc6fe4059fff::owner_cap {
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

