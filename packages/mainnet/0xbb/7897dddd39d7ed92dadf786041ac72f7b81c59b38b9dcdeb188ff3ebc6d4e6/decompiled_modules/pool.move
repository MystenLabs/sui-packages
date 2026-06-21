module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool {
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

    struct ProtocolMPCConfig has key {
        id: 0x2::object::UID,
        btc_script_pubkey: vector<u8>,
    }

    struct ProtocolMPCConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        btc_script_pubkey: vector<u8>,
    }

    struct ProtocolMPCConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_script: vector<u8>,
        new_script: vector<u8>,
    }

    struct DerivedTemplate has key {
        id: 0x2::object::UID,
        parent_template_id: 0x2::object::ID,
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
        min_difficulty: u64,
        cached_network_difficulty: u64,
    }

    struct HashpowerBuyOrder<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        template_id: 0x2::object::ID,
        price_per_difficulty: u64,
        budget: 0x2::balance::Balance<T0>,
        expires_epoch: 0x1::option::Option<u64>,
        is_dynamic: bool,
    }

    struct DerivedTemplateRegistered has copy, drop {
        derived_template_id: 0x2::object::ID,
        parent_template_id: 0x2::object::ID,
        height: u64,
        miner: address,
        timestamp_ms: u64,
    }

    struct HashpowerBuyOrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        buyer: address,
        template_id: 0x2::object::ID,
        price_per_difficulty: u64,
        initial_budget: u64,
        expires_epoch: 0x1::option::Option<u64>,
        is_dynamic: bool,
    }

    struct HashpowerBuyOrderPriceUpdated has copy, drop {
        order_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    struct HashpowerBuyOrderToppedUp has copy, drop {
        order_id: 0x2::object::ID,
        added: u64,
        new_budget: u64,
    }

    struct HashpowerBuyOrderCanceled has copy, drop {
        order_id: 0x2::object::ID,
        refunded: u64,
    }

    struct HashpowerShareFilled has copy, drop {
        order_id: 0x2::object::ID,
        miner: address,
        template_id: 0x2::object::ID,
        derived_template_id: 0x1::option::Option<0x2::object::ID>,
        difficulty: u64,
        payout: u64,
        is_block: bool,
        timestamp_ms: u64,
    }

    public fun accumulate_miner_stats(arg0: &mut RoundAccumulator, arg1: vector<0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        while (!0x1::vector::is_empty<0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats>(&mut arg1);
            assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_miner(&v1) == v0, 13906840350507401233);
            if (0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_round_id(&v1) == arg0.round_id) {
                let v2 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_work(&v1);
                let v3 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_shares(&v1);
                let v4 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_sold_work(&v1);
                let v5 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_sold_shares(&v1);
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
            0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::delete_round_stats(v1);
        };
        0x1::vector::destroy_empty<0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats>(arg1);
    }

    public fun admin(arg0: &Pool) : address {
        arg0.admin
    }

    public fun cancel_hashpower_order<T0>(arg0: HashpowerBuyOrder<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.buyer == 0x2::tx_context::sender(arg1), 13906837782118006817);
        let HashpowerBuyOrder {
            id                   : v0,
            buyer                : _,
            template_id          : _,
            price_per_difficulty : _,
            budget               : v4,
            expires_epoch        : _,
            is_dynamic           : _,
        } = arg0;
        let v7 = v4;
        let v8 = v0;
        0x2::balance::destroy_zero<T0>(v7);
        let v9 = HashpowerBuyOrderCanceled{
            order_id : 0x2::object::id_from_address(0x2::object::uid_to_address(&v8)),
            refunded : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<HashpowerBuyOrderCanceled>(v9);
        0x2::object::delete(v8);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v7), arg1)
    }

    fun check_order_not_expired<T0>(arg0: &HashpowerBuyOrder<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<u64>(&arg0.expires_epoch)) {
            assert!(0x2::tx_context::epoch(arg1) <= *0x1::option::borrow<u64>(&arg0.expires_epoch), 13906838486492774435);
        };
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

    fun compute_payout(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
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

    public fun create_mpc_config(arg0: &PoolAdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 22 && v0 <= 42, 13906836334714552361);
        let v1 = ProtocolMPCConfig{
            id                : 0x2::object::new(arg2),
            btc_script_pubkey : arg1,
        };
        let v2 = ProtocolMPCConfigCreated{
            config_id         : 0x2::object::id<ProtocolMPCConfig>(&v1),
            btc_script_pubkey : v1.btc_script_pubkey,
        };
        0x2::event::emit<ProtocolMPCConfigCreated>(v2);
        0x2::transfer::share_object<ProtocolMPCConfig>(v1);
    }

    public fun current_height(arg0: &Pool) : u64 {
        arg0.current_height
    }

    public fun current_round(arg0: &Pool) : u64 {
        arg0.current_round
    }

    public fun derived_template_height(arg0: &DerivedTemplate) : u64 {
        arg0.height
    }

    public fun derived_template_min_difficulty(arg0: &DerivedTemplate) : u64 {
        arg0.min_difficulty
    }

    public fun derived_template_network_difficulty(arg0: &DerivedTemplate) : u64 {
        arg0.cached_network_difficulty
    }

    public fun derived_template_owner(arg0: &DerivedTemplate) : address {
        arg0.owner
    }

    public fun derived_template_parent(arg0: &DerivedTemplate) : 0x2::object::ID {
        arg0.parent_template_id
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

    fun drain_order_budget<T0>(arg0: &mut HashpowerBuyOrder<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.budget) >= arg1, 13906838576686825503);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.budget, arg1), arg2)
    }

    public fun finalize_round(arg0: &mut Pool, arg1: RoundAccumulator, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.round_id == arg0.current_round, 13906840530896158739);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.created_at_ms + 5000, 13906840539486224405);
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

    public fun hashpower_order_budget<T0>(arg0: &HashpowerBuyOrder<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.budget)
    }

    public fun hashpower_order_buyer<T0>(arg0: &HashpowerBuyOrder<T0>) : address {
        arg0.buyer
    }

    public fun hashpower_order_is_dynamic<T0>(arg0: &HashpowerBuyOrder<T0>) : bool {
        arg0.is_dynamic
    }

    public fun hashpower_order_price<T0>(arg0: &HashpowerBuyOrder<T0>) : u64 {
        arg0.price_per_difficulty
    }

    public fun hashpower_order_template_id<T0>(arg0: &HashpowerBuyOrder<T0>) : 0x2::object::ID {
        arg0.template_id
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
            global_min_difficulty : 1000000,
            accumulator_open      : false,
            current_height        : 0,
        };
        let v2 = PoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Pool>(v1);
        0x2::transfer::transfer<PoolAdminCap>(v2, v0);
    }

    fun maybe_freeze_block_claim(arg0: bool, arg1: u64, arg2: u64, arg3: address, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0) {
            let v0 = BlockFoundClaim{
                id           : 0x2::object::new(arg6),
                round_id     : arg1,
                height       : arg2,
                block_finder : arg3,
                share_hash   : arg4,
                found_at_ms  : arg5,
            };
            let v1 = BlockFound{
                miner        : arg3,
                height       : arg2,
                round_id     : arg1,
                timestamp_ms : arg5,
                claim_id     : 0x2::object::id_to_address(0x2::object::borrow_id<BlockFoundClaim>(&v0)),
            };
            0x2::event::emit<BlockFound>(v1);
            0x2::transfer::freeze_object<BlockFoundClaim>(v0);
        };
    }

    public fun mpc_config_script(arg0: &ProtocolMPCConfig) : vector<u8> {
        arg0.btc_script_pubkey
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
        assert!(arg1.round_id == arg0.current_round, 13906840140054134803);
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

    public fun permissionless_template_fee_mist() : u64 {
        10000000
    }

    public fun place_hashpower_order<T0>(arg0: &Template, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg0.owner == v0, 13906837472880361505);
        assert!(arg2 > 0, 13906837477175590949);
        let v1 = 0x2::object::id<Template>(arg0);
        let v2 = HashpowerBuyOrder<T0>{
            id                   : 0x2::object::new(arg5),
            buyer                : v0,
            template_id          : v1,
            price_per_difficulty : arg2,
            budget               : 0x2::coin::into_balance<T0>(arg1),
            expires_epoch        : arg3,
            is_dynamic           : arg4,
        };
        let v3 = HashpowerBuyOrderPlaced{
            order_id             : 0x2::object::id<HashpowerBuyOrder<T0>>(&v2),
            buyer                : v0,
            template_id          : v1,
            price_per_difficulty : arg2,
            initial_budget       : 0x2::coin::value<T0>(&arg1),
            expires_epoch        : arg3,
            is_dynamic           : arg4,
        };
        0x2::event::emit<HashpowerBuyOrderPlaced>(v3);
        0x2::transfer::share_object<HashpowerBuyOrder<T0>>(v2);
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

    public fun register_derived_template_public(arg0: &Template, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000, 13906837146462191639);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg3);
        let v0 = arg0.ntime;
        let v1 = if (v0 > 7200) {
            v0 - 7200
        } else {
            0
        };
        assert!(arg6 >= v1 && arg6 <= v0 + 7200, 13906837202297028635);
        assert!(arg4 == arg0.coinbase1, 13906837228066701337);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::verify_derived_coinbase(&arg0.coinbase2, &arg5);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = DerivedTemplate{
            id                        : 0x2::object::new(arg7),
            parent_template_id        : 0x2::object::id<Template>(arg0),
            height                    : arg0.height,
            prev_block_hash           : arg0.prev_block_hash,
            coinbase1                 : arg4,
            coinbase2                 : arg5,
            merkle_branches           : arg0.merkle_branches,
            version                   : arg0.version,
            nbits                     : arg0.nbits,
            ntime                     : arg6,
            owner                     : v3,
            created_at_ms             : v2,
            min_difficulty            : arg0.min_difficulty,
            cached_network_difficulty : arg0.cached_network_difficulty,
        };
        let v5 = DerivedTemplateRegistered{
            derived_template_id : 0x2::object::id<DerivedTemplate>(&v4),
            parent_template_id  : 0x2::object::id<Template>(arg0),
            height              : arg0.height,
            miner               : v3,
            timestamp_ms        : v2,
        };
        0x2::event::emit<DerivedTemplateRegistered>(v5);
        0x2::transfer::freeze_object<DerivedTemplate>(v4);
    }

    public fun register_template(arg0: &mut Pool, arg1: &PoolAdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u32, arg9: u32, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) {
        register_template_inner(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun register_template_inner(arg0: &mut Pool, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: u32, arg8: u32, arg9: u32, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.current_round;
        if (arg2 > arg0.current_height) {
            arg0.current_height = arg2;
        };
        let v2 = Template{
            id                        : 0x2::object::new(arg10),
            height                    : arg2,
            prev_block_hash           : arg3,
            coinbase1                 : arg4,
            coinbase2                 : arg5,
            merkle_branches           : arg6,
            version                   : arg7,
            nbits                     : arg8,
            ntime                     : arg9,
            owner                     : 0x2::tx_context::sender(arg10),
            created_at_ms             : v0,
            round_id                  : v1,
            min_difficulty            : arg0.global_min_difficulty,
            cached_network_difficulty : nbits_to_difficulty(arg8),
        };
        let v3 = TemplateRegistered{
            template_id  : 0x2::object::id<Template>(&v2),
            height       : arg2,
            round_id     : v1,
            owner        : 0x2::tx_context::sender(arg10),
            timestamp_ms : v0,
        };
        0x2::event::emit<TemplateRegistered>(v3);
        0x2::transfer::freeze_object<Template>(v2);
    }

    public fun register_template_public(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: u32, arg9: u32, arg10: u32, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000, 13906835793547493399);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.admin);
        register_template_inner(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun reset_difficulty(arg0: &mut Pool, arg1: &PoolAdminCap) {
        arg0.global_min_difficulty = 1000000;
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
        assert!(arg2 >= 1000000 && arg2 <= 1000000000000000, 13906840724169031689);
        arg0.global_min_difficulty = arg2;
    }

    public fun submit_share(arg0: &Template, arg1: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerStats, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::ShareDedup, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : ShareReceipt {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::miner_address(arg1) == v0, 13906839568823353361);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::miner(arg3) == v0, 13906839573118320657);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::template_id(arg3) == 0x2::object::id<Template>(arg0), 13906839577413156879);
        assert!((arg8 ^ arg0.version) & (4294967295 ^ 536862720) == 0, 13906839590297796619);
        let v2 = arg0.ntime;
        let v3 = if (v2 > 7200) {
            v2 - 7200
        } else {
            0
        };
        assert!(arg6 >= v3 && arg6 <= v2 + 7200, 13906839607477796877);
        let v4 = b"";
        0x1::vector::append<u8>(&mut v4, arg0.coinbase1);
        0x1::vector::append<u8>(&mut v4, arg4);
        0x1::vector::append<u8>(&mut v4, arg5);
        0x1::vector::append<u8>(&mut v4, arg0.coinbase2);
        let v5 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg0.merkle_branches)) {
            let v7 = b"";
            0x1::vector::append<u8>(&mut v7, v5);
            0x1::vector::append<u8>(&mut v7, *0x1::vector::borrow<vector<u8>>(&arg0.merkle_branches, v6));
            v5 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v7);
            v6 = v6 + 1;
        };
        let v8 = b"";
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v8, arg8);
        0x1::vector::append<u8>(&mut v8, arg0.prev_block_hash);
        0x1::vector::append<u8>(&mut v8, v5);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v8, arg6);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v8, arg0.nbits);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v8, arg7);
        let v9 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v8);
        let v10 = difficulty_from_hash(&v9);
        assert!(v10 >= arg0.min_difficulty, 13906839770686160903);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::check_and_record(arg3, v9);
        let v11 = v10 >= arg0.cached_network_difficulty;
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::record_share(arg1, arg2, v10, v11, arg0.round_id, arg0.height);
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

    public fun submit_share_for_pay<T0>(arg0: &Template, arg1: &mut HashpowerBuyOrder<T0>, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerStats, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg4: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::ShareDedup, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<Template>(arg0) == arg1.template_id, 13906837958211403805);
        check_order_not_expired<T0>(arg1, arg11);
        let (v0, v1, v2, v3, v4) = validate_share_against_template(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v5 = compute_payout(v2, arg1.price_per_difficulty);
        let v6 = drain_order_budget<T0>(arg1, v5, arg11);
        let v7 = HashpowerShareFilled{
            order_id            : 0x2::object::id<HashpowerBuyOrder<T0>>(arg1),
            miner               : v0,
            template_id         : 0x2::object::id<Template>(arg0),
            derived_template_id : 0x1::option::none<0x2::object::ID>(),
            difficulty          : v2,
            payout              : v5,
            is_block            : v3,
            timestamp_ms        : v4,
        };
        0x2::event::emit<HashpowerShareFilled>(v7);
        maybe_freeze_block_claim(v3, arg0.round_id, arg0.height, v0, v1, v4, arg11);
        v6
    }

    public fun submit_share_for_pay_derived<T0>(arg0: &DerivedTemplate, arg1: &mut HashpowerBuyOrder<T0>, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerStats, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg4: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::ShareDedup, arg5: vector<u8>, arg6: vector<u8>, arg7: u32, arg8: u32, arg9: u32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.parent_template_id == arg1.template_id, 13906838241679245341);
        check_order_not_expired<T0>(arg1, arg11);
        let (v0, v1, v2, v3, v4) = validate_share_against_derived(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v5 = compute_payout(v2, arg1.price_per_difficulty);
        let v6 = drain_order_budget<T0>(arg1, v5, arg11);
        let v7 = HashpowerShareFilled{
            order_id            : 0x2::object::id<HashpowerBuyOrder<T0>>(arg1),
            miner               : v0,
            template_id         : arg0.parent_template_id,
            derived_template_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<DerivedTemplate>(arg0)),
            difficulty          : v2,
            payout              : v5,
            is_block            : v3,
            timestamp_ms        : v4,
        };
        0x2::event::emit<HashpowerShareFilled>(v7);
        maybe_freeze_block_claim(v3, 0, arg0.height, v0, v1, v4, arg11);
        v6
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

    public fun top_up_hashpower_order<T0>(arg0: &mut HashpowerBuyOrder<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.budget, 0x2::coin::into_balance<T0>(arg1));
        let v0 = HashpowerBuyOrderToppedUp{
            order_id   : 0x2::object::id<HashpowerBuyOrder<T0>>(arg0),
            added      : 0x2::coin::value<T0>(&arg1),
            new_budget : 0x2::balance::value<T0>(&arg0.budget),
        };
        0x2::event::emit<HashpowerBuyOrderToppedUp>(v0);
    }

    public fun total_blocks(arg0: &Pool) : u64 {
        arg0.total_blocks
    }

    public fun total_shares(arg0: &Pool) : u64 {
        arg0.total_shares
    }

    public fun update_hashpower_order_price<T0>(arg0: &mut HashpowerBuyOrder<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.buyer == 0x2::tx_context::sender(arg2), 13906837623204216865);
        assert!(arg0.is_dynamic, 13906837627499577383);
        assert!(arg1 > 0, 13906837631794413605);
        arg0.price_per_difficulty = arg1;
        let v0 = HashpowerBuyOrderPriceUpdated{
            order_id  : 0x2::object::id<HashpowerBuyOrder<T0>>(arg0),
            old_price : arg0.price_per_difficulty,
            new_price : arg1,
        };
        0x2::event::emit<HashpowerBuyOrderPriceUpdated>(v0);
    }

    public fun update_mpc_config(arg0: &mut ProtocolMPCConfig, arg1: &PoolAdminCap, arg2: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 >= 22 && v0 <= 42, 13906836420613898281);
        arg0.btc_script_pubkey = arg2;
        let v1 = ProtocolMPCConfigUpdated{
            config_id  : 0x2::object::id<ProtocolMPCConfig>(arg0),
            old_script : arg0.btc_script_pubkey,
            new_script : arg0.btc_script_pubkey,
        };
        0x2::event::emit<ProtocolMPCConfigUpdated>(v1);
    }

    fun validate_share_against_derived(arg0: &DerivedTemplate, arg1: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerStats, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::ShareDedup, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (address, vector<u8>, u64, bool, u64) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::miner_address(arg1) == v0, 13906838997592702993);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::miner(arg3) == v0, 13906839001887670289);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::template_id(arg3) == 0x2::object::id<DerivedTemplate>(arg0), 13906839006182506511);
        assert!((arg8 ^ arg0.version) & (4294967295 ^ 536862720) == 0, 13906839014772178955);
        let v1 = arg0.ntime;
        let v2 = if (v1 > 7200) {
            v1 - 7200
        } else {
            0
        };
        assert!(arg6 >= v2 && arg6 <= v1 + 7200, 13906839031952179213);
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, arg0.coinbase1);
        0x1::vector::append<u8>(&mut v3, arg4);
        0x1::vector::append<u8>(&mut v3, arg5);
        0x1::vector::append<u8>(&mut v3, arg0.coinbase2);
        let v4 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&arg0.merkle_branches)) {
            let v6 = b"";
            0x1::vector::append<u8>(&mut v6, v4);
            0x1::vector::append<u8>(&mut v6, *0x1::vector::borrow<vector<u8>>(&arg0.merkle_branches, v5));
            v4 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v6);
            v5 = v5 + 1;
        };
        let v7 = b"";
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg8);
        0x1::vector::append<u8>(&mut v7, arg0.prev_block_hash);
        0x1::vector::append<u8>(&mut v7, v4);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg6);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg0.nbits);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg7);
        let v8 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v7);
        let v9 = difficulty_from_hash(&v8);
        assert!(v9 >= arg0.min_difficulty, 13906839169390739463);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::check_and_record(arg3, v8);
        let v10 = v9 >= arg0.cached_network_difficulty;
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::record_share(arg1, arg2, v9, v10, 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::mrs_round_id(arg2), arg0.height);
        (v0, v8, v9, v10, 0x2::clock::timestamp_ms(arg9))
    }

    fun validate_share_against_template(arg0: &Template, arg1: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerStats, arg2: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::MinerRoundStats, arg3: &mut 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::ShareDedup, arg4: vector<u8>, arg5: vector<u8>, arg6: u32, arg7: u32, arg8: u32, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (address, vector<u8>, u64, bool, u64) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::miner_address(arg1) == v0, 13906838692650024977);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::miner(arg3) == v0, 13906838696944992273);
        assert!(0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::template_id(arg3) == 0x2::object::id<Template>(arg0), 13906838701239828495);
        assert!((arg8 ^ arg0.version) & (4294967295 ^ 536862720) == 0, 13906838709829500939);
        let v1 = arg0.ntime;
        let v2 = if (v1 > 7200) {
            v1 - 7200
        } else {
            0
        };
        assert!(arg6 >= v2 && arg6 <= v1 + 7200, 13906838727009501197);
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, arg0.coinbase1);
        0x1::vector::append<u8>(&mut v3, arg4);
        0x1::vector::append<u8>(&mut v3, arg5);
        0x1::vector::append<u8>(&mut v3, arg0.coinbase2);
        let v4 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<vector<u8>>(&arg0.merkle_branches)) {
            let v6 = b"";
            0x1::vector::append<u8>(&mut v6, v4);
            0x1::vector::append<u8>(&mut v6, *0x1::vector::borrow<vector<u8>>(&arg0.merkle_branches, v5));
            v4 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v6);
            v5 = v5 + 1;
        };
        let v7 = b"";
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg8);
        0x1::vector::append<u8>(&mut v7, arg0.prev_block_hash);
        0x1::vector::append<u8>(&mut v7, v4);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg6);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg0.nbits);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::append_u32_le(&mut v7, arg7);
        let v8 = 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::btc_math::sha256d(v7);
        let v9 = difficulty_from_hash(&v8);
        assert!(v9 >= arg0.min_difficulty, 13906838864448061447);
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::share_dedup::check_and_record(arg3, v8);
        let v10 = v9 >= arg0.cached_network_difficulty;
        0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner::record_share(arg1, arg2, v9, v10, arg0.round_id, arg0.height);
        (v0, v8, v9, v10, 0x2::clock::timestamp_ms(arg9))
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

    // decompiled from Move bytecode v7
}

