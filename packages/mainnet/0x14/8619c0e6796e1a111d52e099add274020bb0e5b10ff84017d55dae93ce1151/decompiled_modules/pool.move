module 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        admin: address,
        total_blocks: u64,
        total_shares: u64,
        current_round: u64,
        round_start_ms: u64,
        global_min_difficulty: u64,
        accumulator_open: bool,
        current_height: u64,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Template has key {
        id: 0x2::object::UID,
        height: u64,
        prev_block_hash: vector<u8>,
        coinbase1: vector<u8>,
        coinbase2: vector<u8>,
        merkle_branches: vector<vector<u8>>,
        version: u32,
        nbits: u32,
        ntime: u32,
        owner: address,
        created_at_ms: u64,
        round_id: u64,
        min_difficulty: u64,
        cached_network_difficulty: u64,
    }

    struct RoundAccumulator has key {
        id: 0x2::object::UID,
        round_id: u64,
        total_work: u128,
        total_shares: u64,
        created_at_ms: u64,
        block_finder: address,
        block_found_height: u64,
    }

    struct BlockFoundClaim has key {
        id: 0x2::object::UID,
        round_id: u64,
        height: u64,
        block_finder: address,
        share_hash: vector<u8>,
        found_at_ms: u64,
    }

    struct RoundHistory has key {
        id: 0x2::object::UID,
        round_id: u64,
        total_work: u128,
        total_shares: u64,
        closed_at_ms: u64,
        block_finder: address,
        block_found_height: u64,
    }

    struct TemplateRegistered has copy, drop {
        template_id: 0x2::object::ID,
        height: u64,
        round_id: u64,
        owner: address,
        timestamp_ms: u64,
    }

    struct ShareSubmitted has copy, drop {
        miner: address,
        template_id: 0x2::object::ID,
        round_id: u64,
        share_hash: vector<u8>,
        difficulty: u64,
        is_block: bool,
        timestamp_ms: u64,
    }

    struct BlockFound has copy, drop {
        miner: address,
        height: u64,
        round_id: u64,
        timestamp_ms: u64,
        claim_id: address,
    }

    struct RoundClosed has copy, drop {
        round_id: u64,
        total_work: u128,
        total_shares: u64,
        closed_at_ms: u64,
    }

    struct RoundAccumulatorOpened has copy, drop {
        round_id: u64,
        accumulator_id: address,
        block_finder: address,
        block_found_height: u64,
    }

    struct MinerWorkAccumulated has copy, drop {
        miner: address,
        round_id: u64,
        work: u128,
        shares: u64,
    }

    struct MinerWorkRecord has store, key {
        id: 0x2::object::UID,
        round_id: u64,
        miner: address,
        net_work: u128,
    }

    struct ShareReceipt has drop {
        miner: address,
        template_owner: address,
        difficulty: u64,
        round_id: u64,
    }

    public fun accumulate_miner_stats(arg0: &mut RoundAccumulator, arg1: vector<0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::MinerRoundStats>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        while (!0x1::vector::is_empty<0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::MinerRoundStats>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::MinerRoundStats>(&mut arg1);
            assert!(0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::mrs_miner(&v1) == v0, 13906836472151867408);
            if (0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::mrs_round_id(&v1) == arg0.round_id) {
                let v2 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::mrs_work(&v1);
                let v3 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::mrs_shares(&v1);
                let v4 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::mrs_sold_work(&v1);
                let v5 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::mrs_sold_shares(&v1);
                let v6 = if (v4 >= v2) {
                    0
                } else {
                    v2 - v4
                };
                let v7 = if (v5 >= v3) {
                    0
                } else {
                    v3 - v5
                };
                arg0.total_work = arg0.total_work + v6;
                arg0.total_shares = arg0.total_shares + v7;
                if (v6 > 0) {
                    let v8 = MinerWorkAccumulated{
                        miner    : v0,
                        round_id : arg0.round_id,
                        work     : v6,
                        shares   : v7,
                    };
                    0x2::event::emit<MinerWorkAccumulated>(v8);
                    let v9 = MinerWorkRecord{
                        id       : 0x2::object::new(arg2),
                        round_id : arg0.round_id,
                        miner    : v0,
                        net_work : v6,
                    };
                    0x2::transfer::transfer<MinerWorkRecord>(v9, v0);
                };
            };
            0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::delete_round_stats(v1);
        };
        0x1::vector::destroy_empty<0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::MinerRoundStats>(arg1);
    }

    public fun admin(arg0: &Pool) : address {
        arg0.admin
    }

    public fun claim_block_finder(arg0: &BlockFoundClaim) : address {
        arg0.block_finder
    }

    public fun claim_found_at_ms(arg0: &BlockFoundClaim) : u64 {
        arg0.found_at_ms
    }

    public fun claim_height(arg0: &BlockFoundClaim) : u64 {
        arg0.height
    }

    public fun claim_round_id(arg0: &BlockFoundClaim) : u64 {
        arg0.round_id
    }

    public fun claim_share_hash(arg0: &BlockFoundClaim) : vector<u8> {
        arg0.share_hash
    }

    public(friend) fun consume_work_record(arg0: MinerWorkRecord) : (u64, address, u128) {
        let MinerWorkRecord {
            id       : v0,
            round_id : v1,
            miner    : v2,
            net_work : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public fun current_height(arg0: &Pool) : u64 {
        arg0.current_height
    }

    public fun current_round(arg0: &Pool) : u64 {
        arg0.current_round
    }

    fun difficulty_from_hash(arg0: &vector<u8>) : u64 {
        let v0 = 31;
        while (v0 > 0 && *0x1::vector::borrow<u8>(arg0, v0) == 0) {
            v0 = v0 - 1;
        };
        let v1 = if (v0 >= 7) {
            8
        } else {
            v0 + 1
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = v2 << 8;
            v2 = v4 | (*0x1::vector::borrow<u8>(arg0, v0 - v3) as u64);
            v3 = v3 + 1;
        };
        if (v2 == 0) {
            return 1000000000000000
        };
        let v5 = v0 - v1 + 1;
        if (v5 <= 26) {
            let v7 = (65535 << ((208 - 8 * v5) as u8)) / (v2 as u256);
            if (v7 == 0) {
                1
            } else if (v7 > (1000000000000000 as u256)) {
                1000000000000000
            } else {
                (v7 as u64)
            }
        } else {
            let v8 = 65535 / ((v2 as u256) << ((8 * v5 - 208) as u8));
            if (v8 == 0) {
                1
            } else {
                (v8 as u64)
            }
        }
    }

    public fun finalize_round(arg0: &mut Pool, arg1: RoundAccumulator, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.round_id == arg0.current_round, 13906836652540624914);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.created_at_ms + 5000, 13906836661130690580);
        let v1 = arg1.round_id;
        let v2 = arg1.total_work;
        let v3 = arg1.total_shares;
        let RoundAccumulator {
            id                 : v4,
            round_id           : _,
            total_work         : _,
            total_shares       : _,
            created_at_ms      : _,
            block_finder       : _,
            block_found_height : _,
        } = arg1;
        0x2::object::delete(v4);
        arg0.accumulator_open = false;
        arg0.current_round = arg0.current_round + 1;
        arg0.total_blocks = arg0.total_blocks + 1;
        arg0.total_shares = arg0.total_shares + v3;
        arg0.round_start_ms = v0;
        let v11 = RoundClosed{
            round_id     : v1,
            total_work   : v2,
            total_shares : v3,
            closed_at_ms : v0,
        };
        0x2::event::emit<RoundClosed>(v11);
        let v12 = RoundHistory{
            id                 : 0x2::object::new(arg3),
            round_id           : v1,
            total_work         : v2,
            total_shares       : v3,
            closed_at_ms       : v0,
            block_finder       : arg1.block_finder,
            block_found_height : arg1.block_found_height,
        };
        0x2::transfer::freeze_object<RoundHistory>(v12);
    }

    public fun global_min_difficulty(arg0: &Pool) : u64 {
        arg0.global_min_difficulty
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Pool{
            id                    : 0x2::object::new(arg0),
            admin                 : v0,
            total_blocks          : 0,
            total_shares          : 0,
            current_round         : 0,
            round_start_ms        : 0,
            global_min_difficulty : 1,
            accumulator_open      : false,
            current_height        : 0,
        };
        let v2 = PoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Pool>(v1);
        0x2::transfer::transfer<PoolAdminCap>(v2, v0);
    }

    fun nbits_to_difficulty(arg0: u32) : u64 {
        let v0 = ((arg0 >> 24 & 255) as u64);
        let v1 = ((arg0 & 16777215) as u256);
        if (v1 == 0 || v0 == 0) {
            return 1000000000000000
        };
        let v2 = if (v0 >= 3) {
            let v3 = (v0 - 3) * 8;
            if (v3 >= 256) {
                return 1
            };
            v1 << (v3 as u8)
        } else {
            let v4 = (3 - v0) * 8;
            if (v4 >= 64) {
                return 1000000000000000
            };
            v1 >> (v4 as u8)
        };
        if (v2 == 0) {
            return 1000000000000000
        };
        let v5 = 26959535291011309493156476344723991336010898738574164086137773096960 / v2;
        if (v5 > (1000000000000000 as u256)) {
            1000000000000000
        } else if (v5 == 0) {
            1
        } else {
            (v5 as u64)
        }
    }

    public fun open_round_accumulator_from_claim(arg0: &mut Pool, arg1: &BlockFoundClaim, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.round_id == arg0.current_round, 13906836261698600978);
        if (arg0.accumulator_open) {
            return
        };
        arg0.accumulator_open = true;
        let v0 = RoundAccumulator{
            id                 : 0x2::object::new(arg3),
            round_id           : arg0.current_round,
            total_work         : 0,
            total_shares       : 0,
            created_at_ms      : 0x2::clock::timestamp_ms(arg2),
            block_finder       : arg1.block_finder,
            block_found_height : arg1.height,
        };
        let v1 = RoundAccumulatorOpened{
            round_id           : arg0.current_round,
            accumulator_id     : 0x2::object::id_to_address(0x2::object::borrow_id<RoundAccumulator>(&v0)),
            block_finder       : arg1.block_finder,
            block_found_height : arg1.height,
        };
        0x2::event::emit<RoundAccumulatorOpened>(v1);
        0x2::transfer::share_object<RoundAccumulator>(v0);
    }

    public fun receipt_difficulty(arg0: &ShareReceipt) : u64 {
        arg0.difficulty
    }

    public fun receipt_miner(arg0: &ShareReceipt) : address {
        arg0.miner
    }

    public fun receipt_round_id(arg0: &ShareReceipt) : u64 {
        arg0.round_id
    }

    public fun receipt_template_owner(arg0: &ShareReceipt) : address {
        arg0.template_owner
    }

    public fun register_template(arg0: &mut Pool, arg1: &PoolAdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u32, arg9: u32, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg0.current_round;
        if (arg3 > arg0.current_height) {
            arg0.current_height = arg3;
        };
        let v2 = Template{
            id                        : 0x2::object::new(arg11),
            height                    : arg3,
            prev_block_hash           : arg4,
            coinbase1                 : arg5,
            coinbase2                 : arg6,
            merkle_branches           : arg7,
            version                   : arg8,
            nbits                     : arg9,
            ntime                     : arg10,
            owner                     : 0x2::tx_context::sender(arg11),
            created_at_ms             : v0,
            round_id                  : v1,
            min_difficulty            : arg0.global_min_difficulty,
            cached_network_difficulty : nbits_to_difficulty(arg9),
        };
        let v3 = TemplateRegistered{
            template_id  : 0x2::object::id<Template>(&v2),
            height       : arg3,
            round_id     : v1,
            owner        : 0x2::tx_context::sender(arg11),
            timestamp_ms : v0,
        };
        0x2::event::emit<TemplateRegistered>(v3);
        0x2::transfer::freeze_object<Template>(v2);
    }

    public fun reset_difficulty(arg0: &mut Pool, arg1: &PoolAdminCap) {
        arg0.global_min_difficulty = 1;
    }

    public fun round_history_block_finder(arg0: &RoundHistory) : address {
        arg0.block_finder
    }

    public fun round_history_block_found_height(arg0: &RoundHistory) : u64 {
        arg0.block_found_height
    }

    public fun round_history_round_id(arg0: &RoundHistory) : u64 {
        arg0.round_id
    }

    public fun round_history_total_shares(arg0: &RoundHistory) : u64 {
        arg0.total_shares
    }

    public fun round_history_total_work(arg0: &RoundHistory) : u128 {
        arg0.total_work
    }

    public fun set_difficulty(arg0: &mut Pool, arg1: &PoolAdminCap, arg2: u64) {
        assert!(arg2 >= 1 && arg2 <= 1000000000000000, 13906836845813497864);
        arg0.global_min_difficulty = arg2;
    }

    public fun submit_share(arg0: &Template, arg1: &mut 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::MinerStats, arg2: &mut 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::MinerRoundStats, arg3: &mut 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::share_dedup::ShareDedup, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : ShareReceipt {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::miner_address(arg1) == v0, 13906835690467819536);
        assert!(0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::share_dedup::miner(arg3) == v0, 13906835694762786832);
        assert!(0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::share_dedup::template_id(arg3) == 0x2::object::id<Template>(arg0), 13906835699057623054);
        assert!((arg8 ^ arg0.version) & (4294967295 ^ 536862720) == 0, 13906835711942262794);
        let v2 = arg0.ntime;
        let v3 = if (v2 > 7200) {
            v2 - 7200
        } else {
            0
        };
        assert!(arg6 >= v3 && arg6 <= v2 + 7200, 13906835729122263052);
        let v4 = b"";
        0x1::vector::append<u8>(&mut v4, arg0.coinbase1);
        0x1::vector::append<u8>(&mut v4, arg4);
        0x1::vector::append<u8>(&mut v4, arg5);
        0x1::vector::append<u8>(&mut v4, arg0.coinbase2);
        let v5 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::sha256d(v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg0.merkle_branches)) {
            let v7 = b"";
            0x1::vector::append<u8>(&mut v7, v5);
            0x1::vector::append<u8>(&mut v7, *0x1::vector::borrow<vector<u8>>(&arg0.merkle_branches, v6));
            v5 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::sha256d(v7);
            v6 = v6 + 1;
        };
        let v8 = b"";
        0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::append_u32_le(&mut v8, arg8);
        0x1::vector::append<u8>(&mut v8, arg0.prev_block_hash);
        0x1::vector::append<u8>(&mut v8, v5);
        0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::append_u32_le(&mut v8, arg6);
        0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::append_u32_le(&mut v8, arg0.nbits);
        0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::append_u32_le(&mut v8, arg7);
        let v9 = 0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::btc_math::sha256d(v8);
        let v10 = difficulty_from_hash(&v9);
        assert!(v10 >= arg0.min_difficulty, 13906835892330627078);
        0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::share_dedup::check_and_record(arg3, v9);
        let v11 = v10 >= arg0.cached_network_difficulty;
        0x148619c0e6796e1a111d52e099add274020bb0e5b10ff84017d55dae93ce1151::miner::record_share(arg1, arg2, v10, v11, arg0.round_id, arg0.height);
        let v12 = ShareSubmitted{
            miner        : v0,
            template_id  : 0x2::object::id<Template>(arg0),
            round_id     : arg0.round_id,
            share_hash   : v9,
            difficulty   : v10,
            is_block     : v11,
            timestamp_ms : v1,
        };
        0x2::event::emit<ShareSubmitted>(v12);
        if (v11) {
            let v13 = BlockFoundClaim{
                id           : 0x2::object::new(arg10),
                round_id     : arg0.round_id,
                height       : arg0.height,
                block_finder : v0,
                share_hash   : v9,
                found_at_ms  : v1,
            };
            let v14 = BlockFound{
                miner        : v0,
                height       : arg0.height,
                round_id     : arg0.round_id,
                timestamp_ms : v1,
                claim_id     : 0x2::object::id_to_address(0x2::object::borrow_id<BlockFoundClaim>(&v13)),
            };
            0x2::event::emit<BlockFound>(v14);
            0x2::transfer::freeze_object<BlockFoundClaim>(v13);
        };
        ShareReceipt{
            miner          : v0,
            template_owner : arg0.owner,
            difficulty     : v10,
            round_id       : arg0.round_id,
        }
    }

    public fun template_height(arg0: &Template) : u64 {
        arg0.height
    }

    public fun template_id(arg0: &Template) : 0x2::object::ID {
        0x2::object::id<Template>(arg0)
    }

    public fun template_min_difficulty(arg0: &Template) : u64 {
        arg0.min_difficulty
    }

    public fun template_network_difficulty(arg0: &Template) : u64 {
        arg0.cached_network_difficulty
    }

    public fun template_owner(arg0: &Template) : address {
        arg0.owner
    }

    public fun template_round_id(arg0: &Template) : u64 {
        arg0.round_id
    }

    public fun total_blocks(arg0: &Pool) : u64 {
        arg0.total_blocks
    }

    public fun total_shares(arg0: &Pool) : u64 {
        arg0.total_shares
    }

    public fun work_record_miner(arg0: &MinerWorkRecord) : address {
        arg0.miner
    }

    public fun work_record_net_work(arg0: &MinerWorkRecord) : u128 {
        arg0.net_work
    }

    public fun work_record_round_id(arg0: &MinerWorkRecord) : u64 {
        arg0.round_id
    }

    // decompiled from Move bytecode v6
}

