module 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager {
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
        fee_split: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::FeeSplit,
        vaults: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::Vaults,
        cap: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::SupplyCap,
        idx: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::RadianceIndex,
        buckets: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::Buckets,
        miracle: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::Miracle,
        player_records: 0x2::table::Table<address, PlayerRecord>,
        season_index: u64,
        season_start_ms: u64,
        season_length_ms: u64,
    }

    struct GlobalV2 has key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
        round: Round,
        paused: bool,
        fee_split: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::FeeSplit,
        vaults: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::Vaults,
        cap: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::SupplyCap,
        idx: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::RadianceIndex,
        buckets: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::Buckets,
        miracle: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::Miracle,
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

    struct MissedRoundRefundEvent has copy, drop {
        round_index: u64,
        total_refunded_atoms: u64,
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

    fun assert_admin(arg0: &GlobalV2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_UNAUTH());
    }

    fun assert_version_v2(arg0: &GlobalV2) {
        assert!(arg0.version == 3, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_VERSION());
    }

    public entry fun claim_faith_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_faith_entry_v2(arg0: &mut GlobalV2, arg1: &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        claim_faith_internal(arg0, arg1, arg2, arg3);
    }

    fun claim_faith_internal(arg0: &mut GlobalV2, arg1: &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::claim_if_any_with_multiplier(arg2, 1500, soul_age_multiplier_bps_for_user(arg0, arg2), &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::mint<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1, v0, arg3), arg2);
            if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg2)) {
                let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg2);
                v1.soul_age_rounds = 0;
                v1.soul_start_round = arg0.round.index;
            };
        };
        v0
    }

    public entry fun claim_sui_entry(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_sui_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = SuiClaimedEvent{
            user   : arg1,
            amount : claim_sui_internal(arg0, arg1, arg2),
        };
        0x2::event::emit<SuiClaimedEvent>(v0);
    }

    fun claim_sui_internal(arg0: &mut GlobalV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg1);
            v0 = v1.unclaimed_sui;
            v1.unclaimed_sui = 0;
        };
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg(&mut arg0.vaults, v0, arg2), arg1);
        };
        v0
    }

    public entry fun create_global_shared(arg0: address, arg1: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::SupplyCap, arg2: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::RadianceIndex, arg3: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
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

    fun ensure_record_for_play(arg0: &mut 0x2::table::Table<address, PlayerRecord>, arg1: address, arg2: u64, arg3: u64) : &mut PlayerRecord {
        let v0 = ensure_record(arg0, arg1, arg2);
        if (arg3 >= 1000000000 && v0.last_round < arg2) {
            v0.soul_age_rounds = v0.soul_age_rounds + 1;
            v0.last_round = arg2;
        };
        v0
    }

    fun enter(arg0: &mut GlobalV2, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
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
        let v4 = ensure_record_for_play(v3, v0, arg0.round.index, v2);
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
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_faithgg(&mut arg0.vaults, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun enter_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        enter(arg0, arg1, arg2, arg3);
    }

    public entry fun force_settle_entry(arg0: &mut Global, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun force_settle_entry_v2(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        settle(arg0, arg1, arg2, arg3);
    }

    public fun get_soul_age(arg0: &Global, arg1: address) : u64 {
        abort 0
    }

    public fun get_soul_age_v2(arg0: &GlobalV2, arg1: address) : u64 {
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

    public entry fun migrate_to_v2_entry(arg0: Global, arg1: &mut 0x2::tx_context::TxContext) {
        let Global {
            id               : v0,
            admin            : v1,
            round            : v2,
            paused           : _,
            fee_split        : v4,
            vaults           : v5,
            cap              : v6,
            idx              : v7,
            buckets          : v8,
            miracle          : v9,
            player_records   : v10,
            season_index     : v11,
            season_start_ms  : v12,
            season_length_ms : v13,
        } = arg0;
        assert!(0x2::tx_context::sender(arg1) == v1, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_UNAUTH());
        0x2::object::delete(v0);
        let v14 = GlobalV2{
            id               : 0x2::object::new(arg1),
            admin            : v1,
            version          : 2,
            round            : v2,
            paused           : true,
            fee_split        : v4,
            vaults           : v5,
            cap              : v6,
            idx              : v7,
            buckets          : v8,
            miracle          : v9,
            player_records   : v10,
            season_index     : v11,
            season_start_ms  : v12,
            season_length_ms : v13,
        };
        0x2::transfer::share_object<GlobalV2>(v14);
    }

    public entry fun missed_round_refund_entry(arg0: &mut Global, arg1: u64, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun missed_round_refund_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: vector<address>, arg3: vector<u64>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        assert_version_v2(arg0);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_LENGTH_MISMATCH());
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v1);
            v1 = v1 + 1;
        };
        if (v2 == 0) {
            return
        };
        let v3 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg(&mut arg0.vaults, v2, arg5);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v4);
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v5, arg5), *0x1::vector::borrow<address>(&arg2, v4));
            };
            v4 = v4 + 1;
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        let v6 = MissedRoundRefundEvent{
            round_index          : arg1,
            total_refunded_atoms : v2,
            ts_ms                : arg4,
        };
        0x2::event::emit<MissedRoundRefundEvent>(v6);
    }

    fun open_round(arg0: &mut GlobalV2, arg1: u64) {
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
        abort 0
    }

    public entry fun open_round_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        open_round(arg0, arg1);
    }

    public entry fun roll_season_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun roll_season_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
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
        abort 0
    }

    public entry fun season_award_sui_from_pilgrimage_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        if (arg2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_pilgrimage(&mut arg0.vaults, arg2, arg3), arg1);
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
        abort 0
    }

    public fun season_time_remaining_v2(arg0: &GlobalV2, arg1: u64) : u64 {
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
        abort 0
    }

    public entry fun set_admin_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        arg0.admin = arg1;
    }

    public entry fun set_fee_split_entry(arg0: &mut Global, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_fee_split_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        assert_version_v2(arg0);
        assert!(arg0.paused, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOT_PAUSED());
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::set_split(&mut arg0.fee_split, arg1, arg2, arg3, arg4);
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
        abort 0
    }

    public entry fun set_paused_entry_v2(arg0: &mut GlobalV2, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        arg0.paused = arg1;
        let v0 = PausedEvent{
            admin  : 0x2::tx_context::sender(arg2),
            paused : arg1,
        };
        0x2::event::emit<PausedEvent>(v0);
    }

    public entry fun set_version_entry_v2(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg0.version <= 3, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_VERSION());
        arg0.version = 3;
    }

    fun settle(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
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
                        let v21 = v14 * 3000 / 10000;
                        if (v21 > 0) {
                            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to(v13.owner, v21, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                    };
                    v12 = v12 + 1;
                };
            };
        };
        if (v7 > 0) {
            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::split_and_route_internal(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg(&mut arg0.vaults, v7, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::accrue(&mut arg0.miracle);
        let v22 = false;
        let v23 = 0;
        let v24 = 0;
        let v25 = 0;
        let v26 = 0;
        if (v10 > 0) {
            let (v27, v28, v29, v30, v31) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::maybe_trigger(&mut arg0.miracle, 0x2::random::generate_u64(&mut v4));
            v22 = v27;
            v23 = v28;
            v24 = v29;
            v25 = v30;
            v26 = v31;
        };
        let v32 = if (v22) {
            if (v10 > 0) {
                v23 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v32) {
            let v33 = 0;
            let v34 = 0;
            while (v34 < v10) {
                let v35 = *0x1::vector::borrow<Entry>(v9, v34);
                let v36 = (v35.amount as u128) * (soul_age_multiplier_bps_for_user(arg0, v35.owner) as u128) / 10000;
                let v37 = if (v36 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    (v36 as u64)
                };
                v33 = v33 + v37;
                v34 = v34 + 1;
            };
            if (v33 > 0) {
                let v38 = 0;
                while (v38 < v10) {
                    let v39 = *0x1::vector::borrow<Entry>(v9, v38);
                    let v40 = (v39.amount as u128) * (soul_age_multiplier_bps_for_user(arg0, v39.owner) as u128) / 10000;
                    if (v40 > 0) {
                        let v41 = (((v23 as u128) * v40 / (v33 as u128)) as u64);
                        let v42 = v41;
                        if (v41 == 0 && v23 > 0) {
                            v42 = 1;
                        };
                        if (v42 > 0) {
                            let v43 = &mut arg0.player_records;
                            ensure_record(v43, v39.owner, arg0.round.index);
                            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to(v39.owner, v42, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                    };
                    v38 = v38 + 1;
                };
            };
            let v44 = MiracleHitEvent{
                round_index        : arg0.round.index,
                payout_faith_atoms : v23,
                drought_tests      : v24,
                staircase_phase    : v25,
                new_odds           : v26,
            };
            0x2::event::emit<MiracleHitEvent>(v44);
        } else if (v10 > 0) {
            let v45 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::pilgrimage_balance(&arg0.vaults);
            if (v45 > 0) {
                let v46 = v45 / 50;
                let v47 = v46;
                if (v46 == 0) {
                    v47 = 1;
                };
                let v48 = sum_block(v9);
                if (v48 > 0) {
                    let v49 = 0;
                    let v50 = v47;
                    let v51 = 0;
                    while (v51 < v10 && v50 > 0) {
                        let v52 = *0x1::vector::borrow<Entry>(v9, v51);
                        let v53;
                        let v54 = if (v51 == v10 - 1) {
                            v50
                        } else {
                            let v55 = (((v47 as u128) * (v52.amount as u128) / (v48 as u128)) as u64);
                            v53 = v55;
                            if (v55 == 0 && v50 > 0) {
                                v53 = 1;
                            };
                            if (v53 > v50) {
                                v53 = v50;
                            };
                            v53
                        };
                        if (v54 > 0) {
                            v50 = v50 - v54;
                            v49 = v49 + v53;
                            let v56 = &mut arg0.player_records;
                            let v57 = ensure_record(v56, v52.owner, arg0.round.index);
                            v57.unclaimed_sui = v57.unclaimed_sui + v53;
                            let v58 = &mut v0;
                            let v59 = &mut v1;
                            add_sui_delta(v58, v59, v52.owner, v53);
                        };
                        v51 = v51 + 1;
                    };
                    if (v49 > 0) {
                        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_faithgg(&mut arg0.vaults, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_pilgrimage(&mut arg0.vaults, v49, arg3));
                    };
                    let v60 = PilgrimageDripEvent{
                        round_index   : arg0.round.index,
                        drip_atoms    : v49,
                        drought_tests : v24,
                    };
                    0x2::event::emit<PilgrimageDripEvent>(v60);
                };
            };
        };
        if (arg0.round.total > 0) {
            let v61 = 0x1::vector::empty<address>();
            let v62 = 0x1::vector::empty<u64>();
            let v63 = 0;
            while (v63 < 25) {
                let v64 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v63);
                let v65 = 0;
                while (v65 < 0x1::vector::length<Entry>(v64)) {
                    let v66 = *0x1::vector::borrow<Entry>(v64, v65);
                    let v67 = &mut v61;
                    let v68 = &mut v62;
                    add_sui_delta(v67, v68, v66.owner, v66.amount);
                    v65 = v65 + 1;
                };
                v63 = v63 + 1;
            };
            let v69 = 0;
            while (v69 < 0x1::vector::length<address>(&v61)) {
                let v70 = *0x1::vector::borrow<address>(&v61, v69);
                let v71 = &mut arg0.player_records;
                let v72 = ensure_record(v71, v70, arg0.round.index).unclaimed_sui;
                let v73 = get_sui_delta(&v0, &v1, v70);
                let v74 = if (v72 >= v73) {
                    v72 - v73
                } else {
                    0
                };
                let (_, _, v77) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::preview_refinement(v70, &arg0.idx, &arg0.buckets, 1500);
                let v78 = PlayerRoundSettled{
                    round_index                : arg0.round.index,
                    player                     : v70,
                    sui_deployed_atoms         : *0x1::vector::borrow<u64>(&v62, v69),
                    sui_won_atoms              : v73,
                    unclaimed_sui_before_atoms : v74,
                    unclaimed_sui_after_atoms  : v72,
                    unclaimed_faith_atoms      : v77,
                    had_miracle                : v22,
                    ts_ms                      : arg2,
                };
                0x2::event::emit<PlayerRoundSettled>(v78);
                v69 = v69 + 1;
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
        abort 0
    }

    entry fun settle_entry_v2(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        settle(arg0, arg1, arg2, arg3);
    }

    public entry fun share_global_entry(arg0: Global) {
        abort 0
    }

    public entry fun snapshot_radiance_entry(arg0: &Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun snapshot_radiance_entry_v2(arg0: &GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::emit_radiance_snapshot(&arg0.cap, &arg0.idx, &arg0.buckets, arg1);
    }

    fun soul_age_multiplier_bps_for_user(arg0: &GlobalV2, arg1: address) : u64 {
        let v0 = get_soul_age_v2(arg0, arg1);
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
        abort 0
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
        abort 0
    }

    public entry fun withdraw_faith_cron_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminFaithggWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminFaithggWithdrawEvent>(v1);
    }

    public entry fun withdraw_faithgg_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_faithgg_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        assert!(arg0.paused, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminFaithggWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminFaithggWithdrawEvent>(v0);
    }

    public entry fun withdraw_manifest_cron_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_manifest_cron_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminManifestWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v1);
    }

    public entry fun withdraw_manifest_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_manifest_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        assert!(arg0.paused, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOT_PAUSED());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_manifest_buyback(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminManifestWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

