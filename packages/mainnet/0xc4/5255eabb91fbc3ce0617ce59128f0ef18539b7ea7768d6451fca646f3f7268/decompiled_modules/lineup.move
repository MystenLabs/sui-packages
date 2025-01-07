module 0xc45255eabb91fbc3ce0617ce59128f0ef18539b7ea7768d6451fca646f3f7268::lineup {
    struct Global has key {
        id: 0x2::object::UID,
        standard_mood_pools: 0x2::vec_map::VecMap<WinLose, vector<LineUp>>,
        arena_mood_pools: 0x2::vec_map::VecMap<WinLose, vector<LineUp>>,
        version: u64,
        manager: address,
    }

    struct LineUp has copy, drop, store {
        creator: address,
        name: 0x1::string::String,
        role_num: u64,
        roles: vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>,
        gold_cost: u64,
        hash: vector<u8>,
    }

    struct WinLose has copy, drop, store {
        win: u8,
        lose: u8,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x1::vector::empty<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>();
        let v1 = 0;
        while (v1 < 6) {
            0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v0, 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::empty());
            v1 = v1 + 1;
        };
        new_lineUP(0x2::tx_context::sender(arg0), 0x1::string::utf8(b""), 0, v0, 0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::seed(arg0, 12))
    }

    public fun change_manager(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 5);
        arg0.manager = arg1;
    }

    public fun delete_lineup_global(arg0: Global) {
        let Global {
            id                  : v0,
            standard_mood_pools : _,
            arena_mood_pools    : _,
            version             : _,
            manager             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun do_record_player_lineup(arg0: WinLose, arg1: &mut 0x2::vec_map::VecMap<WinLose, vector<LineUp>>, arg2: LineUp) {
        if (0x2::vec_map::contains<WinLose, vector<LineUp>>(arg1, &arg0)) {
            let v0 = 0x2::vec_map::get_mut<WinLose, vector<LineUp>>(arg1, &arg0);
            if (0x1::vector::length<LineUp>(v0) >= 10) {
                0x1::vector::remove<LineUp>(v0, 0);
                0x1::vector::push_back<LineUp>(v0, arg2);
            } else {
                0x1::vector::push_back<LineUp>(v0, arg2);
            };
        } else {
            let v1 = 0x1::vector::empty<LineUp>();
            0x1::vector::push_back<LineUp>(&mut v1, arg2);
            0x2::vec_map::insert<WinLose, vector<LineUp>>(arg1, arg0, v1);
        };
    }

    public fun generate_lineup_by_power(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_role_num_by_lineup_power(arg1);
        let v1 = 0x1::vector::empty<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>();
        while (v0 > 0) {
            0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v1, 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_random_role_by_power(arg0, arg2, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_lineup_level2_prop_by_lineup_power(arg1), 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_lineup_level3_prop_by_lineup_power(arg1), arg3));
            v0 = v0 - 1;
        };
        new_lineUP(0x2::tx_context::sender(arg3), 0x1::string::utf8(b"I'm a super robot"), 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v1), v1, 0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::seed(arg3, arg2))
    }

    entry fun generate_random_cards(arg0: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg1: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 30;
        let v1 = 20;
        let v2 = 0x1::vector::empty<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>();
        while (v0 != 0) {
            let v3 = v1 + 1;
            v1 = v3;
            0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2, 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::create_random_role_for_cards(arg0, v3, arg1));
            v0 = v0 - 1;
        };
        new_lineUP(0x2::tx_context::sender(arg1), 0x1::string::utf8(b"random cards pool"), 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v2), v2, 0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::seed(arg1, 20))
    }

    public fun get_WinLose_lose(arg0: &WinLose) : u8 {
        arg0.lose
    }

    public fun get_WinLose_win(arg0: &WinLose) : u8 {
        arg0.win
    }

    public fun get_attack_hp_sum(arg0: &LineUp) : (u64, u64) {
        let v0 = arg0.roles;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v0)) {
            let v4 = 0x1::vector::borrow<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&v0, v1);
            v2 = v2 + 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_attack(v4);
            v3 = v3 + 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_hp(v4);
            v1 = v1 + 1;
        };
        (v2, v3)
    }

    public fun get_creator(arg0: &LineUp) : address {
        arg0.creator
    }

    public fun get_gold_cost(arg0: &LineUp) : u64 {
        arg0.gold_cost
    }

    public fun get_hash(arg0: &LineUp) : vector<u8> {
        arg0.hash
    }

    public fun get_mut_roles(arg0: &mut LineUp) : &mut vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role> {
        &mut arg0.roles
    }

    public fun get_name(arg0: &LineUp) : 0x1::string::String {
        arg0.name
    }

    public fun get_roles(arg0: &LineUp) : &vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role> {
        &arg0.roles
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id                  : 0x2::object::new(arg0),
            standard_mood_pools : 0x2::vec_map::empty<WinLose, vector<LineUp>>(),
            arena_mood_pools    : 0x2::vec_map::empty<WinLose, vector<LineUp>>(),
            version             : 1,
            manager             : @0xbe379359ac6e9d0fc0b867f147f248f1c2d9fc019a9a708adfcbe15fc3130c18,
        };
        0x2::transfer::share_object<Global>(v0);
    }

    public entry fun init_lineup_pools(arg0: &mut Global, arg1: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 10) {
            loop {
                let v2 = WinLose{
                    win  : v0,
                    lose : v1,
                };
                let v3 = 0x1::vector::empty<LineUp>();
                0x1::vector::push_back<LineUp>(&mut v3, generate_lineup_by_power(arg1, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_lineup_power_by_tag(v0, v1), 1, arg2));
                assert!(!0x2::vec_map::contains<WinLose, vector<LineUp>>(&arg0.standard_mood_pools, &v2), 2);
                assert!(!0x2::vec_map::contains<WinLose, vector<LineUp>>(&arg0.arena_mood_pools, &v2), 2);
                0x2::vec_map::insert<WinLose, vector<LineUp>>(&mut arg0.standard_mood_pools, v2, v3);
                0x2::vec_map::insert<WinLose, vector<LineUp>>(&mut arg0.arena_mood_pools, v2, v3);
                let v4 = v1 + 1;
                v1 = v4;
                if (v4 == 3) {
                    break
                };
            };
            v1 = 0;
            v0 = v0 + 1;
        };
    }

    public fun new_lineUP(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: vector<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>, arg4: u64, arg5: vector<u8>) : LineUp {
        LineUp{
            creator   : arg0,
            name      : arg1,
            role_num  : arg2,
            roles     : arg3,
            gold_cost : arg4,
            hash      : arg5,
        }
    }

    public fun new_lineup_from_reference(arg0: &LineUp) : LineUp {
        let v0 = 0x1::vector::empty<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>();
        let v1 = &arg0.roles;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(v1)) {
            0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v0, 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::new_role_from_reference(0x1::vector::borrow<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(v1, v2)));
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &arg0.hash;
        v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v4)) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(v4, v2));
            v2 = v2 + 1;
        };
        LineUp{
            creator   : arg0.creator,
            name      : arg0.name,
            role_num  : arg0.role_num,
            roles     : v0,
            gold_cost : arg0.gold_cost,
            hash      : v3,
        }
    }

    public fun parse_lineup_str_vec(arg0: 0x1::string::String, arg1: &0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Global, arg2: vector<0x1::string::String>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        let v1 = v0;
        let v2 = 0x1::vector::empty<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>();
        assert!(v0 == 6, 1);
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        while (v1 > 0) {
            let v3 = 0x1::vector::borrow_mut<0x1::string::String>(&mut arg2, v1 - 1);
            let v4 = 0x1::string::length(v3);
            if (v4 == 0) {
                0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2, 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::empty());
                v1 = v1 - 1;
                continue
            };
            let v5 = 0x1::string::utf8(b"-");
            let v6 = 0x1::string::index_of(v3, &v5);
            let v7 = v6 + 1;
            let v8 = v7 + 1;
            let v9 = v8 + 1;
            let v10 = 0x1::string::sub_string(v3, v9, v4);
            let v11 = 0x1::string::utf8(b":");
            let v12 = v9 + 0x1::string::index_of(&v10, &v11);
            let v13 = 0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::get_role_by_class(arg1, 0x1::string::sub_string(v3, 0, v6));
            0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_hp(&mut v13, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::utf8_to_u64(0x1::string::sub_string(v3, v12 + 1, v4)));
            0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_attack(&mut v13, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::utf8_to_u64(0x1::string::sub_string(v3, v9, v12)));
            0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::set_level(&mut v13, (0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::utf8_to_u64(0x1::string::sub_string(v3, v7, v8)) as u8));
            0x1::vector::push_back<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(&mut v2, v13);
            v1 = v1 - 1;
        };
        new_lineUP(0x2::tx_context::sender(arg4), arg0, 6, v2, arg3, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::seed(arg4, 123))
    }

    public fun print_lineup(arg0: &LineUp) {
        let v0 = 0x1::string::utf8(b"Lineup: ");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = arg0.name;
        0x1::string::append(&mut v1, 0x1::string::utf8(b", role number: "));
        0x1::string::append(&mut v1, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.role_num));
        0x1::debug::print<0x1::string::String>(&v1);
        let v2 = &arg0.roles;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(v2)) {
            0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::print_role(0x1::vector::borrow<0xab24d35c986902708f36fe77aed5647e3715307a32375aadda3c792378c08906::role::Role>(v2, v3));
            v3 = v3 + 1;
        };
        v1 = 0x1::string::utf8(b"gold cost: ");
        0x1::string::append(&mut v1, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u64_to_string(arg0.gold_cost));
        0x1::debug::print<0x1::string::String>(&v1);
    }

    public fun print_pools(arg0: &0x2::vec_map::VecMap<WinLose, vector<LineUp>>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<WinLose, vector<LineUp>>(arg0)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<WinLose, vector<LineUp>>(arg0, v0);
            print_tag(v1);
            let v3 = 0x1::vector::length<LineUp>(v2);
            0x1::debug::print<u64>(&v3);
            v0 = v0 + 1;
        };
    }

    public fun print_tag(arg0: &WinLose) {
        let v0 = 0x1::string::utf8(b"Win-Lose tag: ");
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.win));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::u8_to_string(arg0.lose));
        0x1::debug::print<0x1::string::String>(&v0);
    }

    public fun record_player_lineup(arg0: u8, arg1: u8, arg2: &mut Global, arg3: LineUp, arg4: bool) {
        let v0 = WinLose{
            win  : arg0,
            lose : arg1,
        };
        if (arg4) {
            let v1 = &mut arg2.arena_mood_pools;
            do_record_player_lineup(v0, v1, arg3);
        } else {
            let v2 = &mut arg2.standard_mood_pools;
            do_record_player_lineup(v0, v2, arg3);
        };
    }

    public fun select_random_lineup(arg0: u8, arg1: u8, arg2: &Global, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : LineUp {
        let v0 = WinLose{
            win  : arg0,
            lose : arg1,
        };
        let v1 = if (arg3) {
            let v2 = &arg2.arena_mood_pools;
            if (0x2::vec_map::contains<WinLose, vector<LineUp>>(v2, &v0)) {
                0x2::vec_map::get<WinLose, vector<LineUp>>(v2, &v0)
            } else {
                let v3 = WinLose{
                    win  : arg0,
                    lose : 0,
                };
                assert!(0x2::vec_map::contains<WinLose, vector<LineUp>>(v2, &v3), 3);
                0x2::vec_map::get<WinLose, vector<LineUp>>(v2, &v3)
            }
        } else {
            let v4 = &arg2.standard_mood_pools;
            if (0x2::vec_map::contains<WinLose, vector<LineUp>>(v4, &v0)) {
                0x2::vec_map::get<WinLose, vector<LineUp>>(v4, &v0)
            } else {
                let v5 = WinLose{
                    win  : arg0,
                    lose : 0,
                };
                assert!(0x2::vec_map::contains<WinLose, vector<LineUp>>(v4, &v5), 3);
                0x2::vec_map::get<WinLose, vector<LineUp>>(v4, &v5)
            }
        };
        let v6 = 0x1::vector::length<LineUp>(v1);
        let v7 = 0x3dc7b97b2e06efe99a1292fe5fd0bec31b1cc6c0e38cb70e523722fb32e0c2c6::utils::get_random_num(0, v6, 10, arg4) % v6;
        assert!(v6 > v7, 4);
        *0x1::vector::borrow<LineUp>(v1, v7)
    }

    public fun set_hash(arg0: &mut LineUp, arg1: vector<u8>) {
        arg0.hash = arg1;
    }

    public fun upgradeVersion(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 5);
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

