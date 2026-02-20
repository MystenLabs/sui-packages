module 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::member_registry {
    struct MemberRegistry has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        current_term: u64,
        members: vector<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>,
    }

    struct MemberRegistryCreated has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    struct MemberRegistryDeleted has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    public fun create_and_share_blockblock_member_registry(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MemberRegistry{
            id           : 0x2::object::new(arg2),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg1),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg1),
            members      : 0x1::vector::empty<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(),
        };
        let v1 = MemberRegistryCreated{
            registry_id  : 0x2::object::id<MemberRegistry>(&v0),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg1),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg1),
        };
        0x2::event::emit<MemberRegistryCreated>(v1);
        0x2::transfer::share_object<MemberRegistry>(v0);
    }

    public fun register_member_info_to_blockblock_member_registry(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::MemberWitness, arg1: &mut MemberRegistry, arg2: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo) {
        assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(&arg2) == 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::member_address(&arg0), 2);
        let v0 = &arg1.members;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0)) {
            assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(0x1::vector::borrow<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0, v1)) != 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(&arg2), 7);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(&mut arg1.members, arg2);
    }

    public fun store_member_addresses_in_member_registry_to_current_blockblockclub(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &mut 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: MemberRegistry) {
        assert!(arg2.current_term == 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::term(arg1), 2);
        let v0 = &arg2.members;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0)) {
            let v2 = 0x1::vector::borrow<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0, v1);
            if (0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::is_junior(v2)) {
                0x1::vector::push_back<address>(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::borrow_mut_junior_members(arg1), 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(v2));
            } else {
                0x1::vector::push_back<address>(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::borrow_mut_senior_members(arg1), 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(v2));
            };
            v1 = v1 + 1;
        };
        let v3 = MemberRegistryDeleted{
            registry_id  : 0x2::object::id<MemberRegistry>(&arg2),
            current_term : arg2.current_term,
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::id(arg1),
        };
        0x2::event::emit<MemberRegistryDeleted>(v3);
        let MemberRegistry {
            id           : v4,
            club_id      : _,
            current_term : _,
            members      : _,
        } = arg2;
        0x2::object::delete(v4);
    }

    // decompiled from Move bytecode v6
}

