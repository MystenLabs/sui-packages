module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::party {
    struct Party has key {
        id: 0x2::object::UID,
        members: vector<0x2::object::ID>,
        pending: vector<0x2::object::ID>,
    }

    public(friend) fun accept(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: &mut Party, arg2: 0x2::object::ID) {
        remove_pending_invitation(arg1, arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.members) < 6, 2004);
        claim_membership(arg0, arg2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.members, arg2);
    }

    public(friend) fun assert_membership_available(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid(arg0), arg1), 2002);
    }

    fun claim_membership(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: 0x2::object::ID) {
        assert!(!0x2::dynamic_field::exists<0x2::object::ID>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid(arg0), arg1), 2002);
        0x2::dynamic_field::add<0x2::object::ID, bool>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid_mut(arg0), arg1, true);
    }

    public(friend) fun create_inviting(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v0, arg1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, arg2);
        let v2 = Party{
            id      : 0x2::object::new(arg3),
            members : v0,
            pending : v1,
        };
        claim_membership(arg0, arg1);
        assert_membership_available(arg0, arg2);
        0x2::transfer::share_object<Party>(v2);
    }

    public(friend) fun disband(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: Party, arg2: 0x2::object::ID) {
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg1.members, 0) == arg2, 2001);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.members) == 1, 2009);
        release_membership(arg0, arg2);
        let Party {
            id      : v0,
            members : _,
            pending : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun is_member(arg0: &Party, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.members, &arg1)
    }

    public(friend) fun kick(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: &mut Party, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg1.members, 0) == arg2, 2001);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.members, &arg3);
        assert!(v0, 2006);
        assert!(v1 != 0, 2007);
        release_membership(arg0, arg3);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.members, v1);
    }

    public(friend) fun leave(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: &mut Party, arg2: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.members, &arg2);
        assert!(v0, 2006);
        if (v1 == 0) {
            assert!(0x1::vector::length<0x2::object::ID>(&arg1.members) > 1, 2008);
        };
        release_membership(arg0, arg2);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.members, v1);
    }

    fun release_membership(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: 0x2::object::ID) {
        assert!(0x2::dynamic_field::exists<0x2::object::ID>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid(arg0), arg1), 2006);
        0x2::dynamic_field::remove<0x2::object::ID, bool>(0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::uid_mut(arg0), arg1);
    }

    fun remove_pending_invitation(arg0: &mut Party, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.pending, &arg1);
        assert!(v0, 2005);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.pending, v1);
    }

    public(friend) fun update_invitation(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends::FriendRegistry, arg1: &mut Party, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool) {
        if (arg4) {
            assert!(is_member(arg1, arg2), 2006);
            assert_membership_available(arg0, arg3);
            assert!(!0x1::vector::contains<0x2::object::ID>(&arg1.pending, &arg3), 2003);
            assert!(0x1::vector::length<0x2::object::ID>(&arg1.members) < 6 && 0x1::vector::length<0x2::object::ID>(&arg1.pending) < 6, 2004);
            0x1::vector::push_back<0x2::object::ID>(&mut arg1.pending, arg3);
        } else {
            assert!(arg2 == arg3 || *0x1::vector::borrow<0x2::object::ID>(&arg1.members, 0) == arg2, 2001);
            remove_pending_invitation(arg1, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

