module 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::round_manager {
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
        fee_split: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::FeeSplit,
        vaults: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::Vaults,
        cap: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::SupplyCap,
        idx: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::RadianceIndex,
        buckets: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::Buckets,
        miracle: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::miracle::Miracle,
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

    struct SuiClaimedEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct RoundOpened has copy, drop {
        index: u64,
        closes_at_ms: u64,
    }

    struct RoundOpenedEvent has copy, drop {
        index: u64,
        ts_ms: u64,
    }

    struct MiracleHitEvent has copy, drop {
        round_index: u64,
        payout_faith_atoms: u64,
        drought_tests: u64,
        staircase_phase: u64,
        new_odds: u64,
    }

    struct PilgrimageDripEvent has copy, drop {
        round_index: u64,
        drip_atoms: u64,
        drought_tests: u64,
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

    struct PlayerRoundSettled has copy, drop {
        round_index: u64,
        player: address,
        sui_deployed_atoms: u64,
        sui_won_atoms: u64,
        unclaimed_sui_before_atoms: u64,
        unclaimed_sui_after_atoms: u64,
        unclaimed_faith_atoms: u64,
        had_miracle: bool,
        ts_ms: u64,
    }

    fun add_sui_delta(arg0: &mut vector<address>, arg1: &mut vector<u64>, arg2: address, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg2) {
                let v1 = 0x1::vector::borrow_mut<u64>(arg1, v0);
                *v1 = *v1 + arg3;
                return
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<address>(arg0, arg2);
        0x1::vector::push_back<u64>(arg1, arg3);
    }

    fun assert_admin(arg0: &Global, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::errors::E_UNAUTH());
    }

    public entry fun claim_faith_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        claim_faith_internal(arg0, arg1, arg2, arg3);
    }

    fun claim_faith_internal(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::claim_if_any_with_multiplier(arg2, 1000, soul_age_multiplier_bps_for_user(arg0, arg2), &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::FAITH>>(0x2::coin::mint<0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::FAITH>(arg1, v0, arg3), arg2);
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
        let v0 = SuiClaimedEvent{
            user   : arg1,
            amount : claim_sui_internal(arg0, arg1, arg2),
        };
        0x2::event::emit<SuiClaimedEvent>(v0);
    }

    fun claim_sui_internal(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg1);
            v0 = v1.unclaimed_sui;
            v1.unclaimed_sui = 0;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_faithgg(&mut arg0.vaults, v0, arg2), arg1);
        };
        v0
    }

    public entry fun create_global_shared(arg0: address, arg1: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::SupplyCap, arg2: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::RadianceIndex, arg3: 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::create(arg6);
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
            miracle          : 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::miracle::create(arg4, arg5, arg6),
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
        0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::deposit_to_faithgg(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        enter(arg0, arg1, arg2, arg3);
    }

    public entry fun force_settle_entry(arg0: &mut Global, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        settle(arg0, arg1, arg2, arg3);
    }

    public fun get_soul_age(arg0: &Global, arg1: address) : u64 {
        if (!0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
            return 0
        };
        0x2::table::borrow<address, PlayerRecord>(&arg0.player_records, arg1).soul_age_rounds
    }

    fun get_sui_delta(arg0: &vector<address>, arg1: &vector<u64>, arg2: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg2) {
                return *0x1::vector::borrow<u64>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        0
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
        let v1 = RoundOpenedEvent{
            index : arg0.round.index,
            ts_ms : arg1,
        };
        0x2::event::emit<RoundOpenedEvent>(v1);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_pilgrimage(&mut arg0.vaults, arg2, arg3), arg1);
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
        assert!(arg0.paused, 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::errors::E_NOT_PAUSED());
        0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::set_split(&mut arg0.fee_split, arg1, arg2, arg3, arg4);
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

    fun settle(arg0: &mut Global, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.round.phase != 1) {
            return
        };
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = arg0.round.closes_at_ms;
        if (arg2 < v2) {
            return
        };
        if (arg2 > v2 + 600000) {
            arg0.round.phase = 0;
            let v3 = RoundMissed{
                index         : arg0.round.index,
                closes_at_ms  : v2,
                settled_at_ms : arg2,
                total         : arg0.round.total,
            };
            0x2::event::emit<RoundMissed>(v3);
            return
        };
        arg0.round.phase = 2;
        let v4 = 0x2::random::new_generator(arg1, arg3);
        let v5 = 0x2::random::generate_u64_in_range(&mut v4, 0, 25 - 1);
        let v6 = arg0.round.total;
        let v7 = v6 / 10;
        let v8 = v6 - v7;
        let v9 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v5);
        let v10 = 0x1::vector::length<Entry>(v9);
        if (v10 > 0 && v8 > 0) {
            let v11 = sum_block(v9);
            if (v11 > 0) {
                let v12 = 0;
                while (v12 < v10 && v8 > 0) {
                    let v13 = *0x1::vector::borrow<Entry>(v9, v12);
                    let v14;
                    let v15 = if (v12 == v10 - 1) {
                        v8
                    } else {
                        let v16 = (((v8 as u128) * (v13.amount as u128) / (v11 as u128)) as u64);
                        v14 = v16;
                        if (v16 == 0 && v8 > 0) {
                            v14 = 1;
                        };
                        if (v14 > v8) {
                            v14 = v8;
                        };
                        v14
                    };
                    if (v15 > 0) {
                        v8 = v8 - v15;
                        let v17 = &mut arg0.player_records;
                        let v18 = ensure_record(v17, v13.owner, arg0.round.index);
                        v18.unclaimed_sui = v18.unclaimed_sui + v14;
                        v18.total_wins = v18.total_wins + 1;
                        let v19 = &mut v0;
                        let v20 = &mut v1;
                        add_sui_delta(v19, v20, v13.owner, v14);
                        0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::accrue_to(v13.owner, v14, &arg0.idx, &mut arg0.buckets, arg3);
                    };
                    v12 = v12 + 1;
                };
            };
        };
        if (v7 > 0) {
            0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::split_and_route_internal(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_faithgg(&mut arg0.vaults, v7, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::miracle::accrue(&mut arg0.miracle);
        let v21 = false;
        let v22 = 0;
        let v23 = 0;
        let v24 = 0;
        let v25 = 0;
        if (v10 > 0) {
            let (v26, v27, v28, v29, v30) = 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::miracle::maybe_trigger(&mut arg0.miracle, 0x2::random::generate_u64(&mut v4));
            v21 = v26;
            v22 = v27;
            v23 = v28;
            v24 = v29;
            v25 = v30;
        };
        let v31 = if (v21) {
            if (v10 > 0) {
                v22 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v31) {
            let v32 = 0;
            let v33 = 0;
            while (v33 < v10) {
                let v34 = *0x1::vector::borrow<Entry>(v9, v33);
                let v35 = (v34.amount as u128) * (soul_age_multiplier_bps_for_user(arg0, v34.owner) as u128) / 10000;
                let v36 = if (v35 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    (v35 as u64)
                };
                v32 = v32 + v36;
                v33 = v33 + 1;
            };
            if (v32 > 0) {
                let v37 = 0;
                while (v37 < v10) {
                    let v38 = *0x1::vector::borrow<Entry>(v9, v37);
                    let v39 = (v38.amount as u128) * (soul_age_multiplier_bps_for_user(arg0, v38.owner) as u128) / 10000;
                    if (v39 > 0) {
                        let v40 = (((v22 as u128) * v39 / (v32 as u128)) as u64);
                        let v41 = v40;
                        if (v40 == 0 && v22 > 0) {
                            v41 = 1;
                        };
                        if (v41 > 0) {
                            let v42 = &mut arg0.player_records;
                            ensure_record(v42, v38.owner, arg0.round.index);
                            0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::accrue_to(v38.owner, v41, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                    };
                    v37 = v37 + 1;
                };
            };
            let v43 = MiracleHitEvent{
                round_index        : arg0.round.index,
                payout_faith_atoms : v22,
                drought_tests      : v23,
                staircase_phase    : v24,
                new_odds           : v25,
            };
            0x2::event::emit<MiracleHitEvent>(v43);
        } else if (v10 > 0) {
            let v44 = 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::pilgrimage_balance(&arg0.vaults);
            if (v44 > 0) {
                let v45 = v44 / 50;
                let v46 = v45;
                if (v45 == 0) {
                    v46 = 1;
                };
                let v47 = sum_block(v9);
                if (v47 > 0) {
                    let v48 = 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_pilgrimage(&mut arg0.vaults, v46, arg3);
                    let v49 = v46;
                    let v50 = 0;
                    while (v50 < v10 && v49 > 0) {
                        let v51 = *0x1::vector::borrow<Entry>(v9, v50);
                        let v52;
                        let v53 = if (v50 == v10 - 1) {
                            v49
                        } else {
                            let v54 = (((v46 as u128) * (v51.amount as u128) / (v47 as u128)) as u64);
                            v52 = v54;
                            if (v54 == 0 && v49 > 0) {
                                v52 = 1;
                            };
                            if (v52 > v49) {
                                v52 = v49;
                            };
                            v52
                        };
                        if (v53 > 0) {
                            v49 = v49 - v53;
                            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v48, v52, arg3), v51.owner);
                        };
                        v50 = v50 + 1;
                    };
                    0x2::coin::destroy_zero<0x2::sui::SUI>(v48);
                    let v55 = PilgrimageDripEvent{
                        round_index   : arg0.round.index,
                        drip_atoms    : v46,
                        drought_tests : v23,
                    };
                    0x2::event::emit<PilgrimageDripEvent>(v55);
                };
            };
        };
        if (arg0.round.total > 0) {
            let v56 = 0;
            while (v56 < 25) {
                let v57 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v56);
                let v58 = 0x1::vector::length<Entry>(v57);
                if (v58 > 0) {
                    let v59 = if (v56 == v5) {
                        if (v10 > 0) {
                            v8 > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    let v60 = if (v59) {
                        sum_block(v57)
                    } else {
                        0
                    };
                    let v61 = if (v59) {
                        (v60 as u128)
                    } else {
                        0
                    };
                    let v62 = if (v59) {
                        v8
                    } else {
                        0
                    };
                    let v63 = v62;
                    let v64 = if (v58 == 0) {
                        0
                    } else {
                        v58 - 1
                    };
                    let v65 = 0;
                    while (v65 < v58) {
                        let v66 = *0x1::vector::borrow<Entry>(v57, v65);
                        let v67 = if (v59) {
                            if (v60 > 0) {
                                v8 > 0
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        let v68 = if (v67) {
                            let v68 = if (v65 == v64) {
                                v63
                            } else {
                                let v69 = (((v8 as u128) * (v66.amount as u128) / v61) as u64);
                                let v70 = v69;
                                if (v69 == 0 && v63 > 0) {
                                    v70 = 1;
                                };
                                if (v70 > v63) {
                                    v70 = v63;
                                };
                                v70
                            };
                            if (v68 > 0) {
                                v63 = v63 - v68;
                            };
                            v68
                        } else {
                            0
                        };
                        let v71 = &mut arg0.player_records;
                        let v72 = ensure_record(v71, v66.owner, arg0.round.index).unclaimed_sui;
                        let v73 = get_sui_delta(&v0, &v1, v66.owner);
                        let v74 = if (v72 >= v73) {
                            v72 - v73
                        } else {
                            0
                        };
                        let (_, _, v77) = 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::preview_refinement(v66.owner, &arg0.idx, &arg0.buckets, 1000);
                        let v78 = PlayerRoundSettled{
                            round_index                : arg0.round.index,
                            player                     : v66.owner,
                            sui_deployed_atoms         : v66.amount,
                            sui_won_atoms              : v68,
                            unclaimed_sui_before_atoms : v74,
                            unclaimed_sui_after_atoms  : v72,
                            unclaimed_faith_atoms      : v77,
                            had_miracle                : v21,
                            ts_ms                      : arg2,
                        };
                        0x2::event::emit<PlayerRoundSettled>(v78);
                        v65 = v65 + 1;
                    };
                };
                v56 = v56 + 1;
            };
        };
        arg0.round.phase = 0;
        let v79 = RoundSettled{
            index         : arg0.round.index,
            winning       : v5,
            fee           : v7,
            redistributed : v8,
        };
        0x2::event::emit<RoundSettled>(v79);
    }

    public entry fun settle_entry(arg0: &mut Global, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        settle(arg0, arg1, arg2, arg3);
    }

    public entry fun share_global_entry(arg0: Global) {
        0x2::transfer::share_object<Global>(arg0);
    }

    public entry fun snapshot_radiance_entry(arg0: &Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith::emit_radiance_snapshot(&arg0.cap, &arg0.idx, &arg0.buckets, arg1);
    }

    fun soul_age_multiplier_bps_for_user(arg0: &Global, arg1: address) : u64 {
        let v0 = get_soul_age(arg0, arg1);
        if (v0 == 0) {
            10000
        } else {
            let v2 = if (v0 >= 100) {
                100
            } else {
                v0
            };
            10000 + v2 * 100
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_faithgg(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminFaithggWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminFaithggWithdrawEvent>(v1);
    }

    public entry fun withdraw_faithgg_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg0.paused, 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_faithgg(&mut arg0.vaults, arg2, arg3), arg1);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminManifestWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v1);
    }

    public entry fun withdraw_manifest_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert!(arg0.paused, 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminManifestWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

