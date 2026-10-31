module 0x6f13fefeb11114a97c3177b7d4a8cfdacd5b40174ab3f80b07420b456d469a2b::settlement {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        current_season_id: u64,
        season_start_ms: u64,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_seeds: u64,
        total_growth_points: u64,
        eligible_growth_points: u64,
        settlement: 0x1::option::Option<SettlementState>,
        paused: bool,
        seeds_by_owner: 0x2::table::Table<address, vector<0x2::object::ID>>,
        referrers: 0x2::table::Table<address, address>,
        referral_earnings: 0x2::table::Table<address, u64>,
        player_growth: 0x2::table::Table<address, u64>,
        player_growth_season: 0x2::table::Table<address, u64>,
        planted_saplings: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct Sapling has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        cycle_count: u64,
        total_sui_harvested: u64,
    }

    struct Seed has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        cutoff_growth_points: u64,
        reward_processed: bool,
        sapling_id: 0x2::object::ID,
        season_id: u64,
        owner: address,
        planted_at_ms: u64,
        last_watered_ms: u64,
        watering_streak: u64,
        growth_points: u64,
        state: u8,
        fertilizer_charges: u8,
        miracle_grow_applied: bool,
        revival_charges: u8,
        bottomless_can_expiry_ms: u64,
        permanent_gp_bonus: u64,
    }

    struct Tool has store, key {
        id: 0x2::object::UID,
        version: u64,
        kind: 0x1::string::String,
        charges: u8,
        rarity: u8,
    }

    struct Crate has store, key {
        id: 0x2::object::UID,
        version: u64,
        tier: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
    }

    struct SettlementState has store {
        season_id: u64,
        season_end_ms: u64,
        claim_deadline_ms: u64,
        pool_mist: u64,
        eligible_growth_points: u64,
        paid_mist: u64,
        processed_growth_points: u64,
        processed_seeds: u64,
    }

    struct SeasonArchive has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        settlement: SettlementState,
        admin: address,
        season_id: u64,
        season_start_ms: u64,
        season_end_ms: u64,
        finalized_at_ms: u64,
        claim_deadline_ms: u64,
        total_growth_points: u64,
        total_seeds: u64,
        reward_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        swept: bool,
    }

    struct ChallengeBook has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        admin: address,
        current_challenge_id: u64,
        active_challenge_id: u64,
        active_end_ms: u64,
    }

    struct CanopyChallenge has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        challenge_id: u64,
        season_id: u64,
        start_ms: u64,
        end_ms: u64,
        entry_fee_mist: u64,
        entry_count: u64,
        settled: bool,
        canceled: bool,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        entries: 0x2::table::Table<address, ChallengeEntry>,
    }

    struct ChallengeEntry has store {
        player: address,
        season_id: u64,
        baseline_growth_points: u64,
        entered_at_ms: u64,
        refunded: bool,
    }

    struct SeedPlanted has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
        sapling_id: 0x2::object::ID,
    }

    struct SeedWatered has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
        streak: u64,
        growth_points: u64,
    }

    struct SeedDied has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
    }

    struct SeedRevived has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
    }

    struct SeedAbandoned has copy, drop {
        seed_id: 0x2::object::ID,
        owner: address,
        sapling_id: 0x2::object::ID,
    }

    struct CratePurchased has copy, drop {
        crate_id: 0x2::object::ID,
        buyer: address,
        tier: u8,
    }

    struct CrateOpened has copy, drop {
        crate_id: 0x2::object::ID,
        opener: address,
        tool_kind: 0x1::string::String,
        rarity: u8,
    }

    struct SupplyDropPurchased has copy, drop {
        tool_id: 0x2::object::ID,
        buyer: address,
        drop: u8,
        tool_kind: 0x1::string::String,
        price_mist: u64,
    }

    struct RewardClaimed has copy, drop {
        owner: address,
        amount_mist: u64,
    }

    struct ReferralPaid has copy, drop {
        referrer: address,
        referee: address,
        amount_mist: u64,
    }

    struct SaplingMinted has copy, drop {
        sapling_id: 0x2::object::ID,
        owner: address,
    }

    struct SeasonStarted has copy, drop {
        season_id: u64,
        start_ms: u64,
    }

    struct SeasonReset has copy, drop {
        season_id: u64,
    }

    struct SeasonArchived has copy, drop {
        archive_id: 0x2::object::ID,
        season_id: u64,
        finalized_at_ms: u64,
        claim_deadline_ms: u64,
        reward_pool_mist: u64,
        total_growth_points: u64,
        total_seeds: u64,
    }

    struct ArchivedRewardClaimed has copy, drop {
        archive_id: 0x2::object::ID,
        season_id: u64,
        owner: address,
        seed_id: 0x2::object::ID,
        amount_mist: u64,
    }

    struct ArchivedRewardsSwept has copy, drop {
        archive_id: 0x2::object::ID,
        season_id: u64,
        amount_mist: u64,
    }

    struct ChallengeBookCreated has copy, drop {
        book_id: 0x2::object::ID,
        admin: address,
    }

    struct ChallengeOpened has copy, drop {
        challenge_id: u64,
        challenge_object_id: 0x2::object::ID,
        start_ms: u64,
        end_ms: u64,
        entry_fee_mist: u64,
    }

    struct ChallengeEntered has copy, drop {
        challenge_id: u64,
        player: address,
        season_id: u64,
        baseline_growth_points: u64,
        entry_fee_mist: u64,
    }

    struct ChallengeFinalized has copy, drop {
        challenge_id: u64,
        first: address,
        first_score: u64,
        first_payout_mist: u64,
        second: address,
        second_score: u64,
        second_payout_mist: u64,
        third: address,
        third_score: u64,
        third_payout_mist: u64,
        treasury_mist: u64,
        dev_fee_mist: u64,
    }

    struct ChallengeCanceled has copy, drop {
        challenge_id: u64,
        entry_count: u64,
    }

    struct ChallengeEntryRefunded has copy, drop {
        challenge_id: u64,
        player: address,
        refund_mist: u64,
    }

    struct SettlementRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
        legacy_cap_id: 0x2::object::ID,
    }

    struct RewardSettlementFinalized has copy, drop {
        registry_id: 0x2::object::ID,
        season_id: u64,
        season_end_ms: u64,
        claim_deadline_ms: u64,
        pool_mist: u64,
        eligible_growth_points: u64,
    }

    struct RewardEntitlementProcessed has copy, drop {
        registry_id: 0x2::object::ID,
        season_id: u64,
        seed_id: 0x2::object::ID,
        owner: address,
        eligible_growth_points: u64,
        amount_mist: u64,
    }

    struct GameplayPauseChanged has copy, drop {
        registry_id: 0x2::object::ID,
        paused: bool,
    }

    struct SettlementAdminTransferred has copy, drop {
        registry_id: 0x2::object::ID,
        previous_admin: address,
        new_admin: address,
    }

    struct PoolFunded has copy, drop {
        registry_id: 0x2::object::ID,
        season_id: u64,
        amount_mist: u64,
    }

    entry fun abandon_seed(arg0: &mut Registry, arg1: Seed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        assert_seed_owner(&arg1, arg3);
        assert_seed_current(arg0, &arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg1.state != 2 && seed_is_dead_by_time(&arg1, assert_season_active(arg0, arg2))) {
            let v1 = &mut arg1;
            mark_seed_dead(arg0, v1, v0);
        };
        assert!(arg1.state == 2, 10);
        let v2 = 0x2::object::id<Seed>(&arg1);
        let v3 = arg1.sapling_id;
        let v4 = &mut arg1;
        remove_seed_growth_points(arg0, v4, v0);
        let v5 = &mut arg1;
        sync_cutoff_points(arg0, v5);
        remove_seed_from_owner(arg0, v0, v2);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, v3) && *0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, v3) == arg0.current_season_id) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.planted_saplings, v3);
        };
        let v6 = if (arg0.total_seeds > 0) {
            arg0.total_seeds - 1
        } else {
            0
        };
        arg0.total_seeds = v6;
        let v7 = SeedAbandoned{
            seed_id    : v2,
            owner      : v0,
            sapling_id : v3,
        };
        0x2::event::emit<SeedAbandoned>(v7);
        let Seed {
            id                       : v8,
            version                  : _,
            registry_id              : _,
            cutoff_growth_points     : _,
            reward_processed         : _,
            sapling_id               : _,
            season_id                : _,
            owner                    : _,
            planted_at_ms            : _,
            last_watered_ms          : _,
            watering_streak          : _,
            growth_points            : _,
            state                    : _,
            fertilizer_charges       : _,
            miracle_grow_applied     : _,
            revival_charges          : _,
            bottomless_can_expiry_ms : _,
            permanent_gp_bonus       : _,
        } = arg1;
        0x2::object::delete(v8);
    }

    fun add_growth_points(arg0: &mut Registry, arg1: &mut Seed, arg2: address, arg3: u64) {
        arg1.growth_points = arg1.growth_points + arg3;
        if (0x2::table::contains<address, u64>(&arg0.player_growth, arg2)) {
            if (*0x2::table::borrow<address, u64>(&arg0.player_growth_season, arg2) == arg0.current_season_id) {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth, arg2) = *0x2::table::borrow<address, u64>(&arg0.player_growth, arg2) + arg3;
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth, arg2) = arg3;
                *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth_season, arg2) = arg0.current_season_id;
            };
        } else {
            0x2::table::add<address, u64>(&mut arg0.player_growth, arg2, arg3);
            0x2::table::add<address, u64>(&mut arg0.player_growth_season, arg2, arg0.current_season_id);
        };
        arg0.total_growth_points = arg0.total_growth_points + arg3;
    }

    entry fun apply_tool(arg0: &mut Registry, arg1: &mut Seed, arg2: Tool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 100);
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg4);
        assert_seed_current(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = assert_season_active(arg0, arg3);
        assert!(arg1.state != 2, 2);
        assert!(!seed_is_dead_by_time(arg1, v1), 2);
        assert!(arg2.charges > 0, 19);
        let v2 = *0x1::string::as_bytes(&arg2.kind);
        if (v2 == b"fertilizer") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 3;
        } else if (v2 == b"watering_boost") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 1;
        } else if (v2 == b"compost") {
            arg1.watering_streak = arg1.watering_streak + 1;
        } else if (v2 == b"growth_tonic") {
            add_growth_points(arg0, arg1, v0, 20);
        } else if (v2 == b"miracle_grow") {
            arg1.miracle_grow_applied = true;
        } else if (v2 == b"mulch") {
            arg1.bottomless_can_expiry_ms = v1 + 3 * 86400000;
        } else if (v2 == b"rain_barrel") {
            arg1.last_watered_ms = v1;
        } else if (v2 == b"super_soil") {
            arg1.watering_streak = arg1.watering_streak + 3;
        } else if (v2 == b"sunstone") {
            add_growth_points(arg0, arg1, v0, 30);
        } else if (v2 == b"revival_kit") {
            arg1.revival_charges = arg1.revival_charges + 1;
        } else if (v2 == b"double_dose") {
            arg1.miracle_grow_applied = true;
            arg1.fertilizer_charges = arg1.fertilizer_charges + 2;
        } else if (v2 == b"drought_shield") {
            arg1.bottomless_can_expiry_ms = v1 + 7 * 86400000;
        } else if (v2 == b"ancient_bark") {
            add_growth_points(arg0, arg1, v0, 50);
        } else if (v2 == b"moon_water") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 5;
        } else if (v2 == b"earth_core") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 5;
        } else if (v2 == b"bottomless_can") {
            arg1.bottomless_can_expiry_ms = v1 + 259200000;
        } else if (v2 == b"philosophers_soil") {
            arg1.fertilizer_charges = arg1.fertilizer_charges + 10;
        } else if (v2 == b"timeless_seed") {
            arg1.watering_streak = arg1.watering_streak + 5;
            arg1.last_watered_ms = v1;
        } else if (v2 == b"crystal_water") {
            arg1.miracle_grow_applied = true;
            arg1.fertilizer_charges = arg1.fertilizer_charges + 9;
        } else {
            assert!(v2 == b"forest_heart", 20);
            arg1.permanent_gp_bonus = arg1.permanent_gp_bonus + 5;
        };
        arg2.charges = arg2.charges - 1;
        sync_cutoff_points(arg0, arg1);
        return_or_delete_tool(arg2, v0);
    }

    public fun archive_claim_deadline_ms(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.claim_deadline_ms
    }

    fun archive_current_season(arg0: &mut Registry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        finalize_settlement_at(arg0, arg1);
        let v0 = 0x1::option::extract<SettlementState>(&mut arg0.settlement);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool);
        assert!(v1 + v0.paid_mist == v0.pool_mist, 104);
        let v2 = if (v1 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_pool, v1)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        let v3 = arg0.current_season_id;
        let v4 = arg0.season_start_ms;
        let v5 = v0.claim_deadline_ms;
        let v6 = SeasonArchive{
            id                  : 0x2::object::new(arg2),
            version             : 1,
            registry_id         : 0x2::object::id<Registry>(arg0),
            settlement          : v0,
            admin               : arg0.admin,
            season_id           : v3,
            season_start_ms     : v4,
            season_end_ms       : v4 + 2592000000,
            finalized_at_ms     : arg1,
            claim_deadline_ms   : v5,
            total_growth_points : arg0.eligible_growth_points,
            total_seeds         : arg0.total_seeds,
            reward_pool         : v2,
            swept               : false,
        };
        let v7 = SeasonArchived{
            archive_id          : 0x2::object::id<SeasonArchive>(&v6),
            season_id           : v3,
            finalized_at_ms     : arg1,
            claim_deadline_ms   : v5,
            reward_pool_mist    : v1,
            total_growth_points : arg0.eligible_growth_points,
            total_seeds         : arg0.total_seeds,
        };
        0x2::event::emit<SeasonArchived>(v7);
        arg0.total_growth_points = 0;
        arg0.eligible_growth_points = 0;
        arg0.season_start_ms = 0;
        arg0.total_seeds = 0;
        let v8 = SeasonReset{season_id: v3};
        0x2::event::emit<SeasonReset>(v8);
        0x2::transfer::share_object<SeasonArchive>(v6);
    }

    public fun archive_finalized_at_ms(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.finalized_at_ms
    }

    public fun archive_is_swept(arg0: &SeasonArchive) : bool {
        assert_archive_version(arg0);
        arg0.swept
    }

    public fun archive_original_pool(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.settlement.pool_mist
    }

    public fun archive_pool_size(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool)
    }

    public fun archive_registry_id(arg0: &SeasonArchive) : 0x2::object::ID {
        assert_archive_version(arg0);
        arg0.registry_id
    }

    public fun archive_rewards_paid(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.settlement.paid_mist
    }

    public fun archive_season_end_ms(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.season_end_ms
    }

    public fun archive_season_id(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.season_id
    }

    public fun archive_season_start_ms(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.season_start_ms
    }

    public fun archive_total_gp(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.total_growth_points
    }

    public fun archive_total_seeds(arg0: &SeasonArchive) : u64 {
        assert_archive_version(arg0);
        arg0.total_seeds
    }

    fun assert_admin(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun assert_admin_cap(arg0: &Registry, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1.version == 1, 100);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 101);
    }

    fun assert_archive_version(arg0: &SeasonArchive) {
        assert!(arg0.version == 1, 100);
    }

    fun assert_challenge_book(arg0: &CanopyChallenge, arg1: &ChallengeBook) {
        assert!(arg0.version == 1 && arg1.version == 1, 100);
        assert!(arg0.book_id == 0x2::object::id<ChallengeBook>(arg1) && arg0.registry_id == arg1.registry_id, 101);
    }

    fun assert_challenge_cap(arg0: &ChallengeBook, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        assert!(arg1.version == 1, 100);
        assert!(arg1.registry_id == arg0.registry_id, 101);
    }

    fun assert_challenge_registry(arg0: &CanopyChallenge, arg1: &Registry) {
        assert_registry_version(arg1);
        assert!(arg0.version == 1, 100);
        assert!(arg0.registry_id == 0x2::object::id<Registry>(arg1), 101);
    }

    fun assert_pool_funding_open(arg0: &Registry, arg1: &0x2::clock::Clock) {
        assert_registry_version(arg0);
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.season_start_ms > 0, 105);
        assert!(v0 >= arg0.season_start_ms && v0 < arg0.season_start_ms + 2592000000, 105);
        assert!(0x1::option::is_none<SettlementState>(&arg0.settlement), 106);
    }

    fun assert_registry_version(arg0: &Registry) {
        assert!(arg0.version == 1, 100);
    }

    fun assert_season_active(arg0: &Registry, arg1: &0x2::clock::Clock) : u64 {
        assert_registry_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.season_start_ms > 0, 13);
        assert!(v0 - arg0.season_start_ms < 2592000000, 6);
        v0
    }

    fun assert_seed_current(arg0: &Registry, arg1: &Seed) {
        assert_registry_version(arg0);
        assert_seed_version(arg1);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg0), 101);
        assert!(arg1.season_id == arg0.current_season_id, 15);
    }

    fun assert_seed_owner(arg0: &Seed, arg1: &0x2::tx_context::TxContext) {
        assert_seed_version(arg0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
    }

    fun assert_seed_version(arg0: &Seed) {
        assert!(arg0.version == 1, 100);
    }

    entry fun buy_boom_chest(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        buy_crate(arg0, 5, arg1, arg2, arg3);
    }

    entry fun buy_crate(arg0: &mut Registry, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pool_funding_open(arg0, arg3);
        assert!(arg1 <= 6, 8);
        let v0 = if (arg1 == 0) {
            10000000
        } else if (arg1 == 1) {
            10000000
        } else if (arg1 == 2) {
            10000000
        } else if (arg1 == 3) {
            10000000
        } else if (arg1 == 4) {
            10000000
        } else if (arg1 == 5) {
            10000000
        } else {
            10000000
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg4);
        let v3 = &mut v2;
        pay_direct_invite_shop_bonus(arg0, v1, v3, arg4);
        route_paid_action(arg0, v2, arg4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v4 = Crate{
            id      : 0x2::object::new(arg4),
            version : 1,
            tier    : arg1,
        };
        let v5 = CratePurchased{
            crate_id : 0x2::object::id<Crate>(&v4),
            buyer    : v1,
            tier     : arg1,
        };
        0x2::event::emit<CratePurchased>(v5);
        0x2::transfer::transfer<Crate>(v4, v1);
    }

    entry fun buy_supply_drop(arg0: &mut Registry, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_pool_funding_open(arg0, arg3);
        let (v0, v1, v2, v3) = supply_drop_details(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 4);
        let v4 = 0x2::tx_context::sender(arg4);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg4);
        let v6 = &mut v5;
        pay_direct_invite_shop_bonus(arg0, v4, v6, arg4);
        route_paid_action(arg0, v5, arg4);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v7 = Tool{
            id      : 0x2::object::new(arg4),
            version : 1,
            kind    : 0x1::string::utf8(v0),
            charges : v1,
            rarity  : v2,
        };
        let v8 = SupplyDropPurchased{
            tool_id    : 0x2::object::id<Tool>(&v7),
            buyer      : v4,
            drop       : arg1,
            tool_kind  : 0x1::string::utf8(v0),
            price_mist : v3,
        };
        0x2::event::emit<SupplyDropPurchased>(v8);
        0x2::transfer::transfer<Tool>(v7, v4);
    }

    entry fun buy_victory_chest(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        buy_crate(arg0, 6, arg1, arg2, arg3);
    }

    entry fun cancel_canopy_sprint(arg0: &AdminCap, arg1: &mut ChallengeBook, arg2: &mut CanopyChallenge, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_challenge_cap(arg1, arg0, arg4);
        assert_challenge_book(arg2, arg1);
        assert!(!arg2.settled, 30);
        assert!(!arg2.canceled, 31);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.end_ms, 29);
        assert!(arg2.entry_count < 3, 32);
        arg2.canceled = true;
        if (arg1.active_challenge_id == arg2.challenge_id) {
            arg1.active_challenge_id = 0;
            arg1.active_end_ms = 0;
        };
        let v0 = ChallengeCanceled{
            challenge_id : arg2.challenge_id,
            entry_count  : arg2.entry_count,
        };
        0x2::event::emit<ChallengeCanceled>(v0);
    }

    public fun canopy_challenge_end_ms(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.end_ms
    }

    public fun canopy_challenge_entry_baseline(arg0: &CanopyChallenge, arg1: address) : u64 {
        assert!(arg0.version == 1, 100);
        if (0x2::table::contains<address, ChallengeEntry>(&arg0.entries, arg1)) {
            0x2::table::borrow<address, ChallengeEntry>(&arg0.entries, arg1).baseline_growth_points
        } else {
            0
        }
    }

    public fun canopy_challenge_entry_count(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.entry_count
    }

    public fun canopy_challenge_entry_fee(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.entry_fee_mist
    }

    public fun canopy_challenge_entry_refunded(arg0: &CanopyChallenge, arg1: address) : bool {
        assert!(arg0.version == 1, 100);
        0x2::table::contains<address, ChallengeEntry>(&arg0.entries, arg1) && 0x2::table::borrow<address, ChallengeEntry>(&arg0.entries, arg1).refunded
    }

    public fun canopy_challenge_has_entry(arg0: &CanopyChallenge, arg1: address) : bool {
        assert!(arg0.version == 1, 100);
        0x2::table::contains<address, ChallengeEntry>(&arg0.entries, arg1)
    }

    public fun canopy_challenge_id(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.challenge_id
    }

    public fun canopy_challenge_is_canceled(arg0: &CanopyChallenge) : bool {
        assert!(arg0.version == 1, 100);
        arg0.canceled
    }

    public fun canopy_challenge_is_settled(arg0: &CanopyChallenge) : bool {
        assert!(arg0.version == 1, 100);
        arg0.settled
    }

    public fun canopy_challenge_player_score(arg0: &Registry, arg1: &CanopyChallenge, arg2: address) : u64 {
        assert_registry_version(arg0);
        assert!(arg1.version == 1, 100);
        if (0x2::table::contains<address, ChallengeEntry>(&arg1.entries, arg2)) {
            player_challenge_score(arg0, arg1, arg2)
        } else {
            0
        }
    }

    public fun canopy_challenge_pot_size(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun canopy_challenge_season_id(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.season_id
    }

    public fun canopy_challenge_start_ms(arg0: &CanopyChallenge) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.start_ms
    }

    public fun challenge_book_active_end_ms(arg0: &ChallengeBook) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.active_end_ms
    }

    public fun challenge_book_active_id(arg0: &ChallengeBook) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.active_challenge_id
    }

    public fun challenge_book_admin(arg0: &ChallengeBook) : address {
        assert!(arg0.version == 1, 100);
        arg0.admin
    }

    public fun challenge_book_current_id(arg0: &ChallengeBook) : u64 {
        assert!(arg0.version == 1, 100);
        arg0.current_challenge_id
    }

    entry fun claim_archived_reward(arg0: &mut SeasonArchive, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_archive_version(arg0);
        assert_seed_owner(arg1, arg3);
        assert!(arg1.registry_id == arg0.registry_id, 101);
        assert!(arg1.season_id == arg0.season_id, 15);
        assert!(!arg0.swept, 37);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.season_end_ms, 17);
        assert!(v1 <= arg0.claim_deadline_ms, 36);
        assert!(arg0.settlement.paid_mist + 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool) == arg0.settlement.pool_mist, 104);
        let v2 = &mut arg0.settlement;
        let v3 = settle_seed_reward(v2, arg1);
        if (v3 > 0) {
            let v4 = ArchivedRewardClaimed{
                archive_id  : 0x2::object::id<SeasonArchive>(arg0),
                season_id   : arg0.season_id,
                owner       : v0,
                seed_id     : 0x2::object::id<Seed>(arg1),
                amount_mist : v3,
            };
            0x2::event::emit<ArchivedRewardClaimed>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_pool, v3), arg3), v0);
        };
        assert!(arg0.settlement.paid_mist + 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool) == arg0.settlement.pool_mist, 104);
    }

    entry fun claim_reward(arg0: &mut Registry, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_seed_owner(arg1, arg3);
        assert_seed_current(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        finalize_settlement_at(arg0, v1);
        let v2 = 0x1::option::borrow_mut<SettlementState>(&mut arg0.settlement);
        assert!(v1 <= v2.claim_deadline_ms, 36);
        let v3 = settle_seed_reward(v2, arg1);
        if (v3 > 0) {
            let v4 = RewardClaimed{
                owner       : v0,
                amount_mist : v3,
            };
            0x2::event::emit<RewardClaimed>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.reward_pool, v3), arg3), v0);
        };
        assert!(v2.paid_mist + 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool) == v2.pool_mist, 104);
    }

    entry fun create_challenge_book(arg0: &AdminCap, arg1: &Registry, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg2);
        let v0 = ChallengeBook{
            id                   : 0x2::object::new(arg2),
            version              : 1,
            registry_id          : 0x2::object::id<Registry>(arg1),
            admin                : 0x2::tx_context::sender(arg2),
            current_challenge_id : 0,
            active_challenge_id  : 0,
            active_end_ms        : 0,
        };
        let v1 = ChallengeBookCreated{
            book_id : 0x2::object::id<ChallengeBook>(&v0),
            admin   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ChallengeBookCreated>(v1);
        0x2::transfer::share_object<ChallengeBook>(v0);
    }

    entry fun create_settlement_registry(arg0: &0x6f13fefeb11114a97c3177b7d4a8cfdacd5b40174ab3f80b07420b456d469a2b::arboretum::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Registry{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            admin                  : v0,
            current_season_id      : 0,
            season_start_ms        : 0,
            reward_pool            : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury               : 0x2::balance::zero<0x2::sui::SUI>(),
            total_seeds            : 0,
            total_growth_points    : 0,
            eligible_growth_points : 0,
            settlement             : 0x1::option::none<SettlementState>(),
            paused                 : false,
            seeds_by_owner         : 0x2::table::new<address, vector<0x2::object::ID>>(arg1),
            referrers              : 0x2::table::new<address, address>(arg1),
            referral_earnings      : 0x2::table::new<address, u64>(arg1),
            player_growth          : 0x2::table::new<address, u64>(arg1),
            player_growth_season   : 0x2::table::new<address, u64>(arg1),
            planted_saplings       : 0x2::table::new<0x2::object::ID, u64>(arg1),
        };
        let v2 = 0x2::object::id<Registry>(&v1);
        let v3 = SettlementRegistryCreated{
            registry_id   : v2,
            admin         : v0,
            legacy_cap_id : 0x2::object::id<0x6f13fefeb11114a97c3177b7d4a8cfdacd5b40174ab3f80b07420b456d469a2b::arboretum::AdminCap>(arg0),
        };
        0x2::event::emit<SettlementRegistryCreated>(v3);
        0x2::transfer::share_object<Registry>(v1);
        let v4 = AdminCap{
            id          : 0x2::object::new(arg1),
            version     : 1,
            registry_id : v2,
        };
        0x2::transfer::transfer<AdminCap>(v4, v0);
    }

    fun cutoff_points(arg0: &Seed, arg1: u64) : u64 {
        assert_seed_version(arg0);
        assert!(arg0.last_watered_ms <= arg1, 104);
        if (arg0.state == 2 || seed_is_dead_by_time(arg0, arg1)) {
            0
        } else {
            arg0.growth_points
        }
    }

    entry fun deposit_to_pool(arg0: &AdminCap, arg1: &mut Registry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg4);
        assert_pool_funding_open(arg1, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = PoolFunded{
            registry_id : 0x2::object::id<Registry>(arg1),
            season_id   : arg1.current_season_id,
            amount_mist : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<PoolFunded>(v0);
    }

    entry fun enter_canopy_sprint(arg0: &mut CanopyChallenge, arg1: &Registry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_challenge_registry(arg0, arg1);
        assert_registry_version(arg1);
        assert!(!arg1.paused, 12);
        assert!(!arg0.settled, 30);
        assert!(!arg0.canceled, 31);
        assert!(arg0.season_id == arg1.current_season_id, 15);
        let v0 = assert_season_active(arg1, arg3);
        assert!(v0 >= arg0.start_ms && v0 < arg0.end_ms, 26);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, ChallengeEntry>(&arg0.entries, v1), 27);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.entry_fee_mist, 4);
        let v2 = player_growth_points(arg1, v1);
        let v3 = ChallengeEntry{
            player                 : v1,
            season_id              : arg1.current_season_id,
            baseline_growth_points : v2,
            entered_at_ms          : v0,
            refunded               : false,
        };
        0x2::table::add<address, ChallengeEntry>(&mut arg0.entries, v1, v3);
        arg0.entry_count = arg0.entry_count + 1;
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > arg0.entry_fee_mist) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.entry_fee_mist, arg4)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        };
        let v4 = ChallengeEntered{
            challenge_id           : arg0.challenge_id,
            player                 : v1,
            season_id              : arg1.current_season_id,
            baseline_growth_points : v2,
            entry_fee_mist         : arg0.entry_fee_mist,
        };
        0x2::event::emit<ChallengeEntered>(v4);
    }

    entry fun finalize_canopy_sprint(arg0: &AdminCap, arg1: &mut ChallengeBook, arg2: &mut CanopyChallenge, arg3: &Registry, arg4: address, arg5: address, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_challenge_cap(arg1, arg0, arg8);
        assert_challenge_book(arg2, arg1);
        assert_challenge_registry(arg2, arg3);
        assert!(!arg2.settled, 30);
        assert!(!arg2.canceled, 31);
        assert!(arg2.season_id == arg3.current_season_id, 15);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg2.end_ms, 29);
        assert!(arg2.entry_count >= 3, 32);
        let v0 = if (arg4 != arg5) {
            if (arg4 != arg6) {
                arg5 != arg6
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 33);
        let v1 = player_challenge_score(arg3, arg2, arg4);
        let v2 = player_challenge_score(arg3, arg2, arg5);
        let v3 = player_challenge_score(arg3, arg2, arg6);
        assert!(v1 >= v2 && v2 >= v3, 34);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg2.pot);
        let v5 = v4 * 90 / 100;
        let v6 = v4 * 8 / 100;
        let v7 = v4 - v5 - v6;
        let v8 = v5 * 70 / 100;
        let v9 = v5 * 20 / 100;
        let v10 = v5 - v8 - v9;
        payout_from_challenge_pot(arg2, @0x6f1020c2fd6c91129f7cb5e0d651295e87f7245f96b7d090715c89b38197e77f, v6, arg8);
        payout_from_challenge_pot(arg2, @0x485953e2eadf4aa02af950cf8e914fbd2b67523385e73c36118341459d8d45c4, v7, arg8);
        payout_from_challenge_pot(arg2, arg4, v8, arg8);
        payout_from_challenge_pot(arg2, arg5, v9, arg8);
        payout_from_challenge_pot(arg2, arg6, v10, arg8);
        arg2.settled = true;
        if (arg1.active_challenge_id == arg2.challenge_id) {
            arg1.active_challenge_id = 0;
            arg1.active_end_ms = 0;
        };
        let v11 = ChallengeFinalized{
            challenge_id       : arg2.challenge_id,
            first              : arg4,
            first_score        : v1,
            first_payout_mist  : v8,
            second             : arg5,
            second_score       : v2,
            second_payout_mist : v9,
            third              : arg6,
            third_score        : v3,
            third_payout_mist  : v10,
            treasury_mist      : v6,
            dev_fee_mist       : v7,
        };
        0x2::event::emit<ChallengeFinalized>(v11);
    }

    entry fun finalize_reward_settlement(arg0: &mut Registry, arg1: &0x2::clock::Clock) {
        finalize_settlement_at(arg0, 0x2::clock::timestamp_ms(arg1));
    }

    entry fun finalize_season_archive_now(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg3);
        assert!(arg1.season_start_ms > 0, 13);
        archive_current_season(arg1, 0x2::clock::timestamp_ms(arg2), arg3);
    }

    fun finalize_settlement_at(arg0: &mut Registry, arg1: u64) {
        assert_registry_version(arg0);
        assert!(arg0.season_start_ms > 0, 13);
        let v0 = arg0.season_start_ms + 2592000000;
        assert!(arg1 >= v0, 17);
        if (0x1::option::is_some<SettlementState>(&arg0.settlement)) {
            let v1 = 0x1::option::borrow<SettlementState>(&arg0.settlement);
            assert!(v1.season_id == arg0.current_season_id && v1.season_end_ms == v0, 104);
            assert!(v1.eligible_growth_points == arg0.eligible_growth_points, 104);
            assert!(v1.paid_mist + 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool) == v1.pool_mist, 104);
            return
        };
        assert!(arg0.eligible_growth_points <= arg0.total_growth_points, 104);
        let v2 = v0 + 604800000;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool);
        let v4 = SettlementState{
            season_id               : arg0.current_season_id,
            season_end_ms           : v0,
            claim_deadline_ms       : v2,
            pool_mist               : v3,
            eligible_growth_points  : arg0.eligible_growth_points,
            paid_mist               : 0,
            processed_growth_points : 0,
            processed_seeds         : 0,
        };
        0x1::option::fill<SettlementState>(&mut arg0.settlement, v4);
        let v5 = RewardSettlementFinalized{
            registry_id            : 0x2::object::id<Registry>(arg0),
            season_id              : arg0.current_season_id,
            season_end_ms          : v0,
            claim_deadline_ms      : v2,
            pool_mist              : v3,
            eligible_growth_points : arg0.eligible_growth_points,
        };
        0x2::event::emit<RewardSettlementFinalized>(v5);
    }

    fun mark_seed_dead(arg0: &mut Registry, arg1: &mut Seed, arg2: address) {
        arg1.state = 2;
        arg1.watering_streak = 0;
        remove_seed_growth_points(arg0, arg1, arg2);
        sync_cutoff_points(arg0, arg1);
        let v0 = SeedDied{
            seed_id : 0x2::object::id<Seed>(arg1),
            owner   : arg2,
        };
        0x2::event::emit<SeedDied>(v0);
    }

    fun mint_crate_tool(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CrateOpened{
            crate_id  : arg0,
            opener    : arg1,
            tool_kind : 0x1::string::utf8(arg2),
            rarity    : arg4,
        };
        0x2::event::emit<CrateOpened>(v0);
        let v1 = Tool{
            id      : 0x2::object::new(arg5),
            version : 1,
            kind    : 0x1::string::utf8(arg2),
            charges : arg3,
            rarity  : arg4,
        };
        0x2::transfer::transfer<Tool>(v1, arg1);
    }

    entry fun mint_sapling(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Sapling{
            id                  : 0x2::object::new(arg1),
            version             : 1,
            name                : 0x1::string::utf8(arg0),
            cycle_count         : 0,
            total_sui_harvested : 0,
        };
        let v2 = SaplingMinted{
            sapling_id : 0x2::object::id<Sapling>(&v1),
            owner      : v0,
        };
        0x2::event::emit<SaplingMinted>(v2);
        0x2::transfer::transfer<Sapling>(v1, v0);
    }

    entry fun open_canopy_sprint(arg0: &AdminCap, arg1: &mut ChallengeBook, arg2: &Registry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_challenge_cap(arg1, arg0, arg4);
        assert!(arg1.registry_id == 0x2::object::id<Registry>(arg2), 101);
        assert_registry_version(arg2);
        assert!(!arg2.paused, 12);
        assert!(arg1.active_challenge_id == 0, 24);
        let v0 = assert_season_active(arg2, arg3);
        assert!(v0 >= arg2.season_start_ms + 1209600000, 26);
        let v1 = v0 + 86400000;
        assert!(v1 <= arg2.season_start_ms + 2592000000, 6);
        arg1.current_challenge_id = arg1.current_challenge_id + 1;
        arg1.active_challenge_id = arg1.current_challenge_id;
        arg1.active_end_ms = v1;
        let v2 = CanopyChallenge{
            id             : 0x2::object::new(arg4),
            version        : 1,
            registry_id    : 0x2::object::id<Registry>(arg2),
            book_id        : 0x2::object::id<ChallengeBook>(arg1),
            challenge_id   : arg1.current_challenge_id,
            season_id      : arg2.current_season_id,
            start_ms       : v0,
            end_ms         : v1,
            entry_fee_mist : 250000000,
            entry_count    : 0,
            settled        : false,
            canceled       : false,
            pot            : 0x2::balance::zero<0x2::sui::SUI>(),
            entries        : 0x2::table::new<address, ChallengeEntry>(arg4),
        };
        let v3 = ChallengeOpened{
            challenge_id        : arg1.current_challenge_id,
            challenge_object_id : 0x2::object::id<CanopyChallenge>(&v2),
            start_ms            : v0,
            end_ms              : v1,
            entry_fee_mist      : 250000000,
        };
        0x2::event::emit<ChallengeOpened>(v3);
        0x2::transfer::share_object<CanopyChallenge>(v2);
    }

    entry fun open_crate(arg0: &Registry, arg1: Crate, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 100);
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<Crate>(&arg1);
        let Crate {
            id      : v2,
            version : _,
            tier    : v4,
        } = arg1;
        0x2::object::delete(v2);
        let v5 = 0x2::random::new_generator(arg2, arg3);
        if (v4 == 0) {
            let v6 = &mut v5;
            mint_crate_tool(v1, v0, roll_common(v6), 2, 0, arg3);
        } else if (v4 == 1) {
            let v7 = &mut v5;
            let v8 = &mut v5;
            mint_crate_tool(v1, v0, roll_common(v7), 2, 0, arg3);
            mint_crate_tool(v1, v0, roll_common(v8), 2, 0, arg3);
            if (0x2::random::generate_u64_in_range(&mut v5, 0, 9999) == 0) {
                let v9 = &mut v5;
                mint_crate_tool(v1, v0, roll_legendary(v9), 1, 3, arg3);
            };
        } else if (v4 == 2) {
            let v10 = &mut v5;
            let v11 = &mut v5;
            let v12 = &mut v5;
            mint_crate_tool(v1, v0, roll_uncommon(v10), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_common(v11), 2, 0, arg3);
            mint_crate_tool(v1, v0, roll_common(v12), 2, 0, arg3);
            if (0x2::random::generate_u8_in_range(&mut v5, 0, 99) < 5) {
                let v13 = &mut v5;
                mint_crate_tool(v1, v0, roll_legendary(v13), 1, 3, arg3);
            };
        } else if (v4 == 3) {
            let v14 = &mut v5;
            let v15 = &mut v5;
            let v16 = &mut v5;
            let v17 = &mut v5;
            let v18 = &mut v5;
            mint_crate_tool(v1, v0, roll_rare(v14), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_rare(v15), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v16), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v17), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_common(v18), 2, 0, arg3);
            if (0x2::random::generate_u8_in_range(&mut v5, 0, 1) == 0) {
                let v19 = &mut v5;
                mint_crate_tool(v1, v0, roll_legendary(v19), 1, 3, arg3);
            };
        } else if (v4 == 4) {
            let v20 = &mut v5;
            let v21 = &mut v5;
            let v22 = &mut v5;
            let v23 = &mut v5;
            let v24 = &mut v5;
            let v25 = &mut v5;
            let v26 = &mut v5;
            let v27 = &mut v5;
            let v28 = &mut v5;
            mint_crate_tool(v1, v0, roll_legendary(v20), 1, 3, arg3);
            mint_crate_tool(v1, v0, roll_rare(v21), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_rare(v22), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_rare(v23), 3, 2, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v24), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v25), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_uncommon(v26), 3, 1, arg3);
            mint_crate_tool(v1, v0, roll_common(v27), 2, 0, arg3);
            mint_crate_tool(v1, v0, roll_common(v28), 2, 0, arg3);
            if (0x2::random::generate_u8_in_range(&mut v5, 0, 9) < 3) {
                let v29 = &mut v5;
                mint_crate_tool(v1, v0, roll_legendary(v29), 1, 3, arg3);
            };
        } else if (v4 == 5) {
            mint_crate_tool(v1, v0, b"ancient_bark", 1, 2, arg3);
            mint_crate_tool(v1, v0, b"sunstone", 1, 1, arg3);
            mint_crate_tool(v1, v0, b"double_dose", 2, 2, arg3);
            if (0x2::random::generate_u8_in_range(&mut v5, 0, 99) < 10) {
                mint_crate_tool(v1, v0, b"forest_heart", 1, 3, arg3);
            } else {
                mint_crate_tool(v1, v0, b"growth_tonic", 2, 0, arg3);
            };
        } else {
            mint_crate_tool(v1, v0, b"drought_shield", 2, 2, arg3);
            mint_crate_tool(v1, v0, b"rain_barrel", 2, 1, arg3);
            mint_crate_tool(v1, v0, b"mulch", 2, 1, arg3);
            if (0x2::random::generate_u8_in_range(&mut v5, 0, 99) < 25) {
                mint_crate_tool(v1, v0, b"bottomless_can", 1, 3, arg3);
            } else {
                mint_crate_tool(v1, v0, b"revival_kit", 1, 2, arg3);
            };
        };
    }

    fun pay_direct_invite_shop_bonus(arg0: &mut Registry, arg1: address, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, address>(&arg0.referrers, arg1)) {
            return
        };
        let v0 = *0x2::table::borrow<address, address>(&arg0.referrers, arg1);
        if (v0 == arg1) {
            return
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(arg2) * 1 / 100;
        if (v1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3), v0);
        if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v0) = *0x2::table::borrow<address, u64>(&arg0.referral_earnings, v0) + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.referral_earnings, v0, v1);
        };
        let v2 = ReferralPaid{
            referrer    : v0,
            referee     : arg1,
            amount_mist : v1,
        };
        0x2::event::emit<ReferralPaid>(v2);
    }

    fun payout_from_challenge_pot(arg0: &mut CanopyChallenge, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, arg2), arg3), arg1);
        };
    }

    entry fun plant_seed(arg0: &mut Registry, arg1: Sapling, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 100);
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = assert_season_active(arg0, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 4);
        let v2 = 0x2::object::id<Sapling>(&arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, v2)) {
            assert!(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, v2) != arg0.current_season_id, 14);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2) = arg0.current_season_id;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2, arg0.current_season_id);
        };
        arg1.cycle_count = arg1.cycle_count + 1;
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, 10000000, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        if (0x1::option::is_some<address>(&arg3)) {
            let v4 = *0x1::option::borrow<address>(&arg3);
            if (v4 != v0 && !0x2::table::contains<address, address>(&arg0.referrers, v0)) {
                0x2::table::add<address, address>(&mut arg0.referrers, v0, v4);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 1000000, arg5), v4);
                if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v4)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v4) = *0x2::table::borrow<address, u64>(&arg0.referral_earnings, v4) + 1000000;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.referral_earnings, v4, 1000000);
                };
                let v5 = ReferralPaid{
                    referrer    : v4,
                    referee     : v0,
                    amount_mist : 1000000,
                };
                0x2::event::emit<ReferralPaid>(v5);
            };
        };
        route_paid_action(arg0, v3, arg5);
        let v6 = Seed{
            id                       : 0x2::object::new(arg5),
            version                  : 1,
            registry_id              : 0x2::object::id<Registry>(arg0),
            cutoff_growth_points     : 0,
            reward_processed         : false,
            sapling_id               : v2,
            season_id                : arg0.current_season_id,
            owner                    : v0,
            planted_at_ms            : v1,
            last_watered_ms          : v1,
            watering_streak          : 1,
            growth_points            : 0,
            state                    : 0,
            fertilizer_charges       : 0,
            miracle_grow_applied     : false,
            revival_charges          : 0,
            bottomless_can_expiry_ms : 0,
            permanent_gp_bonus       : 0,
        };
        let v7 = 0x2::object::id<Seed>(&v6);
        arg0.total_seeds = arg0.total_seeds + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seeds_by_owner, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0), v7);
        let v8 = &mut v6;
        add_growth_points(arg0, v8, v0, 10);
        let v9 = &mut v6;
        sync_cutoff_points(arg0, v9);
        let v10 = SeedPlanted{
            seed_id    : v7,
            owner      : v0,
            sapling_id : v2,
        };
        0x2::event::emit<SeedPlanted>(v10);
        0x2::transfer::transfer<Sapling>(arg1, v0);
        0x2::transfer::transfer<Seed>(v6, v0);
    }

    entry fun plant_seed_with_nftree<T0: key>(arg0: &mut Registry, arg1: &T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = assert_season_active(arg0, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 10000000, 4);
        let v2 = 0x2::object::id<T0>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, v2)) {
            assert!(*0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, v2) != arg0.current_season_id, 14);
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2) = arg0.current_season_id;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.planted_saplings, v2, arg0.current_season_id);
        };
        let v3 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, 10000000, arg5);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        if (0x1::option::is_some<address>(&arg3)) {
            let v4 = *0x1::option::borrow<address>(&arg3);
            if (v4 != v0 && !0x2::table::contains<address, address>(&arg0.referrers, v0)) {
                0x2::table::add<address, address>(&mut arg0.referrers, v0, v4);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 1000000, arg5), v4);
                if (0x2::table::contains<address, u64>(&arg0.referral_earnings, v4)) {
                    *0x2::table::borrow_mut<address, u64>(&mut arg0.referral_earnings, v4) = *0x2::table::borrow<address, u64>(&arg0.referral_earnings, v4) + 1000000;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.referral_earnings, v4, 1000000);
                };
                let v5 = ReferralPaid{
                    referrer    : v4,
                    referee     : v0,
                    amount_mist : 1000000,
                };
                0x2::event::emit<ReferralPaid>(v5);
            };
        };
        route_paid_action(arg0, v3, arg5);
        let v6 = Seed{
            id                       : 0x2::object::new(arg5),
            version                  : 1,
            registry_id              : 0x2::object::id<Registry>(arg0),
            cutoff_growth_points     : 0,
            reward_processed         : false,
            sapling_id               : v2,
            season_id                : arg0.current_season_id,
            owner                    : v0,
            planted_at_ms            : v1,
            last_watered_ms          : v1,
            watering_streak          : 1,
            growth_points            : 0,
            state                    : 0,
            fertilizer_charges       : 0,
            miracle_grow_applied     : false,
            revival_charges          : 0,
            bottomless_can_expiry_ms : 0,
            permanent_gp_bonus       : 0,
        };
        let v7 = 0x2::object::id<Seed>(&v6);
        arg0.total_seeds = arg0.total_seeds + 1;
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seeds_by_owner, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, v0), v7);
        let v8 = &mut v6;
        add_growth_points(arg0, v8, v0, 10);
        let v9 = &mut v6;
        sync_cutoff_points(arg0, v9);
        let v10 = SeedPlanted{
            seed_id    : v7,
            owner      : v0,
            sapling_id : v2,
        };
        0x2::event::emit<SeedPlanted>(v10);
        0x2::transfer::transfer<Seed>(v6, v0);
    }

    fun player_challenge_score(arg0: &Registry, arg1: &CanopyChallenge, arg2: address) : u64 {
        assert!(0x2::table::contains<address, ChallengeEntry>(&arg1.entries, arg2), 28);
        let v0 = 0x2::table::borrow<address, ChallengeEntry>(&arg1.entries, arg2);
        assert!(v0.season_id == arg0.current_season_id, 15);
        let v1 = player_growth_points(arg0, arg2);
        if (v1 > v0.baseline_growth_points) {
            v1 - v0.baseline_growth_points
        } else {
            0
        }
    }

    public fun player_growth_points(arg0: &Registry, arg1: address) : u64 {
        assert_registry_version(arg0);
        if (0x2::table::contains<address, u64>(&arg0.player_growth, arg1) && *0x2::table::borrow<address, u64>(&arg0.player_growth_season, arg1) == arg0.current_season_id) {
            *0x2::table::borrow<address, u64>(&arg0.player_growth, arg1)
        } else {
            0
        }
    }

    public fun player_referral_earnings(arg0: &Registry, arg1: address) : u64 {
        assert_registry_version(arg0);
        if (0x2::table::contains<address, u64>(&arg0.referral_earnings, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.referral_earnings, arg1)
        } else {
            0
        }
    }

    entry fun refund_canceled_canopy_sprint_entry(arg0: &mut CanopyChallenge, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        assert!(arg0.canceled, 25);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, ChallengeEntry>(&arg0.entries, v0), 28);
        let v1 = 0x2::table::borrow_mut<address, ChallengeEntry>(&mut arg0.entries, v0);
        assert!(!v1.refunded, 35);
        v1.refunded = true;
        let v2 = arg0.entry_fee_mist;
        payout_from_challenge_pot(arg0, v0, v2, arg1);
        let v3 = ChallengeEntryRefunded{
            challenge_id : arg0.challenge_id,
            player       : v0,
            refund_mist  : v2,
        };
        0x2::event::emit<ChallengeEntryRefunded>(v3);
    }

    public fun registry_claim_deadline_ms(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        if (arg0.season_start_ms == 0) {
            0
        } else {
            arg0.season_start_ms + 2592000000 + 604800000
        }
    }

    public fun registry_eligible_gp(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        arg0.eligible_growth_points
    }

    public fun registry_is_paused(arg0: &Registry) : bool {
        assert_registry_version(arg0);
        arg0.paused
    }

    public fun registry_original_pool(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        0x1::option::borrow<SettlementState>(&arg0.settlement).pool_mist
    }

    public fun registry_pool_size(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        0x2::balance::value<0x2::sui::SUI>(&arg0.reward_pool)
    }

    public fun registry_review_ready_ms(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        if (arg0.season_start_ms == 0) {
            0
        } else {
            arg0.season_start_ms + 2592000000 + 86400000
        }
    }

    public fun registry_rewards_paid(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        0x1::option::borrow<SettlementState>(&arg0.settlement).paid_mist
    }

    public fun registry_season_end_ms(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        if (arg0.season_start_ms == 0) {
            0
        } else {
            arg0.season_start_ms + 2592000000
        }
    }

    public fun registry_settlement_finalized(arg0: &Registry) : bool {
        assert_registry_version(arg0);
        0x1::option::is_some<SettlementState>(&arg0.settlement)
    }

    public fun registry_total_gp(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        arg0.total_growth_points
    }

    public fun registry_total_seeds(arg0: &Registry) : u64 {
        assert_registry_version(arg0);
        arg0.total_seeds
    }

    fun remove_seed_from_owner(arg0: &mut Registry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.seeds_by_owner, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.seeds_by_owner, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v0, v1) == arg2) {
                0x1::vector::remove<0x2::object::ID>(v0, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    fun remove_seed_growth_points(arg0: &mut Registry, arg1: &mut Seed, arg2: address) {
        let v0 = arg1.growth_points;
        if (v0 == 0) {
            return
        };
        if (0x2::table::contains<address, u64>(&arg0.player_growth, arg2) && *0x2::table::borrow<address, u64>(&arg0.player_growth_season, arg2) == arg0.current_season_id) {
            let v1 = *0x2::table::borrow<address, u64>(&arg0.player_growth, arg2);
            let v2 = if (v1 > v0) {
                v1 - v0
            } else {
                0
            };
            *0x2::table::borrow_mut<address, u64>(&mut arg0.player_growth, arg2) = v2;
        };
        let v3 = if (arg0.total_growth_points > v0) {
            arg0.total_growth_points - v0
        } else {
            0
        };
        arg0.total_growth_points = v3;
        arg1.growth_points = 0;
    }

    entry fun reset_season(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.season_start_ms > 0, 13);
        assert!(v0 - arg1.season_start_ms >= 2592000000 + 86400000, 21);
        archive_current_season(arg1, v0, arg3);
    }

    fun return_or_delete_tool(arg0: Tool, arg1: address) {
        assert!(arg0.version == 1, 100);
        if (arg0.charges > 0) {
            0x2::transfer::public_transfer<Tool>(arg0, arg1);
        } else {
            let Tool {
                id      : v0,
                version : _,
                kind    : _,
                charges : _,
                rarity  : _,
            } = arg0;
            0x2::object::delete(v0);
        };
    }

    entry fun revive_seed(arg0: &mut Registry, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg3);
        assert_seed_current(arg0, arg1);
        assert!(arg1.state == 2, 10);
        assert!(arg1.growth_points == 0 && arg1.cutoff_growth_points == 0, 104);
        assert!(arg1.revival_charges > 0, 11);
        arg1.revival_charges = arg1.revival_charges - 1;
        arg1.state = 0;
        arg1.last_watered_ms = assert_season_active(arg0, arg2);
        arg1.watering_streak = 1;
        sync_cutoff_points(arg0, arg1);
        let v0 = SeedRevived{
            seed_id : 0x2::object::id<Seed>(arg1),
            owner   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SeedRevived>(v0);
    }

    entry fun revive_seed_with_tool(arg0: &mut Registry, arg1: &mut Seed, arg2: Tool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 100);
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg4);
        assert_seed_current(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2.charges > 0, 19);
        assert!(*0x1::string::as_bytes(&arg2.kind) == b"revival_kit", 18);
        let v1 = assert_season_active(arg0, arg3);
        if (arg1.state != 2 && seed_is_dead_by_time(arg1, v1)) {
            mark_seed_dead(arg0, arg1, v0);
        };
        assert!(arg1.state == 2, 10);
        assert!(arg1.growth_points == 0 && arg1.cutoff_growth_points == 0, 104);
        arg1.state = 0;
        arg1.last_watered_ms = v1;
        arg1.watering_streak = 1;
        sync_cutoff_points(arg0, arg1);
        let v2 = SeedRevived{
            seed_id : 0x2::object::id<Seed>(arg1),
            owner   : v0,
        };
        0x2::event::emit<SeedRevived>(v2);
        arg2.charges = arg2.charges - 1;
        return_or_delete_tool(arg2, v0);
    }

    fun roll_common(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 3);
        if (v0 == 0) {
            b"fertilizer"
        } else if (v0 == 1) {
            b"watering_boost"
        } else if (v0 == 2) {
            b"compost"
        } else {
            b"growth_tonic"
        }
    }

    fun roll_legendary(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 4);
        if (v0 == 0) {
            b"bottomless_can"
        } else if (v0 == 1) {
            b"philosophers_soil"
        } else if (v0 == 2) {
            b"timeless_seed"
        } else if (v0 == 3) {
            b"crystal_water"
        } else {
            b"forest_heart"
        }
    }

    fun roll_rare(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 5);
        if (v0 == 0) {
            b"revival_kit"
        } else if (v0 == 1) {
            b"double_dose"
        } else if (v0 == 2) {
            b"drought_shield"
        } else if (v0 == 3) {
            b"ancient_bark"
        } else if (v0 == 4) {
            b"moon_water"
        } else {
            b"earth_core"
        }
    }

    fun roll_uncommon(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x2::random::generate_u8_in_range(arg0, 0, 4);
        if (v0 == 0) {
            b"miracle_grow"
        } else if (v0 == 1) {
            b"mulch"
        } else if (v0 == 2) {
            b"rain_barrel"
        } else if (v0 == 3) {
            b"super_soil"
        } else {
            b"sunstone"
        }
    }

    fun route_paid_action(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = v0 * 70 / 100;
        let v2 = v0 * 2 / 100;
        let v3 = v0 - v1 - v2;
        if (v1 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.reward_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg2)));
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg2), @0x485953e2eadf4aa02af950cf8e914fbd2b67523385e73c36118341459d8d45c4);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg2), @0x6f1020c2fd6c91129f7cb5e0d651295e87f7245f96b7d090715c89b38197e77f);
        };
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
    }

    public fun sapling_is_planted(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        assert_registry_version(arg0);
        0x2::table::contains<0x2::object::ID, u64>(&arg0.planted_saplings, arg1) && *0x2::table::borrow<0x2::object::ID, u64>(&arg0.planted_saplings, arg1) == arg0.current_season_id
    }

    public fun seed_bottomless_expiry(arg0: &Seed) : u64 {
        assert_seed_version(arg0);
        arg0.bottomless_can_expiry_ms
    }

    public fun seed_cutoff_growth_points(arg0: &Seed) : u64 {
        assert_seed_version(arg0);
        arg0.cutoff_growth_points
    }

    public fun seed_fertilizer_charges(arg0: &Seed) : u8 {
        assert_seed_version(arg0);
        arg0.fertilizer_charges
    }

    public fun seed_growth_points(arg0: &Seed) : u64 {
        assert_seed_version(arg0);
        arg0.growth_points
    }

    fun seed_is_dead_by_time(arg0: &Seed, arg1: u64) : bool {
        (arg1 - arg0.last_watered_ms) / 86400000 >= 10 && arg0.bottomless_can_expiry_ms < arg1
    }

    public fun seed_registry_id(arg0: &Seed) : 0x2::object::ID {
        assert_seed_version(arg0);
        arg0.registry_id
    }

    public fun seed_revival_charges(arg0: &Seed) : u8 {
        assert_seed_version(arg0);
        arg0.revival_charges
    }

    public fun seed_reward_processed(arg0: &Seed) : bool {
        assert_seed_version(arg0);
        arg0.reward_processed
    }

    public fun seed_state_live(arg0: &Seed, arg1: &0x2::clock::Clock) : u8 {
        assert_seed_version(arg0);
        if (arg0.state == 2) {
            return 2
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = (v0 - arg0.last_watered_ms) / 86400000;
        if (arg0.bottomless_can_expiry_ms >= v0) {
            0
        } else if (v1 >= 10) {
            2
        } else if (v1 >= 7) {
            1
        } else {
            0
        }
    }

    public fun seed_streak(arg0: &Seed) : u64 {
        assert_seed_version(arg0);
        arg0.watering_streak
    }

    entry fun send_promo_crate(arg0: &AdminCap, arg1: &Registry, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg4);
        assert_registry_version(arg1);
        assert!(!arg1.paused, 12);
        assert!(arg3 <= 6, 8);
        let v0 = Crate{
            id      : 0x2::object::new(arg4),
            version : 1,
            tier    : arg3,
        };
        let v1 = CratePurchased{
            crate_id : 0x2::object::id<Crate>(&v0),
            buyer    : arg2,
            tier     : arg3,
        };
        0x2::event::emit<CratePurchased>(v1);
        0x2::transfer::transfer<Crate>(v0, arg2);
    }

    entry fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg3);
        arg1.paused = arg2;
        let v0 = GameplayPauseChanged{
            registry_id : 0x2::object::id<Registry>(arg1),
            paused      : arg2,
        };
        0x2::event::emit<GameplayPauseChanged>(v0);
    }

    fun settle_seed_reward(arg0: &mut SettlementState, arg1: &mut Seed) : u64 {
        assert_seed_version(arg1);
        assert!(!arg1.reward_processed, 102);
        assert!(arg1.season_id == arg0.season_id, 15);
        let v0 = arg1.cutoff_growth_points;
        assert!(v0 == cutoff_points(arg1, arg0.season_end_ms), 104);
        assert!(v0 <= arg0.eligible_growth_points, 104);
        let v1 = if (v0 == 0 || arg0.eligible_growth_points == 0) {
            0
        } else {
            (((v0 as u128) * (arg0.pool_mist as u128) / (arg0.eligible_growth_points as u128)) as u64)
        };
        arg0.paid_mist = arg0.paid_mist + v1;
        arg0.processed_growth_points = arg0.processed_growth_points + v0;
        arg0.processed_seeds = arg0.processed_seeds + 1;
        assert!(arg0.paid_mist <= arg0.pool_mist, 104);
        assert!(arg0.processed_growth_points <= arg0.eligible_growth_points, 104);
        arg1.reward_processed = true;
        arg1.growth_points = 0;
        arg1.cutoff_growth_points = 0;
        let v2 = RewardEntitlementProcessed{
            registry_id            : arg1.registry_id,
            season_id              : arg1.season_id,
            seed_id                : 0x2::object::id<Seed>(arg1),
            owner                  : arg1.owner,
            eligible_growth_points : v0,
            amount_mist            : v1,
        };
        0x2::event::emit<RewardEntitlementProcessed>(v2);
        v1
    }

    entry fun start_season(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg3);
        assert!(arg1.season_start_ms == 0, 17);
        assert!(0x1::option::is_none<SettlementState>(&arg1.settlement) && arg1.eligible_growth_points == 0, 104);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 23);
        arg1.current_season_id = arg1.current_season_id + 1;
        arg1.season_start_ms = v0;
        let v1 = SeasonStarted{
            season_id : arg1.current_season_id,
            start_ms  : v0,
        };
        0x2::event::emit<SeasonStarted>(v1);
    }

    entry fun start_season_for_duration(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg4);
        assert!(arg1.season_start_ms == 0, 17);
        assert!(0x1::option::is_none<SettlementState>(&arg1.settlement) && arg1.eligible_growth_points == 0, 104);
        assert!(arg3 > 0 && arg3 <= 2592000000, 23);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 2592000000 - arg3, 23);
        arg1.current_season_id = arg1.current_season_id + 1;
        arg1.season_start_ms = v0 - 2592000000 - arg3;
        let v1 = SeasonStarted{
            season_id : arg1.current_season_id,
            start_ms  : v0,
        };
        0x2::event::emit<SeasonStarted>(v1);
    }

    fun supply_drop_details(arg0: u8) : (vector<u8>, u8, u8, u64) {
        if (arg0 == 0) {
            (b"revival_kit", 1, 2, 50000000)
        } else if (arg0 == 1) {
            (b"drought_shield", 1, 2, 40000000)
        } else {
            let (v4, v5, v6, v7) = if (arg0 == 2) {
                (1, 1, 30000000, b"rain_barrel")
            } else {
                let (v8, v9, v10, v11) = if (arg0 == 3) {
                    (b"mulch", 1, 1, 25000000)
                } else {
                    assert!(arg0 == 4, 22);
                    (b"watering_boost", 1, 0, 20000000)
                };
                (v9, v10, v11, v8)
            };
            (v7, v4, v5, v6)
        }
    }

    entry fun sweep_archived_rewards(arg0: &AdminCap, arg1: &mut SeasonArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_archive_version(arg1);
        assert!(arg0.version == 1, 100);
        assert!(arg0.registry_id == arg1.registry_id, 101);
        assert!(!arg1.swept, 37);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.claim_deadline_ms, 21);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.reward_pool);
        assert!(arg1.settlement.paid_mist + v0 == arg1.settlement.pool_mist, 104);
        arg1.swept = true;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.reward_pool, v0), arg3), @0x6f1020c2fd6c91129f7cb5e0d651295e87f7245f96b7d090715c89b38197e77f);
        };
        let v1 = ArchivedRewardsSwept{
            archive_id  : 0x2::object::id<SeasonArchive>(arg1),
            season_id   : arg1.season_id,
            amount_mist : v0,
        };
        0x2::event::emit<ArchivedRewardsSwept>(v1);
    }

    fun sync_cutoff_points(arg0: &mut Registry, arg1: &mut Seed) {
        assert_seed_current(arg0, arg1);
        assert!(0x1::option::is_none<SettlementState>(&arg0.settlement), 106);
        assert!(!arg1.reward_processed, 102);
        let v0 = cutoff_points(arg1, arg0.season_start_ms + 2592000000);
        assert!(arg0.eligible_growth_points >= arg1.cutoff_growth_points, 104);
        arg0.eligible_growth_points = arg0.eligible_growth_points - arg1.cutoff_growth_points + v0;
        arg1.cutoff_growth_points = v0;
        assert!(arg0.eligible_growth_points <= arg0.total_growth_points, 104);
    }

    entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut Registry, arg3: &0x2::tx_context::TxContext) {
        assert_admin_cap(arg2, &arg0, arg3);
        arg2.admin = arg1;
        let v0 = SettlementAdminTransferred{
            registry_id    : 0x2::object::id<Registry>(arg2),
            previous_admin : arg2.admin,
            new_admin      : arg1,
        };
        0x2::event::emit<SettlementAdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    entry fun water_seed(arg0: &mut Registry, arg1: &mut Seed, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert!(!arg0.paused, 12);
        assert_seed_owner(arg1, arg3);
        assert_seed_current(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = assert_season_active(arg0, arg2);
        assert!(arg1.state != 2, 2);
        let v2 = v1 - arg1.last_watered_ms;
        let v3 = v2 / 86400000;
        if (v3 >= 10 && arg1.bottomless_can_expiry_ms < v1) {
            mark_seed_dead(arg0, arg1, v0);
            return
        };
        assert!(v2 >= 86400000 - 86400000 / 10 || arg1.bottomless_can_expiry_ms >= v1, 5);
        let v4 = if (v3 >= 7) {
            1
        } else {
            0
        };
        arg1.state = v4;
        if (v3 >= 2) {
            arg1.watering_streak = 1;
        } else {
            arg1.watering_streak = arg1.watering_streak + 1;
        };
        let v5 = if (arg1.watering_streak > 25) {
            50
        } else {
            arg1.watering_streak * 2
        };
        let v6 = 10 + arg1.permanent_gp_bonus + v5;
        let v7 = v6;
        if (arg1.miracle_grow_applied) {
            v7 = v6 * 2;
            arg1.miracle_grow_applied = false;
        };
        if (arg1.fertilizer_charges > 0) {
            let v8 = v7 / 2;
            v7 = v7 + v8;
            arg1.fertilizer_charges = arg1.fertilizer_charges - 1;
        };
        add_growth_points(arg0, arg1, v0, v7);
        arg1.last_watered_ms = v1;
        sync_cutoff_points(arg0, arg1);
        let v9 = SeedWatered{
            seed_id       : 0x2::object::id<Seed>(arg1),
            owner         : v0,
            streak        : arg1.watering_streak,
            growth_points : arg1.growth_points,
        };
        0x2::event::emit<SeedWatered>(v9);
    }

    entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap(arg1, arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

