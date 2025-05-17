module 0xeb37dc8a10425cb5e75ee8775ef12bb7ac098d9e4e34076344c661cab8d63358::suibeacon {
    struct MemberNFT has store, key {
        id: 0x2::object::UID,
        username: 0x1::string::String,
        project_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        role: 0x1::string::String,
        join_date: u64,
        team_id: 0x1::string::String,
    }

    struct TeamAdmin has key {
        id: 0x2::object::UID,
    }

    struct TeamRegistry has key {
        id: 0x2::object::UID,
        team_members: 0x2::table::Table<0x1::string::String, vector<address>>,
        minted: 0x2::table::Table<address, bool>,
    }

    struct MemberAdded has copy, drop {
        team_id: 0x1::string::String,
        member: address,
    }

    struct NFTMinted has copy, drop {
        recipient: address,
        username: 0x1::string::String,
        project_name: 0x1::string::String,
        blob_id: 0x1::string::String,
        team_id: 0x1::string::String,
    }

    public entry fun add_team_member(arg0: &TeamAdmin, arg1: vector<u8>, arg2: address, arg3: &mut TeamRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, vector<address>>(&arg3.team_members, v0), 4);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, vector<address>>(&mut arg3.team_members, v0);
        if (!0x1::vector::contains<address>(v1, &arg2)) {
            0x1::vector::push_back<address>(v1, arg2);
            let v2 = MemberAdded{
                team_id : v0,
                member  : arg2,
            };
            0x2::event::emit<MemberAdded>(v2);
        };
    }

    public entry fun create_team(arg0: &TeamAdmin, arg1: vector<u8>, arg2: &mut TeamRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        if (!0x2::table::contains<0x1::string::String, vector<address>>(&arg2.team_members, v0)) {
            0x2::table::add<0x1::string::String, vector<address>>(&mut arg2.team_members, v0, 0x1::vector::empty<address>());
        };
    }

    public fun has_minted(arg0: address, arg1: &TeamRegistry) : bool {
        0x2::table::contains<address, bool>(&arg1.minted, arg0) && *0x2::table::borrow<address, bool>(&arg1.minted, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeamAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TeamAdmin>(v0, 0x2::tx_context::sender(arg0));
        let v1 = TeamRegistry{
            id           : 0x2::object::new(arg0),
            team_members : 0x2::table::new<0x1::string::String, vector<address>>(arg0),
            minted       : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<TeamRegistry>(v1);
    }

    public fun is_team_member(arg0: address, arg1: vector<u8>, arg2: &TeamRegistry) : bool {
        let v0 = 0x1::string::utf8(arg1);
        if (!0x2::table::contains<0x1::string::String, vector<address>>(&arg2.team_members, v0)) {
            return false
        };
        0x1::vector::contains<address>(0x2::table::borrow<0x1::string::String, vector<address>>(&arg2.team_members, v0), &arg0)
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut TeamRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x1::string::utf8(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg5.minted, v0) || !*0x2::table::borrow<address, bool>(&arg5.minted, v0), 2);
        assert!(0x2::table::contains<0x1::string::String, vector<address>>(&arg5.team_members, v1), 4);
        assert!(0x1::vector::contains<address>(0x2::table::borrow<0x1::string::String, vector<address>>(&arg5.team_members, v1), &v0), 3);
        let v2 = MemberNFT{
            id           : 0x2::object::new(arg7),
            username     : 0x1::string::utf8(arg0),
            project_name : 0x1::string::utf8(arg1),
            blob_id      : 0x1::string::utf8(arg2),
            role         : 0x1::string::utf8(arg4),
            join_date    : 0x2::clock::timestamp_ms(arg6),
            team_id      : v1,
        };
        if (0x2::table::contains<address, bool>(&arg5.minted, v0)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg5.minted, v0) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg5.minted, v0, true);
        };
        let v3 = NFTMinted{
            recipient    : v0,
            username     : 0x1::string::utf8(arg0),
            project_name : 0x1::string::utf8(arg1),
            blob_id      : 0x1::string::utf8(arg2),
            team_id      : v1,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::transfer<MemberNFT>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

