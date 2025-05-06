module 0x8743e742a4b838115d1552c4d4836e9c50e34c1f52e75f5c4c9c8a5bb0733f3d::committee {
    struct Committee has store {
        members: 0x2::table::Table<address, Member>,
    }

    struct Member has drop, store {
        weight: u64,
        role: u64,
        joined_time: u64,
        nine: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Committee {
        let v0 = Committee{members: 0x2::table::new<address, Member>(arg0)};
        let v1 = &mut v0;
        add_member_internal(v1, 0x2::tx_context::sender(arg0), 9, 10000, arg0);
        v0
    }

    public fun add_member(arg0: &mut Committee, arg1: address, arg2: &0x2::tx_context::TxContext) {
        validate_admin(arg0, arg2);
        assert!(!0x2::table::contains<address, Member>(&arg0.members, arg1), 1190002);
        add_member_internal(arg0, arg1, 9, 10000, arg2);
    }

    fun add_member_internal(arg0: &mut Committee, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = Member{
            weight      : arg3,
            role        : arg2,
            joined_time : 0x2::tx_context::epoch(arg4),
            nine        : false,
        };
        0x2::table::add<address, Member>(&mut arg0.members, arg1, v0);
    }

    public fun is_member(arg0: &Committee, arg1: address) : bool {
        0x2::table::contains<address, Member>(&arg0.members, arg1)
    }

    public fun remove_member(arg0: &mut Committee, arg1: address, arg2: &0x2::tx_context::TxContext) {
        validate_admin(arg0, arg2);
        assert!(0x2::table::contains<address, Member>(&arg0.members, arg1), 1190000);
        0x2::table::remove<address, Member>(&mut arg0.members, arg1);
    }

    fun validate_admin(arg0: &Committee, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Member>(&arg0.members, v0), 1190000);
        assert!(0x2::table::borrow<address, Member>(&arg0.members, v0).role == 9, 1190001);
    }

    // decompiled from Move bytecode v6
}

