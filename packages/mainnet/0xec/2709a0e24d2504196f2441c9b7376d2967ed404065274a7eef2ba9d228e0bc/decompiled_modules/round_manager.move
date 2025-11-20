module 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::round_manager {
    struct Round has store, key {
        id: 0x2::object::UID,
        index: u64,
        phase: u8,
        closes_at_ms: u64,
        entries: vector<vector<Entry>>,
        total: u64,
    }

    struct Entry has copy, drop, store {
        owner: address,
        amount: u64,
    }

    struct PlayerRecord has store {
        unclaimed_sui: u64,
        total_wins: u64,
        total_entries: u64,
        last_round: u64,
        soul_start_round: u64,
        soul_age_rounds: u64,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        admin: address,
        round: Round,
        paused: bool,
        fee_split: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::FeeSplit,
        vaults: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::Vaults,
        cap: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::SupplyCap,
        idx: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::RadianceIndex,
        buckets: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::Buckets,
        miracle: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::miracle::Miracle,
        player_records: 0x2::table::Table<address, PlayerRecord>,
        season_index: u64,
        season_start_ms: u64,
        season_length_ms: u64,
    }

    struct RoundSettled has copy, drop {
        index: u64,
        winning: u64,
        fee: u64,
        redistributed: u64,
    }

    struct EntryAdded has copy, drop {
        index: u64,
        owner: address,
        block_id: u64,
        amount: u64,
    }

    struct ClaimAllEvent has copy, drop {
        user: address,
        sui_claimed: u64,
        faith_claimed: u64,
    }

    struct RoundOpened has copy, drop {
        index: u64,
        closes_at_ms: u64,
    }

    struct PausedEvent has copy, drop {
        admin: address,
        paused: bool,
    }

    struct TreasurySplitUpdatedEvent has copy, drop {
        admin: address,
        faithgg_bps: u64,
        manifest_bps: u64,
        pilgrimage_bps: u64,
        ops_bps: u64,
    }

    struct AdminFaithggWithdrawEvent has copy, drop {
        admin: address,
        to: address,
        amount: u64,
    }

    struct AdminManifestWithdrawEvent has copy, drop {
        admin: address,
        to: address,
        amount: u64,
    }

    struct RoundMissed has copy, drop {
        index: u64,
        closes_at_ms: u64,
        settled_at_ms: u64,
        total: u64,
    }

    struct SeasonOpened has copy, drop {
        index: u64,
        starts_at_ms: u64,
        ends_at_ms: u64,
    }

    struct SeasonClosed has copy, drop {
        index: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
    }

    struct SeasonAwarded has copy, drop {
        season_index: u64,
        recipient: address,
        amount: u64,
        asset_kind: u8,
        source: u8,
    }

    fun assert_admin(arg0: &Global, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::errors::E_UNAUTH());
    }

    public entry fun claim_all_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        let v0 = claim_sui_internal(arg0, arg2, arg3);
        let v1 = ClaimAllEvent{
            user          : arg2,
            sui_claimed   : v0,
            faith_claimed : claim_faith_internal(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<ClaimAllEvent>(v1);
    }

    public entry fun claim_faith_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        claim_faith_internal(arg0, arg1, arg2, arg3);
    }

    fun claim_faith_internal(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::claim_if_any_with_multiplier(arg2, 1000, soul_age_multiplier_bps_for_user(arg0, arg2), &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::FAITH>>(0x2::coin::mint<0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::FAITH>(arg1, v0, arg3), arg2);
            if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg2)) {
                let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg2);
                v1.soul_age_rounds = 0;
                v1.soul_start_round = arg0.round.index;
            };
        };
        v0
    }

    public entry fun claim_sui_entry(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = ClaimAllEvent{
            user          : arg1,
            sui_claimed   : claim_sui_internal(arg0, arg1, arg2),
            faith_claimed : 0,
        };
        0x2::event::emit<ClaimAllEvent>(v0);
    }

    fun claim_sui_internal(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg1);
            v0 = v1.unclaimed_sui;
            v1.unclaimed_sui = 0;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_faithgg(&mut arg0.vaults, v0, arg2), arg1);
        };
        v0
    }

    public entry fun create_global_shared(arg0: address, arg1: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::SupplyCap, arg2: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::RadianceIndex, arg3: 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::create(arg6);
        let v2 = Round{
            id           : 0x2::object::new(arg6),
            index        : 0,
            phase        : 0,
            closes_at_ms : 0,
            entries      : empty_entries(),
            total        : 0,
        };
        let v3 = Global{
            id               : 0x2::object::new(arg6),
            admin            : arg0,
            round            : v2,
            paused           : false,
            fee_split        : v0,
            vaults           : v1,
            cap              : arg1,
            idx              : arg2,
            buckets          : arg3,
            miracle          : 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::miracle::create(arg4, arg5, arg6),
            player_records   : 0x2::table::new<address, PlayerRecord>(arg6),
            season_index     : 0,
            season_start_ms  : 0,
            season_length_ms : 2592000000,
        };
        0x2::transfer::share_object<Global>(v3);
    }

    fun empty_entries() : vector<vector<Entry>> {
        let v0 = 0x1::vector::empty<vector<Entry>>();
        let v1 = 0;
        while (v1 < 25) {
            0x1::vector::push_back<vector<Entry>>(&mut v0, 0x1::vector::empty<Entry>());
            v1 = v1 + 1;
        };
        v0
    }

    fun empty_record(arg0: u64) : PlayerRecord {
        PlayerRecord{
            unclaimed_sui    : 0,
            total_wins       : 0,
            total_entries    : 0,
            last_round       : 0,
            soul_start_round : arg0,
            soul_age_rounds  : 0,
        }
    }

    fun ensure_record(arg0: &mut 0x2::table::Table<address, PlayerRecord>, arg1: address, arg2: u64) : &mut PlayerRecord {
        if (!0x2::table::contains<address, PlayerRecord>(arg0, arg1)) {
            0x2::table::add<address, PlayerRecord>(arg0, arg1, empty_record(arg2));
        };
        0x2::table::borrow_mut<address, PlayerRecord>(arg0, arg1)
    }

    fun ensure_record_for_play(arg0: &mut 0x2::table::Table<address, PlayerRecord>, arg1: address, arg2: u64) : &mut PlayerRecord {
        let v0 = ensure_record(arg0, arg1, arg2);
        if (v0.last_round < arg2) {
            v0.soul_age_rounds = v0.soul_age_rounds + 1;
            v0.last_round = arg2;
        };
        v0
    }

    fun enter(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg0.paused) {
            true
        } else if (arg0.round.phase != 1) {
            true
        } else {
            arg1 >= 25
        };
        if (v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
            return
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        if (v2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
            return
        };
        let v3 = &mut arg0.player_records;
        let v4 = ensure_record_for_play(v3, v0, arg0.round.index);
        v4.total_entries = v4.total_entries + 1;
        arg0.round.total = arg0.round.total + v2;
        let v5 = Entry{
            owner  : v0,
            amount : v2,
        };
        0x1::vector::push_back<Entry>(0x1::vector::borrow_mut<vector<Entry>>(&mut arg0.round.entries, arg1), v5);
        let v6 = EntryAdded{
            index    : arg0.round.index,
            owner    : v0,
            block_id : arg1,
            amount   : v2,
        };
        0x2::event::emit<EntryAdded>(v6);
        0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::deposit_to_faithgg(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    public entry fun force_settle_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        settle(arg0, arg1, arg2, arg3);
    }

    public fun get_soul_age(arg0: &Global, arg1: address) : u64 {
        if (!0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
            return 0
        };
        0x2::table::borrow<address, PlayerRecord>(&arg0.player_records, arg1).soul_age_rounds
    }

    fun open_round(arg0: &mut Global, arg1: u64) {
        if (arg0.paused) {
            return
        };
        if (arg0.round.phase != 0) {
            return
        };
        arg0.round.index = arg0.round.index + 1;
        arg0.round.phase = 1;
        arg0.round.closes_at_ms = arg1;
        arg0.round.entries = empty_entries();
        arg0.round.total = 0;
        let v0 = RoundOpened{
            index        : arg0.round.index,
            closes_at_ms : arg1,
        };
        0x2::event::emit<RoundOpened>(v0);
    }

    public entry fun open_round_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        open_round(arg0, arg1);
    }

    public entry fun roll_season_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (arg0.season_start_ms == 0) {
            return
        };
        if (arg1 < arg0.season_start_ms + arg0.season_length_ms) {
            return
        };
        let v0 = SeasonClosed{
            index         : arg0.season_index,
            started_at_ms : arg0.season_start_ms,
            ended_at_ms   : arg1,
        };
        0x2::event::emit<SeasonClosed>(v0);
        arg0.season_index = arg0.season_index + 1;
        arg0.season_start_ms = arg1;
        let v1 = SeasonOpened{
            index        : arg0.season_index,
            starts_at_ms : arg1,
            ends_at_ms   : arg1 + arg0.season_length_ms,
        };
        0x2::event::emit<SeasonOpened>(v1);
    }

    public entry fun season_award_sui_from_pilgrimage_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        if (arg2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_pilgrimage(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = SeasonAwarded{
            season_index : arg0.season_index,
            recipient    : arg1,
            amount       : arg2,
            asset_kind   : 0,
            source       : 0,
        };
        0x2::event::emit<SeasonAwarded>(v0);
    }

    public fun season_time_remaining(arg0: &Global, arg1: u64) : u64 {
        if (arg0.season_start_ms == 0) {
            return 0
        };
        let v0 = arg0.season_start_ms + arg0.season_length_ms;
        if (arg1 >= v0) {
            0
        } else {
            v0 - arg1
        }
    }

    public entry fun set_admin_entry(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    public entry fun set_fee_split_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        assert!(arg0.paused, 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::errors::E_NOT_PAUSED());
        0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::set_split(&mut arg0.fee_split, arg1, arg2, arg3, arg4);
        let v0 = TreasurySplitUpdatedEvent{
            admin          : 0x2::tx_context::sender(arg5),
            faithgg_bps    : arg1,
            manifest_bps   : arg2,
            pilgrimage_bps : arg3,
            ops_bps        : arg4,
        };
        0x2::event::emit<TreasurySplitUpdatedEvent>(v0);
    }

    public entry fun set_paused_entry(arg0: &mut Global, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.paused = arg1;
        let v0 = PausedEvent{
            admin  : 0x2::tx_context::sender(arg2),
            paused : arg1,
        };
        0x2::event::emit<PausedEvent>(v0);
    }

    fun settle(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.round.phase != 1) {
            return
        };
        let v0 = arg0.round.closes_at_ms;
        if (arg1 < v0) {
            return
        };
        if (arg1 > v0 + 600000) {
            arg0.round.phase = 0;
            let v1 = RoundMissed{
                index         : arg0.round.index,
                closes_at_ms  : v0,
                settled_at_ms : arg1,
                total         : arg0.round.total,
            };
            0x2::event::emit<RoundMissed>(v1);
            return
        };
        arg0.round.phase = 2;
        let v2 = 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::rng_oracle::pick(arg2, 25);
        let v3 = arg0.round.total;
        let v4 = v3 / 10;
        let v5 = v3 - v4;
        let v6 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v2);
        let v7 = 0x1::vector::length<Entry>(v6);
        if (v7 > 0 && v5 > 0) {
            let v8 = 0;
            while (v8 < v7 && v5 > 0) {
                let v9 = *0x1::vector::borrow<Entry>(v6, v8);
                let v10;
                let v11 = if (v8 == v7 - 1) {
                    v5
                } else {
                    let v12 = v5 * v9.amount / sum_block(v6);
                    v10 = v12;
                    if (v12 == 0 && v5 > 0) {
                        v10 = 1;
                    };
                    if (v10 > v5) {
                        v10 = v5;
                    };
                    v10
                };
                if (v11 > 0) {
                    v5 = v5 - v11;
                    let v13 = &mut arg0.player_records;
                    let v14 = ensure_record(v13, v9.owner, arg0.round.index);
                    v14.unclaimed_sui = v14.unclaimed_sui + v10;
                    v14.total_wins = v14.total_wins + 1;
                    0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::accrue_to(v9.owner, v10, &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                };
                v8 = v8 + 1;
            };
        };
        if (v4 > 0) {
            0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::split_and_route_internal(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_faithgg(&mut arg0.vaults, v4, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::miracle::accrue(&mut arg0.miracle);
        let (v15, v16) = 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::miracle::maybe_trigger(&mut arg0.miracle, arg2 + 7919);
        let v17 = if (v15) {
            if (v7 > 0) {
                v16 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v17) {
            let v18 = 0;
            let v19 = 0;
            while (v19 < v7) {
                let v20 = *0x1::vector::borrow<Entry>(v6, v19);
                v18 = v18 + v20.amount * soul_age_multiplier_bps_for_user(arg0, v20.owner) / 10000;
                v19 = v19 + 1;
            };
            if (v18 > 0) {
                let v21 = 0;
                while (v21 < v7) {
                    let v22 = *0x1::vector::borrow<Entry>(v6, v21);
                    let v23 = v22.amount * soul_age_multiplier_bps_for_user(arg0, v22.owner) / 10000;
                    if (v23 > 0) {
                        let v24 = v16 * v23 / v18;
                        let v25 = v24;
                        if (v24 == 0 && v16 > 0) {
                            v25 = 1;
                        };
                        if (v25 > 0) {
                            let v26 = &mut arg0.player_records;
                            ensure_record(v26, v22.owner, arg0.round.index);
                            0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::faith::accrue_to(v22.owner, v25, &mut arg0.cap, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                    };
                    v21 = v21 + 1;
                };
            };
        } else if (v7 > 0) {
            let v27 = 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::pilgrimage_balance(&arg0.vaults);
            if (v27 > 0) {
                let v28 = v27 / 50;
                let v29 = v28;
                if (v28 == 0) {
                    v29 = 1;
                };
                let v30 = 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_pilgrimage(&mut arg0.vaults, v29, arg3);
                let v31 = v29;
                let v32 = 0;
                while (v32 < v7 && v31 > 0) {
                    let v33 = *0x1::vector::borrow<Entry>(v6, v32);
                    let v34;
                    let v35 = if (v32 == v7 - 1) {
                        v31
                    } else {
                        let v36 = v29 * v33.amount / sum_block(v6);
                        v34 = v36;
                        if (v36 == 0 && v31 > 0) {
                            v34 = 1;
                        };
                        if (v34 > v31) {
                            v34 = v31;
                        };
                        v34
                    };
                    if (v35 > 0) {
                        v31 = v31 - v35;
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v30, v34, arg3), v33.owner);
                    };
                    v32 = v32 + 1;
                };
                0x2::coin::destroy_zero<0x2::sui::SUI>(v30);
            };
        };
        arg0.round.phase = 0;
        let v37 = RoundSettled{
            index         : arg0.round.index,
            winning       : v2,
            fee           : v4,
            redistributed : v5,
        };
        0x2::event::emit<RoundSettled>(v37);
    }

    public entry fun settle_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        settle(arg0, arg1, arg2, arg3);
    }

    public entry fun share_global_entry(arg0: Global) {
        0x2::transfer::share_object<Global>(arg0);
    }

    fun soul_age_multiplier_bps_for_user(arg0: &Global, arg1: address) : u64 {
        let v0 = get_soul_age(arg0, arg1);
        if (v0 == 0) {
            10000
        } else {
            let v2 = if (v0 >= 100) {
                10000
            } else {
                v0 * 10
            };
            10000 + v2
        }
    }

    public entry fun start_seasons_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (arg0.season_start_ms != 0) {
            return
        };
        arg0.season_index = 1;
        arg0.season_start_ms = arg1;
        let v0 = SeasonOpened{
            index        : arg0.season_index,
            starts_at_ms : arg1,
            ends_at_ms   : arg1 + arg0.season_length_ms,
        };
        0x2::event::emit<SeasonOpened>(v0);
    }

    fun sum_block(arg0: &vector<Entry>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Entry>(arg0)) {
            let v2 = *0x1::vector::borrow<Entry>(arg0, v1);
            v0 = v0 + v2.amount;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun withdraw_faith_cron_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_faithgg(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminFaithggWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminFaithggWithdrawEvent>(v1);
    }

    public entry fun withdraw_faithgg_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg0.paused, 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_faithgg(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminFaithggWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminFaithggWithdrawEvent>(v0);
    }

    public entry fun withdraw_manifest_cron_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminManifestWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v1);
    }

    public entry fun withdraw_manifest_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg0.paused, 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminManifestWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

