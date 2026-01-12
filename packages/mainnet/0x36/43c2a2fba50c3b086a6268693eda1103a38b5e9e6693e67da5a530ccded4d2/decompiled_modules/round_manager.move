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

    struct FaithTreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SeasonPassRewardsVaultKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SeasonPassKey has copy, drop, store {
        season: u64,
        user: address,
    }

    struct SeasonPausedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SeasonAwardPaidKey has copy, drop, store {
        season: u64,
        recipient: address,
        asset_kind: u8,
        source: u8,
    }

    struct SeasonAwardPaidValue has store {
        amount: u64,
        ts_ms: u64,
    }

    struct SeasonPassValue has store {
        tier: u8,
        buff_bps: u64,
        purchased_at_ms: u64,
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

    struct SeasonPassPurchasedEvent has copy, drop {
        season_index: u64,
        user: address,
        tier: u8,
        paid_faith_atoms: u64,
        buff_bps: u64,
        ts_ms: u64,
    }

    struct SeasonPassRewardsWithdrawnEvent has copy, drop {
        admin: address,
        amount: u64,
        ts_ms: u64,
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

    public entry fun add_faith_treasury_cap_to_global_v2_entry(arg0: &mut GlobalV2, arg1: 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>) {
        abort 0
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

    fun assert_not_paid_yet(arg0: &GlobalV2, arg1: SeasonAwardPaidKey) {
        assert!(!0x2::dynamic_field::exists_<SeasonAwardPaidKey>(&arg0.id, arg1), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_ALREADY_CLAIMED());
    }

    fun assert_version_v2(arg0: &GlobalV2) {
        assert!(arg0.version == 7, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_VERSION());
    }

    public fun burn_faith(arg0: &mut GlobalV2, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>) : u64 {
        0x2::coin::burn<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(faith_treasury_cap_mut(arg0), arg1)
    }

    public entry fun buy_season_pass_entry_v2(arg0: &mut GlobalV2, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        assert!(arg0.season_start_ms != 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        assert!(!season_paused(arg0), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_UNAUTH());
        let v0 = season_pass_price_atoms(arg3);
        let v1 = season_pass_buff_bps(arg3);
        assert!(v0 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = arg0.season_index;
        let v4 = SeasonPassKey{
            season : v3,
            user   : v2,
        };
        let v5 = 0;
        let v6 = 0;
        if (0x2::dynamic_field::exists_<SeasonPassKey>(&arg0.id, v4)) {
            let v7 = 0x2::dynamic_field::borrow<SeasonPassKey, SeasonPassValue>(&arg0.id, v4).tier;
            v5 = v7;
            v6 = season_pass_price_atoms(v7);
        };
        assert!(arg3 > v5, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v8 = v0 - v6;
        let v9 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg2);
        assert!(v9 >= v8, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INSUFFICIENT_BAL());
        let v10 = if (v9 == v8) {
            arg2
        } else {
            if (0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg2) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(arg2, v2);
            } else {
                0x2::coin::destroy_zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg2);
            };
            0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut arg2, v8, arg4)
        };
        let v11 = v8 / 10;
        let v12 = v10;
        let v13 = if (v11 == 0) {
            0x2::coin::zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg4)
        } else {
            0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&mut v12, v11, arg4)
        };
        let v14 = v13;
        if (0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&v14) > 0) {
            deposit_season_pass_rewards_v2(arg0, v14, arg4);
        } else {
            0x2::coin::destroy_zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v14);
        };
        burn_faith(arg0, v12);
        let v15 = 0x2::clock::timestamp_ms(arg1);
        let v16 = SeasonPassValue{
            tier            : arg3,
            buff_bps        : v1,
            purchased_at_ms : v15,
        };
        if (0x2::dynamic_field::exists_<SeasonPassKey>(&arg0.id, v4)) {
            let SeasonPassValue {
                tier            : _,
                buff_bps        : _,
                purchased_at_ms : _,
            } = 0x2::dynamic_field::remove<SeasonPassKey, SeasonPassValue>(&mut arg0.id, v4);
        };
        0x2::dynamic_field::add<SeasonPassKey, SeasonPassValue>(&mut arg0.id, v4, v16);
        let v20 = SeasonPassPurchasedEvent{
            season_index     : v3,
            user             : v2,
            tier             : arg3,
            paid_faith_atoms : v8,
            buff_bps         : v1,
            ts_ms            : v15,
        };
        0x2::event::emit<SeasonPassPurchasedEvent>(v20);
    }

    public entry fun claim_faith_entry(arg0: &mut Global, arg1: &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_faith_entry_v2(arg0: &mut GlobalV2, arg1: &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_faith_entry_v3(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        claim_faith_internal(arg0, v0, arg1);
    }

    fun claim_faith_internal(arg0: &mut GlobalV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = mul_bps(soul_age_multiplier_bps_for_user(arg0, arg1), season_pass_multiplier_bps_for_user_v2(arg0, arg1));
        let v1 = v0;
        if (v0 > 30000) {
            v1 = 30000;
        };
        let v2 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::claim_if_any_with_multiplier_internal(arg1, 1500, v1, &mut arg0.cap, &mut arg0.idx, &mut arg0.buckets);
        if (v2 > 0) {
            let v3 = faith_treasury_cap_mut(arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::mint<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v3, v2, arg2), arg1);
            if (0x2::table::contains<address, PlayerRecord>(&arg0.player_records, arg1)) {
                let v4 = 0x2::table::borrow_mut<address, PlayerRecord>(&mut arg0.player_records, arg1);
                v4.soul_age_rounds = 0;
                v4.soul_start_round = arg0.round.index;
            };
        };
        v2
    }

    public entry fun claim_sui_entry(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_sui_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
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
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v0, arg2), arg1);
        };
        v0
    }

    public entry fun create_global_shared(arg0: address, arg1: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::SupplyCap, arg2: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::RadianceIndex, arg3: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun deposit_season_pass_rewards_v2(arg0: &mut GlobalV2, arg1: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(arg1);
            return
        };
        let v0 = SeasonPassRewardsVaultKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<SeasonPassRewardsVaultKey>(&arg0.id, v0)) {
            let v1 = SeasonPassRewardsVaultKey{dummy_field: false};
            0x2::dynamic_object_field::add<SeasonPassRewardsVaultKey, 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&mut arg0.id, v1, arg1);
            return
        };
        let v2 = SeasonPassRewardsVaultKey{dummy_field: false};
        0x2::coin::join<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(0x2::dynamic_object_field::borrow_mut<SeasonPassRewardsVaultKey, 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&mut arg0.id, v2), arg1);
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

    fun enter(arg0: &mut GlobalV2, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
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
        if (v2 < 10000000) {
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

    entry fun enter_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        enter(arg0, arg1, arg2, arg3);
    }

    fun faith_treasury_cap_mut(arg0: &mut GlobalV2) : &mut 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH> {
        let v0 = FaithTreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<FaithTreasuryCapKey, 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&mut arg0.id, v0)
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

    fun mark_paid(arg0: &mut GlobalV2, arg1: SeasonAwardPaidKey, arg2: u64, arg3: u64) {
        let v0 = SeasonAwardPaidValue{
            amount : arg2,
            ts_ms  : arg3,
        };
        0x2::dynamic_field::add<SeasonAwardPaidKey, SeasonAwardPaidValue>(&mut arg0.id, arg1, v0);
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
        0x1::vector::reverse<u64>(&mut arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg3)) {
            v1 = 0x1::vector::pop_back<u64>(&mut arg3) + v1;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        if (v1 == 0) {
            return
        };
        let v3 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v1, arg5);
        0x1::vector::reverse<address>(&mut arg2);
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<address>(&arg2), 13906837584547414015);
        0x1::vector::reverse<u64>(&mut arg3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg3)) {
            let v5 = 0x1::vector::pop_back<u64>(&mut arg3);
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v5, arg5), 0x1::vector::pop_back<address>(&mut arg2));
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::destroy_empty<address>(arg2);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        let v6 = MissedRoundRefundEvent{
            round_index          : arg1,
            total_refunded_atoms : v1,
            ts_ms                : arg4,
        };
        0x2::event::emit<MissedRoundRefundEvent>(v6);
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / 10000) as u64)
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
        abort 0
    }

    public entry fun roll_season_entry_v3(arg0: &mut GlobalV2, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        assert!(arg0.season_start_ms != 0, 13906836940302319615);
        assert!(arg0.paused || season_paused(arg0), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_UNAUTH());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.season_start_ms + arg0.season_length_ms) {
            return
        };
        let v1 = SeasonClosed{
            index         : arg0.season_index,
            started_at_ms : arg0.season_start_ms,
            ended_at_ms   : v0,
        };
        0x2::event::emit<SeasonClosed>(v1);
        arg0.season_index = arg0.season_index + 1;
        arg0.season_start_ms = v0;
        let v2 = SeasonOpened{
            index        : arg0.season_index,
            starts_at_ms : v0,
            ends_at_ms   : v0 + arg0.season_length_ms,
        };
        0x2::event::emit<SeasonOpened>(v2);
    }

    public entry fun season_award_sui_from_pilgrimage_entry(arg0: &mut Global, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun season_award_sui_from_pilgrimage_entry_v2(arg0: &mut GlobalV2, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun season_award_sui_from_pilgrimage_entry_v3(arg0: &mut GlobalV2, arg1: &0x2::clock::Clock, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert_version_v2(arg0);
        assert!(arg3 > 0, 13906837240950030335);
        let v0 = SeasonAwardPaidKey{
            season     : arg0.season_index,
            recipient  : arg2,
            asset_kind : 0,
            source     : 2,
        };
        assert_not_paid_yet(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_ops_internal(&mut arg0.vaults, arg3, arg4), arg2);
        mark_paid(arg0, v0, arg3, 0x2::clock::timestamp_ms(arg1));
        let v1 = SeasonAwarded{
            season_index : arg0.season_index,
            recipient    : arg2,
            amount       : arg3,
            asset_kind   : 0,
            source       : 2,
        };
        0x2::event::emit<SeasonAwarded>(v1);
    }

    fun season_pass_buff_bps(arg0: u8) : u64 {
        if (arg0 == 1) {
            11000
        } else if (arg0 == 2) {
            12000
        } else if (arg0 == 3) {
            13000
        } else {
            10000
        }
    }

    public fun season_pass_multiplier_bps_for_user_v2(arg0: &GlobalV2, arg1: address) : u64 {
        if (arg0.season_start_ms == 0 || season_paused(arg0)) {
            return 10000
        };
        let v0 = SeasonPassKey{
            season : arg0.season_index,
            user   : arg1,
        };
        if (!0x2::dynamic_field::exists_<SeasonPassKey>(&arg0.id, v0)) {
            return 10000
        };
        0x2::dynamic_field::borrow<SeasonPassKey, SeasonPassValue>(&arg0.id, v0).buff_bps
    }

    fun season_pass_price_atoms(arg0: u8) : u64 {
        if (arg0 == 1) {
            3000000000000
        } else if (arg0 == 2) {
            5000000000000
        } else if (arg0 == 3) {
            10000000000000
        } else {
            0
        }
    }

    fun season_pass_rewards_balance_v2(arg0: &GlobalV2) : u64 {
        let v0 = SeasonPassRewardsVaultKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<SeasonPassRewardsVaultKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = SeasonPassRewardsVaultKey{dummy_field: false};
        0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(0x2::dynamic_object_field::borrow<SeasonPassRewardsVaultKey, 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&arg0.id, v1))
    }

    public fun season_pass_rewards_balance_view_v2(arg0: &GlobalV2) : u64 {
        season_pass_rewards_balance_v2(arg0)
    }

    fun season_paused(arg0: &GlobalV2) : bool {
        let v0 = SeasonPausedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<SeasonPausedKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = SeasonPausedKey{dummy_field: false};
        *0x2::dynamic_field::borrow<SeasonPausedKey, bool>(&arg0.id, v1)
    }

    public fun season_time_remaining(arg0: &Global, arg1: u64) : u64 {
        abort 0
    }

    public fun season_time_remaining_v2(arg0: &GlobalV2, arg1: u64) : u64 {
        abort 0
    }

    public fun season_time_remaining_v3(arg0: &GlobalV2, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.season_start_ms + arg0.season_length_ms;
        if (arg0.season_start_ms == 0 || v0 >= v1) {
            return 0
        };
        v1 - v0
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
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::set_split_internal(&mut arg0.fee_split, arg1, arg2, arg3, arg4);
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

    public entry fun set_season_paused_entry_v2(arg0: &mut GlobalV2, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = SeasonPausedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<SeasonPausedKey>(&arg0.id, v0)) {
            let v1 = SeasonPausedKey{dummy_field: false};
            0x2::dynamic_field::add<SeasonPausedKey, bool>(&mut arg0.id, v1, arg1);
        } else {
            let v2 = SeasonPausedKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SeasonPausedKey, bool>(&mut arg0.id, v2) = arg1;
        };
    }

    public entry fun set_version_entry_v2(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert!(arg0.version <= 7, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_VERSION());
        arg0.version = 7;
    }

    fun settle(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.round.phase != 1) {
            return
        };
        let v0 = vector[];
        let v1 = vector[];
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
        let v5 = 0x2::random::generate_u64(&mut v4) % 25;
        let v6 = arg0.round.total;
        let v7 = v6 / 10;
        let v8 = v6 - v7;
        let v9 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v5);
        let v10 = 0x1::vector::length<Entry>(v9);
        if (v10 > 0 && v8 > 0) {
            let v11 = sum_block(*v9);
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
                        let v21 = (((v14 as u256) * (3000 as u256) / 10000) as u64);
                        if (v21 > 0) {
                            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v13.owner, v21, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                    };
                    v12 = v12 + 1;
                };
            };
        };
        if (v7 > 0) {
            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::split_and_route_internal(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v7, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::accrue_internal(&mut arg0.miracle);
        let v22 = false;
        let v23 = 0;
        let v24 = 0;
        let v25 = 0;
        let v26 = 0;
        if (v10 > 0) {
            let (v27, v28, v29, v30, v31) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::maybe_trigger_internal(&mut arg0.miracle, 0x2::random::generate_u64(&mut v4));
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
                let v36 = (((v35.amount as u256) * (soul_age_multiplier_bps_for_user(arg0, v35.owner) as u256) / 10000) as u128);
                let v37 = if (v36 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    (v36 as u64)
                };
                v33 = v33 + v37;
                v34 = v34 + 1;
            };
            if (v33 > 0) {
                let v38 = v23;
                let v39 = 0;
                while (v39 < v10 && v38 > 0) {
                    let v40 = *0x1::vector::borrow<Entry>(v9, v39);
                    let v41 = (((v40.amount as u256) * (soul_age_multiplier_bps_for_user(arg0, v40.owner) as u256) / 10000) as u128);
                    let v42 = 0;
                    if (v39 == v10 - 1) {
                        v42 = v38;
                    } else if (v41 > 0) {
                        let v43 = (((v23 as u128) * v41 / (v33 as u128)) as u64);
                        let v44 = v43;
                        if (v43 == 0 && v38 > 0) {
                            v44 = 1;
                        };
                        if (v44 > v38) {
                            v44 = v38;
                        };
                        v42 = v44;
                    };
                    if (v42 > 0) {
                        v38 = v38 - v42;
                        let v45 = &mut arg0.player_records;
                        ensure_record(v45, v40.owner, arg0.round.index);
                        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v40.owner, v42, &arg0.idx, &mut arg0.buckets, arg3);
                    };
                    v39 = v39 + 1;
                };
            };
            let v46 = MiracleHitEvent{
                round_index        : arg0.round.index,
                payout_faith_atoms : v23,
                drought_tests      : v24,
                staircase_phase    : v25,
                new_odds           : v26,
            };
            0x2::event::emit<MiracleHitEvent>(v46);
        } else if (v10 > 0) {
            let v47 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::pilgrimage_balance(&arg0.vaults);
            if (v47 > 0) {
                let v48 = v47 / 50;
                let v49 = v48;
                if (v48 == 0) {
                    v49 = 1;
                };
                let v50 = sum_block(*v9);
                if (v50 > 0) {
                    let v51 = 0;
                    let v52 = v49;
                    let v53 = 0;
                    while (v53 < v10 && v52 > 0) {
                        let v54 = *0x1::vector::borrow<Entry>(v9, v53);
                        let v55;
                        let v56 = if (v53 == v10 - 1) {
                            v52
                        } else {
                            let v57 = (((v49 as u128) * (v54.amount as u128) / (v50 as u128)) as u64);
                            v55 = v57;
                            if (v57 == 0 && v52 > 0) {
                                v55 = 1;
                            };
                            if (v55 > v52) {
                                v55 = v52;
                            };
                            v55
                        };
                        if (v56 > 0) {
                            v52 = v52 - v56;
                            v51 = v51 + v55;
                            let v58 = &mut arg0.player_records;
                            let v59 = ensure_record(v58, v54.owner, arg0.round.index);
                            v59.unclaimed_sui = v59.unclaimed_sui + v55;
                            let v60 = &mut v0;
                            let v61 = &mut v1;
                            add_sui_delta(v60, v61, v54.owner, v55);
                        };
                        v53 = v53 + 1;
                    };
                    if (v51 > 0) {
                        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_faithgg(&mut arg0.vaults, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_pilgrimage_internal(&mut arg0.vaults, v51, arg3));
                    };
                    let v62 = PilgrimageDripEvent{
                        round_index   : arg0.round.index,
                        drip_atoms    : v51,
                        drought_tests : v24,
                    };
                    0x2::event::emit<PilgrimageDripEvent>(v62);
                };
            };
        };
        if (arg0.round.total > 0) {
            let v63 = vector[];
            let v64 = vector[];
            let v65 = 0;
            while (v65 < 25) {
                let v66 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v65);
                let v67 = 0;
                while (v67 < 0x1::vector::length<Entry>(v66)) {
                    let v68 = *0x1::vector::borrow<Entry>(v66, v67);
                    let v69 = &mut v63;
                    let v70 = &mut v64;
                    add_sui_delta(v69, v70, v68.owner, v68.amount);
                    v67 = v67 + 1;
                };
                v65 = v65 + 1;
            };
            let v71 = 0;
            while (v71 < 0x1::vector::length<address>(&v63)) {
                let v72 = *0x1::vector::borrow<address>(&v63, v71);
                let v73 = &mut arg0.player_records;
                let v74 = ensure_record(v73, v72, arg0.round.index).unclaimed_sui;
                let v75 = get_sui_delta(&v0, &v1, v72);
                let v76 = if (v74 >= v75) {
                    v74 - v75
                } else {
                    0
                };
                let (_, _, v79) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::preview_refinement_internal(v72, &arg0.idx, &arg0.buckets, 1500);
                let v80 = PlayerRoundSettled{
                    round_index                : arg0.round.index,
                    player                     : v72,
                    sui_deployed_atoms         : *0x1::vector::borrow<u64>(&v64, v71),
                    sui_won_atoms              : v75,
                    unclaimed_sui_before_atoms : v76,
                    unclaimed_sui_after_atoms  : v74,
                    unclaimed_faith_atoms      : v79,
                    had_miracle                : v22,
                    ts_ms                      : arg2,
                };
                0x2::event::emit<PlayerRoundSettled>(v80);
                v71 = v71 + 1;
            };
        };
        arg0.round.phase = 0;
        let v81 = RoundSettled{
            index         : arg0.round.index,
            winning       : v5,
            fee           : v7,
            redistributed : v8,
        };
        0x2::event::emit<RoundSettled>(v81);
    }

    public entry fun settle_entry(arg0: &mut Global, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun settle_entry_v2(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        settle(arg0, arg1, arg2, arg3);
    }

    public entry fun settle_random_entry_v2(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        settle_with_winning_block_v2(arg0, 0x2::random::generate_u64(&mut v0) % 25, arg2, arg3);
    }

    fun settle_with_winning_block_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 % 25;
        if (arg0.round.phase != 1) {
            return
        };
        let v1 = arg0.round.closes_at_ms;
        if (arg2 < v1) {
            return
        };
        if (arg2 > v1 + 600000) {
            arg0.round.phase = 0;
            let v2 = RoundMissed{
                index         : arg0.round.index,
                closes_at_ms  : v1,
                settled_at_ms : arg2,
                total         : arg0.round.total,
            };
            0x2::event::emit<RoundMissed>(v2);
            return
        };
        arg0.round.phase = 2;
        let v3 = arg0.round.total;
        let v4 = v3 / 10;
        let v5 = v3 - v4;
        let v6 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v0);
        let v7 = 0x1::vector::length<Entry>(v6);
        if (v7 > 0 && v5 > 0) {
            let v8 = sum_block(*v6);
            if (v8 > 0) {
                let v9 = 0;
                while (v9 < v7 && v5 > 0) {
                    let v10 = *0x1::vector::borrow<Entry>(v6, v9);
                    let v11;
                    let v12 = if (v9 == v7 - 1) {
                        v5
                    } else {
                        let v13 = (((((v5 as u128) as u256) * ((v10.amount as u128) as u256) / ((v8 as u128) as u256)) as u128) as u64);
                        v11 = v13;
                        if (v13 == 0 && v5 > 0) {
                            v11 = 1;
                        };
                        if (v11 > v5) {
                            v11 = v5;
                        };
                        v11
                    };
                    if (v12 > 0) {
                        v5 = v5 - v12;
                        let v14 = &mut arg0.player_records;
                        let v15 = ensure_record(v14, v10.owner, arg0.round.index);
                        v15.unclaimed_sui = v15.unclaimed_sui + v11;
                        v15.total_wins = v15.total_wins + 1;
                        let v16 = (((v11 as u256) * (3000 as u256) / 10000) as u64);
                        if (v16 > 0) {
                            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v10.owner, v16, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                    };
                    v9 = v9 + 1;
                };
            };
        };
        if (v4 > 0) {
            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::split_and_route_internal(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v4, arg3), &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        arg0.round.phase = 0;
        let v17 = RoundSettled{
            index         : arg0.round.index,
            winning       : v0,
            fee           : v4,
            redistributed : v5,
        };
        0x2::event::emit<RoundSettled>(v17);
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
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::emit_radiance_snapshot_internal(&arg0.cap, &arg0.idx, &arg0.buckets, arg1);
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

    public entry fun start_seasons_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        assert!(arg0.paused, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOT_PAUSED());
        assert!(arg0.season_start_ms == 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = if (arg2 == 0) {
            2592000000
        } else {
            arg2
        };
        arg0.season_index = 1;
        arg0.season_start_ms = arg1;
        arg0.season_length_ms = v0;
        let v1 = SeasonOpened{
            index        : arg0.season_index,
            starts_at_ms : arg1,
            ends_at_ms   : arg1 + v0,
        };
        0x2::event::emit<SeasonOpened>(v1);
    }

    public entry fun stop_seasons_entry_v2(arg0: &mut GlobalV2, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        assert!(arg0.paused, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOT_PAUSED());
        assert!(arg0.season_start_ms != 0, 13906836785683496959);
        let v0 = SeasonClosed{
            index         : arg0.season_index,
            started_at_ms : arg0.season_start_ms,
            ended_at_ms   : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SeasonClosed>(v0);
        arg0.season_start_ms = 0;
    }

    fun sum_block(arg0: vector<Entry>) : u64 {
        let v0 = 0;
        0x1::vector::reverse<Entry>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Entry>(&arg0)) {
            let v2 = 0x1::vector::pop_back<Entry>(&mut arg0);
            v0 = v0 + v2.amount;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<Entry>(arg0);
        v0
    }

    public entry fun withdraw_all_season_pass_rewards_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = SeasonPassRewardsVaultKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<SeasonPassRewardsVaultKey>(&arg0.id, v0)) {
            return
        };
        let v1 = SeasonPassRewardsVaultKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::borrow_mut<SeasonPassRewardsVaultKey, 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&mut arg0.id, v1);
        let v3 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v2);
        if (v3 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v2, v3, arg2), 0x2::tx_context::sender(arg2));
        let v4 = SeasonPassRewardsWithdrawnEvent{
            admin  : 0x2::tx_context::sender(arg2),
            amount : v3,
            ts_ms  : arg1,
        };
        0x2::event::emit<SeasonPassRewardsWithdrawnEvent>(v4);
    }

    public entry fun withdraw_faith_cron_entry(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun withdraw_faith_cron_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, arg1, arg2), v0);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, arg2, arg3), arg1);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_manifest_buyback_internal(&mut arg0.vaults, arg1, arg2), v0);
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
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_manifest_buyback_internal(&mut arg0.vaults, arg2, arg3), arg1);
        let v0 = AdminManifestWithdrawEvent{
            admin  : 0x2::tx_context::sender(arg3),
            to     : arg1,
            amount : arg2,
        };
        0x2::event::emit<AdminManifestWithdrawEvent>(v0);
    }

    public entry fun withdraw_season_pass_rewards_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        assert!(arg1 > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = SeasonPassRewardsVaultKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<SeasonPassRewardsVaultKey>(&arg0.id, v0), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INSUFFICIENT_BAL());
        let v1 = SeasonPassRewardsVaultKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::borrow_mut<SeasonPassRewardsVaultKey, 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&mut arg0.id, v1);
        assert!(0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v2) >= arg1, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INSUFFICIENT_BAL());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(0x2::coin::split<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(v2, arg1, arg3), 0x2::tx_context::sender(arg3));
        let v3 = SeasonPassRewardsWithdrawnEvent{
            admin  : 0x2::tx_context::sender(arg3),
            amount : arg1,
            ts_ms  : arg2,
        };
        0x2::event::emit<SeasonPassRewardsWithdrawnEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

