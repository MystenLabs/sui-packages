module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::block_registry {
    struct RoundOpened has copy, drop {
        block_height: u64,
        num_fragments: u64,
        proposer: address,
        timestamp_ms: u64,
    }

    struct FragmentSubmitted has copy, drop {
        block_height: u64,
        fragment_index: u64,
        submitter: address,
        slot_number: u64,
        timestamp_ms: u64,
    }

    struct BlockVerified has copy, drop {
        block_height: u64,
        num_participants: u64,
        reward_per_participant: u64,
        timestamp_ms: u64,
    }

    struct RoundExpired has copy, drop {
        block_height: u64,
        filled_count: u64,
        num_fragments: u64,
        timestamp_ms: u64,
    }

    struct ChainReorgEvent has copy, drop {
        fork_height: u64,
        old_tip_height: u64,
        new_tip_height: u64,
        old_tip_hash: vector<u8>,
        new_tip_hash: vector<u8>,
    }

    struct BlockHeaderRegistered has copy, drop {
        height: u64,
        block_hash: vector<u8>,
        parent_hash: vector<u8>,
        chain_work: u256,
        timestamp: u32,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BlockRegistry has key {
        id: 0x2::object::UID,
        hashes: 0x2::table::Table<u64, vector<u8>>,
        parent_hashes: 0x2::table::Table<u64, vector<u8>>,
        timestamps: 0x2::table::Table<u64, u32>,
        bits: 0x2::table::Table<u64, u32>,
        chain_work: 0x2::table::Table<u64, u256>,
        total_registered: u64,
        current_height: u64,
        canonical_tip: u64,
        total_verified: u64,
        fork_hashes: 0x2::table::Table<u64, vector<vector<u8>>>,
        current_round: 0x1::option::Option<address>,
        admin: address,
    }

    struct VerificationRound has key {
        id: 0x2::object::UID,
        block_height: u64,
        num_fragments: u64,
        fragment_offsets: vector<u64>,
        fragment_sizes: vector<u64>,
        fragments: vector<vector<u8>>,
        fragment_filled: vector<bool>,
        submitters: vector<vector<address>>,
        total_submitters: u64,
        filled_count: u64,
        opened_at_ms: u64,
        verified: bool,
    }

    fun bits_to_target(arg0: u32) : u256 {
        let v0 = ((arg0 >> 24) as u8);
        if (v0 <= 3) {
            ((arg0 & 8388607) as u256) >> ((8 * (3 - v0)) as u8)
        } else {
            ((arg0 & 8388607) as u256) << ((8 * (v0 - 3)) as u8)
        }
    }

    fun bytes_of_target(arg0: u256) : u8 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 255;
        while (arg0 & 1 << v0 == 0 && v0 > 0) {
            v0 = v0 - 1;
        };
        (((v0 as u32) / 8 + 1) as u8)
    }

    fun bytes_to_u256_le(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(arg0, v1) as u256) << ((v1 * 8) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    fun calc_next_required_difficulty(arg0: &BlockRegistry, arg1: u64) : u32 {
        if (arg1 == 0) {
            return 486604799
        };
        if ((arg1 + 1) % 2016 != 0) {
            return *0x2::table::borrow<u64, u32>(&arg0.bits, arg1)
        };
        let v0 = arg1 - 2016 - 1;
        target_to_bits(retarget_algorithm(bits_to_target(*0x2::table::borrow<u64, u32>(&arg0.bits, v0)), (*0x2::table::borrow<u64, u32>(&arg0.timestamps, v0) as u64), (*0x2::table::borrow<u64, u32>(&arg0.timestamps, arg1) as u64)))
    }

    fun calc_work_from_bits(arg0: u32) : u256 {
        let v0 = bits_to_target(arg0);
        if (v0 == 0) {
            return 0
        };
        (v0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935) / (v0 + 1) + 1
    }

    fun calculate_median_time(arg0: &vector<u32>) : u32 {
        let v0 = 0x1::vector::length<u32>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = *arg0;
        let v2 = 1;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u32>(&v1, v2);
            let v4 = v2;
            while (v4 > 0 && *0x1::vector::borrow<u32>(&v1, v4 - 1) > v3) {
                *0x1::vector::borrow_mut<u32>(&mut v1, v4) = *0x1::vector::borrow<u32>(&v1, v4 - 1);
                v4 = v4 - 1;
            };
            *0x1::vector::borrow_mut<u32>(&mut v1, v4) = v3;
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<u32>(&v1, v0 / 2)
    }

    public fun canonical_tip(arg0: &BlockRegistry) : u64 {
        arg0.canonical_tip
    }

    public entry fun close_expired_round(arg0: &mut BlockRegistry, arg1: &mut VerificationRound, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(!arg1.verified, 7);
        assert!(v0 >= arg1.opened_at_ms + 30000, 14);
        let v1 = RoundExpired{
            block_height  : arg1.block_height,
            filled_count  : arg1.filled_count,
            num_fragments : arg1.num_fragments,
            timestamp_ms  : v0,
        };
        0x2::event::emit<RoundExpired>(v1);
        arg0.current_round = 0x1::option::none<address>();
    }

    fun coinbase_sats(arg0: u64) : u64 {
        let v0 = arg0 / 210000;
        if (v0 >= 64) {
            return 0
        };
        5000000000 >> (v0 as u8)
    }

    fun compute_block_hash(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::hash::sha2_256(0x1::hash::sha2_256(*arg0));
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 32;
        while (v2 > 0) {
            v2 = v2 - 1;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
        };
        v1
    }

    fun compute_total_reward(arg0: u64) : u64 {
        coinbase_sats(arg0) * 1000
    }

    public fun current_height(arg0: &BlockRegistry) : u64 {
        arg0.current_height
    }

    public entry fun delete_verified_hashes(arg0: &mut BlockRegistry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = arg2 + v0;
            assert!(v1 < arg0.current_height, 16);
            if (0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v1)) {
                0x2::table::remove<u64, vector<u8>>(&mut arg0.hashes, v1);
            };
            v0 = v0 + 1;
        };
    }

    fun extract_bits(arg0: &vector<u8>) : u32 {
        extract_u32_le(arg0, 72)
    }

    fun extract_parent_hash(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 4;
        while (v1 < 36) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun extract_timestamp(arg0: &vector<u8>) : u32 {
        extract_u32_le(arg0, 68)
    }

    fun extract_u32_le(arg0: &vector<u8>, arg1: u64) : u32 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u32) | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u32) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u32) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u32) << 24
    }

    public fun finalized_height(arg0: &BlockRegistry) : u64 {
        if (arg0.current_height >= 6) {
            arg0.current_height - 6
        } else {
            0
        }
    }

    public fun get_chain_work(arg0: &BlockRegistry, arg1: u64) : u256 {
        *0x2::table::borrow<u64, u256>(&arg0.chain_work, arg1)
    }

    public fun get_parent_hash(arg0: &BlockRegistry, arg1: u64) : vector<u8> {
        *0x2::table::borrow<u64, vector<u8>>(&arg0.parent_hashes, arg1)
    }

    public fun get_timestamp(arg0: &BlockRegistry, arg1: u64) : u32 {
        *0x2::table::borrow<u64, u32>(&arg0.timestamps, arg1)
    }

    public entry fun handle_reorg(arg0: &mut BlockRegistry, arg1: &AdminCap, arg2: u64, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0, 24);
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.hashes, arg2 - 1), 23);
        let v1 = if (arg2 > 0) {
            *0x2::table::borrow<u64, u256>(&arg0.chain_work, arg2 - 1)
        } else {
            0
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<vector<u8>>(&arg3, v3);
            assert!(0x1::vector::length<u8>(v4) == 80, 18);
            assert!(verify_pow(v4), 19);
            v2 = v2 + calc_work_from_bits(extract_bits(v4));
            v3 = v3 + 1;
        };
        let v5 = arg2 + v0 - 1;
        let v6 = if (0x2::table::contains<u64, u256>(&arg0.chain_work, arg0.canonical_tip)) {
            *0x2::table::borrow<u64, u256>(&arg0.chain_work, arg0.canonical_tip)
        } else {
            0
        };
        assert!(v2 > v6, 22);
        let v7 = arg0.canonical_tip;
        let v8 = if (0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v7)) {
            *0x2::table::borrow<u64, vector<u8>>(&arg0.hashes, v7)
        } else {
            0x1::vector::empty<u8>()
        };
        while (arg2 <= v7) {
            if (0x2::table::contains<u64, vector<u8>>(&arg0.hashes, arg2)) {
                if (!0x2::table::contains<u64, vector<vector<u8>>>(&arg0.fork_hashes, arg2)) {
                    0x2::table::add<u64, vector<vector<u8>>>(&mut arg0.fork_hashes, arg2, 0x1::vector::empty<vector<u8>>());
                };
                0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<u64, vector<vector<u8>>>(&mut arg0.fork_hashes, arg2), *0x2::table::borrow<u64, vector<u8>>(&arg0.hashes, arg2));
            };
            arg2 = arg2 + 1;
        };
        let v9 = if (arg2 > 0) {
            *0x2::table::borrow<u64, u256>(&arg0.chain_work, arg2 - 1)
        } else {
            0
        };
        let v10 = v9;
        v3 = 0;
        while (v3 < v0) {
            let v11 = arg2 + v3;
            let v12 = 0x1::vector::borrow<vector<u8>>(&arg3, v3);
            let v13 = extract_bits(v12);
            v10 = v10 + calc_work_from_bits(v13);
            if (0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v11)) {
                *0x2::table::borrow_mut<u64, vector<u8>>(&mut arg0.hashes, v11) = compute_block_hash(v12);
                *0x2::table::borrow_mut<u64, vector<u8>>(&mut arg0.parent_hashes, v11) = extract_parent_hash(v12);
                *0x2::table::borrow_mut<u64, u32>(&mut arg0.timestamps, v11) = extract_timestamp(v12);
                *0x2::table::borrow_mut<u64, u32>(&mut arg0.bits, v11) = v13;
                *0x2::table::borrow_mut<u64, u256>(&mut arg0.chain_work, v11) = v10;
            } else {
                0x2::table::add<u64, vector<u8>>(&mut arg0.hashes, v11, compute_block_hash(v12));
                0x2::table::add<u64, vector<u8>>(&mut arg0.parent_hashes, v11, extract_parent_hash(v12));
                0x2::table::add<u64, u32>(&mut arg0.timestamps, v11, extract_timestamp(v12));
                0x2::table::add<u64, u32>(&mut arg0.bits, v11, v13);
                0x2::table::add<u64, u256>(&mut arg0.chain_work, v11, v10);
            };
            v3 = v3 + 1;
        };
        arg0.canonical_tip = v5;
        let v14 = ChainReorgEvent{
            fork_height    : arg2,
            old_tip_height : v7,
            new_tip_height : v5,
            old_tip_hash   : v8,
            new_tip_hash   : *0x2::table::borrow<u64, vector<u8>>(&arg0.hashes, v5),
        };
        0x2::event::emit<ChainReorgEvent>(v14);
    }

    public fun has_active_round(arg0: &BlockRegistry) : bool {
        0x1::option::is_some<address>(&arg0.current_round)
    }

    public fun has_pow_data(arg0: &BlockRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, u32>(&arg0.bits, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = BlockRegistry{
            id               : 0x2::object::new(arg0),
            hashes           : 0x2::table::new<u64, vector<u8>>(arg0),
            parent_hashes    : 0x2::table::new<u64, vector<u8>>(arg0),
            timestamps       : 0x2::table::new<u64, u32>(arg0),
            bits             : 0x2::table::new<u64, u32>(arg0),
            chain_work       : 0x2::table::new<u64, u256>(arg0),
            total_registered : 0,
            current_height   : 0,
            canonical_tip    : 0,
            total_verified   : 0,
            fork_hashes      : 0x2::table::new<u64, vector<vector<u8>>>(arg0),
            current_round    : 0x1::option::none<address>(),
            admin            : v0,
        };
        0x2::transfer::share_object<BlockRegistry>(v2);
    }

    public fun is_finalized(arg0: &BlockRegistry, arg1: u64) : bool {
        arg1 <= finalized_height(arg0)
    }

    public entry fun open_round(arg0: &mut BlockRegistry, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.current_round), 3);
        let v0 = arg0.current_height;
        assert!(0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v0), 4);
        assert!(0x1::vector::length<u64>(&arg3) == arg2, 5);
        assert!(0x1::vector::length<u64>(&arg4) == arg2, 5);
        validate_fragment_schema(&arg3, &arg4, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<vector<address>>();
        let v5 = 0;
        while (v5 < arg2) {
            0x1::vector::push_back<vector<u8>>(&mut v2, 0x1::vector::empty<u8>());
            0x1::vector::push_back<bool>(&mut v3, false);
            0x1::vector::push_back<vector<address>>(&mut v4, 0x1::vector::empty<address>());
            v5 = v5 + 1;
        };
        let v6 = VerificationRound{
            id               : 0x2::object::new(arg5),
            block_height     : v0,
            num_fragments    : arg2,
            fragment_offsets : arg3,
            fragment_sizes   : arg4,
            fragments        : v2,
            fragment_filled  : v3,
            submitters       : v4,
            total_submitters : 0,
            filled_count     : 0,
            opened_at_ms     : v1,
            verified         : false,
        };
        arg0.current_round = 0x1::option::some<address>(0x2::object::id_address<VerificationRound>(&v6));
        let v7 = RoundOpened{
            block_height  : v0,
            num_fragments : arg2,
            proposer      : 0x2::tx_context::sender(arg5),
            timestamp_ms  : v1,
        };
        0x2::event::emit<RoundOpened>(v7);
        0x2::transfer::share_object<VerificationRound>(v6);
    }

    public entry fun register_hashes_batch(arg0: &mut BlockRegistry, arg1: &AdminCap, arg2: u64, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = arg2 + v1;
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg3, v1);
            assert!(0x1::vector::length<u8>(&v3) == 32, 1);
            assert!(!0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v2), 2);
            0x2::table::add<u64, vector<u8>>(&mut arg0.hashes, v2, v3);
            v1 = v1 + 1;
        };
        arg0.total_registered = arg0.total_registered + v0;
    }

    public entry fun register_headers_batch(arg0: &mut BlockRegistry, arg1: &AdminCap, arg2: u64, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 > 0, 24);
        let v1 = if (arg2 > 0 && 0x2::table::contains<u64, u256>(&arg0.chain_work, arg2 - 1)) {
            *0x2::table::borrow<u64, u256>(&arg0.chain_work, arg2 - 1)
        } else {
            0
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = arg2 + v3;
            let v5 = 0x1::vector::borrow<vector<u8>>(&arg3, v3);
            assert!(0x1::vector::length<u8>(v5) == 80, 18);
            assert!(verify_pow(v5), 19);
            let v6 = compute_block_hash(v5);
            let v7 = extract_parent_hash(v5);
            let v8 = extract_timestamp(v5);
            let v9 = extract_bits(v5);
            if (v4 > 0) {
                if (v3 > 0) {
                    let v10 = 0x1::vector::empty<u8>();
                    let v11 = 32;
                    while (v11 > 0) {
                        v11 = v11 - 1;
                        0x1::vector::push_back<u8>(&mut v10, *0x1::vector::borrow<u8>(&v7, v11));
                    };
                    assert!(v10 == compute_block_hash(0x1::vector::borrow<vector<u8>>(&arg3, v3 - 1)), 20);
                } else if (0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v4 - 1)) {
                    let v12 = 0x1::vector::empty<u8>();
                    let v13 = 32;
                    while (v13 > 0) {
                        v13 = v13 - 1;
                        0x1::vector::push_back<u8>(&mut v12, *0x1::vector::borrow<u8>(&v7, v13));
                    };
                    assert!(&v12 == 0x2::table::borrow<u64, vector<u8>>(&arg0.hashes, v4 - 1), 20);
                };
            };
            if (v4 >= 11) {
                assert!(verify_timestamp(arg0, v4, v8), 21);
            };
            let v14 = if (v4 > 0) {
                if (v4 % 2016 == 0) {
                    0x2::table::contains<u64, u32>(&arg0.bits, v4 - 1)
                } else {
                    false
                }
            } else {
                false
            };
            if (v14) {
                let v15 = calc_next_required_difficulty(arg0, v4 - 1);
                if (v15 != v9) {
                };
            };
            v2 = v2 + calc_work_from_bits(v9);
            if (0x2::table::contains<u64, vector<u8>>(&arg0.hashes, v4)) {
                if (0x2::table::borrow<u64, vector<u8>>(&arg0.hashes, v4) != &v6) {
                    if (!0x2::table::contains<u64, vector<vector<u8>>>(&arg0.fork_hashes, v4)) {
                        0x2::table::add<u64, vector<vector<u8>>>(&mut arg0.fork_hashes, v4, 0x1::vector::empty<vector<u8>>());
                    };
                    0x1::vector::push_back<vector<u8>>(0x2::table::borrow_mut<u64, vector<vector<u8>>>(&mut arg0.fork_hashes, v4), v6);
                    v3 = v3 + 1;
                    continue
                };
                v3 = v3 + 1;
                continue
            };
            0x2::table::add<u64, vector<u8>>(&mut arg0.hashes, v4, v6);
            0x2::table::add<u64, vector<u8>>(&mut arg0.parent_hashes, v4, v7);
            0x2::table::add<u64, u32>(&mut arg0.timestamps, v4, v8);
            0x2::table::add<u64, u32>(&mut arg0.bits, v4, v9);
            0x2::table::add<u64, u256>(&mut arg0.chain_work, v4, v2);
            if (v4 > arg0.canonical_tip) {
                arg0.canonical_tip = v4;
            };
            let v16 = BlockHeaderRegistered{
                height      : v4,
                block_hash  : v6,
                parent_hash : v7,
                chain_work  : v2,
                timestamp   : v8,
            };
            0x2::event::emit<BlockHeaderRegistered>(v16);
            v3 = v3 + 1;
        };
        arg0.total_registered = arg0.total_registered + v0;
    }

    fun retarget_algorithm(arg0: u256, arg1: u64, arg2: u64) : u256 {
        let v0 = arg2 - arg1;
        let v1 = v0;
        let v2 = 1209600 / 4;
        let v3 = 1209600 * 4;
        if (v0 > v3) {
            v1 = v3;
        } else if (v0 < v2) {
            v1 = v2;
        };
        let v4 = arg0 / 65536 * (v1 as u256) / (1209600 as u256) * 65536;
        let v5 = v4;
        let v6 = 26959946667150639794667015087019630673637144422540572481103610249215;
        if (v4 > v6) {
            v5 = v6;
        };
        v5
    }

    public entry fun submit_fragment(arg0: &mut BlockRegistry, arg1: &mut VerificationRound, arg2: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3Treasury, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(!arg1.verified, 7);
        assert!(v0 < arg1.opened_at_ms + 30000, 6);
        assert!(0x1::option::is_some<address>(&arg0.current_round), 17);
        assert!(arg4 < arg1.num_fragments, 8);
        assert!(0x1::vector::length<u8>(&arg5) == *0x1::vector::borrow<u64>(&arg1.fragment_sizes, arg4), 9);
        let v2 = 0x1::vector::borrow_mut<vector<address>>(&mut arg1.submitters, arg4);
        let v3 = 0x1::vector::length<address>(v2);
        assert!(v3 < 2, 10);
        let v4 = 0;
        while (v4 < v3) {
            assert!(*0x1::vector::borrow<address>(v2, v4) != v1, 11);
            v4 = v4 + 1;
        };
        if (!*0x1::vector::borrow<bool>(&arg1.fragment_filled, arg4)) {
            *0x1::vector::borrow_mut<vector<u8>>(&mut arg1.fragments, arg4) = arg5;
            *0x1::vector::borrow_mut<bool>(&mut arg1.fragment_filled, arg4) = true;
            arg1.filled_count = arg1.filled_count + 1;
        } else {
            assert!(&arg5 == 0x1::vector::borrow<vector<u8>>(&arg1.fragments, arg4), 12);
        };
        0x1::vector::push_back<address>(v2, v1);
        arg1.total_submitters = arg1.total_submitters + 1;
        let v5 = FragmentSubmitted{
            block_height   : arg1.block_height,
            fragment_index : arg4,
            submitter      : v1,
            slot_number    : v3,
            timestamp_ms   : v0,
        };
        0x2::event::emit<FragmentSubmitted>(v5);
        if (arg1.filled_count == arg1.num_fragments) {
            verify_and_reward(arg0, arg1, arg2, v0, arg6);
        };
    }

    fun target_to_bits(arg0: u256) : u32 {
        let v0 = bytes_of_target(arg0);
        let v1 = v0;
        let v2 = if (v0 <= 3) {
            ((arg0 << 8 * (3 - v0) & 4294967295) as u32)
        } else {
            ((arg0 >> 8 * (v0 - 3) & 4294967295) as u32)
        };
        if (v2 & 8388608 > 0) {
            v2 = v2 >> 8;
            v1 = v0 + 1;
        };
        v2 | (v1 as u32) << 24
    }

    public fun total_registered(arg0: &BlockRegistry) : u64 {
        arg0.total_registered
    }

    public fun total_verified(arg0: &BlockRegistry) : u64 {
        arg0.total_verified
    }

    fun validate_fragment_schema(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = *0x1::vector::borrow<u64>(arg1, v1);
            assert!(*0x1::vector::borrow<u64>(arg0, v1) == v0, 5);
            assert!(v2 > 0, 5);
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        assert!(v0 == 80, 5);
    }

    fun verify_and_reward(arg0: &mut BlockRegistry, arg1: &mut VerificationRound, arg2: &mut 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::M1N3Treasury, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg1.num_fragments) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg1.fragments, v1);
            let v3 = 0;
            while (v3 < 0x1::vector::length<u8>(v2)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(v2, v3));
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(verify_pow(&v0), 19);
        let v4 = 0x1::hash::sha2_256(0x1::hash::sha2_256(v0));
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 32;
        while (v6 > 0) {
            v6 = v6 - 1;
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, v6));
        };
        assert!(&v5 == 0x2::table::borrow<u64, vector<u8>>(&arg0.hashes, arg1.block_height), 13);
        if (!0x2::table::contains<u64, vector<u8>>(&arg0.parent_hashes, arg1.block_height)) {
            0x2::table::add<u64, vector<u8>>(&mut arg0.parent_hashes, arg1.block_height, extract_parent_hash(&v0));
        };
        if (!0x2::table::contains<u64, u32>(&arg0.timestamps, arg1.block_height)) {
            0x2::table::add<u64, u32>(&mut arg0.timestamps, arg1.block_height, extract_timestamp(&v0));
        };
        if (!0x2::table::contains<u64, u32>(&arg0.bits, arg1.block_height)) {
            let v7 = extract_bits(&v0);
            0x2::table::add<u64, u32>(&mut arg0.bits, arg1.block_height, v7);
            let v8 = if (arg1.block_height > 0 && 0x2::table::contains<u64, u256>(&arg0.chain_work, arg1.block_height - 1)) {
                *0x2::table::borrow<u64, u256>(&arg0.chain_work, arg1.block_height - 1)
            } else {
                0
            };
            0x2::table::add<u64, u256>(&mut arg0.chain_work, arg1.block_height, v8 + calc_work_from_bits(v7));
        };
        arg1.verified = true;
        arg0.current_height = arg0.current_height + 1;
        arg0.total_verified = arg0.total_verified + 1;
        arg0.current_round = 0x1::option::none<address>();
        let v9 = if (arg1.total_submitters > 0) {
            compute_total_reward(arg1.block_height) / arg1.total_submitters
        } else {
            0
        };
        let v10 = 0;
        while (v10 < arg1.num_fragments) {
            let v11 = 0x1::vector::borrow<vector<address>>(&arg1.submitters, v10);
            let v12 = 0;
            while (v12 < 0x1::vector::length<address>(v11)) {
                if (v9 > 0) {
                    0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3::mint_reward(arg2, v9, *0x1::vector::borrow<address>(v11, v12), arg4);
                };
                v12 = v12 + 1;
            };
            v10 = v10 + 1;
        };
        let v13 = BlockVerified{
            block_height           : arg1.block_height,
            num_participants       : arg1.total_submitters,
            reward_per_participant : v9,
            timestamp_ms           : arg3,
        };
        0x2::event::emit<BlockVerified>(v13);
    }

    fun verify_pow(arg0: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 80, 18);
        let v0 = 0x1::hash::sha2_256(0x1::hash::sha2_256(*arg0));
        bytes_to_u256_le(&v0) <= bits_to_target(extract_u32_le(arg0, 72))
    }

    fun verify_timestamp(arg0: &BlockRegistry, arg1: u64, arg2: u32) : bool {
        if (arg1 < 11) {
            return true
        };
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0;
        while (v1 < 11 && arg1 > v1) {
            0x1::vector::push_back<u32>(&mut v0, *0x2::table::borrow<u64, u32>(&arg0.timestamps, arg1 - 1 - v1));
            v1 = v1 + 1;
        };
        arg2 > calculate_median_time(&v0)
    }

    // decompiled from Move bytecode v6
}

