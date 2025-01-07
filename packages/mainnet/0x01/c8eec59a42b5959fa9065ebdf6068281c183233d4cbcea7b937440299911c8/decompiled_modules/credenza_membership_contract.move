module 0x1c8eec59a42b5959fa9065ebdf6068281c183233d4cbcea7b937440299911c8::credenza_membership_contract {
    struct Membership has key {
        id: 0x2::object::UID,
        user: address,
        metadata: 0x1::string::String,
    }

    struct MembershipAddedEvent has copy, drop {
        membership: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    struct MembershipRemovedEvent has copy, drop {
        membership: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    struct MembershipAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_membership(arg0: &mut MembershipAdminCap, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Membership{
            id       : 0x2::object::new(arg3),
            user     : arg1,
            metadata : arg2,
        };
        let v1 = MembershipAddedEvent{
            membership : 0x2::object::uid_to_inner(&v0.id),
            user       : arg1,
            metadata   : arg2,
        };
        0x2::event::emit<MembershipAddedEvent>(v1);
        0x2::transfer::transfer<Membership>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MembershipAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MembershipAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun remove_membership(arg0: Membership) {
        let Membership {
            id       : v0,
            user     : v1,
            metadata : v2,
        } = arg0;
        let v3 = MembershipRemovedEvent{
            membership : 0x2::object::uid_to_inner(&arg0.id),
            user       : v1,
            metadata   : v2,
        };
        0x2::event::emit<MembershipRemovedEvent>(v3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

