module 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::vault_user {
    struct UserNode has drop, store {
        id: u64,
        level: u8,
        score: u64,
        extra_score: u64,
        last_active_at: u64,
        refer_count: u64,
        referrer: address,
        referrals: vector<address>,
        tickets: vector<u8>,
    }

    struct LevelConfig has drop, store {
        min_score: u64,
        actual_percentage: u64,
        direct_percentage: u64,
        indirect_percentage: u64,
    }

    struct VaultUser has key {
        id: 0x2::object::UID,
        users: 0x2::linked_table::LinkedTable<address, UserNode>,
        id_to_address: 0x2::vec_map::VecMap<u64, address>,
        level_configs: 0x2::vec_map::VecMap<u8, LevelConfig>,
        next_user_id: u64,
        admin: address,
        operator: address,
        data: 0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<u64, u64>>,
    }

    struct UserRegistered has copy, drop {
        user: address,
        user_id: u64,
        referrer: address,
    }

    struct UserRemoved has copy, drop {
        user: address,
        user_id: u64,
        referrer: address,
    }

    struct UserLevelUpdated has copy, drop {
        user: address,
        user_id: u64,
        old_level: u8,
        new_level: u8,
        score: u64,
        extra_score: u64,
    }

    struct UserTicketsUpdated has copy, drop {
        user: address,
        user_id: u64,
        ticket_type: u8,
        is_add: bool,
    }

    struct LevelConfigUpdated has copy, drop {
        level: u8,
        actual_percentage: u64,
        direct_percentage: u64,
        indirect_percentage: u64,
    }

    struct VAULT_USER has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_lost_user(arg0: &VaultUser, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_user());
        assert!(0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).last_active_at + 15552000000 < 0x2::clock::timestamp_ms(arg2), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_state());
    }

    public(friend) fun assert_vault_admin(arg0: &VaultUser, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(&arg0.admin == &v0, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::unauthorized());
    }

    public(friend) fun calculate_user_level(arg0: &mut VaultUser, arg1: address) : (u64, u64) {
        if (arg1 == @0x2012) {
            return (0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1);
        let v1 = v0.score + v0.extra_score / 2;
        let v2 = 0;
        let v3 = 0x2::vec_map::keys<u8, LevelConfig>(&arg0.level_configs);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            let v5 = *0x1::vector::borrow<u8>(&v3, v4);
            if (v1 >= 0x2::vec_map::get<u8, LevelConfig>(&arg0.level_configs, &v5).min_score) {
                v2 = v5;
            };
            v4 = v4 + 1;
        };
        if (v2 == v0.level) {
            return (0, 0)
        };
        let v6 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1);
        let v7 = v6.level;
        v6.level = v2;
        let v8 = 0x2::vec_map::get<u8, LevelConfig>(&arg0.level_configs, &v7);
        let v9 = 0x2::vec_map::get<u8, LevelConfig>(&arg0.level_configs, &v2);
        let v10 = if (v2 > v7) {
            (v9.direct_percentage - v8.direct_percentage) * 100 / v8.direct_percentage
        } else {
            0
        };
        let v11 = if (v2 > v7) {
            (v9.indirect_percentage - v8.indirect_percentage) * 100 / v8.indirect_percentage
        } else {
            0
        };
        let v12 = UserLevelUpdated{
            user        : arg1,
            user_id     : v6.id,
            old_level   : v7,
            new_level   : v2,
            score       : v6.score,
            extra_score : v6.extra_score,
        };
        0x2::event::emit<UserLevelUpdated>(v12);
        ((v10 as u64), (v11 as u64))
    }

    public fun consume_ticket(arg0: &mut VaultUser, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = false;
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, v0)) {
            let v2 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, v0);
            let (v3, v4) = 0x1::vector::index_of<u8>(&v2.tickets, &arg1);
            if (v3) {
                0x1::vector::remove<u8>(&mut v2.tickets, v4);
                v1 = true;
                let v5 = UserTicketsUpdated{
                    user        : v0,
                    user_id     : v2.id,
                    ticket_type : arg1,
                    is_add      : false,
                };
                0x2::event::emit<UserTicketsUpdated>(v5);
            };
        };
        v1
    }

    public entry fun create_vault_user(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::vec_map::empty<u8, LevelConfig>();
        let v1 = LevelConfig{
            min_score           : 0,
            actual_percentage   : 550,
            direct_percentage   : 80,
            indirect_percentage : 40,
        };
        0x2::vec_map::insert<u8, LevelConfig>(&mut v0, 0, v1);
        let v2 = LevelConfig{
            min_score           : 20000000,
            actual_percentage   : 550,
            direct_percentage   : 100,
            indirect_percentage : 50,
        };
        0x2::vec_map::insert<u8, LevelConfig>(&mut v0, 1, v2);
        let v3 = LevelConfig{
            min_score           : 50000000,
            actual_percentage   : 550,
            direct_percentage   : 120,
            indirect_percentage : 60,
        };
        0x2::vec_map::insert<u8, LevelConfig>(&mut v0, 2, v3);
        let v4 = LevelConfig{
            min_score           : 100000000,
            actual_percentage   : 550,
            direct_percentage   : 140,
            indirect_percentage : 70,
        };
        0x2::vec_map::insert<u8, LevelConfig>(&mut v0, 3, v4);
        let v5 = LevelConfig{
            min_score           : 150000000,
            actual_percentage   : 550,
            direct_percentage   : 160,
            indirect_percentage : 80,
        };
        0x2::vec_map::insert<u8, LevelConfig>(&mut v0, 4, v5);
        let v6 = LevelConfig{
            min_score           : 200000000,
            actual_percentage   : 550,
            direct_percentage   : 180,
            indirect_percentage : 90,
        };
        0x2::vec_map::insert<u8, LevelConfig>(&mut v0, 5, v6);
        let v7 = VaultUser{
            id            : 0x2::object::new(arg1),
            users         : 0x2::linked_table::new<address, UserNode>(arg1),
            id_to_address : 0x2::vec_map::empty<u64, address>(),
            level_configs : v0,
            next_user_id  : 3000,
            admin         : 0x2::tx_context::sender(arg1),
            operator      : 0x2::tx_context::sender(arg1),
            data          : 0x2::linked_table::new<address, 0x2::vec_map::VecMap<u64, u64>>(arg1),
        };
        0x2::transfer::share_object<VaultUser>(v7);
        0x2::object::uid_to_inner(&v7.id)
    }

    public(friend) fun generate_ticket(arg0: &mut VaultUser, arg1: u64, arg2: u8) {
        let v0 = get_user_address(arg0, arg1);
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, v0)) {
            0x1::vector::push_back<u8>(&mut 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, v0).tickets, arg2);
            let v1 = UserTicketsUpdated{
                user        : v0,
                user_id     : arg1,
                ticket_type : arg2,
                is_add      : true,
            };
            0x2::event::emit<UserTicketsUpdated>(v1);
        };
    }

    public entry fun generate_ticket_by_operator(arg0: &mut VaultUser, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::unauthorized());
        generate_ticket(arg0, arg1, arg2);
    }

    public entry fun get_data(arg0: &VaultUser, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::vec_map::VecMap<u64, u64> {
        if (0x2::linked_table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.data, arg1)) {
            *0x2::linked_table::borrow<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.data, arg1)
        } else {
            0x2::vec_map::empty<u64, u64>()
        }
    }

    public fun get_referrer(arg0: &VaultUser, arg1: address) : address {
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).referrer
        } else {
            @0x2012
        }
    }

    public fun get_user_address(arg0: &VaultUser, arg1: u64) : address {
        if (0x2::vec_map::contains<u64, address>(&arg0.id_to_address, &arg1)) {
            *0x2::vec_map::get<u64, address>(&arg0.id_to_address, &arg1)
        } else {
            @0x2012
        }
    }

    public entry fun get_user_address_by_id(arg0: &VaultUser, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : address {
        get_user_address(arg0, arg1)
    }

    public fun get_user_id(arg0: &VaultUser, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).id
        } else {
            0
        }
    }

    public entry fun get_user_info(arg0: &VaultUser, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (u64, u8, u64, u64, u64, address, vector<address>, vector<u8>) {
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            let v8 = 0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1);
            (v8.id, v8.level, v8.score, v8.extra_score, v8.refer_count, v8.referrer, v8.referrals, v8.tickets)
        } else {
            (0, 0, 0, 0, 0, @0x2012, 0x1::vector::empty<address>(), 0x1::vector::empty<u8>())
        }
    }

    public fun get_user_level_data(arg0: &VaultUser, arg1: address) : (u64, u64, u64) {
        if (!0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1);
        if (!0x2::vec_map::contains<u8, LevelConfig>(&arg0.level_configs, &v0.level)) {
            return (0, 0, 0)
        };
        let v1 = 0x2::vec_map::get<u8, LevelConfig>(&arg0.level_configs, &v0.level);
        (v1.actual_percentage, v1.direct_percentage, v1.indirect_percentage)
    }

    fun init(arg0: VAULT_USER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun recover_user(arg0: &AdminCap, arg1: &mut VaultUser, arg2: address, arg3: address, arg4: &0x2::clock::Clock) {
        assert_lost_user(arg1, arg2, arg4);
        let v0 = 0x2::linked_table::borrow<address, UserNode>(&arg1.users, arg2).referrals;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            let v2 = *0x1::vector::borrow<address>(&v0, v1);
            if (0x2::linked_table::contains<address, UserNode>(&arg1.users, v2)) {
                0x2::linked_table::borrow_mut<address, UserNode>(&mut arg1.users, v2).referrer = arg3;
            };
            v1 = v1 + 1;
        };
        let v3 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg1.users, arg3);
        v3.refer_count = v3.refer_count + 0x1::vector::length<address>(&v0);
        0x1::vector::append<address>(&mut v3.referrals, v0);
        let v4 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg1.users, arg2);
        v4.referrals = 0x1::vector::empty<address>();
        v4.refer_count = 0;
        v4.tickets = 0x1::vector::empty<u8>();
    }

    public entry fun register_by_admin(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg4);
        register_user(arg0, arg1, arg2, arg3);
    }

    public entry fun register_by_user(arg0: &mut VaultUser, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        register_user(arg0, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    public(friend) fun register_user(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return
        };
        let v0 = get_user_address(arg0, arg2);
        let v1 = if (0x2::linked_table::contains<address, UserNode>(&arg0.users, v0) && arg1 != v0) {
            v0
        } else {
            @0x2012
        };
        update_referrer(arg0, v1, arg1, arg3);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = simple_random(arg1, v2, 5, 20);
        let v4 = if ((arg0.next_user_id + v3) % 10 == 4) {
            arg0.next_user_id + v3 + 2
        } else {
            arg0.next_user_id + v3
        };
        arg0.next_user_id = v4;
        let v5 = arg0.next_user_id;
        let v6 = UserNode{
            id             : v5,
            level          : 0,
            score          : 10,
            extra_score    : 10,
            last_active_at : v2,
            refer_count    : 0,
            referrer       : v1,
            referrals      : 0x1::vector::empty<address>(),
            tickets        : 0x1::vector::empty<u8>(),
        };
        0x2::linked_table::push_back<address, UserNode>(&mut arg0.users, arg1, v6);
        0x2::vec_map::insert<u64, address>(&mut arg0.id_to_address, v5, arg1);
        let v7 = UserRegistered{
            user     : arg1,
            user_id  : v5,
            referrer : v1,
        };
        0x2::event::emit<UserRegistered>(v7);
    }

    public entry fun remove_user(arg0: &mut VaultUser, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg2);
        let v0 = get_user_address(arg0, arg1);
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, v0)) {
            let UserNode {
                id             : v1,
                level          : _,
                score          : _,
                extra_score    : _,
                last_active_at : _,
                refer_count    : _,
                referrer       : v7,
                referrals      : _,
                tickets        : _,
            } = 0x2::linked_table::remove<address, UserNode>(&mut arg0.users, v0);
            let v10 = v1;
            let (_, _) = 0x2::vec_map::remove<u64, address>(&mut arg0.id_to_address, &v10);
            if (0x2::linked_table::contains<address, UserNode>(&arg0.users, v7)) {
                let v13 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, v7);
                let (v14, v15) = 0x1::vector::index_of<address>(&v13.referrals, &v0);
                if (v14) {
                    0x1::vector::swap_remove<address>(&mut v13.referrals, v15);
                    v13.refer_count = v13.refer_count - 1;
                };
            };
            let v16 = UserRemoved{
                user     : v0,
                user_id  : v10,
                referrer : v7,
            };
            0x2::event::emit<UserRemoved>(v16);
        };
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &mut VaultUser, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
    }

    public entry fun set_level_config(arg0: &mut VaultUser, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg6);
        assert!(arg1 > 0 && arg1 <= 20, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_level());
        assert!(arg2 >= 0 && arg3 >= 500 && arg4 >= 50 && arg5 >= 10, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_value());
        assert!(arg3 + arg4 + arg5 <= 1000, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_value());
        if (arg1 > 1) {
            let v0 = arg1 - 1;
            assert!(0x2::vec_map::contains<u8, LevelConfig>(&arg0.level_configs, &v0), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_level());
            let v1 = arg1 - 1;
            let v2 = 0x2::vec_map::get<u8, LevelConfig>(&arg0.level_configs, &v1);
            assert!(v2.min_score <= arg2 && v2.actual_percentage <= arg3 && v2.direct_percentage <= arg4 && v2.indirect_percentage <= arg5, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_value());
        };
        let v3 = if (arg1 == 0) {
            0
        } else {
            arg2
        };
        let v4 = LevelConfig{
            min_score           : v3,
            actual_percentage   : arg3,
            direct_percentage   : arg4,
            indirect_percentage : arg5,
        };
        if (0x2::vec_map::contains<u8, LevelConfig>(&arg0.level_configs, &arg1)) {
            *0x2::vec_map::get_mut<u8, LevelConfig>(&mut arg0.level_configs, &arg1) = v4;
        } else {
            0x2::vec_map::insert<u8, LevelConfig>(&mut arg0.level_configs, arg1, v4);
        };
        let v5 = LevelConfigUpdated{
            level               : arg1,
            actual_percentage   : arg3,
            direct_percentage   : arg4,
            indirect_percentage : arg5,
        };
        0x2::event::emit<LevelConfigUpdated>(v5);
    }

    public entry fun set_operator(arg0: &mut VaultUser, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg2);
        arg0.operator = arg1;
    }

    public(friend) fun simple_random(arg0: address, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg2 + ((0x2::address::to_u256(arg0) - (arg1 as u256) & 18446744073709551615) as u64) % (arg3 - arg2 + 1)
    }

    public(friend) fun update_active_time(arg0: &mut VaultUser, arg1: address, arg2: &0x2::clock::Clock) {
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1).last_active_at = 0x2::clock::timestamp_ms(arg2);
        };
    }

    public entry fun update_data_by_key(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::unauthorized());
        if (!0x2::linked_table::contains<address, 0x2::vec_map::VecMap<u64, u64>>(&arg0.data, arg1)) {
            let v0 = 0x2::vec_map::empty<u64, u64>();
            0x2::vec_map::insert<u64, u64>(&mut v0, arg2, arg3);
            0x2::linked_table::push_back<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.data, arg1, v0);
        } else {
            let v1 = 0x2::linked_table::borrow_mut<address, 0x2::vec_map::VecMap<u64, u64>>(&mut arg0.data, arg1);
            if (arg3 == 18446744073709551615) {
                let (_, _) = 0x2::vec_map::remove<u64, u64>(v1, &arg2);
            } else if (0x2::vec_map::contains<u64, u64>(v1, &arg2)) {
                *0x2::vec_map::get_mut<u64, u64>(v1, &arg2) = arg3;
            } else {
                0x2::vec_map::insert<u64, u64>(v1, arg2, arg3);
            };
        };
    }

    public entry fun update_extra_score(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg3);
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_user());
        0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1).extra_score = arg2;
    }

    public(friend) fun update_referrer(arg0: &mut VaultUser, arg1: address, arg2: address, arg3: &0x2::clock::Clock) {
        if (arg1 == @0x2012 && !0x2::linked_table::contains<address, UserNode>(&arg0.users, @0x2012)) {
            let v0 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v0, arg2);
            let v1 = UserNode{
                id             : 3000,
                level          : 0,
                score          : 10,
                extra_score    : 10,
                last_active_at : 0x2::clock::timestamp_ms(arg3),
                refer_count    : 1,
                referrer       : arg1,
                referrals      : v0,
                tickets        : 0x1::vector::empty<u8>(),
            };
            0x2::linked_table::push_back<address, UserNode>(&mut arg0.users, @0x2012, v1);
        } else {
            let v2 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1);
            0x1::vector::push_back<address>(&mut v2.referrals, arg2);
            v2.refer_count = v2.refer_count + 1;
        };
    }

    public entry fun update_score(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg3);
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_user());
        0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1).extra_score = arg2;
    }

    public entry fun update_user_level(arg0: &mut VaultUser, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg3);
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x8ee92eaf39323d838406ab3e458fe534c7e6f7f32295ef503e2dfd1863d941f6::errors::invalid_user());
        let v0 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1);
        v0.level = arg2;
        let v1 = UserLevelUpdated{
            user        : arg1,
            user_id     : v0.id,
            old_level   : v0.level,
            new_level   : arg2,
            score       : v0.score,
            extra_score : v0.extra_score,
        };
        0x2::event::emit<UserLevelUpdated>(v1);
    }

    public(friend) fun update_user_score(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: u64, arg4: bool) : (u64, u64, u64, u64) {
        if (arg1 == @0x2012 || arg2 == 0 || arg3 == 0 || !0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).referrer;
        let v1 = arg2 / 1000000 * arg3;
        if (arg4) {
            let v2 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1);
            v2.score = v2.score + v1;
            if (v0 != @0x2012 && 0x2::linked_table::contains<address, UserNode>(&arg0.users, v0)) {
                let v3 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, v0);
                v3.extra_score = v3.extra_score + v1;
            };
        } else {
            let v4 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1);
            let v5 = if (v4.score >= v1) {
                v4.score - v1
            } else {
                0
            };
            v4.score = v5;
            if (v0 != @0x2012 && 0x2::linked_table::contains<address, UserNode>(&arg0.users, v0)) {
                let v6 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, v0);
                let v7 = if (v6.extra_score >= v1) {
                    v6.extra_score - v1
                } else {
                    0
                };
                v6.extra_score = v7;
            };
        };
        let (v8, v9) = calculate_user_level(arg0, arg1);
        let (v10, v11) = calculate_user_level(arg0, v0);
        (v8, v9, v10, v11)
    }

    // decompiled from Move bytecode v6
}

