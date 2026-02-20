module 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members {
    struct MemberInfo has drop, store {
        current_term: u64,
        is_junior: bool,
        name: 0x1::string::String,
        major: 0x1::string::String,
        member_address: address,
    }

    public fun create_member_info(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) : MemberInfo {
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::previous_term(arg0) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1), 2);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::previous_club(arg0) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::id(arg1), 2);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg0) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg2), 2);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg0) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::id(arg2), 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_junior_members(arg1), &v0)) {
            true
        } else {
            let v2 = 0x2::tx_context::sender(arg5);
            0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg1), &v2)
        };
        MemberInfo{
            current_term   : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg0),
            is_junior      : !v1,
            name           : arg3,
            major          : arg4,
            member_address : 0x2::tx_context::sender(arg5),
        }
    }

    public fun create_member_info_by_president_or_vice_president(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: address, arg3: &0x2::tx_context::TxContext) : MemberInfo {
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg0) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1), 2);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg3) || 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg3), 13906834406271614975);
        MemberInfo{
            current_term   : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg0),
            is_junior      : false,
            name           : 0x1::string::utf8(b""),
            major          : 0x1::string::utf8(b""),
            member_address : arg2,
        }
    }

    public(friend) fun is_junior(arg0: &MemberInfo) : bool {
        arg0.is_junior
    }

    public(friend) fun major(arg0: &MemberInfo) : 0x1::string::String {
        arg0.major
    }

    public(friend) fun member_address(arg0: &MemberInfo) : address {
        arg0.member_address
    }

    public(friend) fun name(arg0: &MemberInfo) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

