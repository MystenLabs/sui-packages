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

    struct AutoRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AutoRegistry has store {
        configs: 0x2::table::Table<address, AutoConfig>,
        index: vector<address>,
        auto_fee_bps: u64,
    }

    struct AutoConfig has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        per_round_mist: u64,
        strategy: u8,
        blocks: vector<u64>,
        rounds_remaining: u64,
        min_balance_stop: u64,
        last_entered_round: u64,
    }

    struct PlannedAutoEntry has copy, drop {
        owner: address,
        block_id: u64,
        amount: u64,
    }

    struct AutoDeposited has copy, drop {
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct AutoWithdrawn has copy, drop {
        owner: address,
        amount: u64,
        new_balance: u64,
    }

    struct AutoConfigured has copy, drop {
        owner: address,
        per_round_mist: u64,
        strategy: u8,
        blocks: vector<u64>,
        rounds_remaining: u64,
        min_balance_stop: u64,
    }

    struct AutoStopped has copy, drop {
        owner: address,
    }

    struct AutoCranked has copy, drop {
        round_index: u64,
        start: u64,
        count: u64,
        entered_configs: u64,
        skipped_configs: u64,
        total_stake_atoms: u64,
        fee_atoms: u64,
    }

    struct AutoFeeUpdated has copy, drop {
        admin: address,
        auto_fee_bps: u64,
    }

    struct RaptureKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Rapture has store {
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_share_bps: u64,
        odds: u64,
    }

    struct RaptureFired has copy, drop {
        round_index: u64,
        pot_atoms: u64,
        winner_count: u64,
    }

    struct RaptureConfigUpdated has copy, drop {
        admin: address,
        fee_share_bps: u64,
        odds: u64,
    }

    struct EmissionCfgKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EmissionCfg has store {
        rate_bps: u64,
    }

    struct EmissionRateUpdated has copy, drop {
        admin: address,
        rate_bps: u64,
    }

    struct BlessedHoursKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BlessedHours has store {
        start_ms: u64,
        end_ms: u64,
        bonus_per_test: u64,
        budget: u64,
    }

    struct BlessedHourSet has copy, drop {
        admin: address,
        start_ms: u64,
        end_ms: u64,
        bonus_per_test: u64,
        budget: u64,
    }

    struct BlessedDrop has copy, drop {
        round_index: u64,
        amount: u64,
        winner_take_all: bool,
        winner: address,
        winner_count: u64,
    }

    struct PilgrimageSwept has copy, drop {
        admin: address,
        amount: u64,
    }

    struct AdminOpsWithdrawEvent has copy, drop {
        admin: address,
        to: address,
        amount: u64,
    }

    struct BatchCreditPaidKey has copy, drop, store {
        batch_key: vector<u8>,
    }

    struct BatchCredited has copy, drop {
        batch_key: vector<u8>,
        total_atoms: u64,
        recipient_count: u64,
    }

    fun accrue_emission_all_entrants(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.id;
        let v1 = ensure_emission_cfg(v0).rate_bps;
        if (v1 == 0) {
            return
        };
        let v2 = 0;
        while (v2 < 25) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<Entry>(0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v2))) {
                let v4 = *0x1::vector::borrow<Entry>(0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v2), v3);
                let v5 = (((v4.amount as u256) * (v1 as u256) / 10000) as u64);
                if (v5 > 0) {
                    0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v4.owner, v5, &arg0.idx, &mut arg0.buckets, arg1);
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
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
        assert!(arg0.version == 10, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_VERSION());
    }

    public fun auto_config_view_v2(arg0: &GlobalV2, arg1: address) : (bool, u64, u64, u8, u64, u64, u64) {
        let v0 = AutoRegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<AutoRegistryKey>(&arg0.id, v0)) {
            return (false, 0, 0, 0, 0, 0, 0)
        };
        let v1 = AutoRegistryKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<AutoRegistryKey, AutoRegistry>(&arg0.id, v1);
        if (!0x2::table::contains<address, AutoConfig>(&v2.configs, arg1)) {
            return (false, 0, 0, 0, 0, 0, 0)
        };
        let v3 = 0x2::table::borrow<address, AutoConfig>(&v2.configs, arg1);
        (true, 0x2::balance::value<0x2::sui::SUI>(&v3.balance), v3.per_round_mist, v3.strategy, v3.rounds_remaining, v3.min_balance_stop, v3.last_entered_round)
    }

    entry fun auto_configure_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u8, arg3: vector<u64>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        assert!(arg2 <= 2, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        if (arg2 == 0) {
            assert!(0x1::vector::length<u64>(&arg3) > 0 && 0x1::vector::length<u64>(&arg3) <= 25, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
            let v0 = &arg3;
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(v0)) {
                assert!(*0x1::vector::borrow<u64>(v0, v1) < 25, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_BAD_BLOCK());
                v1 = v1 + 1;
            };
        } else {
            assert!(0x1::vector::is_empty<u64>(&arg3), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        };
        assert!(arg1 >= 10000000 * auto_portion_count(arg2, &arg3), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = ensure_auto_registry(arg0, arg6);
        let v4 = ensure_auto_config(v3, v2);
        v4.per_round_mist = arg1;
        v4.strategy = arg2;
        v4.blocks = arg3;
        v4.rounds_remaining = arg4;
        v4.min_balance_stop = arg5;
        let v5 = AutoConfigured{
            owner            : v2,
            per_round_mist   : arg1,
            strategy         : arg2,
            blocks           : arg3,
            rounds_remaining : arg4,
            min_balance_stop : arg5,
        };
        0x2::event::emit<AutoConfigured>(v5);
    }

    entry fun auto_deposit_entry_v2(arg0: &mut GlobalV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ensure_auto_registry(arg0, arg2);
        let v2 = ensure_auto_config(v1, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = AutoDeposited{
            owner       : v0,
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&v2.balance),
        };
        0x2::event::emit<AutoDeposited>(v3);
    }

    fun auto_portion_count(arg0: u8, arg1: &vector<u64>) : u64 {
        if (arg0 == 0) {
            0x1::vector::length<u64>(arg1)
        } else if (arg0 == 1) {
            1
        } else {
            25
        }
    }

    public fun auto_registry_view_v2(arg0: &GlobalV2) : (u64, u64) {
        let v0 = AutoRegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<AutoRegistryKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = AutoRegistryKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<AutoRegistryKey, AutoRegistry>(&arg0.id, v1);
        (0x1::vector::length<address>(&v2.index), v2.auto_fee_bps)
    }

    entry fun auto_stop_entry_v2(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = ensure_auto_registry(arg0, arg1);
        assert!(0x2::table::contains<address, AutoConfig>(&v1.configs, v0), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
        0x2::table::borrow_mut<address, AutoConfig>(&mut v1.configs, v0).rounds_remaining = 0;
        let v2 = AutoStopped{owner: v0};
        0x2::event::emit<AutoStopped>(v2);
    }

    entry fun auto_withdraw_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ensure_auto_registry(arg0, arg2);
        assert!(0x2::table::contains<address, AutoConfig>(&v1.configs, v0), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_NOTHING_TO_CLAIM());
        let v2 = 0x2::table::borrow_mut<address, AutoConfig>(&mut v1.configs, v0);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2.balance);
        let v4 = if (arg1 == 0) {
            v3
        } else {
            arg1
        };
        assert!(v4 > 0 && v4 <= v3, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INSUFFICIENT_BAL());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2.balance, v4), arg2), v0);
        let v5 = AutoWithdrawn{
            owner       : v0,
            amount      : v4,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&v2.balance),
        };
        0x2::event::emit<AutoWithdrawn>(v5);
    }

    public fun blessed_hours_view_v2(arg0: &GlobalV2) : (u64, u64, u64, u64) {
        let v0 = BlessedHoursKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BlessedHoursKey>(&arg0.id, v0)) {
            return (0, 0, 0, 0)
        };
        let v1 = BlessedHoursKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<BlessedHoursKey, BlessedHours>(&arg0.id, v1);
        (v2.start_ms, v2.end_ms, v2.bonus_per_test, v2.budget)
    }

    public entry fun bootstrap_global_v2_entry(arg0: u64, arg1: u64, arg2: u64, arg3: 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::create(arg4);
        let (v2, v3, v4) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::create_internal(arg0, arg4);
        let v5 = Round{
            id           : 0x2::object::new(arg4),
            index        : 0,
            phase        : 0,
            closes_at_ms : 0,
            entries      : empty_entries(),
            total        : 0,
        };
        let v6 = GlobalV2{
            id               : 0x2::object::new(arg4),
            admin            : 0x2::tx_context::sender(arg4),
            version          : 10,
            round            : v5,
            paused           : false,
            fee_split        : v0,
            vaults           : v1,
            cap              : v2,
            idx              : v3,
            buckets          : v4,
            miracle          : 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::t_create(arg1, arg2, arg4),
            player_records   : 0x2::table::new<address, PlayerRecord>(arg4),
            season_index     : 0,
            season_start_ms  : 0,
            season_length_ms : 2592000000,
        };
        let v7 = FaithTreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<FaithTreasuryCapKey, 0x2::coin::TreasuryCap<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>>(&mut v6.id, v7, arg3);
        0x2::transfer::share_object<GlobalV2>(v6);
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

    entry fun crank_auto_entries_v2(arg0: &mut GlobalV2, arg1: &0x2::random::Random, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        let v0 = if (arg0.paused) {
            true
        } else if (arg0.round.phase != 1) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return
        };
        let v1 = AutoRegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<AutoRegistryKey>(&arg0.id, v1)) {
            return
        };
        let v2 = arg0.round.index;
        let v3 = 0x2::random::new_generator(arg1, arg4);
        let v4 = 0x1::vector::empty<PlannedAutoEntry>();
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        let v6 = 0x2::balance::zero<0x2::sui::SUI>();
        let v7 = 0;
        let v8 = 0;
        let v9 = AutoRegistryKey{dummy_field: false};
        let v10 = 0x2::dynamic_field::borrow_mut<AutoRegistryKey, AutoRegistry>(&mut arg0.id, v9);
        let v11 = 0x1::vector::length<address>(&v10.index);
        let v12 = if (arg2 >= v11) {
            arg2
        } else if (arg3 >= v11 - arg2) {
            v11
        } else {
            arg2 + arg3
        };
        while (arg2 < v12) {
            let v13 = *0x1::vector::borrow<address>(&v10.index, arg2);
            arg2 = arg2 + 1;
            let v14 = 0x2::table::borrow_mut<address, AutoConfig>(&mut v10.configs, v13);
            let v15 = 0x2::balance::value<0x2::sui::SUI>(&v14.balance);
            let v16 = if (v14.rounds_remaining == 0) {
                true
            } else if (v14.last_entered_round == v2) {
                true
            } else if (v14.per_round_mist == 0) {
                true
            } else if (v15 < v14.per_round_mist) {
                true
            } else {
                v15 < v14.min_balance_stop
            };
            if (v16) {
                v8 = v8 + 1;
                continue
            };
            let v17 = (((v14.per_round_mist as u256) * (v10.auto_fee_bps as u256) / 10000) as u64);
            let v18 = v14.per_round_mist - v17;
            let v19 = v18 / auto_portion_count(v14.strategy, &v14.blocks);
            if (v19 < 10000000) {
                v8 = v8 + 1;
                continue
            };
            if (v14.strategy == 1) {
                let v20 = PlannedAutoEntry{
                    owner    : v13,
                    block_id : 0x2::random::generate_u64(&mut v3) % 25,
                    amount   : v18,
                };
                0x1::vector::push_back<PlannedAutoEntry>(&mut v4, v20);
            } else if (v14.strategy == 0) {
                let v21 = 0x1::vector::length<u64>(&v14.blocks);
                let v22 = 0;
                while (v22 < v21) {
                    let v23 = if (v22 == v21 - 1) {
                        v18 - v19 * (v21 - 1)
                    } else {
                        v19
                    };
                    let v24 = PlannedAutoEntry{
                        owner    : v13,
                        block_id : *0x1::vector::borrow<u64>(&v14.blocks, v22),
                        amount   : v23,
                    };
                    0x1::vector::push_back<PlannedAutoEntry>(&mut v4, v24);
                    v22 = v22 + 1;
                };
            } else {
                let v25 = 0;
                while (v25 < 25) {
                    let v26 = if (v25 == 25 - 1) {
                        v18 - v19 * (25 - 1)
                    } else {
                        v19
                    };
                    let v27 = PlannedAutoEntry{
                        owner    : v13,
                        block_id : v25,
                        amount   : v26,
                    };
                    0x1::vector::push_back<PlannedAutoEntry>(&mut v4, v27);
                    v25 = v25 + 1;
                };
            };
            if (v17 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut v6, 0x2::balance::split<0x2::sui::SUI>(&mut v14.balance, v17));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::balance::split<0x2::sui::SUI>(&mut v14.balance, v18));
            v14.last_entered_round = v2;
            v14.rounds_remaining = v14.rounds_remaining - 1;
            v7 = v7 + 1;
        };
        let v28 = 0x2::balance::value<0x2::sui::SUI>(&v6);
        0x1::vector::reverse<PlannedAutoEntry>(&mut v4);
        let v29 = 0;
        while (v29 < 0x1::vector::length<PlannedAutoEntry>(&v4)) {
            let v30 = 0x1::vector::pop_back<PlannedAutoEntry>(&mut v4);
            enter_for(arg0, v30.owner, v30.block_id, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v30.amount), arg4));
            v29 = v29 + 1;
        };
        0x1::vector::destroy_empty<PlannedAutoEntry>(v4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        if (v28 > 0) {
            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_ops_internal(&mut arg0.vaults, 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        };
        let v31 = AutoCranked{
            round_index       : v2,
            start             : arg2,
            count             : arg3,
            entered_configs   : v7,
            skipped_configs   : v8,
            total_stake_atoms : 0x2::balance::value<0x2::sui::SUI>(&v5),
            fee_atoms         : v28,
        };
        0x2::event::emit<AutoCranked>(v31);
    }

    public entry fun create_global_shared(arg0: address, arg1: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::SupplyCap, arg2: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::RadianceIndex, arg3: 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::Buckets, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun credit_unclaimed_sui_batch_entry_v2(arg0: &mut GlobalV2, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        assert_version_v2(arg0);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 > 0 && v0 == 0x1::vector::length<u64>(&arg4), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        assert!(0x1::vector::length<u8>(&arg1) > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v1 = BatchCreditPaidKey{batch_key: arg1};
        assert!(!0x2::dynamic_field::exists_<BatchCreditPaidKey>(&arg0.id, v1), 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_ALREADY_CLAIMED());
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg4, v3) > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
            v2 = v2 + *0x1::vector::borrow<u64>(&arg4, v3);
            v3 = v3 + 1;
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v2, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_faithgg(&mut arg0.vaults, arg2);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = &mut arg0.player_records;
            let v6 = ensure_record(v5, *0x1::vector::borrow<address>(&arg3, v4), arg0.round.index);
            v6.unclaimed_sui = v6.unclaimed_sui + *0x1::vector::borrow<u64>(&arg4, v4);
            v4 = v4 + 1;
        };
        0x2::dynamic_field::add<BatchCreditPaidKey, bool>(&mut arg0.id, v1, true);
        let v7 = BatchCredited{
            batch_key       : arg1,
            total_atoms     : v2,
            recipient_count : v0,
        };
        0x2::event::emit<BatchCredited>(v7);
    }

    public entry fun deposit_and_route_entry_v2(arg0: &mut GlobalV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::split_and_route_internal(arg1, &arg0.fee_split, &mut arg0.vaults, arg2);
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

    public(friend) fun dev_mint_faith(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH> {
        assert_admin(arg0, arg2);
        0x2::coin::mint<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(faith_treasury_cap_mut(arg0), arg1, arg2)
    }

    public fun emission_rate_view_v2(arg0: &GlobalV2) : u64 {
        let v0 = EmissionCfgKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<EmissionCfgKey>(&arg0.id, v0)) {
            return 10000
        };
        let v1 = EmissionCfgKey{dummy_field: false};
        0x2::dynamic_field::borrow<EmissionCfgKey, EmissionCfg>(&arg0.id, v1).rate_bps
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

    fun ensure_auto_config(arg0: &mut AutoRegistry, arg1: address) : &mut AutoConfig {
        if (!0x2::table::contains<address, AutoConfig>(&arg0.configs, arg1)) {
            let v0 = AutoConfig{
                balance            : 0x2::balance::zero<0x2::sui::SUI>(),
                per_round_mist     : 0,
                strategy           : 0,
                blocks             : vector[],
                rounds_remaining   : 0,
                min_balance_stop   : 0,
                last_entered_round : 0,
            };
            0x2::table::add<address, AutoConfig>(&mut arg0.configs, arg1, v0);
            0x1::vector::push_back<address>(&mut arg0.index, arg1);
        };
        0x2::table::borrow_mut<address, AutoConfig>(&mut arg0.configs, arg1)
    }

    fun ensure_auto_registry(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) : &mut AutoRegistry {
        let v0 = AutoRegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<AutoRegistryKey>(&arg0.id, v0)) {
            let v1 = AutoRegistryKey{dummy_field: false};
            let v2 = AutoRegistry{
                configs      : 0x2::table::new<address, AutoConfig>(arg1),
                index        : vector[],
                auto_fee_bps : 0,
            };
            0x2::dynamic_field::add<AutoRegistryKey, AutoRegistry>(&mut arg0.id, v1, v2);
        };
        let v3 = AutoRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AutoRegistryKey, AutoRegistry>(&mut arg0.id, v3)
    }

    fun ensure_blessed_hours(arg0: &mut 0x2::object::UID) : &mut BlessedHours {
        let v0 = BlessedHoursKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<BlessedHoursKey>(arg0, v0)) {
            let v1 = BlessedHoursKey{dummy_field: false};
            let v2 = BlessedHours{
                start_ms       : 0,
                end_ms         : 0,
                bonus_per_test : 0,
                budget         : 0,
            };
            0x2::dynamic_field::add<BlessedHoursKey, BlessedHours>(arg0, v1, v2);
        };
        let v3 = BlessedHoursKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<BlessedHoursKey, BlessedHours>(arg0, v3)
    }

    fun ensure_emission_cfg(arg0: &mut 0x2::object::UID) : &mut EmissionCfg {
        let v0 = EmissionCfgKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<EmissionCfgKey>(arg0, v0)) {
            let v1 = EmissionCfgKey{dummy_field: false};
            let v2 = EmissionCfg{rate_bps: 10000};
            0x2::dynamic_field::add<EmissionCfgKey, EmissionCfg>(arg0, v1, v2);
        };
        let v3 = EmissionCfgKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<EmissionCfgKey, EmissionCfg>(arg0, v3)
    }

    fun ensure_rapture(arg0: &mut 0x2::object::UID) : &mut Rapture {
        let v0 = RaptureKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<RaptureKey>(arg0, v0)) {
            let v1 = RaptureKey{dummy_field: false};
            let v2 = Rapture{
                pot           : 0x2::balance::zero<0x2::sui::SUI>(),
                fee_share_bps : 0,
                odds          : 2000,
            };
            0x2::dynamic_field::add<RaptureKey, Rapture>(arg0, v1, v2);
        };
        let v3 = RaptureKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RaptureKey, Rapture>(arg0, v3)
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
        let v0 = if (arg0.paused) {
            true
        } else if (arg0.round.phase != 1) {
            true
        } else {
            arg1 >= 25
        };
        if (v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
            return
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) < 10000000) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
            return
        };
        enter_for(arg0, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    public entry fun enter_entry(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun enter_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        enter(arg0, arg1, arg2, arg3);
    }

    fun enter_for(arg0: &mut GlobalV2, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = &mut arg0.player_records;
        let v2 = ensure_record_for_play(v1, arg1, arg0.round.index, v0);
        v2.total_entries = v2.total_entries + 1;
        arg0.round.total = arg0.round.total + v0;
        let v3 = Entry{
            owner  : arg1,
            amount : v0,
        };
        0x1::vector::push_back<Entry>(0x1::vector::borrow_mut<vector<Entry>>(&mut arg0.round.entries, arg2), v3);
        let v4 = EntryAdded{
            index    : arg0.round.index,
            owner    : arg1,
            block_id : arg2,
            amount   : v0,
        };
        0x2::event::emit<EntryAdded>(v4);
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_faithgg(&mut arg0.vaults, arg3);
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

    public entry fun fund_rapture_entry_v2(arg0: &mut GlobalV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version_v2(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = &mut arg0.id;
        0x2::balance::join<0x2::sui::SUI>(&mut ensure_rapture(v0).pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
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
        assert!(0x1::vector::length<u64>(&arg3) == 0x1::vector::length<address>(&arg2), 13906837855130353663);
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

    public fun rapture_view_v2(arg0: &GlobalV2) : (u64, u64, u64) {
        let v0 = RaptureKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<RaptureKey>(&arg0.id, v0)) {
            return (0, 0, 2000)
        };
        let v1 = RaptureKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<RaptureKey, Rapture>(&arg0.id, v1);
        (0x2::balance::value<0x2::sui::SUI>(&v2.pot), v2.fee_share_bps, v2.odds)
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
        assert!(arg0.season_start_ms != 0, 13906837210885259263);
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
        assert!(arg3 > 0, 13906837511532969983);
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

    public entry fun set_auto_fee_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        assert!(arg1 <= 500, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = ensure_auto_registry(arg0, arg2);
        v0.auto_fee_bps = arg1;
        let v1 = AutoFeeUpdated{
            admin        : 0x2::tx_context::sender(arg2),
            auto_fee_bps : arg1,
        };
        0x2::event::emit<AutoFeeUpdated>(v1);
    }

    public entry fun set_blessed_hour_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg5);
        assert_version_v2(arg0);
        assert!(arg2 >= arg1, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        assert!(arg2 - arg1 <= 21600000, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        assert!(arg3 <= 1000000000000, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        assert!(arg4 <= 100000000000000, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = &mut arg0.id;
        let v1 = ensure_blessed_hours(v0);
        v1.start_ms = arg1;
        v1.end_ms = arg2;
        v1.bonus_per_test = arg3;
        v1.budget = arg4;
        let v2 = BlessedHourSet{
            admin          : 0x2::tx_context::sender(arg5),
            start_ms       : arg1,
            end_ms         : arg2,
            bonus_per_test : arg3,
            budget         : arg4,
        };
        0x2::event::emit<BlessedHourSet>(v2);
    }

    public entry fun set_emission_rate_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        assert!(arg1 <= 20000, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = &mut arg0.id;
        ensure_emission_cfg(v0).rate_bps = arg1;
        let v1 = EmissionRateUpdated{
            admin    : 0x2::tx_context::sender(arg2),
            rate_bps : arg1,
        };
        0x2::event::emit<EmissionRateUpdated>(v1);
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

    public entry fun set_rapture_config_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_version_v2(arg0);
        assert!(arg1 <= 3000, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        assert!(arg2 >= 100, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_ARGS());
        let v0 = &mut arg0.id;
        let v1 = ensure_rapture(v0);
        v1.fee_share_bps = arg1;
        v1.odds = arg2;
        let v2 = RaptureConfigUpdated{
            admin         : 0x2::tx_context::sender(arg3),
            fee_share_bps : arg1,
            odds          : arg2,
        };
        0x2::event::emit<RaptureConfigUpdated>(v2);
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
        assert!(arg0.version <= 10, 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::errors::E_INVALID_VERSION());
        arg0.version = 10;
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
                    };
                    v12 = v12 + 1;
                };
            };
        };
        if (v10 == 0 && v8 > 0) {
            let v21 = &mut arg0.id;
            0x2::balance::join<0x2::sui::SUI>(&mut ensure_rapture(v21).pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v8, arg3)));
        };
        if (v7 > 0) {
            let v22 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v7, arg3);
            let v23 = &mut arg0.id;
            let v24 = ensure_rapture(v23);
            if (v24.fee_share_bps > 0) {
                let v25 = (((v7 as u256) * (v24.fee_share_bps as u256) / 10000) as u64);
                if (v25 > 0) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v24.pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v22, v25, arg3)));
                };
            };
            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::split_and_route_internal(v22, &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::accrue_internal(&mut arg0.miracle);
        let v26 = false;
        let v27 = 0;
        let v28 = 0;
        let v29 = 0;
        let v30 = 0;
        if (v10 > 0) {
            let (v31, v32, v33, v34, v35) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::miracle::maybe_trigger_internal(&mut arg0.miracle, 0x2::random::generate_u64(&mut v4));
            v26 = v31;
            v27 = v32;
            v28 = v33;
            v29 = v34;
            v30 = v35;
        };
        let v36 = if (v26) {
            if (v10 > 0) {
                v27 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v36) {
            let v37 = 0;
            let v38 = 0;
            while (v38 < v10) {
                let v39 = *0x1::vector::borrow<Entry>(v9, v38);
                let v40 = (((v39.amount as u256) * (soul_age_multiplier_bps_for_user(arg0, v39.owner) as u256) / 10000) as u128);
                let v41 = if (v40 > 18446744073709551615) {
                    18446744073709551615
                } else {
                    (v40 as u64)
                };
                v37 = v37 + v41;
                v38 = v38 + 1;
            };
            if (v37 > 0) {
                let v42 = v27;
                let v43 = 0;
                while (v43 < v10 && v42 > 0) {
                    let v44 = *0x1::vector::borrow<Entry>(v9, v43);
                    let v45 = (((v44.amount as u256) * (soul_age_multiplier_bps_for_user(arg0, v44.owner) as u256) / 10000) as u128);
                    let v46 = 0;
                    if (v43 == v10 - 1) {
                        v46 = v42;
                    } else if (v45 > 0) {
                        let v47 = (((v27 as u128) * v45 / (v37 as u128)) as u64);
                        let v48 = v47;
                        if (v47 == 0 && v42 > 0) {
                            v48 = 1;
                        };
                        if (v48 > v42) {
                            v48 = v42;
                        };
                        v46 = v48;
                    };
                    if (v46 > 0) {
                        v42 = v42 - v46;
                        let v49 = &mut arg0.player_records;
                        ensure_record(v49, v44.owner, arg0.round.index);
                        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v44.owner, v46, &arg0.idx, &mut arg0.buckets, arg3);
                    };
                    v43 = v43 + 1;
                };
            };
            let v50 = MiracleHitEvent{
                round_index        : arg0.round.index,
                payout_faith_atoms : v27,
                drought_tests      : v28,
                staircase_phase    : v29,
                new_odds           : v30,
            };
            0x2::event::emit<MiracleHitEvent>(v50);
        };
        let v51 = 0;
        if (v10 > 0) {
            let v52 = &mut arg0.id;
            let v53 = ensure_rapture(v52);
            if (0x2::balance::value<0x2::sui::SUI>(&v53.pot) > 0 && 0x2::random::generate_u64(&mut v4) % v53.odds == 0) {
                let v54 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v53.pot);
                v51 = 0x2::balance::value<0x2::sui::SUI>(&v54);
                0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::deposit_to_faithgg(&mut arg0.vaults, 0x2::coin::from_balance<0x2::sui::SUI>(v54, arg3));
            };
        };
        if (v51 > 0) {
            let v55 = sum_block(*v9);
            if (v55 > 0) {
                let v56 = v51;
                let v57 = 0;
                while (v57 < v10 && v56 > 0) {
                    let v58 = *0x1::vector::borrow<Entry>(v9, v57);
                    let v59;
                    let v60 = if (v57 == v10 - 1) {
                        v56
                    } else {
                        let v61 = (((v51 as u128) * (v58.amount as u128) / (v55 as u128)) as u64);
                        v59 = v61;
                        if (v61 == 0 && v56 > 0) {
                            v59 = 1;
                        };
                        if (v59 > v56) {
                            v59 = v56;
                        };
                        v59
                    };
                    if (v60 > 0) {
                        v56 = v56 - v60;
                        let v62 = &mut arg0.player_records;
                        let v63 = ensure_record(v62, v58.owner, arg0.round.index);
                        v63.unclaimed_sui = v63.unclaimed_sui + v59;
                        let v64 = &mut v0;
                        let v65 = &mut v1;
                        add_sui_delta(v64, v65, v58.owner, v59);
                    };
                    v57 = v57 + 1;
                };
            };
            let v66 = RaptureFired{
                round_index  : arg0.round.index,
                pot_atoms    : v51,
                winner_count : v10,
            };
            0x2::event::emit<RaptureFired>(v66);
        };
        if (v10 > 0) {
            let v67 = sum_block(*v9);
            let v68 = if (v67 > 0) {
                let v69 = &mut arg0.id;
                let v70 = ensure_blessed_hours(v69);
                let v71 = if (arg2 >= v70.start_ms) {
                    if (arg2 < v70.end_ms) {
                        if (v70.bonus_per_test > 0) {
                            v70.budget >= v70.bonus_per_test
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v71) {
                    v70.budget = v70.budget - v70.bonus_per_test;
                    v70.bonus_per_test
                } else {
                    0
                }
            } else {
                0
            };
            if (v68 > 0) {
                if (0x2::random::generate_u64(&mut v4) % 2 == 0) {
                    let v72 = 0x2::random::generate_u64(&mut v4) % v67;
                    let v73 = 0x1::vector::borrow<Entry>(v9, 0).owner;
                    let v74 = 0;
                    while (v74 < v10) {
                        let v75 = *0x1::vector::borrow<Entry>(v9, v74);
                        if (v72 < v75.amount) {
                            v73 = v75.owner;
                            break
                        };
                        v72 = v72 - v75.amount;
                        v74 = v74 + 1;
                    };
                    0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v73, v68, &arg0.idx, &mut arg0.buckets, arg3);
                    let v76 = BlessedDrop{
                        round_index     : arg0.round.index,
                        amount          : v68,
                        winner_take_all : true,
                        winner          : v73,
                        winner_count    : v10,
                    };
                    0x2::event::emit<BlessedDrop>(v76);
                } else {
                    let v77 = v68;
                    let v78 = 0;
                    while (v78 < v10 && v77 > 0) {
                        let v79 = *0x1::vector::borrow<Entry>(v9, v78);
                        let v80;
                        let v81 = if (v78 == v10 - 1) {
                            v77
                        } else {
                            let v82 = (((v68 as u128) * (v79.amount as u128) / (v67 as u128)) as u64);
                            v80 = v82;
                            if (v82 == 0 && v77 > 0) {
                                v80 = 1;
                            };
                            if (v80 > v77) {
                                v80 = v77;
                            };
                            v80
                        };
                        if (v81 > 0) {
                            v77 = v77 - v81;
                            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v79.owner, v80, &arg0.idx, &mut arg0.buckets, arg3);
                        };
                        v78 = v78 + 1;
                    };
                    let v83 = BlessedDrop{
                        round_index     : arg0.round.index,
                        amount          : v68,
                        winner_take_all : false,
                        winner          : @0x0,
                        winner_count    : v10,
                    };
                    0x2::event::emit<BlessedDrop>(v83);
                };
            };
        };
        if (arg0.round.total > 0) {
            let v84 = vector[];
            let v85 = vector[];
            let v86 = 0;
            while (v86 < 25) {
                let v87 = 0x1::vector::borrow<vector<Entry>>(&arg0.round.entries, v86);
                let v88 = 0;
                while (v88 < 0x1::vector::length<Entry>(v87)) {
                    let v89 = *0x1::vector::borrow<Entry>(v87, v88);
                    let v90 = &mut v84;
                    let v91 = &mut v85;
                    add_sui_delta(v90, v91, v89.owner, v89.amount);
                    v88 = v88 + 1;
                };
                v86 = v86 + 1;
            };
            let v92 = &mut arg0.id;
            let v93 = ensure_emission_cfg(v92).rate_bps;
            let v94 = 0;
            while (v94 < 0x1::vector::length<address>(&v84)) {
                let v95 = *0x1::vector::borrow<address>(&v84, v94);
                let v96 = *0x1::vector::borrow<u64>(&v85, v94);
                if (v93 > 0) {
                    let v97 = (((v96 as u256) * (v93 as u256) / 10000) as u64);
                    if (v97 > 0) {
                        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::accrue_to_internal(v95, v97, &arg0.idx, &mut arg0.buckets, arg3);
                    };
                };
                let v98 = &mut arg0.player_records;
                let v99 = ensure_record(v98, v95, arg0.round.index).unclaimed_sui;
                let v100 = get_sui_delta(&v0, &v1, v95);
                let v101 = if (v99 >= v100) {
                    v99 - v100
                } else {
                    0
                };
                let (_, _, v104) = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::preview_refinement_internal(v95, &arg0.idx, &arg0.buckets, 1500);
                let v105 = PlayerRoundSettled{
                    round_index                : arg0.round.index,
                    player                     : v95,
                    sui_deployed_atoms         : v96,
                    sui_won_atoms              : v100,
                    unclaimed_sui_before_atoms : v101,
                    unclaimed_sui_after_atoms  : v99,
                    unclaimed_faith_atoms      : v104,
                    had_miracle                : v26,
                    ts_ms                      : arg2,
                };
                0x2::event::emit<PlayerRoundSettled>(v105);
                v94 = v94 + 1;
            };
        };
        arg0.round.phase = 0;
        let v106 = RoundSettled{
            index         : arg0.round.index,
            winning       : v5,
            fee           : v7,
            redistributed : v8,
        };
        0x2::event::emit<RoundSettled>(v106);
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
                    };
                    v9 = v9 + 1;
                };
            };
        };
        accrue_emission_all_entrants(arg0, arg3);
        if (v7 == 0 && v5 > 0) {
            let v16 = &mut arg0.id;
            0x2::balance::join<0x2::sui::SUI>(&mut ensure_rapture(v16).pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v5, arg3)));
        };
        if (v4 > 0) {
            let v17 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_faithgg_internal(&mut arg0.vaults, v4, arg3);
            let v18 = &mut arg0.id;
            let v19 = ensure_rapture(v18);
            if (v19.fee_share_bps > 0) {
                let v20 = (((v4 as u256) * (v19.fee_share_bps as u256) / 10000) as u64);
                if (v20 > 0) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v19.pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v17, v20, arg3)));
                };
            };
            0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::split_and_route_internal(v17, &arg0.fee_split, &mut arg0.vaults, arg3);
        };
        arg0.round.phase = 0;
        let v21 = RoundSettled{
            index         : arg0.round.index,
            winning       : v0,
            fee           : v4,
            redistributed : v5,
        };
        0x2::event::emit<RoundSettled>(v21);
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
        assert!(arg0.season_start_ms != 0, 13906837056266436607);
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

    public entry fun sweep_pilgrimage_to_rapture_entry_v2(arg0: &mut GlobalV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        assert_version_v2(arg0);
        let v0 = 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::pilgrimage_balance(&arg0.vaults);
        if (v0 > 0) {
            let v1 = &mut arg0.id;
            0x2::balance::join<0x2::sui::SUI>(&mut ensure_rapture(v1).pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_pilgrimage_internal(&mut arg0.vaults, v0, arg1)));
        };
        let v2 = PilgrimageSwept{
            admin  : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<PilgrimageSwept>(v2);
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

    public entry fun withdraw_ops_cron_entry_v2(arg0: &mut GlobalV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_version_v2(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::treasury::withdraw_ops_internal(&mut arg0.vaults, arg1, arg2), v0);
        let v1 = AdminOpsWithdrawEvent{
            admin  : v0,
            to     : v0,
            amount : arg1,
        };
        0x2::event::emit<AdminOpsWithdrawEvent>(v1);
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

    // decompiled from Move bytecode v7
}

