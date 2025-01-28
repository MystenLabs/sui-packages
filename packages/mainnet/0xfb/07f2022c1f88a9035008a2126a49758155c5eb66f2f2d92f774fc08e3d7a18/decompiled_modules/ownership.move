module 0xfb07f2022c1f88a9035008a2126a49758155c5eb66f2f2d92f774fc08e3d7a18::ownership {
    struct CredenzaOwnership has store, key {
        id: 0x2::object::UID,
        target: 0x2::object::ID,
        owners: 0x2::vec_set::VecSet<address>,
    }

    struct CredenzaOwnershipCreatedEvent has copy, drop {
        ownership_id: 0x2::object::ID,
        ownership_target: 0x2::object::ID,
    }

    struct CredenzaOwnerAddedEvent has copy, drop {
        ownership_id: 0x2::object::ID,
        ownership_target: 0x2::object::ID,
        recipient: address,
    }

    struct CredenzaOwnerRemovedEvent has copy, drop {
        ownership_id: 0x2::object::ID,
        ownership_target: 0x2::object::ID,
        recipient: address,
    }

    public fun add_owner(arg0: &mut CredenzaOwnership, arg1: address) {
        if (!is_owner(arg0, arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.owners, arg1);
            let v0 = CredenzaOwnerAddedEvent{
                ownership_id     : 0x2::object::uid_to_inner(&arg0.id),
                ownership_target : arg0.target,
                recipient        : arg1,
            };
            0x2::event::emit<CredenzaOwnerAddedEvent>(v0);
        };
    }

    public fun assert_owner(arg0: &CredenzaOwnership, arg1: address) {
        assert!(is_owner(arg0, arg1), 20001);
    }

    public fun create_ownership(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : CredenzaOwnership {
        let v0 = CredenzaOwnership{
            id     : 0x2::object::new(arg1),
            target : arg0,
            owners : 0x2::vec_set::empty<address>(),
        };
        let v1 = CredenzaOwnershipCreatedEvent{
            ownership_id     : 0x2::object::uid_to_inner(&v0.id),
            ownership_target : arg0,
        };
        0x2::event::emit<CredenzaOwnershipCreatedEvent>(v1);
        v0
    }

    public fun is_owner(arg0: &CredenzaOwnership, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.owners, &arg1)
    }

    public fun remove_owner(arg0: &mut CredenzaOwnership, arg1: address) : bool {
        assert!(0x2::vec_set::size<address>(&arg0.owners) > 1, 20002);
        if (is_owner(arg0, arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.owners, &arg1);
            let v0 = CredenzaOwnerRemovedEvent{
                ownership_id     : 0x2::object::uid_to_inner(&arg0.id),
                ownership_target : arg0.target,
                recipient        : arg1,
            };
            0x2::event::emit<CredenzaOwnerRemovedEvent>(v0);
            return true
        };
        false
    }

    public fun set_owner(arg0: &mut CredenzaOwnership, arg1: address, arg2: bool) {
        if (arg2) {
            add_owner(arg0, arg1);
        } else {
            remove_owner(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

