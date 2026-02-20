module 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::alumni {
    struct CertificateOfCompletion has key {
        id: 0x2::object::UID,
        img_url: 0x1::string::String,
    }

    struct Alumni has key {
        id: 0x2::object::UID,
        img_url: 0x1::string::String,
    }

    struct AlumniRegistry has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        current_term: u64,
        members: vector<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>,
    }

    public fun check_and_mit_certificate_of_completions(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: &mut AlumniRegistry, arg3: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo) {
        let v0 = &arg2.members;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0)) {
            let v2 = 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(0x1::vector::borrow<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0, v1));
            assert!(0x1::vector::contains<address>(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::borrow_senior_members(arg1), &v2), 13906834462106189823);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(&mut arg2.members, arg3);
    }

    public fun create_and_share_alumni_registry(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::PresidentWitness, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AlumniRegistry{
            id           : 0x2::object::new(arg2),
            club_id      : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_club(arg1),
            current_term : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg1),
            members      : 0x1::vector::empty<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(),
        };
        0x2::transfer::share_object<AlumniRegistry>(v0);
    }

    public fun register_member_info_to_alumni_registry(arg0: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::MemberWitness, arg1: &mut AlumniRegistry, arg2: 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo) {
        assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(&arg2) == 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::member_address(&arg0), 1);
        let v0 = &arg1.members;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0)) {
            assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(0x1::vector::borrow<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(v0, v1)) != 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::member_address(&arg2), 1);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members::MemberInfo>(&mut arg1.members, arg2);
    }

    // decompiled from Move bytecode v6
}

