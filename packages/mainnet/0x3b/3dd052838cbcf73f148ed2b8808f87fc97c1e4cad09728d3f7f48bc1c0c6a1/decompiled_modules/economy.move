module 0x3b3dd052838cbcf73f148ed2b8808f87fc97c1e4cad09728d3f7f48bc1c0c6a1::economy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameBank has key {
        id: 0x2::object::UID,
        dev_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        total_minted: u64,
        variation_cursors: vector<u64>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        initial_mint_cap: u64,
        total_supply_cap: u64,
        mint_price: u64,
        breed_base_price: u64,
        breed_escalation_bps: u64,
        max_breed_count: u64,
        breed_price_bonexp: u64,
        water_price_sui: u64,
        water_price_bonexp: u64,
        standing_fee_sui: u64,
        mint_dev_bps: u64,
        breed_dev_bps: u64,
        action_dev_bps: u64,
        bonexp_per_hour: u64,
        bonexp_accrual_cap_ms: u64,
        age_bonus_bps: u64,
        max_age_bonus_bps: u64,
        combat: CombatParams,
        power_regen_per_hour: u64,
        epoch_duration_ms: u64,
        decay: DecayParams,
        buyback_bps: u64,
        leaderboard_size: u64,
        rarity_variation_counts: vector<u64>,
        mint_rarity_cutoffs: RarityCutoffs,
        breed_rarity_cutoffs: RarityCutoffs,
        tiers: vector<Tier>,
        max_stationed_per_owner: u64,
        paused: bool,
    }

    struct DecayParams has copy, drop, store {
        start_rate_bps: u64,
        floor_rate_bps: u64,
        midpoint_bps: u64,
        steepness: u64,
    }

    struct CombatParams has copy, drop, store {
        drain_bps: u64,
        drain_efficiency_bps: u64,
        drain_power_loss: u64,
        attack_cooldown_ms: u64,
        defend_immunity_ms: u64,
    }

    struct RarityCutoffs has copy, drop, store {
        uncommon_at: u64,
        rare_at: u64,
        legendary_at: u64,
        genesis_at: u64,
    }

    struct Tier has copy, drop, store {
        max_rank: u64,
        amount_per_slot: u64,
    }

    struct ScoreRecord has copy, drop, store {
        epoch: u64,
        score: u64,
    }

    struct Standing has copy, drop, store {
        player: address,
        score: u64,
    }

    struct EpochBoard has key {
        id: 0x2::object::UID,
        epoch: u64,
        ends_at_ms: u64,
        scores: 0x2::table::Table<address, ScoreRecord>,
        top: vector<Standing>,
    }

    struct Award has copy, drop, store {
        player: address,
        rank: u64,
        tier: u8,
        amount: u64,
        claimed: bool,
    }

    struct EpochPrize has key {
        id: 0x2::object::UID,
        epoch: u64,
        awards: vector<Award>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct CrownSeed has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        rank: u64,
        tier: u8,
        palette_id: u8,
        prize: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SponsorEvent has copy, drop {
        donor: address,
        amount: u64,
    }

    struct BurnForScoreEvent has copy, drop {
        player: address,
        epoch: u64,
        burned: u64,
        gained: u64,
        new_score: u64,
    }

    struct SettleEpochEvent has copy, drop {
        epoch: u64,
        extracted: u64,
        awarded: u64,
    }

    struct CrownSeedMintedEvent has copy, drop {
        epoch: u64,
        rank: u64,
        player: address,
        amount: u64,
    }

    struct CrownSeedBurnedEvent has copy, drop {
        epoch: u64,
        rank: u64,
        amount: u64,
    }

    public fun action_dev_bps(arg0: &Config) : u64 {
        arg0.action_dev_bps
    }

    public fun age_bonus_bps(arg0: &Config) : u64 {
        arg0.age_bonus_bps
    }

    public fun attack_cooldown_ms(arg0: &Config) : u64 {
        arg0.combat.attack_cooldown_ms
    }

    public fun award_amount(arg0: &EpochPrize, arg1: u64) : u64 {
        0x1::vector::borrow<Award>(&arg0.awards, arg1).amount
    }

    public fun award_claimed(arg0: &EpochPrize, arg1: u64) : bool {
        0x1::vector::borrow<Award>(&arg0.awards, arg1).claimed
    }

    public fun award_count(arg0: &EpochPrize) : u64 {
        0x1::vector::length<Award>(&arg0.awards)
    }

    public fun award_player(arg0: &EpochPrize, arg1: u64) : address {
        0x1::vector::borrow<Award>(&arg0.awards, arg1).player
    }

    public fun award_rank(arg0: &EpochPrize, arg1: u64) : u64 {
        0x1::vector::borrow<Award>(&arg0.awards, arg1).rank
    }

    public fun award_tier(arg0: &EpochPrize, arg1: u64) : u8 {
        0x1::vector::borrow<Award>(&arg0.awards, arg1).tier
    }

    public fun bonexp_accrual_cap_ms(arg0: &Config) : u64 {
        arg0.bonexp_accrual_cap_ms
    }

    public fun bonexp_per_hour(arg0: &Config) : u64 {
        arg0.bonexp_per_hour
    }

    public fun breed_base_price(arg0: &Config) : u64 {
        arg0.breed_base_price
    }

    public fun breed_dev_bps(arg0: &Config) : u64 {
        arg0.breed_dev_bps
    }

    public fun breed_escalation_bps(arg0: &Config) : u64 {
        arg0.breed_escalation_bps
    }

    public fun breed_price_bonexp(arg0: &Config) : u64 {
        arg0.breed_price_bonexp
    }

    public fun breed_rarity_cutoffs(arg0: &Config) : &RarityCutoffs {
        &arg0.breed_rarity_cutoffs
    }

    public fun burn_crown_seed(arg0: CrownSeed, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let CrownSeed {
            id         : v0,
            epoch      : v1,
            rank       : v2,
            tier       : _,
            palette_id : _,
            prize      : v5,
        } = arg0;
        let v6 = v5;
        0x2::object::delete(v0);
        let v7 = CrownSeedBurnedEvent{
            epoch  : v1,
            rank   : v2,
            amount : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<CrownSeedBurnedEvent>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg1)
    }

    public fun burn_for_score(arg0: &mut EpochBoard, arg1: &mut GameBank, arg2: &mut 0x3b3dd052838cbcf73f148ed2b8808f87fc97c1e4cad09728d3f7f48bc1c0c6a1::bonexp::BonexpVault, arg3: &Config, arg4: 0x2::coin::Coin<0x3b3dd052838cbcf73f148ed2b8808f87fc97c1e4cad09728d3f7f48bc1c0c6a1::bonexp::BONEXP>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.paused, 2);
        collect(arg1, arg5, arg3.standing_fee_sui, arg3.action_dev_bps, arg7);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (v0 >= arg0.ends_at_ms) {
            assert!(0x1::vector::is_empty<Standing>(&arg0.top), 10);
            roll_epoch(arg0, arg3, v0);
        };
        let v1 = arg3.epoch_duration_ms;
        let v2 = arg0.ends_at_ms - v0;
        let v3 = if (v2 >= v1) {
            0
        } else {
            v1 - v2
        };
        let v4 = 0x2::coin::value<0x3b3dd052838cbcf73f148ed2b8808f87fc97c1e4cad09728d3f7f48bc1c0c6a1::bonexp::BONEXP>(&arg4);
        let v5 = mul_bps(v4, decay_rate_bps(arg3, mul_div(v3, 10000, v1)));
        0x3b3dd052838cbcf73f148ed2b8808f87fc97c1e4cad09728d3f7f48bc1c0c6a1::bonexp::burn(arg2, arg4);
        let v6 = 0x2::tx_context::sender(arg7);
        let v7 = arg0.epoch;
        let v8 = if (0x2::table::contains<address, ScoreRecord>(&arg0.scores, v6)) {
            let v9 = 0x2::table::borrow<address, ScoreRecord>(&arg0.scores, v6);
            if (v9.epoch == v7) {
                v9.score
            } else {
                0
            }
        } else {
            0
        };
        let v10 = v8 + v5;
        if (0x2::table::contains<address, ScoreRecord>(&arg0.scores, v6)) {
            let v11 = 0x2::table::borrow_mut<address, ScoreRecord>(&mut arg0.scores, v6);
            v11.epoch = v7;
            v11.score = v10;
        } else {
            let v12 = ScoreRecord{
                epoch : v7,
                score : v10,
            };
            0x2::table::add<address, ScoreRecord>(&mut arg0.scores, v6, v12);
        };
        let v13 = &mut arg0.top;
        update_top(v13, v6, v10, arg3.leaderboard_size);
        let v14 = BurnForScoreEvent{
            player    : v6,
            epoch     : v7,
            burned    : v4,
            gained    : v5,
            new_score : v10,
        };
        0x2::event::emit<BurnForScoreEvent>(v14);
    }

    public fun buyback_bps(arg0: &Config) : u64 {
        arg0.buyback_bps
    }

    fun collect(arg0: &mut GameBank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 7);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg4));
        };
        route(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)), arg3);
    }

    public fun crown_seed_epoch(arg0: &CrownSeed) : u64 {
        arg0.epoch
    }

    public fun crown_seed_palette_id(arg0: &CrownSeed) : u8 {
        arg0.palette_id
    }

    public fun crown_seed_value(arg0: &CrownSeed) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize)
    }

    public fun decay_floor_rate_bps(arg0: &Config) : u64 {
        arg0.decay.floor_rate_bps
    }

    public fun decay_midpoint_bps(arg0: &Config) : u64 {
        arg0.decay.midpoint_bps
    }

    public fun decay_rate_bps(arg0: &Config, arg1: u64) : u64 {
        let v0 = arg0.decay.floor_rate_bps;
        let v1 = arg0.decay.midpoint_bps;
        let (v2, v3) = if (arg1 >= v1) {
            (arg1 - v1, false)
        } else {
            (v1 - arg1, true)
        };
        let v4 = if (v3) {
            mul_div(10000, 10000, exp_approx(arg0.decay.steepness * v2))
        } else {
            exp_approx(arg0.decay.steepness * v2)
        };
        let v5 = v0 + mul_div(arg0.decay.start_rate_bps - v0, 10000, 10000 + v4);
        if (v5 > 10000) {
            10000
        } else {
            v5
        }
    }

    public fun decay_start_rate_bps(arg0: &Config) : u64 {
        arg0.decay.start_rate_bps
    }

    public fun decay_steepness(arg0: &Config) : u64 {
        arg0.decay.steepness
    }

    fun default_variation_counts() : vector<u64> {
        vector[45, 30, 18, 5, 2]
    }

    public fun defend_immunity_ms(arg0: &Config) : u64 {
        arg0.combat.defend_immunity_ms
    }

    public fun dev_pool_value(arg0: &GameBank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.dev_pool)
    }

    public fun drain_bps(arg0: &Config) : u64 {
        arg0.combat.drain_bps
    }

    public fun drain_efficiency_bps(arg0: &Config) : u64 {
        arg0.combat.drain_efficiency_bps
    }

    public fun drain_power_loss(arg0: &Config) : u64 {
        arg0.combat.drain_power_loss
    }

    public fun ends_at_ms(arg0: &EpochBoard) : u64 {
        arg0.ends_at_ms
    }

    public fun epoch(arg0: &EpochBoard) : u64 {
        arg0.epoch
    }

    public fun epoch_duration_ms(arg0: &Config) : u64 {
        arg0.epoch_duration_ms
    }

    fun exp_approx(arg0: u64) : u64 {
        let v0 = exp_table();
        let v1 = if (arg0 > 120000) {
            120000
        } else {
            arg0
        };
        let v2 = v1 / 8000;
        let v3 = v1 % 8000;
        let v4 = *0x1::vector::borrow<u64>(&v0, v2);
        if (v3 == 0 || v2 + 1 >= 0x1::vector::length<u64>(&v0)) {
            v4
        } else {
            v4 + mul_div(*0x1::vector::borrow<u64>(&v0, v2 + 1) - v4, v3, 8000)
        }
    }

    fun exp_table() : vector<u64> {
        vector[10000, 22255, 49530, 110232, 245325, 545982, 1215104, 2704264, 6018450, 13394308, 29809580, 66342440, 147647816, 328596255, 731304420, 1627547914]
    }

    public fun genesis_at(arg0: &RarityCutoffs) : u64 {
        arg0.genesis_at
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameBank{
            id                : 0x2::object::new(arg0),
            dev_pool          : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury          : 0x2::balance::zero<0x2::sui::SUI>(),
            total_minted      : 0,
            variation_cursors : vector[0, 0, 0, 0, 0],
        };
        0x2::transfer::share_object<GameBank>(v1);
        let v2 = CombatParams{
            drain_bps            : 3500,
            drain_efficiency_bps : 10000,
            drain_power_loss     : 30,
            attack_cooldown_ms   : 14400000,
            defend_immunity_ms   : 28800000,
        };
        let v3 = DecayParams{
            start_rate_bps : 10002,
            floor_rate_bps : 3000,
            midpoint_bps   : 7000,
            steepness      : 12,
        };
        let v4 = RarityCutoffs{
            uncommon_at  : 8000,
            rare_at      : 9500,
            legendary_at : 9900,
            genesis_at   : 10000,
        };
        let v5 = RarityCutoffs{
            uncommon_at  : 8000,
            rare_at      : 9500,
            legendary_at : 9900,
            genesis_at   : 10000,
        };
        let v6 = Tier{
            max_rank        : 1,
            amount_per_slot : 100000000000,
        };
        let v7 = Tier{
            max_rank        : 3,
            amount_per_slot : 35000000000,
        };
        let v8 = Tier{
            max_rank        : 10,
            amount_per_slot : 10000000000,
        };
        let v9 = Tier{
            max_rank        : 20,
            amount_per_slot : 4000000000,
        };
        let v10 = 0x1::vector::empty<Tier>();
        let v11 = &mut v10;
        0x1::vector::push_back<Tier>(v11, v6);
        0x1::vector::push_back<Tier>(v11, v7);
        0x1::vector::push_back<Tier>(v11, v8);
        0x1::vector::push_back<Tier>(v11, v9);
        let v12 = Config{
            id                      : 0x2::object::new(arg0),
            initial_mint_cap        : 3000,
            total_supply_cap        : 10000,
            mint_price              : 20000000000,
            breed_base_price        : 5000000000,
            breed_escalation_bps    : 2500,
            max_breed_count         : 5,
            breed_price_bonexp      : 5000000000000,
            water_price_sui         : 400000000,
            water_price_bonexp      : 2000000000000,
            standing_fee_sui        : 200000000,
            mint_dev_bps            : 10000,
            breed_dev_bps           : 2000,
            action_dev_bps          : 2000,
            bonexp_per_hour         : 100000000000,
            bonexp_accrual_cap_ms   : 259200000,
            age_bonus_bps           : 300,
            max_age_bonus_bps       : 5000,
            combat                  : v2,
            power_regen_per_hour    : 0,
            epoch_duration_ms       : 604800000,
            decay                   : v3,
            buyback_bps             : 1000,
            leaderboard_size        : 200,
            rarity_variation_counts : default_variation_counts(),
            mint_rarity_cutoffs     : v4,
            breed_rarity_cutoffs    : v5,
            tiers                   : v10,
            max_stationed_per_owner : 3,
            paused                  : false,
        };
        0x2::transfer::share_object<Config>(v12);
        let v13 = EpochBoard{
            id         : 0x2::object::new(arg0),
            epoch      : 0,
            ends_at_ms : 0,
            scores     : 0x2::table::new<address, ScoreRecord>(arg0),
            top        : 0x1::vector::empty<Standing>(),
        };
        0x2::transfer::share_object<EpochBoard>(v13);
    }

    public fun initial_mint_cap(arg0: &Config) : u64 {
        arg0.initial_mint_cap
    }

    public fun leaderboard_size(arg0: &Config) : u64 {
        arg0.leaderboard_size
    }

    public fun legendary_at(arg0: &RarityCutoffs) : u64 {
        arg0.legendary_at
    }

    public fun max_age_bonus_bps(arg0: &Config) : u64 {
        arg0.max_age_bonus_bps
    }

    public fun max_breed_count(arg0: &Config) : u64 {
        arg0.max_breed_count
    }

    public fun max_stationed_per_owner(arg0: &Config) : u64 {
        arg0.max_stationed_per_owner
    }

    public fun mint_crown_seed(arg0: &mut EpochPrize, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 0x1::vector::length<Award>(&arg0.awards), 5);
        let v0 = 0x1::vector::borrow_mut<Award>(&mut arg0.awards, arg1);
        assert!(!v0.claimed, 6);
        v0.claimed = true;
        let v1 = v0.player;
        let v2 = v0.rank;
        let v3 = v0.tier;
        let v4 = v0.amount;
        let v5 = arg0.epoch;
        let v6 = CrownSeed{
            id         : 0x2::object::new(arg2),
            epoch      : v5,
            rank       : v2,
            tier       : v3,
            palette_id : ((v5 % 6) as u8),
            prize      : 0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v4),
        };
        0x2::transfer::public_transfer<CrownSeed>(v6, v1);
        let v7 = CrownSeedMintedEvent{
            epoch  : v5,
            rank   : v2,
            player : v1,
            amount : v4,
        };
        0x2::event::emit<CrownSeedMintedEvent>(v7);
    }

    public fun mint_dev_bps(arg0: &Config) : u64 {
        arg0.mint_dev_bps
    }

    public fun mint_price(arg0: &Config) : u64 {
        arg0.mint_price
    }

    public fun mint_rarity_cutoffs(arg0: &Config) : &RarityCutoffs {
        &arg0.mint_rarity_cutoffs
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        mul_div(arg0, arg1, 10000)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_tier(arg0: u64, arg1: u64) : Tier {
        Tier{
            max_rank        : arg0,
            amount_per_slot : arg1,
        }
    }

    public(friend) fun next_variation(arg0: &mut GameBank, arg1: &Config, arg2: u8) : u64 {
        let v0 = (arg2 as u64);
        let v1 = 0x1::vector::borrow_mut<u64>(&mut arg0.variation_cursors, v0);
        *v1 = *v1 + 1;
        *v1 % *0x1::vector::borrow<u64>(&arg1.rarity_variation_counts, v0)
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun power_regen_per_hour(arg0: &Config) : u64 {
        arg0.power_regen_per_hour
    }

    public fun prize_epoch(arg0: &EpochPrize) : u64 {
        arg0.epoch
    }

    public fun prize_pot_value(arg0: &EpochPrize) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun rare_at(arg0: &RarityCutoffs) : u64 {
        arg0.rare_at
    }

    public fun rarity_variation_counts(arg0: &Config) : &vector<u64> {
        &arg0.rarity_variation_counts
    }

    public(friend) fun record_mint(arg0: &mut GameBank) {
        arg0.total_minted = arg0.total_minted + 1;
    }

    fun roll_epoch(arg0: &mut EpochBoard, arg1: &Config, arg2: u64) {
        arg0.epoch = arg0.epoch + 1;
        arg0.ends_at_ms = arg2 + arg1.epoch_duration_ms;
        arg0.top = 0x1::vector::empty<Standing>();
    }

    public(friend) fun route(arg0: &mut GameBank, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.dev_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, mul_bps(0x2::balance::value<0x2::sui::SUI>(&arg1), arg2)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, arg1);
    }

    public fun score_of(arg0: &EpochBoard, arg1: address) : u64 {
        if (!0x2::table::contains<address, ScoreRecord>(&arg0.scores, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, ScoreRecord>(&arg0.scores, arg1);
        if (v0.epoch == arg0.epoch) {
            v0.score
        } else {
            0
        }
    }

    public fun set_bonexp_production(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg1.bonexp_per_hour = arg2;
        arg1.bonexp_accrual_cap_ms = arg3;
        arg1.age_bonus_bps = arg4;
        arg1.max_age_bonus_bps = arg5;
    }

    public fun set_buyback(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        assert!(arg2 <= 10000, 0);
        arg1.buyback_bps = arg2;
        arg1.leaderboard_size = arg3;
    }

    public fun set_combat(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg2 <= 10000 && arg3 <= 10000, 0);
        let v0 = CombatParams{
            drain_bps            : arg2,
            drain_efficiency_bps : arg3,
            drain_power_loss     : arg4,
            attack_cooldown_ms   : arg5,
            defend_immunity_ms   : arg6,
        };
        arg1.combat = v0;
        arg1.power_regen_per_hour = arg7;
    }

    public fun set_dev_shares(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg2 <= 10000) {
            if (arg3 <= 10000) {
                arg4 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg1.mint_dev_bps = arg2;
        arg1.breed_dev_bps = arg3;
        arg1.action_dev_bps = arg4;
    }

    public fun set_epoch(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg4 <= arg3, 0);
        assert!(arg5 <= 10000, 0);
        arg1.epoch_duration_ms = arg2;
        let v0 = DecayParams{
            start_rate_bps : arg3,
            floor_rate_bps : arg4,
            midpoint_bps   : arg5,
            steepness      : arg6,
        };
        arg1.decay = v0;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_prices(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        arg1.mint_price = arg2;
        arg1.breed_base_price = arg3;
        arg1.breed_escalation_bps = arg4;
        arg1.max_breed_count = arg5;
        arg1.breed_price_bonexp = arg6;
        arg1.water_price_sui = arg7;
        arg1.water_price_bonexp = arg8;
        arg1.standing_fee_sui = arg9;
    }

    public fun set_rarity_cutoffs(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = if (arg2 <= arg3) {
            if (arg3 <= arg4) {
                if (arg4 <= arg5) {
                    arg5 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = if (arg6 <= arg7) {
            if (arg7 <= arg8) {
                if (arg8 <= arg9) {
                    arg9 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0);
        let v2 = RarityCutoffs{
            uncommon_at  : arg2,
            rare_at      : arg3,
            legendary_at : arg4,
            genesis_at   : arg5,
        };
        arg1.mint_rarity_cutoffs = v2;
        let v3 = RarityCutoffs{
            uncommon_at  : arg6,
            rare_at      : arg7,
            legendary_at : arg8,
            genesis_at   : arg9,
        };
        arg1.breed_rarity_cutoffs = v3;
    }

    public fun set_station_cap(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 > 0, 9);
        arg1.max_stationed_per_owner = arg2;
    }

    public fun set_supply_caps(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.initial_mint_cap = arg2;
        arg1.total_supply_cap = arg3;
    }

    public fun set_tiers(arg0: &AdminCap, arg1: &mut Config, arg2: vector<Tier>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Tier>(&arg2)) {
            let v2 = 0x1::vector::borrow<Tier>(&arg2, v1);
            assert!(v2.max_rank > v0, 1);
            v0 = v2.max_rank;
            v1 = v1 + 1;
        };
        arg1.tiers = arg2;
    }

    public fun set_variation_counts(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 5, 8);
        let v0 = 0;
        while (v0 < 5) {
            assert!(*0x1::vector::borrow<u64>(&arg2, v0) > 0, 8);
            v0 = v0 + 1;
        };
        arg1.rarity_variation_counts = arg2;
    }

    public fun settle_epoch(arg0: &mut GameBank, arg1: &mut EpochBoard, arg2: &Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg1.ends_at_ms, 3);
        let v1 = mul_bps(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), arg2.buyback_bps);
        let v2 = arg1.epoch;
        let v3 = 0x1::vector::empty<Award>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 1;
        let v7 = 0;
        while (v7 < 0x1::vector::length<Tier>(&arg2.tiers)) {
            let v8 = 0x1::vector::borrow<Tier>(&arg2.tiers, v7);
            let v9 = 0;
            while (v9 < v8.max_rank - v5 && v6 <= 0x1::vector::length<Standing>(&arg1.top)) {
                let v10 = Award{
                    player  : 0x1::vector::borrow<Standing>(&arg1.top, v6 - 1).player,
                    rank    : v6,
                    tier    : (v7 as u8),
                    amount  : v8.amount_per_slot,
                    claimed : false,
                };
                0x1::vector::push_back<Award>(&mut v3, v10);
                v4 = v4 + v8.amount_per_slot;
                v6 = v6 + 1;
                v9 = v9 + 1;
            };
            v5 = v8.max_rank;
            v7 = v7 + 1;
        };
        let v11 = if (v4 < v1) {
            v4
        } else {
            v1
        };
        let v12 = 0x1::vector::empty<Award>();
        let v13 = 0;
        let v14 = 0;
        while (v14 < 0x1::vector::length<Award>(&v3)) {
            let v15 = 0x1::vector::borrow<Award>(&v3, v14);
            let v16 = mul_div(v15.amount, v11, v4);
            let v17 = Award{
                player  : v15.player,
                rank    : v15.rank,
                tier    : v15.tier,
                amount  : v16,
                claimed : false,
            };
            0x1::vector::push_back<Award>(&mut v12, v17);
            v13 = v13 + v16;
            v14 = v14 + 1;
        };
        let v18 = EpochPrize{
            id     : 0x2::object::new(arg4),
            epoch  : v2,
            awards : v12,
            pot    : 0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v11),
        };
        0x2::transfer::share_object<EpochPrize>(v18);
        let v19 = mul_bps(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), 5000);
        let v20 = if (standing_fee_sui(arg2) < v19) {
            standing_fee_sui(arg2)
        } else {
            v19
        };
        if (v20 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v20), arg4), 0x2::tx_context::sender(arg4));
        };
        roll_epoch(arg1, arg2, v0);
        let v21 = SettleEpochEvent{
            epoch     : v2,
            extracted : v11,
            awarded   : v13,
        };
        0x2::event::emit<SettleEpochEvent>(v21);
    }

    public(friend) fun setup_crown_seed_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"epoch"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rank"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"palette_id"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Crown Seed (Epoch {epoch})"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A cryptographic pod loaded with SUI, won at Rank #{rank} in Epoch #{epoch}. Burn it to unseal."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hashbonsai-assets.wal.app/seeds/seed_tire{tier}_c{palette_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hashbonsai.wal.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{epoch}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rank}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{palette_id}"));
        let v4 = 0x2::display::new_with_fields<CrownSeed>(arg0, v0, v2, arg1);
        0x2::display::update_version<CrownSeed>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<CrownSeed>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun setup_crownseed_royalty(arg0: &0x2::package::Publisher, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<CrownSeed>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<CrownSeed>(&mut v3, &v2, arg1, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<CrownSeed>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<CrownSeed>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun sponsor_treasury(arg0: &mut GameBank, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = SponsorEvent{
            donor  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<SponsorEvent>(v0);
    }

    public fun standing_fee_sui(arg0: &Config) : u64 {
        arg0.standing_fee_sui
    }

    public fun top_len(arg0: &EpochBoard) : u64 {
        0x1::vector::length<Standing>(&arg0.top)
    }

    public fun top_player(arg0: &EpochBoard, arg1: u64) : address {
        0x1::vector::borrow<Standing>(&arg0.top, arg1).player
    }

    public fun top_score(arg0: &EpochBoard, arg1: u64) : u64 {
        0x1::vector::borrow<Standing>(&arg0.top, arg1).score
    }

    public fun total_minted(arg0: &GameBank) : u64 {
        arg0.total_minted
    }

    public fun total_supply_cap(arg0: &Config) : u64 {
        arg0.total_supply_cap
    }

    public fun treasury_value(arg0: &GameBank) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun uncommon_at(arg0: &RarityCutoffs) : u64 {
        arg0.uncommon_at
    }

    fun update_top(arg0: &mut vector<Standing>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Standing>(arg0)) {
            if (0x1::vector::borrow<Standing>(arg0, v0).player == arg1) {
                0x1::vector::remove<Standing>(arg0, v0);
                break
            };
            v0 = v0 + 1;
        };
        let v1 = 0x1::vector::length<Standing>(arg0);
        let v2 = v1;
        let v3 = 0;
        while (v3 < v1) {
            if (arg2 > 0x1::vector::borrow<Standing>(arg0, v3).score) {
                v2 = v3;
                break
            };
            v3 = v3 + 1;
        };
        if (v2 < arg3) {
            let v4 = Standing{
                player : arg1,
                score  : arg2,
            };
            0x1::vector::insert<Standing>(arg0, v4, v2);
            if (0x1::vector::length<Standing>(arg0) > arg3) {
                0x1::vector::pop_back<Standing>(arg0);
            };
        };
    }

    public fun water_price_bonexp(arg0: &Config) : u64 {
        arg0.water_price_bonexp
    }

    public fun water_price_sui(arg0: &Config) : u64 {
        arg0.water_price_sui
    }

    public fun withdraw_dev_fee(arg0: &AdminCap, arg1: &mut GameBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.dev_pool) >= arg2, 4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.dev_pool, arg2), arg3)
    }

    entry fun withdraw_dev_fee_to_sender(arg0: &AdminCap, arg1: &mut GameBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_dev_fee(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

