module 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apter {
    struct APTER has drop {
        dummy_field: bool,
    }

    struct ApterNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        collection: 0x1::string::String,
        creator: address,
    }

    struct MedalInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        nftid: 0x2::object::ID,
        time: u64,
    }

    struct Apter has store, key {
        id: 0x2::object::UID,
        exp: u64,
        lvl: u64,
        cnt_done: u64,
        done_quests: 0x2::vec_map::VecMap<0x1::string::String, bool>,
        medals: vector<MedalInfo>,
    }

    struct RewardDef has copy, drop, store {
        sui: u64,
        coin: u64,
        exp: u64,
    }

    struct QuestDef has store, key {
        id: 0x2::object::UID,
        qid: 0x1::string::String,
        proj: 0x1::string::String,
        cond: 0x1::string::String,
        reward: RewardDef,
        start_time: u64,
        end_time: u64,
        cnt_done: u64,
        max_done: u64,
        ext: 0x2::vec_map::VecMap<u64, 0x1::string::String>,
    }

    struct GlobalInfo has store, key {
        id: 0x2::object::UID,
        pause: bool,
        cnt_apter: u64,
        cnt_done: u64,
        quests: 0x2::vec_map::VecMap<0x1::string::String, QuestDef>,
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        apc_pool: 0x2::balance::Balance<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>,
        apters: 0x2::table::Table<address, Apter>,
    }

    struct ClaimEvent has copy, drop, store {
        account: address,
        id: 0x1::string::String,
        time: u64,
    }

    public entry fun add_quest(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg3), 1);
        let v0 = RewardDef{
            sui  : 0,
            coin : 0,
            exp  : 0,
        };
        let v1 = QuestDef{
            id         : 0x2::object::new(arg3),
            qid        : 0x1::string::utf8(arg2),
            proj       : 0x1::string::utf8(arg1),
            cond       : 0x1::string::utf8(b""),
            reward     : v0,
            start_time : 0,
            end_time   : 0,
            cnt_done   : 0,
            max_done   : 0,
            ext        : 0x2::vec_map::empty<u64, 0x1::string::String>(),
        };
        0x2::vec_map::insert<0x1::string::String, QuestDef>(&mut arg0.quests, 0x1::string::utf8(arg2), v1);
    }

    public fun admin_address() : address {
        @0xdeaf4320dddc10e8a5c5deb8055d2e43401551e387f4515f4953b0bcf1fe0451
    }

    public entry fun batch_set_quest(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, QuestDef>(&mut arg0.quests, &v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            set_quest_internal(v1, *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2), 0x1::vector::borrow<vector<u8>>(&arg4, v2));
            v2 = v2 + 1;
        };
    }

    public entry fun claim_quest(arg0: &mut GlobalInfo, arg1: &mut 0x2::coin::TreasuryCap<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.pause, 6);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::string::utf8(arg3);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, arg3);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v2, arg5);
        assert!(0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::zkticket::check_ticket(&arg4, &v2), 500);
        if (!0x2::table::contains<address, Apter>(&arg0.apters, v0)) {
            let v3 = Apter{
                id          : 0x2::object::new(arg6),
                exp         : 0,
                lvl         : 0,
                cnt_done    : 0,
                done_quests : 0x2::vec_map::empty<0x1::string::String, bool>(),
                medals      : 0x1::vector::empty<MedalInfo>(),
            };
            0x2::table::add<address, Apter>(&mut arg0.apters, v0, v3);
            let v4 = &mut arg0.cnt_apter;
            *v4 = *v4 + 1;
        };
        assert!(!is_done_quest(0x2::table::borrow<address, Apter>(&mut arg0.apters, v0), &v1), 2);
        do_quest(arg0, arg1, arg2, &v1, arg6);
        let v5 = ClaimEvent{
            account : v0,
            id      : 0x1::string::utf8(arg3),
            time    : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<ClaimEvent>(v5);
    }

    public entry fun clean_quests(arg0: &mut GlobalInfo, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg1), 1);
        while (!0x2::vec_map::is_empty<0x1::string::String, QuestDef>(&arg0.quests)) {
            let (_, v1) = 0x2::vec_map::pop<0x1::string::String, QuestDef>(&mut arg0.quests);
            let QuestDef {
                id         : v2,
                qid        : _,
                proj       : _,
                cond       : _,
                reward     : _,
                start_time : _,
                end_time   : _,
                cnt_done   : _,
                max_done   : _,
                ext        : _,
            } = v1;
            0x2::object::delete(v2);
        };
    }

    fun do_quest(arg0: &mut GlobalInfo, arg1: &mut 0x2::coin::TreasuryCap<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>, arg2: &0x2::clock::Clock, arg3: &0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_map::contains<0x1::string::String, QuestDef>(&mut arg0.quests, arg3), 4);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, QuestDef>(&mut arg0.quests, arg3);
        assert!(v1.max_done == 0 || v1.cnt_done < v1.max_done, 3);
        let v2 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v1.start_time == 0 || v1.start_time <= v2, 5);
        assert!(v1.end_time == 0 || v1.end_time >= v2, 5);
        let v3 = 0x2::table::borrow_mut<address, Apter>(&mut arg0.apters, v0);
        if (v1.reward.exp > 0) {
            v3.exp = v3.exp + v1.reward.exp;
        };
        if (v1.reward.sui > 0) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_pool) >= v1.reward.sui, 501);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_pool, v1.reward.sui, arg4), v0);
        };
        if (v1.reward.coin > 0) {
            0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::mint(arg1, v1.reward.coin, v0, arg4);
        };
        let v4 = 10004;
        if (0x2::vec_map::contains<u64, 0x1::string::String>(&v1.ext, &v4)) {
            let v5 = 10001;
            let v6 = 10004;
            let v7 = 10002;
            let v8 = 10003;
            let v9 = *0x2::vec_map::get<u64, 0x1::string::String>(&v1.ext, &v6);
            0x1::string::append_utf8(&mut v9, b" #");
            0x1::string::append_utf8(&mut v9, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::u64_to_string(v1.cnt_done));
            let v10 = *0x2::vec_map::get<u64, 0x1::string::String>(&v1.ext, &v8);
            0x1::string::append_utf8(&mut v10, b"?id=");
            0x1::string::append_utf8(&mut v10, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::u64_to_string(v1.cnt_done));
            0x1::string::append_utf8(&mut v10, b"&acc=");
            0x1::string::append_utf8(&mut v10, 0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::string_utils::address_to_string(&v0));
            let v11 = mint_medal_nft_interval(0x2::vec_map::get<u64, 0x1::string::String>(&v1.ext, &v5), &v9, 0x2::vec_map::get<u64, 0x1::string::String>(&v1.ext, &v7), &v10, v0, arg4);
            let v12 = 10006;
            if (!0x2::vec_map::contains<u64, 0x1::string::String>(&v1.ext, &v12)) {
                let v13 = MedalInfo{
                    id    : 0x2::object::new(arg4),
                    name  : v9,
                    nftid : v11,
                    time  : v2,
                };
                0x1::vector::push_back<MedalInfo>(&mut v3.medals, v13);
            };
        };
        0x2::vec_map::insert<0x1::string::String, bool>(&mut v3.done_quests, *arg3, true);
        arg0.cnt_done = arg0.cnt_done + 1;
        v3.cnt_done = v3.cnt_done + 1;
        v1.cnt_done = v1.cnt_done + 1;
    }

    fun init(arg0: APTER, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg1), 1);
        let v0 = GlobalInfo{
            id        : 0x2::object::new(arg1),
            pause     : false,
            cnt_apter : 0,
            cnt_done  : 0,
            quests    : 0x2::vec_map::empty<0x1::string::String, QuestDef>(),
            sui_pool  : 0x2::balance::zero<0x2::sui::SUI>(),
            apc_pool  : 0x2::balance::zero<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>(),
            apters    : 0x2::table::new<address, Apter>(arg1),
        };
        0x2::transfer::share_object<GlobalInfo>(v0);
        let v1 = 0x2::package::claim<APTER>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://sui.apass.network/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{collection}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{creator}"));
        let v6 = 0x2::display::new_with_fields<ApterNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<ApterNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<ApterNFT>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_done_quest(arg0: &Apter, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, bool>(&arg0.done_quests, arg1)
    }

    fun mint_medal_nft_interval(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg5);
        let v1 = ApterNFT{
            id          : v0,
            name        : *arg1,
            description : *arg2,
            url         : *arg3,
            collection  : *arg0,
            creator     : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::transfer<ApterNFT>(v1, arg4);
        0x2::object::uid_to_inner(&v0)
    }

    public entry fun remove_quest(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0x1::string::utf8(arg1);
        let (_, v2) = 0x2::vec_map::remove<0x1::string::String, QuestDef>(&mut arg0.quests, &v0);
        let QuestDef {
            id         : v3,
            qid        : _,
            proj       : _,
            cond       : _,
            reward     : _,
            start_time : _,
            end_time   : _,
            cnt_done   : _,
            max_done   : _,
            ext        : _,
        } = v2;
        0x2::object::delete(v3);
    }

    public entry fun set_pause(arg0: &mut GlobalInfo, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg2), 1);
        arg0.pause = arg1;
    }

    public entry fun set_quest(arg0: &mut GlobalInfo, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(admin_address() == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, QuestDef>(&mut arg0.quests, &v0);
        set_quest_internal(v1, arg2, arg3, &arg4);
    }

    fun set_quest_internal(arg0: &mut QuestDef, arg1: u64, arg2: u64, arg3: &vector<u8>) {
        if (arg1 == 1) {
            arg0.cond = 0x1::string::utf8(*arg3);
        } else if (arg1 == 2) {
            arg0.reward.sui = arg2;
        } else if (arg1 == 3) {
            arg0.reward.coin = arg2;
        } else if (arg1 == 4) {
            arg0.reward.exp = arg2;
        } else if (arg1 == 5) {
            arg0.cnt_done = arg2;
        } else if (arg1 == 6) {
            arg0.max_done = arg2;
        } else if (arg1 == 7) {
            arg0.start_time = arg2;
        } else if (arg1 == 8) {
            arg0.end_time = arg2;
        } else if (arg1 == 9) {
            arg0.proj = 0x1::string::utf8(*arg3);
        } else if (arg1 >= 10000) {
            if (!0x2::vec_map::contains<u64, 0x1::string::String>(&arg0.ext, &arg1)) {
                0x2::vec_map::insert<u64, 0x1::string::String>(&mut arg0.ext, arg1, 0x1::string::utf8(*arg3));
            } else {
                *0x2::vec_map::get_mut<u64, 0x1::string::String>(&mut arg0.ext, &arg1) = 0x1::string::utf8(*arg3);
            };
        };
    }

    public entry fun withdraw_apc(arg0: &mut GlobalInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_address() == v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>>(0x2::coin::take<0x62fff363d8919c16c3354e452800afc92cc1815296475bb87b769b5e6468dc38::apc::APC>(&mut arg0.apc_pool, arg1, arg2), v0);
    }

    public entry fun withdraw_sui(arg0: &mut GlobalInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(admin_address() == v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_pool, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

