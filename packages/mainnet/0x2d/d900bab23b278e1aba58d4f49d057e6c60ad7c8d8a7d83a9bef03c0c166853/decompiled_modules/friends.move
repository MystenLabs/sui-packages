module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::friends {
    struct FriendRegistry has key {
        id: 0x2::object::UID,
    }

    struct FriendKey has copy, drop, store {
        pos0: address,
    }

    struct FriendList has key {
        id: 0x2::object::UID,
        owner: address,
        friends: 0x2::vec_set::VecSet<address>,
    }

    public(friend) fun create(arg0: &mut FriendRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = FriendKey{pos0: v0};
        assert!(!0x2::derived_object::exists<FriendKey>(&arg0.id, v1), 2101);
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, arg1);
        let v3 = FriendKey{pos0: v0};
        let v4 = FriendList{
            id      : 0x2::derived_object::claim<FriendKey>(&mut arg0.id, v3),
            owner   : v0,
            friends : v2,
        };
        0x2::transfer::transfer<FriendList>(v4, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FriendRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FriendRegistry>(v0);
    }

    public(friend) fun set(arg0: &mut FriendList, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2102);
        if (arg2) {
            assert!(!0x2::vec_set::contains<address>(&arg0.friends, &arg1), 2103);
            assert!(0x2::vec_set::length<address>(&arg0.friends) < 100, 2105);
            0x2::vec_set::insert<address>(&mut arg0.friends, arg1);
        } else {
            assert!(0x2::vec_set::contains<address>(&arg0.friends, &arg1), 2104);
            0x2::vec_set::remove<address>(&mut arg0.friends, &arg1);
        };
    }

    public(friend) fun snapshot(arg0: &FriendList) : 0x2::vec_set::VecSet<address> {
        arg0.friends
    }

    public(friend) fun uid(arg0: &FriendRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut FriendRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

