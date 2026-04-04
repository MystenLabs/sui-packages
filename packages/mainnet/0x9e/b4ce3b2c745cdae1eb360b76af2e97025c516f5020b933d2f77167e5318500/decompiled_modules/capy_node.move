module 0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::capy_node {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MiningCommit has key {
        id: 0x2::object::UID,
        miner: address,
        nft_node_id: 0x2::object::ID,
        commit_hash: vector<u8>,
        commit_time: u64,
        revealed: bool,
    }

    struct MinerPool has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        start_time: u64,
        reward_balance: 0x2::balance::Balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>,
        app_uid: 0x2::object::ID,
    }

    struct NFTNode has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        power: u64,
        last_claim_time: u64,
        registered_at: u64,
        owner: address,
        type_str: 0x1::ascii::String,
        super_id: 0x1::option::Option<0x2::object::ID>,
        fee_percent: u8,
        fee_recipient: address,
        shard_pool_id: 0x2::object::ID,
    }

    struct SuperNode has key {
        id: 0x2::object::UID,
        version: u64,
        creator: address,
        tied_capy_id: 0x2::object::ID,
        enabled_type: 0x1::type_name::TypeName,
        super_number: u64,
        fee_percent: u8,
        current_onboarded: u64,
        max_onboarded: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        shard_pool_ids: vector<0x2::object::ID>,
        total_super_nodes_created: u64,
        registered_wallets: 0x2::table::Table<address, bool>,
        shard_participant_counts: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        allowed_types: 0x2::table::Table<0x1::ascii::String, bool>,
        super_count: 0x2::table::Table<0x1::ascii::String, u64>,
    }

    struct ShardPool has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        total_power: u128,
        participant_count: u64,
        difficulty_factor: u64,
        total_power_snapshot: u128,
        last_snapshot_day: u64,
    }

    struct CapyUnregistered has copy, drop {
        miner: address,
        commit_id: 0x2::object::ID,
        reason: vector<u8>,
    }

    struct CommitDeleted has copy, drop {
        miner: address,
        commit_id: 0x2::object::ID,
        reason: vector<u8>,
    }

    struct SuperNodeCreated has copy, drop {
        creator: address,
        nft_type: 0x1::type_name::TypeName,
        super_number: u64,
        fee_amount: u64,
        fee_percent: u8,
    }

    struct NewAllowedTypeAdded has copy, drop {
        nft_type: 0x1::ascii::String,
        added_by: address,
    }

    struct RoyaltyPaid has copy, drop {
        super_node_id: 0x2::object::ID,
        miner: address,
        creator: address,
        amount: u64,
        phase: u64,
    }

    struct MineSucceeded has copy, drop {
        miner: address,
        nft_id: 0x2::object::ID,
        reward_amount: u64,
        phase: u64,
    }

    struct MineFailed has copy, drop {
        miner: address,
        nft_id: 0x2::object::ID,
    }

    fun adjust_difficulty_shard(arg0: &mut ShardPool) {
        let v0 = 1000 + arg0.participant_count * 1;
        let v1 = if (v0 > 100000000) {
            100000000
        } else {
            v0
        };
        arg0.difficulty_factor = v1;
    }

    fun calculate_power() : u64 {
        1000000000
    }

    entry fun commit_mine(arg0: &NFTNode, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (arg0.last_claim_time == 0) {
            arg0.registered_at
        } else {
            arg0.last_claim_time
        };
        assert!(v1 - v2 >= 86400000, 10);
        0x1::vector::append<u8>(&mut arg1, 0x2::address::to_bytes(v0));
        0x1::vector::append<u8>(&mut arg1, 0x2::object::id_bytes<NFTNode>(arg0));
        0x1::vector::append<u8>(&mut arg1, 0x2::bcs::to_bytes<u64>(&v1));
        let v3 = MiningCommit{
            id          : 0x2::object::new(arg3),
            miner       : v0,
            nft_node_id : 0x2::object::id<NFTNode>(arg0),
            commit_hash : 0x2::hash::blake2b256(&arg1),
            commit_time : v1,
            revealed    : false,
        };
        0x2::transfer::transfer<MiningCommit>(v3, v0);
    }

    public fun create_config(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::ascii::String, bool>(arg1);
        0x2::table::add<0x1::ascii::String, bool>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>()), true);
        let v1 = Config{
            id            : 0x2::object::new(arg1),
            version       : 2,
            admin         : 0x2::object::id<AdminCap>(arg0),
            allowed_types : v0,
            super_count   : 0x2::table::new<0x1::ascii::String, u64>(arg1),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun create_pool(arg0: 0x2::object::ID, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MinerPool{
            id             : 0x2::object::new(arg2),
            version        : 2,
            admin          : 0x2::object::id<AdminCap>(arg1),
            start_time     : 0,
            reward_balance : 0x2::balance::zero<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(),
            app_uid        : arg0,
        };
        0x2::transfer::share_object<MinerPool>(v0);
    }

    public fun create_registry(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                        : 0x2::object::new(arg1),
            version                   : 2,
            admin                     : 0x2::object::id<AdminCap>(arg0),
            shard_pool_ids            : 0x1::vector::empty<0x2::object::ID>(),
            total_super_nodes_created : 0,
            registered_wallets        : 0x2::table::new<address, bool>(arg1),
            shard_participant_counts  : 0x2::table::new<0x2::object::ID, u64>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun create_shard_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ShardPool{
            id                   : 0x2::object::new(arg2),
            version              : 2,
            admin                : 0x2::object::id<AdminCap>(arg1),
            total_power          : 0,
            participant_count    : 0,
            difficulty_factor    : 1000,
            total_power_snapshot : 0,
            last_snapshot_day    : 0,
        };
        assert!(arg0.version == 2, 27);
        let v1 = 0x2::object::id<ShardPool>(&v0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.shard_pool_ids, v1);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, v1, 0);
        0x2::transfer::share_object<ShardPool>(v0);
    }

    entry fun create_super_node<T0: store + key>(arg0: &mut Registry, arg1: &mut Config, arg2: &mut MinerPool, arg3: &NFTNode, arg4: &T0, arg5: u8, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        assert!(arg2.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = if (arg5 == 0) {
            true
        } else if (arg5 == 2) {
            true
        } else if (arg5 == 4) {
            true
        } else if (arg5 == 6) {
            true
        } else if (arg5 == 8) {
            true
        } else {
            arg5 == 10
        };
        assert!(v1, 17);
        assert!(arg3.owner == v0, 1);
        assert!(arg3.type_str == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>()), 18);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = 0x1::type_name::into_string(v2);
        if (!0x2::table::contains<0x1::ascii::String, bool>(&arg1.allowed_types, v3)) {
            0x2::table::add<0x1::ascii::String, bool>(&mut arg1.allowed_types, v3, true);
            let v4 = NewAllowedTypeAdded{
                nft_type : v3,
                added_by : v0,
            };
            0x2::event::emit<NewAllowedTypeAdded>(v4);
        };
        let v5 = 0;
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg1.super_count, v3)) {
            v5 = *0x2::table::borrow<0x1::ascii::String, u64>(&arg1.super_count, v3);
        };
        assert!(v5 < 100, 16);
        let v6 = arg0.total_super_nodes_created;
        if (v6 < 5) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 10000000000, 15);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, 10000000000, arg8), @0xd0d72246bfb13549f654628d34bee78aaca712003a6e61fb6b406f5470967a);
        } else {
            assert!(0x2::coin::value<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&arg7) >= 100000000000000, 15);
            0x2::balance::join<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg2.reward_balance, 0x2::coin::into_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(0x2::coin::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg7, 100000000000000, arg8)));
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg6);
        };
        if (0x2::coin::value<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(arg7, v0);
        } else {
            0x2::coin::destroy_zero<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(arg7);
        };
        let v7 = v5 + 1;
        if (v5 == 0) {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg1.super_count, v3, v7);
        } else {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg1.super_count, v3) = v7;
        };
        arg0.total_super_nodes_created = arg0.total_super_nodes_created + 1;
        let v8 = SuperNode{
            id                : 0x2::object::new(arg8),
            version           : 2,
            creator           : v0,
            tied_capy_id      : arg3.nft_id,
            enabled_type      : v2,
            super_number      : v7,
            fee_percent       : arg5,
            current_onboarded : 0,
            max_onboarded     : 5000,
        };
        0x2::transfer::share_object<SuperNode>(v8);
        let v9 = if (v6 < 5) {
            10000000000
        } else {
            100000000000000
        };
        let v10 = SuperNodeCreated{
            creator      : v0,
            nft_type     : v2,
            super_number : v7,
            fee_amount   : v9,
            fee_percent  : arg5,
        };
        0x2::event::emit<SuperNodeCreated>(v10);
    }

    entry fun delete_expired_commit(arg0: MiningCommit, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.miner == v0, 1);
        assert!(v1 - arg0.commit_time > 600000, 8);
        assert!(v1 - arg0.commit_time >= 86400000, 10);
        let v2 = CommitDeleted{
            miner     : v0,
            commit_id : 0x2::object::id<MiningCommit>(&arg0),
            reason    : b"expired",
        };
        0x2::event::emit<CommitDeleted>(v2);
        let MiningCommit {
            id          : v3,
            miner       : _,
            nft_node_id : _,
            commit_hash : _,
            commit_time : _,
            revealed    : _,
        } = arg0;
        0x2::object::delete(v3);
    }

    fun find_lowest_shard_index(arg0: &vector<0x2::object::ID>, arg1: &0x2::table::Table<0x2::object::ID, u64>) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, u64>(arg1, *0x1::vector::borrow<0x2::object::ID>(arg0, 0));
        let v1 = 1;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            v0 = 0x2::table::borrow<0x2::object::ID, u64>(arg1, *0x1::vector::borrow<0x2::object::ID>(arg0, v1));
            if (*v0 < *v0) {
            };
            v1 = v1 + 1;
        };
        0
    }

    public fun fund_pool(arg0: &mut MinerPool, arg1: 0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>) {
        0x2::balance::join<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(arg1));
    }

    public fun get_current_phase_and_reward(arg0: u64, arg1: u64) : (u64, u64) {
        if (arg1 < arg0) {
            return (0, 0)
        };
        let v0 = if (arg1 > arg0 + 3155760000000) {
            arg0 + 3155760000000
        } else {
            arg1
        };
        let v1 = 1;
        let v2 = 7;
        let v3 = 2000 * 1000000000;
        let v4 = (v0 - arg0) / 86400000;
        while (v4 >= v2) {
            v4 = v4 - v2;
            v2 = v2 * 2;
            v3 = v3 / 2;
            v1 = v1 + 1;
        };
        (v1, v3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate_config(arg0: &mut Config, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 25);
        assert!(arg0.version < 2, 26);
        arg0.version = 2;
    }

    entry fun migrate_miner_pool(arg0: &mut MinerPool, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 25);
        assert!(arg0.version < 2, 26);
        arg0.version = 2;
    }

    entry fun migrate_registry(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 25);
        assert!(arg0.version < 2, 26);
        arg0.version = 2;
    }

    entry fun migrate_shard_pool(arg0: &mut ShardPool, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 25);
        assert!(arg0.version < 2, 26);
        arg0.version = 2;
    }

    entry fun migrate_super_node(arg0: &mut SuperNode, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 28);
        assert!(arg0.version < 2, 26);
        arg0.version = 2;
    }

    entry fun register_capy(arg0: &mut Registry, arg1: &mut ShardPool, arg2: &Config, arg3: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, bool>(&arg0.registered_wallets, v0), 5);
        assert!(0x2::object::id<ShardPool>(arg1) == *0x1::vector::borrow<0x2::object::ID>(&arg0.shard_pool_ids, find_lowest_shard_index(&arg0.shard_pool_ids, &arg0.shard_participant_counts)), 23);
        let v1 = calculate_power();
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>());
        assert!(0x2::table::contains<0x1::ascii::String, bool>(&arg2.allowed_types, v3), 12);
        arg1.total_power = arg1.total_power + (v1 as u128);
        arg1.participant_count = arg1.participant_count + 1;
        adjust_difficulty_shard(arg1);
        update_snapshot_if_needed_shard(arg1, v2);
        let v4 = 0x2::object::id<ShardPool>(arg1);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, v4) = arg1.participant_count;
        let v5 = NFTNode{
            id              : 0x2::object::new(arg5),
            nft_id          : 0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>(arg3),
            power           : v1,
            last_claim_time : 0,
            registered_at   : v2,
            owner           : v0,
            type_str        : v3,
            super_id        : 0x1::option::none<0x2::object::ID>(),
            fee_percent     : 0,
            fee_recipient   : @0x0,
            shard_pool_id   : v4,
        };
        0x2::table::add<address, bool>(&mut arg0.registered_wallets, v0, true);
        0x2::transfer::transfer<NFTNode>(v5, v0);
    }

    entry fun register_capy_from_kiosk(arg0: &mut Registry, arg1: &mut ShardPool, arg2: &Config, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<address, bool>(&arg0.registered_wallets, v0), 5);
        assert!(0x2::object::id<ShardPool>(arg1) == *0x1::vector::borrow<0x2::object::ID>(&arg0.shard_pool_ids, find_lowest_shard_index(&arg0.shard_pool_ids, &arg0.shard_participant_counts)), 23);
        let v1 = calculate_power();
        let v2 = 0x2::clock::timestamp_ms(arg6);
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>());
        assert!(0x2::table::contains<0x1::ascii::String, bool>(&arg2.allowed_types, v3), 12);
        arg1.total_power = arg1.total_power + (v1 as u128);
        arg1.participant_count = arg1.participant_count + 1;
        adjust_difficulty_shard(arg1);
        update_snapshot_if_needed_shard(arg1, v2);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, 0x2::object::id<ShardPool>(arg1)) = arg1.participant_count;
        let v4 = NFTNode{
            id              : 0x2::object::new(arg7),
            nft_id          : 0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>(0x2::kiosk::borrow<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy::Capy>>(arg3, arg4, arg5)),
            power           : v1,
            last_claim_time : 0,
            registered_at   : v2,
            owner           : v0,
            type_str        : v3,
            super_id        : 0x1::option::none<0x2::object::ID>(),
            fee_percent     : 0,
            fee_recipient   : @0x0,
            shard_pool_id   : 0x2::object::id<ShardPool>(arg1),
        };
        0x2::table::add<address, bool>(&mut arg0.registered_wallets, v0, true);
        0x2::transfer::transfer<NFTNode>(v4, v0);
    }

    entry fun register_with_super<T0: store + key>(arg0: &mut Registry, arg1: &mut ShardPool, arg2: &Config, arg3: &mut SuperNode, arg4: &T0, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        assert!(arg3.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::table::contains<address, bool>(&arg0.registered_wallets, v0), 5);
        assert!(0x2::object::id<ShardPool>(arg1) == *0x1::vector::borrow<0x2::object::ID>(&arg0.shard_pool_ids, find_lowest_shard_index(&arg0.shard_pool_ids, &arg0.shard_participant_counts)), 23);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, bool>(&arg2.allowed_types, v1), 12);
        assert!(arg3.enabled_type == 0x1::type_name::with_defining_ids<T0>(), 14);
        assert!(arg3.current_onboarded < arg3.max_onboarded, 13);
        let v2 = calculate_power();
        let v3 = 0x2::clock::timestamp_ms(arg5);
        arg1.total_power = arg1.total_power + (v2 as u128);
        arg1.participant_count = arg1.participant_count + 1;
        adjust_difficulty_shard(arg1);
        update_snapshot_if_needed_shard(arg1, v3);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, 0x2::object::id<ShardPool>(arg1)) = arg1.participant_count;
        arg3.current_onboarded = arg3.current_onboarded + 1;
        let v4 = NFTNode{
            id              : 0x2::object::new(arg6),
            nft_id          : 0x2::object::id<T0>(arg4),
            power           : v2,
            last_claim_time : 0,
            registered_at   : v3,
            owner           : v0,
            type_str        : v1,
            super_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<SuperNode>(arg3)),
            fee_percent     : arg3.fee_percent,
            fee_recipient   : arg3.creator,
            shard_pool_id   : 0x2::object::id<ShardPool>(arg1),
        };
        0x2::table::add<address, bool>(&mut arg0.registered_wallets, v0, true);
        0x2::transfer::transfer<NFTNode>(v4, v0);
    }

    entry fun register_with_super_from_kiosk<T0: store + key>(arg0: &mut Registry, arg1: &mut ShardPool, arg2: &Config, arg3: &mut SuperNode, arg4: &0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        assert!(arg3.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!0x2::table::contains<address, bool>(&arg0.registered_wallets, v0), 5);
        assert!(0x2::object::id<ShardPool>(arg1) == *0x1::vector::borrow<0x2::object::ID>(&arg0.shard_pool_ids, find_lowest_shard_index(&arg0.shard_pool_ids, &arg0.shard_participant_counts)), 23);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, bool>(&arg2.allowed_types, v1), 12);
        assert!(arg3.enabled_type == 0x1::type_name::with_defining_ids<T0>(), 14);
        assert!(arg3.current_onboarded < arg3.max_onboarded, 13);
        0x2::kiosk::borrow<T0>(arg4, arg5, arg6);
        let v2 = calculate_power();
        let v3 = 0x2::clock::timestamp_ms(arg7);
        arg1.total_power = arg1.total_power + (v2 as u128);
        arg1.participant_count = arg1.participant_count + 1;
        adjust_difficulty_shard(arg1);
        update_snapshot_if_needed_shard(arg1, v3);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, 0x2::object::id<ShardPool>(arg1)) = arg1.participant_count;
        arg3.current_onboarded = arg3.current_onboarded + 1;
        let v4 = NFTNode{
            id              : 0x2::object::new(arg8),
            nft_id          : arg6,
            power           : v2,
            last_claim_time : 0,
            registered_at   : v3,
            owner           : v0,
            type_str        : v1,
            super_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<SuperNode>(arg3)),
            fee_percent     : arg3.fee_percent,
            fee_recipient   : arg3.creator,
            shard_pool_id   : 0x2::object::id<ShardPool>(arg1),
        };
        0x2::table::add<address, bool>(&mut arg0.registered_wallets, v0, true);
        0x2::transfer::transfer<NFTNode>(v4, v0);
    }

    entry fun reveal_mine<T0: store + key>(arg0: &mut ShardPool, arg1: &mut MinerPool, arg2: &mut NFTNode, arg3: &T0, arg4: MiningCommit, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg4.miner == v0, 1);
        assert!(arg4.nft_node_id == 0x2::object::id<NFTNode>(arg2), 4);
        assert!(arg2.owner == v0, 1);
        assert!(0x2::object::id<T0>(arg3) == arg2.nft_id, 4);
        assert!(!arg4.revealed, 7);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.super_id), 19);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 - arg4.commit_time <= 600000, 8);
        assert!(v1 - arg1.start_time <= 3155760000000, 2);
        0x1::vector::append<u8>(&mut arg5, 0x2::address::to_bytes(v0));
        0x1::vector::append<u8>(&mut arg5, 0x2::object::id_bytes<NFTNode>(arg2));
        0x1::vector::append<u8>(&mut arg5, 0x2::bcs::to_bytes<u64>(&arg4.commit_time));
        assert!(0x2::hash::blake2b256(&arg5) == arg4.commit_hash, 9);
        update_snapshot_if_needed_shard(arg0, v1);
        let (v2, v3) = get_current_phase_and_reward(arg1.start_time, v1);
        let v4 = if (arg0.total_power_snapshot == 0) {
            arg0.total_power
        } else {
            arg0.total_power_snapshot
        };
        assert!(v4 > 0, 21);
        assert!(arg0.difficulty_factor > 0, 24);
        let v5 = 0x2::random::new_generator(arg7, arg8);
        let v6 = 0x2::random::generate_u128(&mut v5);
        0x1::vector::append<u8>(&mut arg5, 0x2::bcs::to_bytes<u128>(&v6));
        let v7 = 0x2::hash::blake2b256(&arg5);
        let v8 = 0x1::vector::length<u8>(&v7);
        let v9 = 0;
        let v10 = if (v8 > 8) {
            v8 - 8
        } else {
            0
        };
        let v11 = 0;
        while (v11 < 8 && v10 + v11 < v8) {
            let v12 = v9 << 8;
            v9 = v12 | (*0x1::vector::borrow<u8>(&v7, v10 + v11) as u64);
            v11 = v11 + 1;
        };
        arg2.last_claim_time = v1;
        let MiningCommit {
            id          : v13,
            miner       : _,
            nft_node_id : _,
            commit_hash : _,
            commit_time : _,
            revealed    : _,
        } = arg4;
        0x2::object::delete(v13);
        if (((v9 % 1000000) as u128) < (arg2.power as u128) * 1000 / (arg0.difficulty_factor as u128) * 1000000 / v4 && v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(0x2::coin::from_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(0x2::balance::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg1.reward_balance, v3), arg8), v0);
            let v19 = MineSucceeded{
                miner         : v0,
                nft_id        : arg2.nft_id,
                reward_amount : v3,
                phase         : v2,
            };
            0x2::event::emit<MineSucceeded>(v19);
        } else {
            let v20 = MineFailed{
                miner  : v0,
                nft_id : arg2.nft_id,
            };
            0x2::event::emit<MineFailed>(v20);
        };
    }

    entry fun reveal_mine_from_kiosk<T0: store + key>(arg0: &mut ShardPool, arg1: &mut MinerPool, arg2: &mut NFTNode, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: MiningCommit, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::random::Random, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg6.miner == v0, 1);
        assert!(arg6.nft_node_id == 0x2::object::id<NFTNode>(arg2), 4);
        assert!(arg2.owner == v0, 1);
        assert!(!arg6.revealed, 7);
        assert!(0x2::object::id<T0>(0x2::kiosk::borrow<T0>(arg3, arg4, arg5)) == arg2.nft_id, 4);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.super_id), 19);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(v1 - arg6.commit_time <= 600000, 8);
        assert!(v1 - arg1.start_time <= 3155760000000, 2);
        0x1::vector::append<u8>(&mut arg7, 0x2::address::to_bytes(v0));
        0x1::vector::append<u8>(&mut arg7, 0x2::object::id_bytes<NFTNode>(arg2));
        0x1::vector::append<u8>(&mut arg7, 0x2::bcs::to_bytes<u64>(&arg6.commit_time));
        assert!(0x2::hash::blake2b256(&arg7) == arg6.commit_hash, 9);
        update_snapshot_if_needed_shard(arg0, v1);
        let (v2, v3) = get_current_phase_and_reward(arg1.start_time, v1);
        let v4 = if (arg0.total_power_snapshot == 0) {
            arg0.total_power
        } else {
            arg0.total_power_snapshot
        };
        assert!(v4 > 0, 21);
        assert!(arg0.difficulty_factor > 0, 24);
        let v5 = 0x2::random::new_generator(arg9, arg10);
        let v6 = 0x2::random::generate_u128(&mut v5);
        0x1::vector::append<u8>(&mut arg7, 0x2::bcs::to_bytes<u128>(&v6));
        let v7 = 0x2::hash::blake2b256(&arg7);
        let v8 = 0x1::vector::length<u8>(&v7);
        let v9 = 0;
        let v10 = if (v8 > 8) {
            v8 - 8
        } else {
            0
        };
        let v11 = 0;
        while (v11 < 8 && v10 + v11 < v8) {
            let v12 = v9 << 8;
            v9 = v12 | (*0x1::vector::borrow<u8>(&v7, v10 + v11) as u64);
            v11 = v11 + 1;
        };
        arg2.last_claim_time = v1;
        let MiningCommit {
            id          : v13,
            miner       : _,
            nft_node_id : _,
            commit_hash : _,
            commit_time : _,
            revealed    : _,
        } = arg6;
        0x2::object::delete(v13);
        if (((v9 % 1000000) as u128) < (arg2.power as u128) * 1000 / (arg0.difficulty_factor as u128) * 1000000 / v4 && v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(0x2::coin::from_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(0x2::balance::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg1.reward_balance, v3), arg10), v0);
            let v19 = MineSucceeded{
                miner         : v0,
                nft_id        : arg2.nft_id,
                reward_amount : v3,
                phase         : v2,
            };
            0x2::event::emit<MineSucceeded>(v19);
        } else {
            let v20 = MineFailed{
                miner  : v0,
                nft_id : arg2.nft_id,
            };
            0x2::event::emit<MineFailed>(v20);
        };
    }

    entry fun reveal_with_super<T0: store + key>(arg0: &mut ShardPool, arg1: &mut MinerPool, arg2: &mut NFTNode, arg3: &T0, arg4: &SuperNode, arg5: MiningCommit, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &0x2::random::Random, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.super_id), 20);
        assert!(0x2::object::id<SuperNode>(arg4) == *0x1::option::borrow<0x2::object::ID>(&arg2.super_id), 14);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg5.miner == v0, 1);
        assert!(arg5.nft_node_id == 0x2::object::id<NFTNode>(arg2), 4);
        assert!(arg2.owner == v0, 1);
        assert!(0x2::object::id<T0>(arg3) == arg2.nft_id, 4);
        assert!(!arg5.revealed, 7);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        assert!(v1 - arg5.commit_time <= 600000, 8);
        assert!(v1 - arg1.start_time <= 3155760000000, 2);
        0x1::vector::append<u8>(&mut arg6, 0x2::address::to_bytes(v0));
        0x1::vector::append<u8>(&mut arg6, 0x2::object::id_bytes<NFTNode>(arg2));
        0x1::vector::append<u8>(&mut arg6, 0x2::bcs::to_bytes<u64>(&arg5.commit_time));
        assert!(0x2::hash::blake2b256(&arg6) == arg5.commit_hash, 9);
        update_snapshot_if_needed_shard(arg0, v1);
        let (v2, v3) = get_current_phase_and_reward(arg1.start_time, v1);
        let v4 = if (arg0.total_power_snapshot == 0) {
            arg0.total_power
        } else {
            arg0.total_power_snapshot
        };
        assert!(v4 > 0, 21);
        assert!(arg0.difficulty_factor > 0, 24);
        let v5 = 0x2::random::new_generator(arg8, arg9);
        let v6 = 0x2::random::generate_u128(&mut v5);
        0x1::vector::append<u8>(&mut arg6, 0x2::bcs::to_bytes<u128>(&v6));
        let v7 = 0x2::hash::blake2b256(&arg6);
        let v8 = 0x1::vector::length<u8>(&v7);
        let v9 = 0;
        let v10 = if (v8 > 8) {
            v8 - 8
        } else {
            0
        };
        let v11 = 0;
        while (v11 < 8 && v10 + v11 < v8) {
            let v12 = v9 << 8;
            v9 = v12 | (*0x1::vector::borrow<u8>(&v7, v10 + v11) as u64);
            v11 = v11 + 1;
        };
        arg2.last_claim_time = v1;
        let MiningCommit {
            id          : v13,
            miner       : _,
            nft_node_id : _,
            commit_hash : _,
            commit_time : _,
            revealed    : _,
        } = arg5;
        0x2::object::delete(v13);
        if (((v9 % 1000000) as u128) < (arg2.power as u128) * 1000 / (arg0.difficulty_factor as u128) * 1000000 / v4 && v3 > 0) {
            let v19 = 0x2::balance::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg1.reward_balance, v3);
            let v20 = v3 * (arg4.fee_percent as u64) / 100;
            if (v20 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(0x2::coin::from_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(0x2::balance::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut v19, v20), arg9), arg4.creator);
                let v21 = RoyaltyPaid{
                    super_node_id : 0x2::object::id<SuperNode>(arg4),
                    miner         : v0,
                    creator       : arg4.creator,
                    amount        : v20,
                    phase         : v2,
                };
                0x2::event::emit<RoyaltyPaid>(v21);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(0x2::coin::from_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(v19, arg9), v0);
            let v22 = MineSucceeded{
                miner         : v0,
                nft_id        : arg2.nft_id,
                reward_amount : v3,
                phase         : v2,
            };
            0x2::event::emit<MineSucceeded>(v22);
        } else {
            let v23 = MineFailed{
                miner  : v0,
                nft_id : arg2.nft_id,
            };
            0x2::event::emit<MineFailed>(v23);
        };
    }

    entry fun reveal_with_super_from_kiosk<T0: store + key>(arg0: &mut ShardPool, arg1: &mut MinerPool, arg2: &mut NFTNode, arg3: &0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &SuperNode, arg7: MiningCommit, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &0x2::random::Random, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg2.super_id), 20);
        assert!(0x2::object::id<SuperNode>(arg6) == *0x1::option::borrow<0x2::object::ID>(&arg2.super_id), 14);
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(arg7.miner == v0, 1);
        assert!(arg7.nft_node_id == 0x2::object::id<NFTNode>(arg2), 4);
        assert!(arg2.owner == v0, 1);
        assert!(!arg7.revealed, 7);
        assert!(0x2::object::id<T0>(0x2::kiosk::borrow<T0>(arg3, arg4, arg5)) == arg2.nft_id, 4);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(v1 - arg7.commit_time <= 600000, 8);
        assert!(v1 - arg1.start_time <= 3155760000000, 2);
        0x1::vector::append<u8>(&mut arg8, 0x2::address::to_bytes(v0));
        0x1::vector::append<u8>(&mut arg8, 0x2::object::id_bytes<NFTNode>(arg2));
        0x1::vector::append<u8>(&mut arg8, 0x2::bcs::to_bytes<u64>(&arg7.commit_time));
        assert!(0x2::hash::blake2b256(&arg8) == arg7.commit_hash, 9);
        update_snapshot_if_needed_shard(arg0, v1);
        let (v2, v3) = get_current_phase_and_reward(arg1.start_time, v1);
        let v4 = if (arg0.total_power_snapshot == 0) {
            arg0.total_power
        } else {
            arg0.total_power_snapshot
        };
        assert!(v4 > 0, 21);
        assert!(arg0.difficulty_factor > 0, 24);
        let v5 = 0x2::random::new_generator(arg10, arg11);
        let v6 = 0x2::random::generate_u128(&mut v5);
        0x1::vector::append<u8>(&mut arg8, 0x2::bcs::to_bytes<u128>(&v6));
        let v7 = 0x2::hash::blake2b256(&arg8);
        let v8 = 0x1::vector::length<u8>(&v7);
        let v9 = 0;
        let v10 = if (v8 > 8) {
            v8 - 8
        } else {
            0
        };
        let v11 = 0;
        while (v11 < 8 && v10 + v11 < v8) {
            let v12 = v9 << 8;
            v9 = v12 | (*0x1::vector::borrow<u8>(&v7, v10 + v11) as u64);
            v11 = v11 + 1;
        };
        arg2.last_claim_time = v1;
        let MiningCommit {
            id          : v13,
            miner       : _,
            nft_node_id : _,
            commit_hash : _,
            commit_time : _,
            revealed    : _,
        } = arg7;
        0x2::object::delete(v13);
        if (((v9 % 1000000) as u128) < (arg2.power as u128) * 1000 / (arg0.difficulty_factor as u128) * 1000000 / v4 && v3 > 0) {
            let v19 = 0x2::balance::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut arg1.reward_balance, v3);
            let v20 = v3 * (arg6.fee_percent as u64) / 100;
            if (v20 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(0x2::coin::from_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(0x2::balance::split<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(&mut v19, v20), arg11), arg6.creator);
                let v21 = RoyaltyPaid{
                    super_node_id : 0x2::object::id<SuperNode>(arg6),
                    miner         : v0,
                    creator       : arg6.creator,
                    amount        : v20,
                    phase         : v2,
                };
                0x2::event::emit<RoyaltyPaid>(v21);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>>(0x2::coin::from_balance<0x14bd61802d31291fb410bd75757e3347221bf8019707307e5926afeebf4667cf::cbtc::CBTC>(v19, arg11), v0);
            let v22 = MineSucceeded{
                miner         : v0,
                nft_id        : arg2.nft_id,
                reward_amount : v3,
                phase         : v2,
            };
            0x2::event::emit<MineSucceeded>(v22);
        } else {
            let v23 = MineFailed{
                miner  : v0,
                nft_id : arg2.nft_id,
            };
            0x2::event::emit<MineFailed>(v23);
        };
    }

    public fun set_start_time(arg0: &mut MinerPool, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 2, 27);
        assert!(arg0.start_time == 0, 3);
        arg0.start_time = 0x2::clock::timestamp_ms(arg2);
    }

    entry fun unregister_capy(arg0: &mut Registry, arg1: &mut ShardPool, arg2: NFTNode, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2.owner == v0, 1);
        assert!(arg2.shard_pool_id == 0x2::object::id<ShardPool>(arg1), 22);
        assert!(0x2::table::contains<address, bool>(&arg0.registered_wallets, v0), 6);
        assert!(arg1.participant_count > 0, 11);
        assert!(arg1.total_power >= (arg2.power as u128), 11);
        arg1.total_power = arg1.total_power - (arg2.power as u128);
        arg1.participant_count = arg1.participant_count - 1;
        adjust_difficulty_shard(arg1);
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, 0x2::object::id<ShardPool>(arg1)) = arg1.participant_count;
        0x2::table::remove<address, bool>(&mut arg0.registered_wallets, v0);
        let v1 = CapyUnregistered{
            miner     : v0,
            commit_id : 0x2::object::id<NFTNode>(&arg2),
            reason    : b"unregistered",
        };
        0x2::event::emit<CapyUnregistered>(v1);
        let NFTNode {
            id              : v2,
            nft_id          : _,
            power           : _,
            last_claim_time : _,
            registered_at   : _,
            owner           : _,
            type_str        : _,
            super_id        : _,
            fee_percent     : _,
            fee_recipient   : _,
            shard_pool_id   : _,
        } = arg2;
        0x2::object::delete(v2);
    }

    entry fun unregister_with_super(arg0: &mut Registry, arg1: &mut ShardPool, arg2: &mut SuperNode, arg3: NFTNode, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 27);
        assert!(arg1.version == 2, 27);
        assert!(arg2.version == 2, 27);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3.owner == v0, 1);
        assert!(0x2::table::contains<address, bool>(&arg0.registered_wallets, v0), 6);
        let v1 = 0x2::object::id<SuperNode>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg3.super_id, &v1), 14);
        assert!(arg3.shard_pool_id == 0x2::object::id<ShardPool>(arg1), 22);
        assert!(arg1.participant_count > 0, 11);
        assert!(arg1.total_power >= (arg3.power as u128), 11);
        assert!(arg2.current_onboarded > 0, 11);
        arg1.total_power = arg1.total_power - (arg3.power as u128);
        arg1.participant_count = arg1.participant_count - 1;
        adjust_difficulty_shard(arg1);
        arg2.current_onboarded = arg2.current_onboarded - 1;
        *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.shard_participant_counts, 0x2::object::id<ShardPool>(arg1)) = arg1.participant_count;
        0x2::table::remove<address, bool>(&mut arg0.registered_wallets, v0);
        let NFTNode {
            id              : v2,
            nft_id          : _,
            power           : _,
            last_claim_time : _,
            registered_at   : _,
            owner           : _,
            type_str        : _,
            super_id        : _,
            fee_percent     : _,
            fee_recipient   : _,
            shard_pool_id   : _,
        } = arg3;
        0x2::object::delete(v2);
    }

    fun update_snapshot_if_needed_shard(arg0: &mut ShardPool, arg1: u64) {
        let v0 = arg1 / 86400000;
        if (v0 > arg0.last_snapshot_day) {
            arg0.total_power_snapshot = arg0.total_power;
            arg0.last_snapshot_day = v0;
        };
    }

    // decompiled from Move bytecode v6
}

