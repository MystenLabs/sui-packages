module 0xce13403dddb989f83670c25b478b15af91ae974b3b896602b3b01c4510a0d8e5::party_group {
    struct PartyGroupInvite has key {
        id: 0x2::object::UID,
        group_id: 0x2::object::ID,
    }

    struct PartyMemberKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PartyGroupMembershipKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct PartyMemberAddedEvent has copy, drop {
        group_id: 0x2::object::ID,
        member_id: 0x2::object::ID,
        invite_id: 0x2::object::ID,
    }

    struct PartyMemberRemovedEvent has copy, drop {
        group_id: 0x2::object::ID,
        member_id: 0x2::object::ID,
    }

    struct PartyGroupJoinedEvent has copy, drop {
        group_id: 0x2::object::ID,
        member_id: 0x2::object::ID,
    }

    struct PartyGroupInviteDeclinedEvent has copy, drop {
        group_id: 0x2::object::ID,
        member_id: 0x2::object::ID,
        invite_id: 0x2::object::ID,
    }

    struct PartyGroupLeftEvent has copy, drop {
        group_id: 0x2::object::ID,
        member_id: 0x2::object::ID,
    }

    public fun add_member(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0);
        let v1 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg2);
        let v2 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v3 = PartyMemberKey{pos0: v1};
        assert!(!0x2::dynamic_field::exists<PartyMemberKey>(v2, v3), 0);
        assert!(!has_group_membership(arg2, v0), 6);
        let v4 = PartyMemberKey{pos0: v1};
        0x2::dynamic_field::add<PartyMemberKey, bool>(v2, v4, true);
        let v5 = PartyGroupInvite{
            id       : 0x2::object::new(arg3),
            group_id : v0,
        };
        0x2::transfer::transfer<PartyGroupInvite>(v5, 0x2::object::id_to_address(&v1));
        let v6 = PartyMemberAddedEvent{
            group_id  : v0,
            member_id : v1,
            invite_id : 0x2::object::id<PartyGroupInvite>(&v5),
        };
        0x2::event::emit<PartyMemberAddedEvent>(v6);
    }

    public fun decline(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x2::transfer::Receiving<PartyGroupInvite>) {
        let PartyGroupInvite {
            id       : v0,
            group_id : v1,
        } = 0x2::transfer::receive<PartyGroupInvite>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1), arg2);
        let v2 = v0;
        0x2::object::delete(v2);
        let v3 = PartyGroupInviteDeclinedEvent{
            group_id  : v1,
            member_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            invite_id : 0x2::object::uid_to_inner(&v2),
        };
        0x2::event::emit<PartyGroupInviteDeclinedEvent>(v3);
    }

    public fun has_group_membership(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: 0x2::object::ID) : bool {
        let v0 = PartyGroupMembershipKey{pos0: arg1};
        0x2::dynamic_field::exists<PartyGroupMembershipKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun has_member(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: 0x2::object::ID) : bool {
        let v0 = PartyMemberKey{pos0: arg1};
        0x2::dynamic_field::exists<PartyMemberKey>(0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid(arg0), v0)
    }

    public fun is_member(arg0: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party) : bool {
        has_member(arg0, 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg1)) && has_group_membership(arg1, 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0))
    }

    public fun join(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg3: 0x2::transfer::Receiving<PartyGroupInvite>) {
        let v0 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0);
        let v1 = 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg2);
        let v2 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v3 = 0x2::transfer::receive<PartyGroupInvite>(v2, arg3);
        assert!(v3.group_id == v1, 5);
        assert!(has_member(arg2, v0), 4);
        let PartyGroupInvite {
            id       : v4,
            group_id : _,
        } = v3;
        0x2::object::delete(v4);
        let v6 = PartyGroupMembershipKey{pos0: v1};
        assert!(!0x2::dynamic_field::exists<PartyGroupMembershipKey>(v2, v6), 2);
        let v7 = PartyGroupMembershipKey{pos0: v1};
        0x2::dynamic_field::add<PartyGroupMembershipKey, bool>(v2, v7, true);
        let v8 = PartyGroupJoinedEvent{
            group_id  : v1,
            member_id : v0,
        };
        0x2::event::emit<PartyGroupJoinedEvent>(v8);
    }

    public fun leave(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyGroupMembershipKey{pos0: arg2};
        assert!(0x2::dynamic_field::exists<PartyGroupMembershipKey>(v0, v1), 3);
        let v2 = PartyGroupMembershipKey{pos0: arg2};
        0x2::dynamic_field::remove<PartyGroupMembershipKey, bool>(v0, v2);
        let v3 = PartyGroupLeftEvent{
            group_id  : arg2,
            member_id : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
        };
        0x2::event::emit<PartyGroupLeftEvent>(v3);
    }

    public fun party_group_invite_group_id(arg0: &PartyGroupInvite) : 0x2::object::ID {
        arg0.group_id
    }

    public fun remove_member(arg0: &mut 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party, arg1: &0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::PartyAdminCap, arg2: 0x2::object::ID) {
        let v0 = 0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::uid_mut(arg0, arg1);
        let v1 = PartyMemberKey{pos0: arg2};
        assert!(0x2::dynamic_field::exists<PartyMemberKey>(v0, v1), 1);
        let v2 = PartyMemberKey{pos0: arg2};
        0x2::dynamic_field::remove<PartyMemberKey, bool>(v0, v2);
        let v3 = PartyMemberRemovedEvent{
            group_id  : 0x2::object::id<0xb11906f9134cc6a0035febbe807465dbf125ddd4c1258cc1e64c78a1506c8e81::party::Party>(arg0),
            member_id : arg2,
        };
        0x2::event::emit<PartyMemberRemovedEvent>(v3);
    }

    // decompiled from Move bytecode v7
}

