module 0x1b74780ae834195aa8716690077221954160bd8aca7612b83dd019c45952584::credenza_membership_contract {
    struct MembershipList has store, key {
        id: 0x2::object::UID,
        members: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct MembershipAddedEvent has copy, drop {
        membership: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    struct MembershipStatus has copy, drop {
        user: address,
        hasMembership: bool,
        metadata: 0x1::string::String,
    }

    public fun addMembership(arg0: &mut MembershipList, arg1: address, arg2: 0x1::string::String) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.members, arg1);
        } else {
            let v0 = MembershipAddedEvent{
                membership : 0x2::object::uid_to_inner(&arg0.id),
                user       : arg1,
                metadata   : arg2,
            };
            0x2::event::emit<MembershipAddedEvent>(v0);
        };
        0x2::table::add<address, 0x1::string::String>(&mut arg0.members, arg1, arg2);
    }

    public fun hasMembership(arg0: &MembershipList, arg1: address) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            let v0 = MembershipStatus{
                user          : arg1,
                hasMembership : true,
                metadata      : *0x2::table::borrow<address, 0x1::string::String>(&arg0.members, arg1),
            };
            0x2::event::emit<MembershipStatus>(v0);
        } else {
            let v1 = MembershipStatus{
                user          : arg1,
                hasMembership : false,
                metadata      : 0x1::string::utf8(0x1::vector::empty<u8>()),
            };
            0x2::event::emit<MembershipStatus>(v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MembershipList{
            id      : 0x2::object::new(arg0),
            members : 0x2::table::new<address, 0x1::string::String>(arg0),
        };
        0x2::transfer::transfer<MembershipList>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun removeMembership(arg0: &mut MembershipList, arg1: address) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.members, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

