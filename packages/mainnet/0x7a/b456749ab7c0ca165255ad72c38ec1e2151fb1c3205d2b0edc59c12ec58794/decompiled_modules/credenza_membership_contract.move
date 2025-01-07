module 0x7ab456749ab7c0ca165255ad72c38ec1e2151fb1c3205d2b0edc59c12ec58794::credenza_membership_contract {
    struct MembershipList has store, key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct MembershipAddedEvent has copy, drop {
        membership_list_id: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    struct MembershipListCreatedEvent has copy, drop {
        membership_list_id: 0x2::object::ID,
    }

    struct MembershipRemovedEvent has copy, drop {
        membership_list_id: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MembershipList{
            id      : 0x2::object::new(arg0),
            members : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        let v1 = MembershipListCreatedEvent{membership_list_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<MembershipListCreatedEvent>(v1);
        0x2::transfer::public_transfer<MembershipList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun remove_membership(arg0: &mut MembershipList, arg1: address) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            let v0 = MembershipRemovedEvent{
                membership_list_id : 0x2::object::uid_to_inner(&arg0.id),
                user               : arg1,
                metadata           : 0x2::table::remove<address, 0x1::string::String>(&mut arg0.members, arg1),
            };
            0x2::event::emit<MembershipRemovedEvent>(v0);
        };
    }

    public fun set_membership(arg0: &mut MembershipList, arg1: address, arg2: 0x1::string::String) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.members, arg1);
        } else {
            let v0 = MembershipAddedEvent{
                membership_list_id : 0x2::object::uid_to_inner(&arg0.id),
                user               : arg1,
                metadata           : arg2,
            };
            0x2::event::emit<MembershipAddedEvent>(v0);
        };
        0x2::table::add<address, 0x1::string::String>(&mut arg0.members, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

