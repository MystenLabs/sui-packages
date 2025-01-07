module 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::vault_user {
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
        password_hash: vector<u8>,
        principal_locked: bool,
        account_locked: bool,
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
        id_to_address: 0x2::linked_table::LinkedTable<u64, 0x2::vec_map::VecMap<u64, address>>,
        level_configs: 0x2::vec_map::VecMap<u8, LevelConfig>,
        next_user_id: u64,
        admin: address,
        operator: address,
        data: 0x2::linked_table::LinkedTable<address, 0x2::vec_map::VecMap<u64, u64>>,
        vk: 0x2::vec_map::VecMap<u8, vector<u8>>,
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

    struct PrincipalLocked has copy, drop {
        user: address,
        user_id: u64,
        principal_locked: bool,
    }

    struct LevelConfigUpdated has copy, drop {
        level: u8,
        min_score: u64,
        actual_percentage: u64,
        direct_percentage: u64,
        indirect_percentage: u64,
    }

    struct OperatorUpdated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct UserRecovered has copy, drop {
        user: address,
        user_id: u64,
        new_user: address,
    }

    struct VAULT_USER has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun add_user_address(arg0: &mut VaultUser, arg1: u64, arg2: address) {
        let (v0, v1) = get_segment_info(arg1);
        let v2 = v1;
        if (!0x2::linked_table::contains<u64, 0x2::vec_map::VecMap<u64, address>>(&arg0.id_to_address, v0)) {
            0x2::linked_table::push_back<u64, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.id_to_address, v0, 0x2::vec_map::empty<u64, address>());
        };
        if (arg2 != @0x0) {
            0x2::vec_map::insert<u64, address>(0x2::linked_table::borrow_mut<u64, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.id_to_address, v0), v2, arg2);
        } else {
            let (_, _) = 0x2::vec_map::remove<u64, address>(0x2::linked_table::borrow_mut<u64, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.id_to_address, v0), &v2);
        };
    }

    public(friend) fun assert_lost_user(arg0: &VaultUser, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_user());
        assert!(0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).last_active_at + 15552000000 < 0x2::clock::timestamp_ms(arg2), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_state());
    }

    public(friend) fun assert_vault_admin(arg0: &VaultUser, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(&arg0.admin == &v0, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::unauthorized());
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
            id_to_address : 0x2::linked_table::new<u64, 0x2::vec_map::VecMap<u64, address>>(arg1),
            level_configs : v0,
            next_user_id  : 3000,
            admin         : 0x2::tx_context::sender(arg1),
            operator      : 0x2::tx_context::sender(arg1),
            data          : 0x2::linked_table::new<address, 0x2::vec_map::VecMap<u64, u64>>(arg1),
            vk            : 0x2::vec_map::empty<u8, vector<u8>>(),
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
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::unauthorized());
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

    fun get_segment_info(arg0: u64) : (u64, u64) {
        (arg0 / 10000, arg0 % 10000)
    }

    public fun get_user_address(arg0: &VaultUser, arg1: u64) : address {
        let (v0, v1) = get_segment_info(arg1);
        let v2 = v1;
        if (!0x2::linked_table::contains<u64, 0x2::vec_map::VecMap<u64, address>>(&arg0.id_to_address, v0)) {
            return @0x2012
        };
        let v3 = 0x2::linked_table::borrow<u64, 0x2::vec_map::VecMap<u64, address>>(&arg0.id_to_address, v0);
        if (!0x2::vec_map::contains<u64, address>(v3, &v2)) {
            return @0x2012
        };
        *0x2::vec_map::get<u64, address>(v3, &v2)
    }

    public entry fun get_user_address_by_id(arg0: &VaultUser, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : address {
        get_user_address(arg0, arg1)
    }

    public entry fun get_user_info(arg0: &VaultUser, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : (u64, u8, u64, u64, u64, address, vector<address>, vector<u8>, vector<u8>, bool) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            let v10 = 0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1);
            (v10.id, v10.principal_locked, v10.level, v10.score, v10.extra_score, v10.refer_count, v10.referrer, v10.referrals, v10.tickets, v10.password_hash)
        } else {
            (0, false, 0, 0, 0, 0, @0x2012, 0x1::vector::empty<address>(), 0x1::vector::empty<u8>(), 0x1::vector::empty<u8>())
        };
        (v0, v2, v3, v4, v5, v6, v7, v8, v9, v1)
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

    public(friend) fun is_account_locked(arg0: &VaultUser, arg1: address) : bool {
        if (!0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return false
        };
        0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).account_locked
    }

    public(friend) fun is_principal_locked(arg0: &VaultUser, arg1: address) : bool {
        if (!0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return false
        };
        0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).principal_locked
    }

    public(friend) fun recover_user(arg0: &AdminCap, arg1: &mut VaultUser, arg2: address, arg3: address, arg4: &0x2::clock::Clock) {
        assert_lost_user(arg1, arg2, arg4);
        let v0 = 0x2::linked_table::borrow<address, UserNode>(&arg1.users, arg2);
        let v1 = v0.id;
        let v2 = v0.referrals;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v2)) {
            let v4 = *0x1::vector::borrow<address>(&v2, v3);
            if (0x2::linked_table::contains<address, UserNode>(&arg1.users, v4)) {
                0x2::linked_table::borrow_mut<address, UserNode>(&mut arg1.users, v4).referrer = arg3;
            };
            v3 = v3 + 1;
        };
        let v5 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg1.users, arg3);
        v5.refer_count = v5.refer_count + 0x1::vector::length<address>(&v2);
        0x1::vector::append<address>(&mut v5.referrals, v2);
        let v6 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg1.users, arg2);
        v6.referrals = 0x1::vector::empty<address>();
        v6.refer_count = 0;
        v6.tickets = 0x1::vector::empty<u8>();
        let v7 = UserRecovered{
            user     : arg2,
            user_id  : v1,
            new_user : arg3,
        };
        0x2::event::emit<UserRecovered>(v7);
    }

    public entry fun register_by_admin(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg4);
        register_user(arg0, arg1, arg2, arg3);
    }

    public entry fun register_by_user(arg0: &mut VaultUser, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        register_user(arg0, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    public(friend) fun register_user(arg0: &mut VaultUser, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return 0
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
            id               : v5,
            level            : 0,
            score            : 10,
            extra_score      : 10,
            last_active_at   : v2,
            refer_count      : 0,
            referrer         : v1,
            referrals        : 0x1::vector::empty<address>(),
            tickets          : 0x1::vector::empty<u8>(),
            password_hash    : 0x1::vector::empty<u8>(),
            principal_locked : false,
            account_locked   : false,
        };
        0x2::linked_table::push_back<address, UserNode>(&mut arg0.users, arg1, v6);
        add_user_address(arg0, v5, arg1);
        let v7 = UserRegistered{
            user     : arg1,
            user_id  : v5,
            referrer : v1,
        };
        0x2::event::emit<UserRegistered>(v7);
        v5
    }

    public entry fun remove_user(arg0: &mut VaultUser, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg2);
        let v0 = get_user_address(arg0, arg1);
        if (0x2::linked_table::contains<address, UserNode>(&arg0.users, v0)) {
            let UserNode {
                id               : v1,
                level            : _,
                score            : _,
                extra_score      : _,
                last_active_at   : _,
                refer_count      : _,
                referrer         : v7,
                referrals        : _,
                tickets          : _,
                password_hash    : _,
                principal_locked : _,
                account_locked   : _,
            } = 0x2::linked_table::remove<address, UserNode>(&mut arg0.users, v0);
            add_user_address(arg0, v1, @0x0);
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
                user_id  : v1,
                referrer : v7,
            };
            0x2::event::emit<UserRemoved>(v16);
        };
    }

    public entry fun safe_lock(arg0: &mut VaultUser, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg2) > 0, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_value());
        let v0 = 0;
        let v1 = if (0x1::vector::length<u8>(0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v0)) > 0) {
            let v2 = 1;
            0x1::vector::length<u8>(0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v2)) > 0
        } else {
            false
        };
        let v3 = if (v1) {
            let v4 = 2;
            0x1::vector::length<u8>(0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v4)) > 0
        } else {
            false
        };
        let v5 = if (v3) {
            let v6 = 3;
            0x1::vector::length<u8>(0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v6)) > 0
        } else {
            false
        };
        assert!(v5, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_state());
        assert!(arg3 <= 0x2::clock::timestamp_ms(arg7) + 300000 && arg3 + 300000 > 0x2::clock::timestamp_ms(arg7), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_value());
        let v7 = if (arg6 == 0) {
            0x2::tx_context::sender(arg8)
        } else {
            get_user_address(arg0, arg6)
        };
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, v7), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_user());
        let v8 = 0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, v7);
        if (0x1::vector::length<u8>(&v8.password_hash) != 0 && v8.password_hash != arg2) {
            abort 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_password()
        };
        0x1::vector::append<u8>(&mut arg2, 0x2::bcs::to_bytes<u64>(&arg3));
        let v9 = 0x2::groth16::bn254();
        let v10 = 0;
        let v11 = 1;
        let v12 = 2;
        let v13 = 3;
        let v14 = 0x2::groth16::pvk_from_bytes(*0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v10), *0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v11), *0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v12), *0x2::vec_map::get<u8, vector<u8>>(&arg0.vk, &v13));
        let v15 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v16 = 0x2::groth16::proof_points_from_bytes(arg1);
        assert!(0x2::groth16::verify_groth16_proof(&v9, &v14, &v15, &v16), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_proof());
        if (arg6 == 0 && 0x1::vector::length<u8>(&v8.password_hash) == 0) {
            v8.password_hash = arg2;
        } else {
            v8.principal_locked = arg4;
            v8.account_locked = arg5;
        };
        let v17 = PrincipalLocked{
            user             : v7,
            user_id          : v8.id,
            principal_locked : arg4,
        };
        0x2::event::emit<PrincipalLocked>(v17);
    }

    public entry fun set_admin(arg0: &AdminCap, arg1: &mut VaultUser, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.admin = arg2;
    }

    public entry fun set_level_config(arg0: &mut VaultUser, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg6);
        assert!(arg1 > 0 && arg1 <= 20, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_level());
        assert!(arg2 >= 0 && arg3 >= 500 && arg4 >= 50 && arg5 >= 10, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_value());
        assert!(arg3 + arg4 + arg5 <= 1000, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_value());
        if (arg1 > 1) {
            let v0 = arg1 - 1;
            assert!(0x2::vec_map::contains<u8, LevelConfig>(&arg0.level_configs, &v0), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_level());
            let v1 = arg1 - 1;
            let v2 = 0x2::vec_map::get<u8, LevelConfig>(&arg0.level_configs, &v1);
            assert!(v2.min_score <= arg2 && v2.actual_percentage <= arg3 && v2.direct_percentage <= arg4 && v2.indirect_percentage <= arg5, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_value());
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
            min_score           : arg2,
            actual_percentage   : arg3,
            direct_percentage   : arg4,
            indirect_percentage : arg5,
        };
        0x2::event::emit<LevelConfigUpdated>(v5);
    }

    public entry fun set_operator(arg0: &mut VaultUser, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg2);
        arg0.operator = arg1;
        let v0 = OperatorUpdated{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public entry fun set_vk(arg0: &AdminCap, arg1: &mut VaultUser, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::size<u8, vector<u8>>(&arg1.vk) < 5, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_value());
        0x2::vec_map::insert<u8, vector<u8>>(&mut arg1.vk, arg2, arg3);
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
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::unauthorized());
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
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_user());
        0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1).extra_score = arg2;
    }

    public(friend) fun update_referrer(arg0: &mut VaultUser, arg1: address, arg2: address, arg3: &0x2::clock::Clock) {
        if (arg1 == @0x2012 && !0x2::linked_table::contains<address, UserNode>(&arg0.users, @0x2012)) {
            let v0 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v0, arg2);
            let v1 = UserNode{
                id               : 3000,
                level            : 0,
                score            : 10,
                extra_score      : 10,
                last_active_at   : 0x2::clock::timestamp_ms(arg3),
                refer_count      : 1,
                referrer         : @0x2012,
                referrals        : v0,
                tickets          : 0x1::vector::empty<u8>(),
                password_hash    : 0x1::vector::empty<u8>(),
                principal_locked : false,
                account_locked   : false,
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
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_user());
        0x2::linked_table::borrow_mut<address, UserNode>(&mut arg0.users, arg1).extra_score = arg2;
    }

    public entry fun update_user_level(arg0: &mut VaultUser, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_vault_admin(arg0, arg3);
        assert!(0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1), 0x766225d4e8a287554de3639b115dd000f148d5f65c1054e04e7c4e992af275c7::errors::invalid_user());
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

    public(friend) fun user_id(arg0: &VaultUser, arg1: address) : u64 {
        if (!0x2::linked_table::contains<address, UserNode>(&arg0.users, arg1)) {
            return 0
        };
        0x2::linked_table::borrow<address, UserNode>(&arg0.users, arg1).id
    }

    // decompiled from Move bytecode v6
}

