module 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::members {
    struct MemberInfo has drop, store {
        current_term: u64,
        is_junior: bool,
        name: 0x1::string::String,
        major: 0x1::string::String,
        member_address: address,
    }

    public fun create_member_info(arg0: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) : MemberInfo {
        assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg0) == 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::term(arg1), 2);
        MemberInfo{
            current_term   : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg0),
            is_junior      : arg2,
            name           : arg3,
            major          : arg4,
            member_address : 0x2::tx_context::sender(arg5),
        }
    }

    public fun create_member_info_by_president_or_vice_president(arg0: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockRegistry, arg1: &0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::BlockBlockClub, arg2: address, arg3: &0x2::tx_context::TxContext) : MemberInfo {
        assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg0) == 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::term(arg1), 2);
        assert!(0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::president(arg1) == 0x2::tx_context::sender(arg3) || 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3), 13906834371911876607);
        MemberInfo{
            current_term   : 0xf42fc87f86c22014d86828822aaa0157900e5353ad9ce40635377a1e1f966207::blockblock::current_term(arg0),
            is_junior      : false,
            name           : 0x1::string::utf8(b""),
            major          : 0x1::string::utf8(b""),
            member_address : arg2,
        }
    }

    public(friend) fun is_junior(arg0: &MemberInfo) : bool {
        arg0.is_junior
    }

    public(friend) fun member_address(arg0: &MemberInfo) : address {
        arg0.member_address
    }

    // decompiled from Move bytecode v6
}

