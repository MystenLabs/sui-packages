module 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::mission {
    struct MissionGlobal has key {
        id: 0x2::object::UID,
        balance_SHUI: 0x2::balance::Balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>,
        invite_pool_limit: u64,
        mission_records: 0x2::linked_table::LinkedTable<0x1::string::String, MissionInfo>,
        invite_claim_records: 0x2::table::Table<u64, 0x2::table::Table<u64, bool>>,
        creator: address,
        version: u64,
    }

    struct MissionInfo has store {
        name: 0x1::string::String,
        desc: 0x1::string::String,
        goal_process: u64,
        missions: 0x2::table::Table<u64, UserRecord>,
        deadline: u64,
        reward: 0x1::string::String,
    }

    struct UserRecord has drop, store {
        name: 0x1::string::String,
        metaId: u64,
        current_process: u64,
        is_claimed: bool,
    }

    public(friend) fun add_process(arg0: &mut MissionGlobal, arg1: 0x1::string::String, arg2: &0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity) {
        let v0 = &mut arg0.mission_records;
        if (0x2::linked_table::contains<0x1::string::String, MissionInfo>(v0, arg1)) {
            let v1 = 0x2::linked_table::borrow_mut<0x1::string::String, MissionInfo>(v0, arg1);
            let v2 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::get_meta_id(arg2);
            if (!0x2::table::contains<u64, UserRecord>(&v1.missions, v2)) {
                let v3 = UserRecord{
                    name            : arg1,
                    metaId          : v2,
                    current_process : 1,
                    is_claimed      : false,
                };
                0x2::table::add<u64, UserRecord>(&mut v1.missions, v2, v3);
            } else {
                let v4 = 0x2::table::borrow_mut<u64, UserRecord>(&mut v1.missions, v2);
                if (v4.current_process < v1.goal_process) {
                    v4.current_process = v4.current_process + 1;
                };
            };
        };
    }

    public fun change_owner(arg0: &mut MissionGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        arg0.creator = arg1;
    }

    public entry fun claim_invite_mission(arg0: &mut MissionGlobal, arg1: &0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaInfoGlobal, arg2: u64, arg3: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9);
        let v0 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::query_invited_num(arg1, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3));
        let v1 = false;
        if (arg2 == 2 && v0 >= 2) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 100;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 100 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        if (arg2 == 5 && v0 >= 5) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 500;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 500 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        if (arg2 == 10 && v0 >= 10) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 1000;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 1000 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        if (arg2 == 20 && v0 >= 20) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 3000;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 3000 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        if (arg2 == 50 && v0 >= 50) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 10000;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 10000 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        if (arg2 == 75 && v0 >= 75) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 25000;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 25000 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        if (arg2 == 99 && v0 >= 99) {
            arg0.invite_pool_limit = arg0.invite_pool_limit + 50000;
            if (!has_clamied_invite(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 50000 * 1000000000), arg4), 0x2::tx_context::sender(arg4));
                record_invite_clamied(arg0, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg3), arg2, arg4);
                v1 = true;
            };
        };
        assert!(arg0.invite_pool_limit <= 59000000, 7);
        assert!(v1, 8);
    }

    public entry fun claim_mission(arg0: &mut MissionGlobal, arg1: 0x1::string::String, arg2: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity) {
        assert!(arg0.version == 0, 9);
        let v0 = &mut arg0.mission_records;
        assert!(0x2::linked_table::contains<0x1::string::String, MissionInfo>(v0, arg1), 4);
        let v1 = 0x2::linked_table::borrow_mut<0x1::string::String, MissionInfo>(v0, arg1);
        let v2 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::get_meta_id(arg2);
        assert!(0x2::table::contains<u64, UserRecord>(&v1.missions, v2), 3);
        let v3 = 0x2::table::borrow_mut<u64, UserRecord>(&mut v1.missions, v2);
        assert!(!v3.is_claimed, 5);
        assert!(v3.current_process >= v1.goal_process, 6);
        v3.is_claimed = true;
        let v4 = 0x1::string::utf8(b"receive reward");
        0x1::debug::print<0x1::string::String>(&v4);
    }

    public entry fun delete_mission(arg0: &mut MissionGlobal, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 2);
        assert!(0x2::linked_table::contains<0x1::string::String, MissionInfo>(&arg0.mission_records, arg1), 1);
        let MissionInfo {
            name         : _,
            desc         : _,
            goal_process : _,
            missions     : v3,
            deadline     : _,
            reward       : _,
        } = 0x2::linked_table::remove<0x1::string::String, MissionInfo>(&mut arg0.mission_records, arg1);
        0x2::table::drop<u64, UserRecord>(v3);
    }

    fun has_clamied_invite(arg0: &MissionGlobal, arg1: u64, arg2: u64) : bool {
        if (!0x2::table::contains<u64, 0x2::table::Table<u64, bool>>(&arg0.invite_claim_records, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u64, 0x2::table::Table<u64, bool>>(&arg0.invite_claim_records, arg1);
        if (!0x2::table::contains<u64, bool>(v0, arg2)) {
            return false
        };
        *0x2::table::borrow<u64, bool>(v0, arg2)
    }

    public fun increment(arg0: &mut MissionGlobal, arg1: u64) {
        assert!(arg0.version == 0, 9);
        arg0.version = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MissionGlobal{
            id                   : 0x2::object::new(arg0),
            balance_SHUI         : 0x2::balance::zero<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(),
            invite_pool_limit    : 0,
            mission_records      : 0x2::linked_table::new<0x1::string::String, MissionInfo>(arg0),
            invite_claim_records : 0x2::table::new<u64, 0x2::table::Table<u64, bool>>(arg0),
            creator              : @0x1cb722782ce2440afefff4062fd0bd98021c09b5ef720b7e584e7c071cd417,
            version              : 0,
        };
        0x2::transfer::share_object<MissionGlobal>(v0);
    }

    public fun init_funds_from_main_contract(arg0: &mut MissionGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::Global, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        0x2::balance::join<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::extract_mission_reserve_balance(arg1, arg2));
    }

    public fun init_missions(arg0: &mut MissionGlobal, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"water down");
        let v1 = MissionInfo{
            name         : v0,
            desc         : 0x1::string::utf8(b"water down 3 times"),
            goal_process : 3,
            missions     : 0x2::table::new<u64, UserRecord>(arg2),
            deadline     : 0x2::clock::timestamp_ms(arg1) + 3 * 86400000,
            reward       : 0x1::string::utf8(b"anything"),
        };
        assert!(!0x2::linked_table::contains<0x1::string::String, MissionInfo>(&arg0.mission_records, v0), 1);
        0x2::linked_table::push_back<0x1::string::String, MissionInfo>(&mut arg0.mission_records, v0, v1);
    }

    fun numbers_to_ascii_vector(arg0: u16) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun numbers_to_ascii_vector_64(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun query_invite_status(arg0: &MissionGlobal, arg1: &0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaInfoGlobal, arg2: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = *0x1::string::bytes(&v0);
        let v2 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::query_invited_num(arg1, arg2);
        let v3 = numbers_to_ascii_vector(1);
        let v4 = numbers_to_ascii_vector(0);
        let v5 = numbers_to_ascii_vector(2);
        if (v2 >= 2) {
            if (!has_clamied_invite(arg0, arg2, 2)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        if (v2 >= 5) {
            if (!has_clamied_invite(arg0, arg2, 5)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        if (v2 >= 10) {
            if (!has_clamied_invite(arg0, arg2, 10)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        if (v2 >= 20) {
            if (!has_clamied_invite(arg0, arg2, 20)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        if (v2 >= 50) {
            if (!has_clamied_invite(arg0, arg2, 50)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        if (v2 >= 75) {
            if (!has_clamied_invite(arg0, arg2, 75)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        if (v2 >= 99) {
            if (!has_clamied_invite(arg0, arg2, 99)) {
                0x1::vector::append<u8>(&mut v1, v5);
            } else {
                0x1::vector::append<u8>(&mut v1, v3);
            };
        } else {
            0x1::vector::append<u8>(&mut v1, v4);
        };
        0x1::string::utf8(v1)
    }

    public entry fun query_mission_list(arg0: &MissionGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: &0x2::clock::Clock) : 0x1::string::String {
        let v0 = &arg0.mission_records;
        let v1 = 0x2::linked_table::front<0x1::string::String, MissionInfo>(v0);
        let v2 = 0x2::linked_table::borrow<0x1::string::String, MissionInfo>(v0, *0x1::option::borrow<0x1::string::String>(v1));
        let v3 = v2.deadline;
        let v4 = 0x2::clock::timestamp_ms(arg2);
        let v5 = 0x1::string::utf8(b"");
        let v6 = *0x1::string::bytes(&v5);
        let v7 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::get_meta_id(arg1);
        let v8 = 0x1::ascii::byte(0x1::ascii::char(58));
        let v9 = 0x1::ascii::byte(0x1::ascii::char(59));
        if (0x2::table::contains<u64, UserRecord>(&v2.missions, v7)) {
            let v10 = 0x2::table::borrow<u64, UserRecord>(&v2.missions, v7);
            if (!v10.is_claimed && v4 < v3) {
                0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v2.name));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v2.desc));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector((v10.current_process as u16)));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector((v2.goal_process as u16)));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector_64(v2.deadline - v4));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v2.reward));
                0x1::vector::push_back<u8>(&mut v6, v9);
            };
        } else if (v4 < v3) {
            0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v2.name));
            0x1::vector::push_back<u8>(&mut v6, v8);
            0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v2.desc));
            0x1::vector::push_back<u8>(&mut v6, v8);
            0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector((0 as u16)));
            0x1::vector::push_back<u8>(&mut v6, v8);
            0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector((v2.goal_process as u16)));
            0x1::vector::push_back<u8>(&mut v6, v8);
            0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector_64(v2.deadline - v4));
            0x1::vector::push_back<u8>(&mut v6, v8);
            0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v2.reward));
            0x1::vector::push_back<u8>(&mut v6, v9);
        };
        let v11 = 0x2::linked_table::next<0x1::string::String, MissionInfo>(v0, *0x1::option::borrow<0x1::string::String>(v1));
        while (0x1::option::is_some<0x1::string::String>(v11)) {
            let v12 = *0x1::option::borrow<0x1::string::String>(v11);
            0x1::debug::print<0x1::string::String>(&v12);
            let v13 = 0x2::linked_table::borrow<0x1::string::String, MissionInfo>(v0, v12);
            let v14 = 0;
            if (0x2::table::contains<u64, UserRecord>(&v13.missions, v7)) {
                let v15 = 0x2::table::borrow<u64, UserRecord>(&v13.missions, v7);
                if (v15.is_claimed) {
                    continue
                };
                v14 = v15.current_process;
            };
            if (v4 < v3) {
                0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v13.name));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v13.desc));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector((v14 as u16)));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector((v13.goal_process as u16)));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, numbers_to_ascii_vector_64(v13.deadline - v4));
                0x1::vector::push_back<u8>(&mut v6, v8);
                0x1::vector::append<u8>(&mut v6, *0x1::string::bytes(&v13.reward));
                0x1::vector::push_back<u8>(&mut v6, v9);
            };
            v11 = 0x2::linked_table::next<0x1::string::String, MissionInfo>(v0, v12);
        };
        0x1::string::utf8(v6)
    }

    fun record_invite_clamied(arg0: &mut MissionGlobal, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<u64, 0x2::table::Table<u64, bool>>(&arg0.invite_claim_records, arg1)) {
            let v0 = 0x2::table::new<u64, bool>(arg3);
            0x2::table::add<u64, bool>(&mut v0, arg2, true);
            0x2::table::add<u64, 0x2::table::Table<u64, bool>>(&mut arg0.invite_claim_records, arg1, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<u64, 0x2::table::Table<u64, bool>>(&mut arg0.invite_claim_records, arg1);
            if (!0x2::table::contains<u64, bool>(v1, arg2)) {
                0x2::table::add<u64, bool>(v1, arg2, true);
            };
        };
    }

    // decompiled from Move bytecode v6
}

