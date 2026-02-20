module 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::alumni {
    struct ALUMNI has drop {
        dummy_field: bool,
    }

    struct BlockBlockAlumni has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        term: u64,
        img_url: 0x1::string::String,
    }

    struct AlumniRegistry has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        current_term: u64,
        certificate_folder_name: 0x1::string::String,
        pending_members: vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>,
        minted_members: vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>,
    }

    struct AlumniRegistryCreated has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    public fun check_and_mint_certificate_of_completions(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::FormerPresidentWitness, arg1: &mut AlumniRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::is_empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&arg1.pending_members) == false) {
            let v0 = 0x1::vector::pop_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg1.pending_members);
            let v1 = b"https://vuhaopuyxmqlpkpeqvaf.supabase.co/storage/v1/object/public/completion_certificate/";
            0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(arg1.certificate_folder_name));
            0x1::vector::append<u8>(&mut v1, b"/");
            0x1::vector::append<u8>(&mut v1, b"Blockblock");
            0x1::vector::append<u8>(&mut v1, b"_");
            0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::name(&v0)));
            0x1::vector::append<u8>(&mut v1, b"_");
            0x1::vector::append<u8>(&mut v1, 0x1::string::into_bytes(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::major(&v0)));
            0x1::vector::append<u8>(&mut v1, b".svg");
            let v2 = BlockBlockAlumni{
                id      : 0x2::object::new(arg2),
                club_id : arg1.club_id,
                term    : arg1.current_term - 1,
                img_url : 0x1::string::utf8(v1),
            };
            0x2::transfer::transfer<BlockBlockAlumni>(v2, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&v0));
            0x1::vector::push_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg1.minted_members, v0);
        };
    }

    public fun create_and_share_alumni_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::FormerPresidentWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::is_active(arg1) == false, 10);
        let v0 = AlumniRegistry{
            id                      : 0x2::object::new(arg4),
            club_id                 : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg2),
            current_term            : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg2),
            certificate_folder_name : arg3,
            pending_members         : 0x1::vector::empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(),
            minted_members          : 0x1::vector::empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(),
        };
        let v1 = AlumniRegistryCreated{
            registry_id  : 0x2::object::id<AlumniRegistry>(&v0),
            current_term : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg2),
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg2),
        };
        0x2::event::emit<AlumniRegistryCreated>(v1);
        0x2::transfer::share_object<AlumniRegistry>(v0);
    }

    fun init(arg0: ALUMNI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ALUMNI>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"BlockBlock Completion NFT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"BlockBlock club completion certificate NFT"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{img_url}"));
        let v5 = 0x2::display::new_with_fields<BlockBlockAlumni>(&v0, v1, v3, arg1);
        0x2::display::update_version<BlockBlockAlumni>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<BlockBlockAlumni>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun register_member_info_to_alumni_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::MemberWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut AlumniRegistry, arg3: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo) {
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::member_address(&arg0), 1);
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        assert!(0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg1), &v0), 11);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::is_junior(&arg3) == false, 12);
        let v1 = &arg2.pending_members;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(v1)) {
            assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(0x1::vector::borrow<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(v1, v2)) != 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3), 2);
            v2 = v2 + 1;
        };
        let v3 = &arg2.minted_members;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(v3)) {
            assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(0x1::vector::borrow<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(v3, v4)) != 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3), 2);
            v4 = v4 + 1;
        };
        0x1::vector::push_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg2.pending_members, arg3);
    }

    // decompiled from Move bytecode v6
}

