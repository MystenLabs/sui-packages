module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        total_shares: u64,
        total_blocks: u64,
        miners: 0x2::table::Table<address, MinerStats>,
        share_hashes: 0x2::table::Table<vector<u8>, bool>,
        admin: address,
        chain_tip: 0x1::option::Option<address>,
        chain_height: u64,
        current_round: u64,
        round_start_ms: u64,
        round_total_work: u128,
        round_shares: u64,
        global_min_difficulty: u64,
        difficulty_window: vector<u64>,
        difficulty_window_size: u64,
        avg_share_difficulty: u64,
    }

    struct Template has store, key {
        id: 0x2::object::UID,
        height: u64,
        prev_block_hash: vector<u8>,
        coinbase1: vector<u8>,
        coinbase2: vector<u8>,
        merkle_branches: vector<vector<u8>>,
        version: u32,
        nbits: u32,
        ntime: u32,
        is_active: bool,
        owner: address,
        created_at_ms: u64,
        share_count: u64,
    }

    struct MinerStats has copy, drop, store {
        current_difficulty: u64,
        last_share_time_ms: u64,
        total_shares: u64,
        blocks_found: u64,
        avg_share_interval_ms: u64,
        registered_at_ms: u64,
        current_round_work: u128,
        current_round_shares: u64,
        last_round_id: u64,
    }

    struct MiningShare has store, key {
        id: 0x2::object::UID,
        template_id: address,
        block_height: u64,
        prev_block_hash: vector<u8>,
        merkle_root: vector<u8>,
        extranonce1: vector<u8>,
        extranonce2: vector<u8>,
        ntime: u32,
        nonce: u32,
        version: u32,
        share_hash: vector<u8>,
        difficulty_achieved: u64,
        target_difficulty: u64,
        network_difficulty: u64,
        is_block: bool,
        miner: address,
        timestamp_ms: u64,
        parent_share: 0x1::option::Option<address>,
        chain_height: u64,
        round_id: u64,
        work_weight: u64,
    }

    struct MinerRegistered has copy, drop {
        miner: address,
        initial_difficulty: u64,
        timestamp_ms: u64,
    }

    struct TemplateCreated has copy, drop {
        template_id: address,
        height: u64,
        prev_block_hash: vector<u8>,
        ntime: u32,
        owner: address,
        timestamp_ms: u64,
    }

    struct ShareSubmitted has copy, drop {
        share_id: address,
        miner: address,
        template_id: address,
        difficulty_achieved: u64,
        target_difficulty: u64,
        is_block: bool,
        timestamp_ms: u64,
    }

    struct BlockFound has copy, drop {
        share_id: address,
        miner: address,
        height: u64,
        share_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct DifficultyAdjusted has copy, drop {
        miner: address,
        old_difficulty: u64,
        new_difficulty: u64,
    }

    struct DifficultyReset has copy, drop {
        miner: address,
        old_difficulty: u64,
        new_difficulty: u64,
        time_since_last_share_ms: u64,
    }

    struct RoundComplete has copy, drop {
        round_id: u64,
        block_height: u64,
        block_finder: address,
        total_work: u128,
        total_shares: u64,
        duration_ms: u64,
    }

    struct ShareValidated has copy, drop {
        miner: address,
        template_id: address,
        share_hash: vector<u8>,
        difficulty_achieved: u64,
        target_difficulty: u64,
        is_block: bool,
        timestamp_ms: u64,
    }

    fun adjust_global_difficulty(arg0: &mut Pool, arg1: u64) {
        let v0 = 0x1::vector::length<u64>(&arg0.difficulty_window);
        if (v0 < 2) {
            return
        };
        let v1 = *0x1::vector::borrow<u64>(&arg0.difficulty_window, 0);
        let v2 = if (arg1 > v1) {
            arg1 - v1
        } else {
            1
        };
        let v3 = (v2 as u128) * (2 as u128);
        if (v3 == 0) {
            return
        };
        let v4 = (arg0.global_min_difficulty as u128) * (v0 as u128) * 30000 / v3;
        let v5 = if (v4 > (1000000000000000 as u128)) {
            1000000000000000
        } else if (v4 < (1 as u128)) {
            1
        } else {
            (v4 as u64)
        };
        arg0.global_min_difficulty = v5;
    }

    fun append_u32_le(arg0: &mut vector<u8>, arg1: u32) {
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
    }

    fun bytes_to_u256_le(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u8>(arg0);
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, v2) as u256);
        };
        v0
    }

    public fun calculate_miner_proportion(arg0: &Pool, arg1: address) : (u128, u128) {
        if (!0x2::table::contains<address, MinerStats>(&arg0.miners, arg1)) {
            return (0, 1)
        };
        let v0 = 0x2::table::borrow<address, MinerStats>(&arg0.miners, arg1);
        if (v0.last_round_id != arg0.current_round) {
            return (0, 1)
        };
        let v1 = arg0.round_total_work;
        if (v1 == 0) {
            (0, 1)
        } else {
            (v0.current_round_work, v1)
        }
    }

    fun compute_merkle_root(arg0: vector<u8>, arg1: &vector<vector<u8>>) : vector<u8> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            let v2 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(arg1, v1));
            v0 = sha256d(v2);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun deactivate_template(arg0: &mut Template, arg1: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 5);
        arg0.is_active = false;
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::deactivate_in_index(arg1, 0x2::object::uid_to_address(&arg0.id), 0x2::clock::timestamp_ms(arg2));
    }

    public entry fun decay_miner_difficulty(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg2 || v0 == arg0.admin, 5);
        assert!(0x2::table::contains<address, MinerStats>(&arg0.miners, arg2), 3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::table::borrow_mut<address, MinerStats>(&mut arg0.miners, arg2);
        let v3 = if (v1 > v2.last_share_time_ms) {
            v1 - v2.last_share_time_ms
        } else {
            0
        };
        assert!(v3 > 30000 * 4, 8);
        let v4 = v2.current_difficulty;
        v2.current_difficulty = arg0.global_min_difficulty;
        v2.avg_share_interval_ms = 30000;
        v2.last_share_time_ms = v1;
        if (v4 != v2.current_difficulty) {
            let v5 = DifficultyReset{
                miner                    : arg2,
                old_difficulty           : v4,
                new_difficulty           : v2.current_difficulty,
                time_since_last_share_ms : v3,
            };
            0x2::event::emit<DifficultyReset>(v5);
        };
    }

    fun difficulty_from_hash(arg0: &vector<u8>) : u64 {
        let v0 = bytes_to_u256_le(arg0);
        if (v0 == 0) {
            return 1000000000000000
        };
        let v1 = 26959535291011309493156476344723991336010898738574164086137773096960 / v0;
        if (v1 > (1000000000000000 as u256)) {
            1000000000000000
        } else if (v1 < 1) {
            1
        } else {
            (v1 as u64)
        }
    }

    public fun get_avg_share_difficulty(arg0: &Pool) : u64 {
        arg0.avg_share_difficulty
    }

    public fun get_chain_tip(arg0: &Pool) : (0x1::option::Option<address>, u64) {
        (arg0.chain_tip, arg0.chain_height)
    }

    public fun get_current_round(arg0: &Pool) : (u64, u128, u64) {
        (arg0.current_round, arg0.round_total_work, arg0.round_shares)
    }

    public fun get_global_min_difficulty(arg0: &Pool) : u64 {
        arg0.global_min_difficulty
    }

    public fun get_miner_difficulty(arg0: &Pool, arg1: address) : u64 {
        if (0x2::table::contains<address, MinerStats>(&arg0.miners, arg1)) {
            let v1 = 0x2::table::borrow<address, MinerStats>(&arg0.miners, arg1).current_difficulty;
            if (v1 > arg0.global_min_difficulty) {
                v1
            } else {
                arg0.global_min_difficulty
            }
        } else {
            arg0.global_min_difficulty
        }
    }

    public fun get_miner_round_work(arg0: &Pool, arg1: address) : (u128, u64, u64) {
        if (0x2::table::contains<address, MinerStats>(&arg0.miners, arg1)) {
            let v3 = 0x2::table::borrow<address, MinerStats>(&arg0.miners, arg1);
            if (v3.last_round_id != arg0.current_round) {
                (0, 0, arg0.current_round)
            } else {
                (v3.current_round_work, v3.current_round_shares, v3.last_round_id)
            }
        } else {
            (0, 0, arg0.current_round)
        }
    }

    public fun get_miner_stats(arg0: &Pool, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, MinerStats>(&arg0.miners, arg1)) {
            let v3 = 0x2::table::borrow<address, MinerStats>(&arg0.miners, arg1);
            (v3.total_shares, v3.blocks_found, v3.registered_at_ms)
        } else {
            (0, 0, 0)
        }
    }

    public fun get_pool_stats(arg0: &Pool) : (u64, u64, u64) {
        (arg0.total_shares, arg0.total_blocks, arg0.current_round)
    }

    public fun get_round_totals(arg0: &Pool) : (u64, u128, u64, u64) {
        (arg0.current_round, arg0.round_total_work, arg0.round_shares, arg0.round_start_ms)
    }

    public fun get_share_difficulty(arg0: &MiningShare) : u64 {
        arg0.difficulty_achieved
    }

    public fun get_share_hash(arg0: &MiningShare) : vector<u8> {
        arg0.share_hash
    }

    public fun get_share_is_block(arg0: &MiningShare) : bool {
        arg0.is_block
    }

    public fun get_share_miner(arg0: &MiningShare) : address {
        arg0.miner
    }

    public fun get_share_round_id(arg0: &MiningShare) : u64 {
        arg0.round_id
    }

    public fun get_share_work_weight(arg0: &MiningShare) : u64 {
        arg0.work_weight
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id                     : 0x2::object::new(arg0),
            total_shares           : 0,
            total_blocks           : 0,
            miners                 : 0x2::table::new<address, MinerStats>(arg0),
            share_hashes           : 0x2::table::new<vector<u8>, bool>(arg0),
            admin                  : 0x2::tx_context::sender(arg0),
            chain_tip              : 0x1::option::none<address>(),
            chain_height           : 0,
            current_round          : 0,
            round_start_ms         : 0,
            round_total_work       : 0,
            round_shares           : 0,
            global_min_difficulty  : 1,
            difficulty_window      : 0x1::vector::empty<u64>(),
            difficulty_window_size : 20,
            avg_share_difficulty   : 1,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public fun is_miner_registered(arg0: &Pool, arg1: address) : bool {
        0x2::table::contains<address, MinerStats>(&arg0.miners, arg1)
    }

    public fun is_share_matured(arg0: &Pool, arg1: &MiningShare) : bool {
        arg1.round_id < arg0.current_round
    }

    public fun is_template_active(arg0: &Template) : bool {
        arg0.is_active
    }

    fun nbits_to_difficulty(arg0: u32) : u64 {
        let v0 = ((arg0 >> 24 & 255) as u8);
        let v1 = ((arg0 & 16777215) as u256);
        if (v1 == 0) {
            return 1000000000000000
        };
        let v2 = if (v0 <= 3) {
            v1 >> ((8 * (3 - v0)) as u8)
        } else {
            v1 << ((8 * (v0 - 3)) as u8)
        };
        if (v2 == 0) {
            return 1000000000000000
        };
        let v3 = 26959535291011309493156476344723991336010898738574164086137773096960 / v2;
        if (v3 > (1000000000000000 as u256)) {
            1000000000000000
        } else {
            (v3 as u64)
        }
    }

    public entry fun register_and_submit(arg0: &mut Pool, arg1: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u32, arg9: u32, arg10: u32, arg11: vector<u8>, arg12: vector<u8>, arg13: u32, arg14: u32, arg15: u32, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Template{
            id              : 0x2::object::new(arg17),
            height          : arg3,
            prev_block_hash : arg4,
            coinbase1       : arg5,
            coinbase2       : arg6,
            merkle_branches : arg7,
            version         : arg8,
            nbits           : arg9,
            ntime           : arg10,
            is_active       : true,
            owner           : v0,
            created_at_ms   : v1,
            share_count     : 0,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::register_in_index(arg1, v3, v0, arg3, v1);
        let v4 = TemplateCreated{
            template_id     : v3,
            height          : arg3,
            prev_block_hash : arg4,
            ntime           : arg10,
            owner           : v0,
            timestamp_ms    : v1,
        };
        0x2::event::emit<TemplateCreated>(v4);
        assert!(0x2::table::contains<address, MinerStats>(&arg0.miners, v0), 3);
        assert!(arg15 & (4294967295 ^ 536862720) == 0, 7);
        let v5 = v2.version & (4294967295 ^ 536862720) | arg15 & 536862720;
        let v6 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v6, v2.coinbase1);
        0x1::vector::append<u8>(&mut v6, arg11);
        0x1::vector::append<u8>(&mut v6, arg12);
        0x1::vector::append<u8>(&mut v6, v2.coinbase2);
        let v7 = compute_merkle_root(sha256d(v6), &v2.merkle_branches);
        let v8 = 0x1::vector::empty<u8>();
        let v9 = &mut v8;
        append_u32_le(v9, v5);
        0x1::vector::append<u8>(&mut v8, v2.prev_block_hash);
        0x1::vector::append<u8>(&mut v8, v7);
        let v10 = &mut v8;
        append_u32_le(v10, arg13);
        let v11 = &mut v8;
        append_u32_le(v11, v2.nbits);
        let v12 = &mut v8;
        append_u32_le(v12, arg14);
        let v13 = sha256d(v8);
        let v14 = difficulty_from_hash(&v13);
        let v15 = 0x2::table::borrow_mut<address, MinerStats>(&mut arg0.miners, v0);
        if (v15.last_round_id != arg0.current_round) {
            v15.current_round_work = 0;
            v15.current_round_shares = 0;
            v15.last_round_id = arg0.current_round;
        };
        let v16 = if (arg16 > arg0.global_min_difficulty) {
            arg16
        } else {
            arg0.global_min_difficulty
        };
        assert!(v14 >= v16, 1);
        let v17 = v15.current_difficulty;
        v15.current_difficulty = v16;
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.share_hashes, v13), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.share_hashes, v13, true);
        let v18 = nbits_to_difficulty(v2.nbits);
        let v19 = v14 >= v18;
        let v20 = if (v1 > v15.last_share_time_ms) {
            v1 - v15.last_share_time_ms
        } else {
            30000
        };
        v15.avg_share_interval_ms = (v15.avg_share_interval_ms * 3 + v20) / 4;
        v15.last_share_time_ms = v1;
        v15.total_shares = v15.total_shares + 1;
        v15.current_round_work = v15.current_round_work + (v14 as u128);
        v15.current_round_shares = v15.current_round_shares + 1;
        if (v19) {
            v15.blocks_found = v15.blocks_found + 1;
        };
        if (v17 != v16) {
            let v21 = DifficultyAdjusted{
                miner          : v0,
                old_difficulty : v17,
                new_difficulty : v16,
            };
            0x2::event::emit<DifficultyAdjusted>(v21);
        };
        arg0.avg_share_difficulty = (arg0.avg_share_difficulty * 7 + v16) / 8;
        let v22 = arg0.chain_height + 1;
        let v23 = arg0.current_round;
        arg0.round_total_work = arg0.round_total_work + (v14 as u128);
        arg0.round_shares = arg0.round_shares + 1;
        arg0.total_shares = arg0.total_shares + 1;
        v2.share_count = v2.share_count + 1;
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_share_count(arg1, v3, v2.share_count);
        if (v19) {
            arg0.total_blocks = arg0.total_blocks + 1;
        };
        let v24 = MiningShare{
            id                  : 0x2::object::new(arg17),
            template_id         : v3,
            block_height        : v2.height,
            prev_block_hash     : v2.prev_block_hash,
            merkle_root         : v7,
            extranonce1         : arg11,
            extranonce2         : arg12,
            ntime               : arg13,
            nonce               : arg14,
            version             : v5,
            share_hash          : v13,
            difficulty_achieved : v14,
            target_difficulty   : v16,
            network_difficulty  : v18,
            is_block            : v19,
            miner               : v0,
            timestamp_ms        : v1,
            parent_share        : arg0.chain_tip,
            chain_height        : v22,
            round_id            : v23,
            work_weight         : v14,
        };
        let v25 = 0x2::object::uid_to_address(&v24.id);
        arg0.chain_tip = 0x1::option::some<address>(v25);
        arg0.chain_height = v22;
        let v26 = ShareSubmitted{
            share_id            : v25,
            miner               : v0,
            template_id         : v3,
            difficulty_achieved : v14,
            target_difficulty   : v16,
            is_block            : v19,
            timestamp_ms        : v1,
        };
        0x2::event::emit<ShareSubmitted>(v26);
        if (v19) {
            let v27 = BlockFound{
                share_id     : v25,
                miner        : v0,
                height       : v2.height,
                share_hash   : v13,
                timestamp_ms : v1,
            };
            0x2::event::emit<BlockFound>(v27);
            let v28 = if (v1 > arg0.round_start_ms) {
                v1 - arg0.round_start_ms
            } else {
                0
            };
            let v29 = RoundComplete{
                round_id     : v23,
                block_height : v2.height,
                block_finder : v0,
                total_work   : arg0.round_total_work,
                total_shares : arg0.round_shares,
                duration_ms  : v28,
            };
            0x2::event::emit<RoundComplete>(v29);
            arg0.current_round = arg0.current_round + 1;
            arg0.round_total_work = 0;
            arg0.round_shares = 0;
            arg0.round_start_ms = v1;
        };
        0x1::vector::push_back<u64>(&mut arg0.difficulty_window, v1);
        let v30 = 0x1::vector::length<u64>(&arg0.difficulty_window);
        if (v30 > arg0.difficulty_window_size) {
            let v31 = 0x1::vector::empty<u64>();
            let v32 = v30 - arg0.difficulty_window_size;
            while (v32 < v30) {
                0x1::vector::push_back<u64>(&mut v31, *0x1::vector::borrow<u64>(&arg0.difficulty_window, v32));
                v32 = v32 + 1;
            };
            arg0.difficulty_window = v31;
        };
        adjust_global_difficulty(arg0, v1);
        0x2::transfer::transfer<MiningShare>(v24, v0);
        0x2::transfer::share_object<Template>(v2);
    }

    public entry fun register_and_submit_lightweight(arg0: &mut Pool, arg1: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u32, arg9: u32, arg10: u32, arg11: vector<u8>, arg12: vector<u8>, arg13: u32, arg14: u32, arg15: u32, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Template{
            id              : 0x2::object::new(arg17),
            height          : arg3,
            prev_block_hash : arg4,
            coinbase1       : arg5,
            coinbase2       : arg6,
            merkle_branches : arg7,
            version         : arg8,
            nbits           : arg9,
            ntime           : arg10,
            is_active       : true,
            owner           : v0,
            created_at_ms   : v1,
            share_count     : 0,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::register_in_index(arg1, v3, v0, arg3, v1);
        let v4 = TemplateCreated{
            template_id     : v3,
            height          : arg3,
            prev_block_hash : arg4,
            ntime           : arg10,
            owner           : v0,
            timestamp_ms    : v1,
        };
        0x2::event::emit<TemplateCreated>(v4);
        assert!(0x2::table::contains<address, MinerStats>(&arg0.miners, v0), 3);
        assert!(arg15 & (4294967295 ^ 536862720) == 0, 7);
        let v5 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v5, v2.coinbase1);
        0x1::vector::append<u8>(&mut v5, arg11);
        0x1::vector::append<u8>(&mut v5, arg12);
        0x1::vector::append<u8>(&mut v5, v2.coinbase2);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = &mut v6;
        append_u32_le(v7, v2.version & (4294967295 ^ 536862720) | arg15 & 536862720);
        0x1::vector::append<u8>(&mut v6, v2.prev_block_hash);
        0x1::vector::append<u8>(&mut v6, compute_merkle_root(sha256d(v5), &v2.merkle_branches));
        let v8 = &mut v6;
        append_u32_le(v8, arg13);
        let v9 = &mut v6;
        append_u32_le(v9, v2.nbits);
        let v10 = &mut v6;
        append_u32_le(v10, arg14);
        let v11 = sha256d(v6);
        let v12 = difficulty_from_hash(&v11);
        let v13 = 0x2::table::borrow_mut<address, MinerStats>(&mut arg0.miners, v0);
        if (v13.last_round_id != arg0.current_round) {
            v13.current_round_work = 0;
            v13.current_round_shares = 0;
            v13.last_round_id = arg0.current_round;
        };
        let v14 = if (arg16 > arg0.global_min_difficulty) {
            arg16
        } else {
            arg0.global_min_difficulty
        };
        assert!(v12 >= v14, 1);
        let v15 = v13.current_difficulty;
        v13.current_difficulty = v14;
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.share_hashes, v11), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.share_hashes, v11, true);
        let v16 = v12 >= nbits_to_difficulty(v2.nbits);
        let v17 = if (v1 > v13.last_share_time_ms) {
            v1 - v13.last_share_time_ms
        } else {
            30000
        };
        v13.avg_share_interval_ms = (v13.avg_share_interval_ms * 3 + v17) / 4;
        v13.last_share_time_ms = v1;
        v13.total_shares = v13.total_shares + 1;
        v13.current_round_work = v13.current_round_work + (v12 as u128);
        v13.current_round_shares = v13.current_round_shares + 1;
        if (v16) {
            v13.blocks_found = v13.blocks_found + 1;
        };
        if (v15 != v14) {
            let v18 = DifficultyAdjusted{
                miner          : v0,
                old_difficulty : v15,
                new_difficulty : v14,
            };
            0x2::event::emit<DifficultyAdjusted>(v18);
        };
        arg0.avg_share_difficulty = (arg0.avg_share_difficulty * 7 + v14) / 8;
        arg0.round_total_work = arg0.round_total_work + (v12 as u128);
        arg0.round_shares = arg0.round_shares + 1;
        arg0.total_shares = arg0.total_shares + 1;
        v2.share_count = v2.share_count + 1;
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_share_count(arg1, v3, v2.share_count);
        if (v16) {
            arg0.total_blocks = arg0.total_blocks + 1;
        };
        let v19 = ShareValidated{
            miner               : v0,
            template_id         : v3,
            share_hash          : v11,
            difficulty_achieved : v12,
            target_difficulty   : v14,
            is_block            : v16,
            timestamp_ms        : v1,
        };
        0x2::event::emit<ShareValidated>(v19);
        if (v16) {
            let v20 = BlockFound{
                share_id     : @0x0,
                miner        : v0,
                height       : v2.height,
                share_hash   : v11,
                timestamp_ms : v1,
            };
            0x2::event::emit<BlockFound>(v20);
            let v21 = if (v1 > arg0.round_start_ms) {
                v1 - arg0.round_start_ms
            } else {
                0
            };
            let v22 = RoundComplete{
                round_id     : arg0.current_round,
                block_height : v2.height,
                block_finder : v0,
                total_work   : arg0.round_total_work,
                total_shares : arg0.round_shares,
                duration_ms  : v21,
            };
            0x2::event::emit<RoundComplete>(v22);
            arg0.current_round = arg0.current_round + 1;
            arg0.round_total_work = 0;
            arg0.round_shares = 0;
            arg0.round_start_ms = v1;
            v2.is_active = false;
            0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::deactivate_in_index(arg1, v3, v1);
        };
        0x1::vector::push_back<u64>(&mut arg0.difficulty_window, v1);
        let v23 = 0x1::vector::length<u64>(&arg0.difficulty_window);
        if (v23 > arg0.difficulty_window_size) {
            let v24 = 0x1::vector::empty<u64>();
            let v25 = v23 - arg0.difficulty_window_size;
            while (v25 < v23) {
                0x1::vector::push_back<u64>(&mut v24, *0x1::vector::borrow<u64>(&arg0.difficulty_window, v25));
                v25 = v25 + 1;
            };
            arg0.difficulty_window = v24;
        };
        adjust_global_difficulty(arg0, v1);
        0x2::transfer::share_object<Template>(v2);
    }

    public entry fun register_miner(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, MinerStats>(&arg0.miners, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = if (arg0.avg_share_difficulty > arg0.global_min_difficulty) {
            arg0.avg_share_difficulty
        } else {
            arg0.global_min_difficulty
        };
        let v3 = MinerStats{
            current_difficulty    : v2,
            last_share_time_ms    : v1,
            total_shares          : 0,
            blocks_found          : 0,
            avg_share_interval_ms : 30000,
            registered_at_ms      : v1,
            current_round_work    : 0,
            current_round_shares  : 0,
            last_round_id         : arg0.current_round,
        };
        0x2::table::add<address, MinerStats>(&mut arg0.miners, v0, v3);
        let v4 = MinerRegistered{
            miner              : v0,
            initial_difficulty : v2,
            timestamp_ms       : v1,
        };
        0x2::event::emit<MinerRegistered>(v4);
    }

    public entry fun register_template(arg0: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: u32, arg8: u32, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = Template{
            id              : 0x2::object::new(arg10),
            height          : arg2,
            prev_block_hash : arg3,
            coinbase1       : arg4,
            coinbase2       : arg5,
            merkle_branches : arg6,
            version         : arg7,
            nbits           : arg8,
            ntime           : arg9,
            is_active       : true,
            owner           : v0,
            created_at_ms   : v1,
            share_count     : 0,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::register_in_index(arg0, v3, v0, arg2, v1);
        let v4 = TemplateCreated{
            template_id     : v3,
            height          : arg2,
            prev_block_hash : arg3,
            ntime           : arg9,
            owner           : v0,
            timestamp_ms    : v1,
        };
        0x2::event::emit<TemplateCreated>(v4);
        0x2::transfer::share_object<Template>(v2);
    }

    fun sha256d(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(0x1::hash::sha2_256(arg0))
    }

    public entry fun submit_share(arg0: &mut Pool, arg1: &mut Template, arg2: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: u32, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<address, MinerStats>(&arg0.miners, v0), 3);
        assert!(arg1.is_active, 6);
        assert!(arg8 & (4294967295 ^ 536862720) == 0, 7);
        let v2 = arg1.version & (4294967295 ^ 536862720) | arg8 & 536862720;
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, arg1.coinbase1);
        0x1::vector::append<u8>(&mut v3, arg4);
        0x1::vector::append<u8>(&mut v3, arg5);
        0x1::vector::append<u8>(&mut v3, arg1.coinbase2);
        let v4 = compute_merkle_root(sha256d(v3), &arg1.merkle_branches);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = &mut v5;
        append_u32_le(v6, v2);
        0x1::vector::append<u8>(&mut v5, arg1.prev_block_hash);
        0x1::vector::append<u8>(&mut v5, v4);
        let v7 = &mut v5;
        append_u32_le(v7, arg6);
        let v8 = &mut v5;
        append_u32_le(v8, arg1.nbits);
        let v9 = &mut v5;
        append_u32_le(v9, arg7);
        let v10 = sha256d(v5);
        let v11 = difficulty_from_hash(&v10);
        let v12 = 0x2::table::borrow_mut<address, MinerStats>(&mut arg0.miners, v0);
        if (v12.last_round_id != arg0.current_round) {
            v12.current_round_work = 0;
            v12.current_round_shares = 0;
            v12.last_round_id = arg0.current_round;
        };
        let v13 = if (arg9 > arg0.global_min_difficulty) {
            arg9
        } else {
            arg0.global_min_difficulty
        };
        assert!(v11 >= v13, 1);
        let v14 = v12.current_difficulty;
        v12.current_difficulty = v13;
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.share_hashes, v10), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.share_hashes, v10, true);
        let v15 = nbits_to_difficulty(arg1.nbits);
        let v16 = v11 >= v15;
        let v17 = if (v1 > v12.last_share_time_ms) {
            v1 - v12.last_share_time_ms
        } else {
            30000
        };
        v12.avg_share_interval_ms = (v12.avg_share_interval_ms * 3 + v17) / 4;
        v12.last_share_time_ms = v1;
        v12.total_shares = v12.total_shares + 1;
        v12.current_round_work = v12.current_round_work + (v11 as u128);
        v12.current_round_shares = v12.current_round_shares + 1;
        if (v16) {
            v12.blocks_found = v12.blocks_found + 1;
        };
        if (v14 != v13) {
            let v18 = DifficultyAdjusted{
                miner          : v0,
                old_difficulty : v14,
                new_difficulty : v13,
            };
            0x2::event::emit<DifficultyAdjusted>(v18);
        };
        arg0.avg_share_difficulty = (arg0.avg_share_difficulty * 7 + v13) / 8;
        let v19 = arg0.chain_height + 1;
        let v20 = arg0.current_round;
        arg0.round_total_work = arg0.round_total_work + (v11 as u128);
        arg0.round_shares = arg0.round_shares + 1;
        arg0.total_shares = arg0.total_shares + 1;
        arg1.share_count = arg1.share_count + 1;
        let v21 = 0x2::object::uid_to_address(&arg1.id);
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_share_count(arg2, v21, arg1.share_count);
        if (v16) {
            arg0.total_blocks = arg0.total_blocks + 1;
        };
        let v22 = MiningShare{
            id                  : 0x2::object::new(arg10),
            template_id         : v21,
            block_height        : arg1.height,
            prev_block_hash     : arg1.prev_block_hash,
            merkle_root         : v4,
            extranonce1         : arg4,
            extranonce2         : arg5,
            ntime               : arg6,
            nonce               : arg7,
            version             : v2,
            share_hash          : v10,
            difficulty_achieved : v11,
            target_difficulty   : v13,
            network_difficulty  : v15,
            is_block            : v16,
            miner               : v0,
            timestamp_ms        : v1,
            parent_share        : arg0.chain_tip,
            chain_height        : v19,
            round_id            : v20,
            work_weight         : v11,
        };
        let v23 = 0x2::object::uid_to_address(&v22.id);
        arg0.chain_tip = 0x1::option::some<address>(v23);
        arg0.chain_height = v19;
        let v24 = ShareSubmitted{
            share_id            : v23,
            miner               : v0,
            template_id         : v21,
            difficulty_achieved : v11,
            target_difficulty   : v13,
            is_block            : v16,
            timestamp_ms        : v1,
        };
        0x2::event::emit<ShareSubmitted>(v24);
        if (v16) {
            let v25 = BlockFound{
                share_id     : v23,
                miner        : v0,
                height       : arg1.height,
                share_hash   : v10,
                timestamp_ms : v1,
            };
            0x2::event::emit<BlockFound>(v25);
            let v26 = if (v1 > arg0.round_start_ms) {
                v1 - arg0.round_start_ms
            } else {
                0
            };
            let v27 = RoundComplete{
                round_id     : v20,
                block_height : arg1.height,
                block_finder : v0,
                total_work   : arg0.round_total_work,
                total_shares : arg0.round_shares,
                duration_ms  : v26,
            };
            0x2::event::emit<RoundComplete>(v27);
            arg0.current_round = arg0.current_round + 1;
            arg0.round_total_work = 0;
            arg0.round_shares = 0;
            arg0.round_start_ms = v1;
        };
        0x1::vector::push_back<u64>(&mut arg0.difficulty_window, v1);
        let v28 = 0x1::vector::length<u64>(&arg0.difficulty_window);
        if (v28 > arg0.difficulty_window_size) {
            let v29 = 0x1::vector::empty<u64>();
            let v30 = v28 - arg0.difficulty_window_size;
            while (v30 < v28) {
                0x1::vector::push_back<u64>(&mut v29, *0x1::vector::borrow<u64>(&arg0.difficulty_window, v30));
                v30 = v30 + 1;
            };
            arg0.difficulty_window = v29;
        };
        adjust_global_difficulty(arg0, v1);
        0x2::transfer::transfer<MiningShare>(v22, v0);
    }

    public entry fun submit_share_lightweight(arg0: &mut Pool, arg1: &mut Template, arg2: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::TemplateRegistry, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: u32, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<address, MinerStats>(&arg0.miners, v0), 3);
        assert!(arg1.is_active, 6);
        assert!(arg8 & (4294967295 ^ 536862720) == 0, 7);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, arg1.coinbase1);
        0x1::vector::append<u8>(&mut v2, arg4);
        0x1::vector::append<u8>(&mut v2, arg5);
        0x1::vector::append<u8>(&mut v2, arg1.coinbase2);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = &mut v3;
        append_u32_le(v4, arg1.version & (4294967295 ^ 536862720) | arg8 & 536862720);
        0x1::vector::append<u8>(&mut v3, arg1.prev_block_hash);
        0x1::vector::append<u8>(&mut v3, compute_merkle_root(sha256d(v2), &arg1.merkle_branches));
        let v5 = &mut v3;
        append_u32_le(v5, arg6);
        let v6 = &mut v3;
        append_u32_le(v6, arg1.nbits);
        let v7 = &mut v3;
        append_u32_le(v7, arg7);
        let v8 = sha256d(v3);
        let v9 = difficulty_from_hash(&v8);
        let v10 = 0x2::table::borrow_mut<address, MinerStats>(&mut arg0.miners, v0);
        if (v10.last_round_id != arg0.current_round) {
            v10.current_round_work = 0;
            v10.current_round_shares = 0;
            v10.last_round_id = arg0.current_round;
        };
        let v11 = if (arg9 > arg0.global_min_difficulty) {
            arg9
        } else {
            arg0.global_min_difficulty
        };
        assert!(v9 >= v11, 1);
        let v12 = v10.current_difficulty;
        v10.current_difficulty = v11;
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.share_hashes, v8), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.share_hashes, v8, true);
        let v13 = v9 >= nbits_to_difficulty(arg1.nbits);
        let v14 = if (v1 > v10.last_share_time_ms) {
            v1 - v10.last_share_time_ms
        } else {
            30000
        };
        v10.avg_share_interval_ms = (v10.avg_share_interval_ms * 3 + v14) / 4;
        v10.last_share_time_ms = v1;
        v10.total_shares = v10.total_shares + 1;
        v10.current_round_work = v10.current_round_work + (v9 as u128);
        v10.current_round_shares = v10.current_round_shares + 1;
        if (v13) {
            v10.blocks_found = v10.blocks_found + 1;
        };
        if (v12 != v11) {
            let v15 = DifficultyAdjusted{
                miner          : v0,
                old_difficulty : v12,
                new_difficulty : v11,
            };
            0x2::event::emit<DifficultyAdjusted>(v15);
        };
        arg0.avg_share_difficulty = (arg0.avg_share_difficulty * 7 + v11) / 8;
        arg0.round_total_work = arg0.round_total_work + (v9 as u128);
        arg0.round_shares = arg0.round_shares + 1;
        arg0.total_shares = arg0.total_shares + 1;
        arg1.share_count = arg1.share_count + 1;
        let v16 = 0x2::object::uid_to_address(&arg1.id);
        0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::update_share_count(arg2, v16, arg1.share_count);
        if (v13) {
            arg0.total_blocks = arg0.total_blocks + 1;
        };
        let v17 = ShareValidated{
            miner               : v0,
            template_id         : v16,
            share_hash          : v8,
            difficulty_achieved : v9,
            target_difficulty   : v11,
            is_block            : v13,
            timestamp_ms        : v1,
        };
        0x2::event::emit<ShareValidated>(v17);
        if (v13) {
            let v18 = BlockFound{
                share_id     : @0x0,
                miner        : v0,
                height       : arg1.height,
                share_hash   : v8,
                timestamp_ms : v1,
            };
            0x2::event::emit<BlockFound>(v18);
            let v19 = if (v1 > arg0.round_start_ms) {
                v1 - arg0.round_start_ms
            } else {
                0
            };
            let v20 = RoundComplete{
                round_id     : arg0.current_round,
                block_height : arg1.height,
                block_finder : v0,
                total_work   : arg0.round_total_work,
                total_shares : arg0.round_shares,
                duration_ms  : v19,
            };
            0x2::event::emit<RoundComplete>(v20);
            arg0.current_round = arg0.current_round + 1;
            arg0.round_start_ms = v1;
            arg0.round_total_work = 0;
            arg0.round_shares = 0;
            arg1.is_active = false;
            0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::template_registry::deactivate_in_index(arg2, v16, v1);
        };
        0x1::vector::push_back<u64>(&mut arg0.difficulty_window, v1);
        let v21 = 0x1::vector::length<u64>(&arg0.difficulty_window);
        if (v21 > arg0.difficulty_window_size) {
            let v22 = 0x1::vector::empty<u64>();
            let v23 = v21 - arg0.difficulty_window_size;
            while (v23 < v21) {
                0x1::vector::push_back<u64>(&mut v22, *0x1::vector::borrow<u64>(&arg0.difficulty_window, v23));
                v23 = v23 + 1;
            };
            arg0.difficulty_window = v22;
        };
        adjust_global_difficulty(arg0, v1);
    }

    public fun template_coinbase1(arg0: &Template) : vector<u8> {
        arg0.coinbase1
    }

    public fun template_coinbase2(arg0: &Template) : vector<u8> {
        arg0.coinbase2
    }

    public fun template_created_at_ms(arg0: &Template) : u64 {
        arg0.created_at_ms
    }

    public fun template_height(arg0: &Template) : u64 {
        arg0.height
    }

    public fun template_id(arg0: &Template) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun template_merkle_branches(arg0: &Template) : vector<vector<u8>> {
        arg0.merkle_branches
    }

    public fun template_nbits(arg0: &Template) : u32 {
        arg0.nbits
    }

    public fun template_ntime(arg0: &Template) : u32 {
        arg0.ntime
    }

    public fun template_owner(arg0: &Template) : address {
        arg0.owner
    }

    public fun template_prev_block_hash(arg0: &Template) : vector<u8> {
        arg0.prev_block_hash
    }

    public fun template_share_count(arg0: &Template) : u64 {
        arg0.share_count
    }

    public fun template_version(arg0: &Template) : u32 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

