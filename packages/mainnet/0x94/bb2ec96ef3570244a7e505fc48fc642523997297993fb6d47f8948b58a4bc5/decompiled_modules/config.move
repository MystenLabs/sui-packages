module 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config {
    struct EconomyAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EconomyRegistry has key {
        id: 0x2::object::UID,
    }

    struct InstanceKey<phantom T0> has copy, drop, store {
        pos0: u8,
    }

    struct FeeSplit has copy, drop, store {
        treasury_bps: u64,
        pool_bps: u64,
        burn_bps: u64,
    }

    struct EmissionParams has copy, drop, store {
        emission_bps: u64,
        claim_delay_ms: u64,
        claim_window_epochs: u64,
    }

    struct RewardCeiling has copy, drop, store {
        point_value_ceiling_bps: u64,
        rate_ema_fills: u64,
    }

    struct LockTerm has copy, drop, store {
        duration_ms: u64,
        boost_bps: u64,
    }

    struct EscrowParams has copy, drop, store {
        vest_duration_ms: u64,
        exit_penalty_bps: u64,
        early_unlock_penalty_bps: u64,
        penalty_burn_bps: u64,
        escrow_lock_bonus_bps: u64,
        lock_terms: vector<LockTerm>,
        max_boosted_amount: u64,
        max_locks: u64,
        max_vesting_tranches: u64,
    }

    struct PointsTable has copy, drop, store {
        win: u64,
        draw: u64,
        loss: u64,
        defense: u64,
        house_bps: u64,
    }

    struct EarningCaps has copy, drop, store {
        base_daily_points: u64,
        points_per_locked_unit: u64,
        locked_unit: u64,
        max_locked_points: u64,
        points_per_character: u64,
        max_counted_characters: u64,
    }

    struct BuybackLimits has copy, drop, store {
        max_buyback_mist: u64,
        min_interval_ms: u64,
        min_rate: u64,
        rate_band_bps: u64,
    }

    struct EconomyConfig<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        genesis_ms: u64,
        epoch_length_ms: u64,
        treasury_recipient: address,
        challenge_fee_mist: u64,
        fee_split: FeeSplit,
        emission: EmissionParams,
        reward_ceiling: RewardCeiling,
        escrow: EscrowParams,
        points: PointsTable,
        earning_caps: EarningCaps,
        buyback: BuybackLimits,
        buyback_cap_id: 0x1::option::Option<0x2::object::ID>,
        epoch_publisher_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        group: vector<u8>,
    }

    public(friend) fun new<T0>(arg0: &mut EconomyRegistry, arg1: u64, arg2: u64, arg3: address, arg4: u64) : EconomyConfig<T0> {
        assert!(arg2 >= 60000 && arg2 <= 604800000, 13906837571662905351);
        assert!(arg3 != @0x0, 13906837580253364239);
        assert!(arg1 <= arg4 + 2592000000 && arg1 + arg2 > arg4, 13906837593138790423);
        let v0 = InstanceKey<T0>{pos0: 0};
        let v1 = FeeSplit{
            treasury_bps : 4000,
            pool_bps     : 4000,
            burn_bps     : 2000,
        };
        let v2 = EmissionParams{
            emission_bps        : 100,
            claim_delay_ms      : 2 * 3600000,
            claim_window_epochs : 30,
        };
        let v3 = RewardCeiling{
            point_value_ceiling_bps : 9000,
            rate_ema_fills          : 168,
        };
        let v4 = LockTerm{
            duration_ms : 30 * 86400000,
            boost_bps   : 12500,
        };
        let v5 = LockTerm{
            duration_ms : 90 * 86400000,
            boost_bps   : 17500,
        };
        let v6 = LockTerm{
            duration_ms : 180 * 86400000,
            boost_bps   : 25000,
        };
        let v7 = 0x1::vector::empty<LockTerm>();
        let v8 = &mut v7;
        0x1::vector::push_back<LockTerm>(v8, v4);
        0x1::vector::push_back<LockTerm>(v8, v5);
        0x1::vector::push_back<LockTerm>(v8, v6);
        let v9 = EscrowParams{
            vest_duration_ms         : 30 * 86400000,
            exit_penalty_bps         : 5000,
            early_unlock_penalty_bps : 5000,
            penalty_burn_bps         : 5000,
            escrow_lock_bonus_bps    : 11000,
            lock_terms               : v7,
            max_boosted_amount       : 250000000000000,
            max_locks                : 16,
            max_vesting_tranches     : 16,
        };
        let v10 = PointsTable{
            win       : 10,
            draw      : 5,
            loss      : 3,
            defense   : 6,
            house_bps : 5000,
        };
        let v11 = EarningCaps{
            base_daily_points      : 40,
            points_per_locked_unit : 1,
            locked_unit            : 5000000000000,
            max_locked_points      : 60,
            points_per_character   : 20,
            max_counted_characters : 3,
        };
        let v12 = BuybackLimits{
            max_buyback_mist : 100 * 1000000000,
            min_interval_ms  : 3600000,
            min_rate         : 0,
            rate_band_bps    : 2000,
        };
        EconomyConfig<T0>{
            id                     : 0x2::derived_object::claim<InstanceKey<T0>>(&mut arg0.id, v0),
            version                : 1,
            paused                 : false,
            genesis_ms             : arg1,
            epoch_length_ms        : arg2,
            treasury_recipient     : arg3,
            challenge_fee_mist     : 50000000,
            fee_split              : v1,
            emission               : v2,
            reward_ceiling         : v3,
            escrow                 : v9,
            points                 : v10,
            earning_caps           : v11,
            buyback                : v12,
            buyback_cap_id         : 0x1::option::none<0x2::object::ID>(),
            epoch_publisher_cap_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public(friend) fun assert_not_paused<T0>(arg0: &EconomyConfig<T0>) {
        assert!(!arg0.paused, 13906837348324343811);
    }

    public(friend) fun assert_version<T0>(arg0: &EconomyConfig<T0>) {
        assert!(arg0.version == 1, 13906837331144343553);
    }

    public fun base_daily_points(arg0: &EarningCaps) : u64 {
        arg0.base_daily_points
    }

    public fun boost_bps(arg0: &LockTerm) : u64 {
        arg0.boost_bps
    }

    public(friend) fun bps() : u64 {
        10000
    }

    public fun burn_bps(arg0: &FeeSplit) : u64 {
        arg0.burn_bps
    }

    public fun buyback_cap_id<T0>(arg0: &EconomyConfig<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.buyback_cap_id
    }

    public fun buyback_limits<T0>(arg0: &EconomyConfig<T0>) : BuybackLimits {
        arg0.buyback
    }

    public fun challenge_fee_mist<T0>(arg0: &EconomyConfig<T0>) : u64 {
        arg0.challenge_fee_mist
    }

    public fun claim_delay_ms(arg0: &EmissionParams) : u64 {
        arg0.claim_delay_ms
    }

    public fun claim_window_epochs(arg0: &EmissionParams) : u64 {
        arg0.claim_window_epochs
    }

    public fun current_epoch<T0>(arg0: &EconomyConfig<T0>, arg1: &0x2::clock::Clock) : u64 {
        epoch_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun defense(arg0: &PointsTable) : u64 {
        arg0.defense
    }

    public fun draw(arg0: &PointsTable) : u64 {
        arg0.draw
    }

    public fun duration_ms(arg0: &LockTerm) : u64 {
        arg0.duration_ms
    }

    public fun early_unlock_penalty_bps(arg0: &EscrowParams) : u64 {
        arg0.early_unlock_penalty_bps
    }

    public fun earning_caps<T0>(arg0: &EconomyConfig<T0>) : EarningCaps {
        arg0.earning_caps
    }

    public fun emission<T0>(arg0: &EconomyConfig<T0>) : EmissionParams {
        arg0.emission
    }

    public fun emission_bps(arg0: &EmissionParams) : u64 {
        arg0.emission_bps
    }

    fun emit_updated<T0>(arg0: &EconomyConfig<T0>, arg1: vector<u8>) {
        let v0 = ConfigUpdated{
            config_id : 0x2::object::id<EconomyConfig<T0>>(arg0),
            group     : arg1,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun epoch_at<T0>(arg0: &EconomyConfig<T0>, arg1: u64) : u64 {
        assert!(arg1 >= arg0.genesis_ms, 13906836789979512849);
        (arg1 - arg0.genesis_ms) / arg0.epoch_length_ms
    }

    public fun epoch_length_ms<T0>(arg0: &EconomyConfig<T0>) : u64 {
        arg0.epoch_length_ms
    }

    public fun epoch_publisher_cap_id<T0>(arg0: &EconomyConfig<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.epoch_publisher_cap_id
    }

    public fun epoch_start_ms<T0>(arg0: &EconomyConfig<T0>, arg1: u64) : u64 {
        arg0.genesis_ms + arg1 * arg0.epoch_length_ms
    }

    public fun escrow_lock_bonus_bps(arg0: &EscrowParams) : u64 {
        arg0.escrow_lock_bonus_bps
    }

    public fun escrow_params<T0>(arg0: &EconomyConfig<T0>) : EscrowParams {
        arg0.escrow
    }

    public fun exit_penalty_bps(arg0: &EscrowParams) : u64 {
        arg0.exit_penalty_bps
    }

    public fun fee_split<T0>(arg0: &EconomyConfig<T0>) : FeeSplit {
        arg0.fee_split
    }

    public fun genesis_ms<T0>(arg0: &EconomyConfig<T0>) : u64 {
        arg0.genesis_ms
    }

    public fun house_bps(arg0: &PointsTable) : u64 {
        arg0.house_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EconomyAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<EconomyAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = EconomyRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<EconomyRegistry>(v1);
    }

    public(friend) fun instance_key<T0>(arg0: u8) : InstanceKey<T0> {
        InstanceKey<T0>{pos0: arg0}
    }

    public fun is_paused<T0>(arg0: &EconomyConfig<T0>) : bool {
        arg0.paused
    }

    public(friend) fun kind_burn_vault() : u8 {
        3
    }

    public(friend) fun kind_config() : u8 {
        0
    }

    public(friend) fun kind_escrow_registry() : u8 {
        4
    }

    public(friend) fun kind_fee_vault() : u8 {
        1
    }

    public(friend) fun kind_rewards_pool() : u8 {
        2
    }

    public fun lock_terms(arg0: &EscrowParams) : vector<LockTerm> {
        arg0.lock_terms
    }

    public fun locked_unit(arg0: &EarningCaps) : u64 {
        arg0.locked_unit
    }

    public fun loss(arg0: &PointsTable) : u64 {
        arg0.loss
    }

    public fun max_boosted_amount(arg0: &EscrowParams) : u64 {
        arg0.max_boosted_amount
    }

    public fun max_buyback_mist(arg0: &BuybackLimits) : u64 {
        arg0.max_buyback_mist
    }

    public fun max_counted_characters(arg0: &EarningCaps) : u64 {
        arg0.max_counted_characters
    }

    public fun max_locked_points(arg0: &EarningCaps) : u64 {
        arg0.max_locked_points
    }

    public fun max_locks(arg0: &EscrowParams) : u64 {
        arg0.max_locks
    }

    public fun max_vesting_tranches(arg0: &EscrowParams) : u64 {
        arg0.max_vesting_tranches
    }

    public fun migrate<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap) {
        assert!(arg0.version < 1, 13906836751324938259);
        arg0.version = 1;
        emit_updated<T0>(arg0, b"version");
    }

    public fun min_interval_ms(arg0: &BuybackLimits) : u64 {
        arg0.min_interval_ms
    }

    public fun min_rate(arg0: &BuybackLimits) : u64 {
        arg0.min_rate
    }

    public fun package_version() : u64 {
        1
    }

    public fun penalty_burn_bps(arg0: &EscrowParams) : u64 {
        arg0.penalty_burn_bps
    }

    public fun point_value_ceiling_bps(arg0: &RewardCeiling) : u64 {
        arg0.point_value_ceiling_bps
    }

    public fun points<T0>(arg0: &EconomyConfig<T0>) : PointsTable {
        arg0.points
    }

    public fun points_per_character(arg0: &EarningCaps) : u64 {
        arg0.points_per_character
    }

    public fun points_per_locked_unit(arg0: &EarningCaps) : u64 {
        arg0.points_per_locked_unit
    }

    public fun pool_bps(arg0: &FeeSplit) : u64 {
        arg0.pool_bps
    }

    public fun rate_band_bps(arg0: &BuybackLimits) : u64 {
        arg0.rate_band_bps
    }

    public fun rate_ema_fills(arg0: &RewardCeiling) : u64 {
        arg0.rate_ema_fills
    }

    public fun reward_ceiling<T0>(arg0: &EconomyConfig<T0>) : RewardCeiling {
        arg0.reward_ceiling
    }

    public(friend) fun set_buyback_cap_id<T0>(arg0: &mut EconomyConfig<T0>, arg1: 0x1::option::Option<0x2::object::ID>) {
        arg0.buyback_cap_id = arg1;
    }

    public fun set_buyback_limits<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 > 0 && arg2 <= 100000000000000, 13906836592410361863);
        assert!(arg3 >= 300000 && arg3 <= 86400000, 13906836605295263751);
        assert!(arg4 > 0, 13906836613885198343);
        assert!(arg5 >= 500 && arg5 <= 2000, 13906836626770100231);
        let v0 = BuybackLimits{
            max_buyback_mist : arg2,
            min_interval_ms  : arg3,
            min_rate         : arg4,
            rate_band_bps    : arg5,
        };
        arg0.buyback = v0;
        emit_updated<T0>(arg0, b"buyback");
    }

    public fun set_challenge_fee<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 >= 1000000 && arg2 <= 10000000000, 13906835604567883783);
        arg0.challenge_fee_mist = arg2;
        emit_updated<T0>(arg0, b"challenge_fee");
    }

    public fun set_earning_caps<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 >= 20 && arg2 <= 120, 13906836403431800839);
        assert!(arg3 <= 120, 13906836412021735431);
        assert!(arg4 > 0, 13906836416316702727);
        assert!(arg5 <= 120, 13906836420611670023);
        assert!(arg6 >= 10 && arg6 <= 40, 13906836437791539207);
        assert!(arg7 >= 1 && arg7 <= 3, 13906836459266375687);
        let v0 = EarningCaps{
            base_daily_points      : arg2,
            points_per_locked_unit : arg3,
            locked_unit            : arg4,
            max_locked_points      : arg5,
            points_per_character   : arg6,
            max_counted_characters : arg7,
        };
        arg0.earning_caps = v0;
        emit_updated<T0>(arg0, b"earning_caps");
    }

    public fun set_emission<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 >= 25 && arg2 <= 200, 13906835677582327815);
        assert!(arg3 >= 3600000 && arg3 <= 86400000, 13906835690467229703);
        assert!(arg4 >= 7 && arg4 <= 365, 13906835711942066183);
        let v0 = EmissionParams{
            emission_bps        : arg2,
            claim_delay_ms      : arg3,
            claim_window_epochs : arg4,
        };
        arg0.emission = v0;
        emit_updated<T0>(arg0, b"emission");
    }

    public(friend) fun set_epoch_publisher_cap_id<T0>(arg0: &mut EconomyConfig<T0>, arg1: 0x1::option::Option<0x2::object::ID>) {
        arg0.epoch_publisher_cap_id = arg1;
    }

    public fun set_escrow_params<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 >= 1209600000 && arg2 <= 7776000000, 13906835935280365575);
        assert!(arg3 >= 2500 && arg3 <= 7500, 13906835948165267463);
        assert!(arg4 >= 2500 && arg4 <= 7500, 13906835969640103943);
        assert!(arg4 >= arg3, 13906835978230956053);
        assert!(arg5 >= 2500 && arg5 <= 7500, 13906835991114940423);
        assert!(arg6 >= 10000 && arg6 <= 12000, 13906836012589776903);
        assert!(arg7 > 0, 13906836021179711495);
        assert!(arg8 >= 1 && arg8 <= 32, 13906836025474678791);
        assert!(arg9 >= 1 && arg9 <= 32, 13906836038359580679);
        assert!(arg2 <= 0x1::vector::borrow<LockTerm>(&arg0.escrow.lock_terms, 0).duration_ms, 13906836046949777419);
        let v0 = &mut arg0.escrow;
        v0.vest_duration_ms = arg2;
        v0.exit_penalty_bps = arg3;
        v0.early_unlock_penalty_bps = arg4;
        v0.penalty_burn_bps = arg5;
        v0.escrow_lock_bonus_bps = arg6;
        v0.max_boosted_amount = arg7;
        v0.max_locks = arg8;
        v0.max_vesting_tranches = arg9;
        emit_updated<T0>(arg0, b"escrow");
    }

    public fun set_fee_split<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 >= 2000 && arg2 <= 5000, 13906835518668406789);
        assert!(arg3 >= 3000 && arg3 <= 6000, 13906835522963374085);
        assert!(arg4 >= 1000 && arg4 <= 3000, 13906835527258341381);
        assert!(arg2 + arg3 + arg4 == 10000, 13906835531553308677);
        let v0 = FeeSplit{
            treasury_bps : arg2,
            pool_bps     : arg3,
            burn_bps     : arg4,
        };
        arg0.fee_split = v0;
        emit_updated<T0>(arg0, b"fee_split");
    }

    public fun set_lock_terms<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: vector<u64>, arg3: vector<u64>) {
        assert_version<T0>(arg0);
        let v0 = 0x1::vector::length<u64>(&arg2);
        let v1 = if (v0 >= 1) {
            if (v0 <= 4) {
                0x1::vector::length<u64>(&arg3) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906836158618796041);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v3 <= 31536000000, 13906836171503566855);
            assert!(v4 >= 10000 && v4 <= 30000, 13906836175798534151);
            if (v2 > 0) {
                assert!(v3 > *0x1::vector::borrow<u64>(&arg2, v2 - 1), 13906836184388599817);
                assert!(v4 >= *0x1::vector::borrow<u64>(&arg3, v2 - 1), 13906836188683567113);
            };
            v2 = v2 + 1;
        };
        assert!(*0x1::vector::borrow<u64>(&arg2, 0) >= arg0.escrow.vest_duration_ms, 13906836201568600075);
        let v5 = 0x1::vector::empty<LockTerm>();
        let v6 = 0;
        while (v6 < v0) {
            let v7 = LockTerm{
                duration_ms : *0x1::vector::borrow<u64>(&arg2, v6),
                boost_bps   : *0x1::vector::borrow<u64>(&arg3, v6),
            };
            0x1::vector::push_back<LockTerm>(&mut v5, v7);
            v6 = v6 + 1;
        };
        arg0.escrow.lock_terms = v5;
        emit_updated<T0>(arg0, b"lock_terms");
    }

    public fun set_paused<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        arg0.paused = arg2;
        emit_updated<T0>(arg0, b"paused");
    }

    public fun set_points<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_version<T0>(arg0);
        let v0 = if (arg2 <= 1000) {
            if (arg3 <= 1000) {
                if (arg4 <= 1000) {
                    arg5 <= 1000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906836308942520327);
        assert!(arg6 <= 10000, 13906836317532454919);
        let v1 = if (arg2 >= 1) {
            if (arg2 >= arg3) {
                arg2 >= arg4 + arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13906836321827815437);
        let v2 = PointsTable{
            win       : arg2,
            draw      : arg3,
            loss      : arg4,
            defense   : arg5,
            house_bps : arg6,
        };
        arg0.points = v2;
        emit_updated<T0>(arg0, b"points");
    }

    public fun set_reward_ceiling<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: u64, arg3: u64) {
        assert_version<T0>(arg0);
        assert!(arg2 >= 5000 && arg2 <= 10000, 13906835793546444807);
        assert!(arg3 >= 24 && arg3 <= 720, 13906835810726313991);
        let v0 = RewardCeiling{
            point_value_ceiling_bps : arg2,
            rate_ema_fills          : arg3,
        };
        arg0.reward_ceiling = v0;
        emit_updated<T0>(arg0, b"reward_ceiling");
    }

    public fun set_treasury_recipient<T0>(arg0: &mut EconomyConfig<T0>, arg1: &EconomyAdminCap, arg2: address) {
        assert_version<T0>(arg0);
        assert!(arg2 != @0x0, 13906836686900166671);
        arg0.treasury_recipient = arg2;
        emit_updated<T0>(arg0, b"treasury_recipient");
    }

    public(friend) fun share<T0>(arg0: EconomyConfig<T0>) {
        0x2::transfer::share_object<EconomyConfig<T0>>(arg0);
    }

    public fun treasury_bps(arg0: &FeeSplit) : u64 {
        arg0.treasury_bps
    }

    public fun treasury_recipient<T0>(arg0: &EconomyConfig<T0>) : address {
        arg0.treasury_recipient
    }

    public(friend) fun uid_mut(arg0: &mut EconomyRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun version<T0>(arg0: &EconomyConfig<T0>) : u64 {
        arg0.version
    }

    public fun vest_duration_ms(arg0: &EscrowParams) : u64 {
        arg0.vest_duration_ms
    }

    public fun win(arg0: &PointsTable) : u64 {
        arg0.win
    }

    // decompiled from Move bytecode v7
}

