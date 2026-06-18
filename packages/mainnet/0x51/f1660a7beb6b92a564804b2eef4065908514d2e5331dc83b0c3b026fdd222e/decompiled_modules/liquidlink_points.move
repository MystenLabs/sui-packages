module 0x51f1660a7beb6b92a564804b2eef4065908514d2e5331dc83b0c3b026fdd222e::liquidlink_points {
    struct PointConfig has key {
        id: 0x2::object::UID,
        point_cap: 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap,
        yt_settlement_cap: 0x1::option::Option<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        duration: u64,
        enabled: bool,
        total_yt_amount: u256,
        total_yt_base: u256,
        config_version: u64,
    }

    struct LpPointState<phantom T0: drop> has key {
        id: 0x2::object::UID,
        point_config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_settlement_cap: 0x1::option::Option<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>,
        pool_settlement_cap: 0x1::option::Option<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>,
        lp_multiplier_bps: u64,
        acc_point_per_lp: u128,
        last_updated_ms: u64,
        total_lp_points_accrued: u64,
        point_config_version: u64,
    }

    struct UserKey has copy, drop, store {
        pos0: address,
    }

    struct PositionKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct YtPointWeightKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct YtMarketAllowedKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct YtPointWeight has copy, drop, store {
        multiplier_bps: u64,
    }

    struct UserYtExposure has store {
        yt_base: u256,
    }

    struct YtPositionContribution has store {
        owner: address,
        raw_amount: u256,
        base_amount: u256,
    }

    struct YtMarketExposure has store {
        yt_amount: u256,
        yt_base: u256,
    }

    struct LpLegPointRecord has store {
        owner: address,
        lp_amount: u64,
        reward_debt: u128,
        pending_points: u64,
    }

    struct PointConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        owner: address,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        duration: u64,
        enabled: bool,
        total_yt_amount: u256,
        total_yt_base: u256,
        config_version: u64,
    }

    struct PointConfigUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        yt_multiplier_bps: u64,
        lp_multiplier_bps: u64,
        duration: u64,
        enabled: bool,
        total_yt_amount: u256,
        total_yt_base: u256,
        config_version: u64,
    }

    struct LpPointStateCreatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_multiplier_bps: u64,
    }

    struct YtPointWeightConfiguredEvent has copy, drop {
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        multiplier_bps: u64,
    }

    struct YtMarketAllowedEvent has copy, drop {
        config_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
    }

    struct LpPointWeightConfiguredEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        multiplier_bps: u64,
    }

    struct YtPointsSyncedEvent has copy, drop {
        config_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        previous_base_amount: u256,
        new_base_amount: u256,
        owner_score_per_duration: u256,
    }

    struct LpPointAccumulatorUpdatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        elapsed_ms: u64,
        total_sy: u64,
        lp_supply: u64,
        points_accrued: u64,
        acc_point_per_lp: u128,
    }

    struct LpLegPointsSettledEvent has copy, drop {
        state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        pending_added: u64,
        pending_total: u64,
        lp_amount: u64,
        reward_debt: u128,
    }

    struct LpPointsClaimedEvent has copy, drop {
        state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        points: u64,
    }

    fun add_lp_points_to_liquidlink(arg0: &PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg3: u64, arg4: address) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::router::add_point_by_admin(arg2, &arg0.point_cap, arg1, arg3, arg0.duration, arg4);
    }

    fun allow_yt_market(arg0: &mut PointConfig, arg1: 0x2::object::ID) {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return
        };
        let v1 = YtMarketExposure{
            yt_amount : 0,
            yt_base   : 0,
        };
        0x2::dynamic_field::add<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v0, v1);
        let v2 = YtMarketAllowedEvent{
            config_id : 0x2::object::id<PointConfig>(arg0),
            market_id : arg1,
        };
        0x2::event::emit<YtMarketAllowedEvent>(v2);
    }

    public fun allow_yt_market_by_admin(arg0: &mut PointConfig, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: 0x2::object::ID) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        allow_yt_market(arg0, arg3);
    }

    fun apply_user_yt_score(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg3: address, arg4: &0x2::clock::Clock) : u256 {
        ensure_user_yt_exposure(arg0, arg3);
        let v0 = UserKey{pos0: arg3};
        let v1 = if (arg0.enabled) {
            weighted_points(0x2::dynamic_field::borrow<UserKey, UserYtExposure>(&arg0.id, v0).yt_base, arg0.yt_multiplier_bps)
        } else {
            0
        };
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::router::set_linear_time_point_by_admin(arg2, &arg0.point_cap, arg1, checked_points_to_u64(v1), arg0.duration, arg4, arg3);
        v1
    }

    fun assert_lp_position_match<T0: drop>(arg0: &LpPointState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition) {
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::pool_id(arg1) == arg0.pool_id, 9204);
    }

    fun assert_lp_state_match<T0: drop>(arg0: &PointConfig, arg1: &LpPointState<T0>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>) {
        assert!(arg1.point_config_id == 0x2::object::id<PointConfig>(arg0), 9203);
        assert!(arg1.pool_id == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg2), 9204);
    }

    fun assert_yt_market_allowed(arg0: &PointConfig, arg1: 0x2::object::ID) {
        assert!(yt_market_allowed(arg0, arg1), 9207);
    }

    fun bump_config_version(arg0: &mut PointConfig) {
        arg0.config_version = arg0.config_version + 1;
    }

    fun calc_lp_points(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 9200);
        let v0 = (arg0 as u256) * (arg1 as u256) * (arg2 as u256) / (10000 as u256) / (arg3 as u256);
        assert!(v0 <= (18446744073709551615 as u256), 9201);
        (v0 as u64)
    }

    fun checked_points_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= (18446744073709551615 as u256), 9201);
        (arg0 as u64)
    }

    fun claim_lp_points<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: 0x2::object::ID, arg5: address) : u64 {
        let v0 = PositionKey{pos0: arg4};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg1.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow_mut<PositionKey, LpLegPointRecord>(&mut arg1.id, v0);
        let v2 = v1.pending_points;
        v1.pending_points = 0;
        if (v2 > 0) {
            add_lp_points_to_liquidlink(arg0, arg2, arg3, v2, arg5);
        };
        let v3 = LpPointsClaimedEvent{
            state_id    : 0x2::object::id<LpPointState<T0>>(arg1),
            position_id : arg4,
            owner       : arg5,
            points      : v2,
        };
        0x2::event::emit<LpPointsClaimedEvent>(v3);
        v2
    }

    public fun claim_lp_points_with_points<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg6: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : u64 {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg3);
        update_pool_lp_points<T0>(arg0, arg1, arg5, arg7);
        settle_lp_position<T0>(arg0, arg1, arg2, arg4, arg6, 0x2::tx_context::sender(arg8));
        claim_lp_points<T0>(arg0, arg1, arg2, arg4, 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg6), 0x2::tx_context::sender(arg8))
    }

    fun combined_multiplier_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 10000;
        assert!(v0 <= 18446744073709551615, 9201);
        (v0 as u64)
    }

    public fun config_version(arg0: &PointConfig) : u64 {
        arg0.config_version
    }

    fun create_and_share(arg0: 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 9200);
        let v0 = PointConfig{
            id                : 0x2::object::new(arg4),
            point_cap         : arg0,
            yt_settlement_cap : 0x1::option::none<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(),
            yt_multiplier_bps : arg1,
            lp_multiplier_bps : arg2,
            duration          : arg3,
            enabled           : true,
            total_yt_amount   : 0,
            total_yt_base     : 0,
            config_version    : 0,
        };
        let v1 = PointConfigCreatedEvent{
            config_id         : 0x2::object::id<PointConfig>(&v0),
            owner             : 0x2::tx_context::sender(arg4),
            yt_multiplier_bps : arg1,
            lp_multiplier_bps : arg2,
            duration          : arg3,
            enabled           : true,
            total_yt_amount   : v0.total_yt_amount,
            total_yt_base     : v0.total_yt_base,
            config_version    : v0.config_version,
        };
        0x2::event::emit<PointConfigCreatedEvent>(v1);
        0x2::transfer::share_object<PointConfig>(v0);
    }

    public fun create_and_share_by_admin(arg0: 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        create_and_share(arg0, arg3, arg4, arg5, arg6);
    }

    public fun create_and_share_default_by_admin(arg0: 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap::PointCap, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        create_and_share(arg0, 10000, 10000, 86400000, arg3);
    }

    fun create_and_share_lp_point_state<T0: drop>(arg0: &PointConfig, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LpPointState<T0>{
            id                      : 0x2::object::new(arg3),
            point_config_id         : 0x2::object::id<PointConfig>(arg0),
            pool_id                 : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg1),
            lp_settlement_cap       : 0x1::option::none<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(),
            pool_settlement_cap     : 0x1::option::none<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(),
            lp_multiplier_bps       : 10000,
            acc_point_per_lp        : 0,
            last_updated_ms         : 0x2::clock::timestamp_ms(arg2),
            total_lp_points_accrued : 0,
            point_config_version    : arg0.config_version,
        };
        let v1 = LpPointStateCreatedEvent{
            state_id          : 0x2::object::id<LpPointState<T0>>(&v0),
            config_id         : 0x2::object::id<PointConfig>(arg0),
            pool_id           : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg1),
            lp_multiplier_bps : 10000,
        };
        0x2::event::emit<LpPointStateCreatedEvent>(v1);
        0x2::transfer::share_object<LpPointState<T0>>(v0);
    }

    public fun create_lp_point_state_by_admin<T0: drop>(arg0: &PointConfig, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        create_and_share_lp_point_state<T0>(arg0, arg1, arg4, arg5);
    }

    public fun duration(arg0: &PointConfig) : u64 {
        arg0.duration
    }

    fun emit_config_updated(arg0: &PointConfig) {
        let v0 = PointConfigUpdatedEvent{
            config_id         : 0x2::object::id<PointConfig>(arg0),
            yt_multiplier_bps : arg0.yt_multiplier_bps,
            lp_multiplier_bps : arg0.lp_multiplier_bps,
            duration          : arg0.duration,
            enabled           : arg0.enabled,
            total_yt_amount   : arg0.total_yt_amount,
            total_yt_base     : arg0.total_yt_base,
            config_version    : arg0.config_version,
        };
        0x2::event::emit<PointConfigUpdatedEvent>(v0);
    }

    public fun enabled(arg0: &PointConfig) : bool {
        arg0.enabled
    }

    fun ensure_market_yt_exposure(arg0: &mut PointConfig, arg1: 0x2::object::ID) {
        allow_yt_market(arg0, arg1);
    }

    fun ensure_user_yt_exposure(arg0: &mut PointConfig, arg1: address) {
        let v0 = UserKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<UserKey>(&arg0.id, v0)) {
            let v1 = UserYtExposure{yt_base: 0};
            0x2::dynamic_field::add<UserKey, UserYtExposure>(&mut arg0.id, v0, v1);
        };
    }

    public fun lp_acc_point_per_lp<T0: drop>(arg0: &LpPointState<T0>) : u128 {
        arg0.acc_point_per_lp
    }

    public fun lp_last_updated_ms<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.last_updated_ms
    }

    public fun lp_multiplier_bps(arg0: &PointConfig) : u64 {
        arg0.lp_multiplier_bps
    }

    public fun lp_pending_points<T0: drop>(arg0: &LpPointState<T0>, arg1: 0x2::object::ID) : u64 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, LpLegPointRecord>(&arg0.id, v0).pending_points
    }

    public fun lp_point_config_version<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.point_config_version
    }

    fun lp_reward_debt(arg0: u64, arg1: u128) : u128 {
        (arg0 as u128) * arg1
    }

    public fun lp_state_multiplier_bps<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.lp_multiplier_bps
    }

    fun mutate_market_yt_exposure(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        ensure_market_yt_exposure(arg0, arg1);
        let v0 = YtMarketAllowedKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<YtMarketAllowedKey, YtMarketExposure>(&mut arg0.id, v0);
        assert!(v1.yt_amount >= arg2, 9202);
        assert!(v1.yt_base >= arg3, 9202);
        v1.yt_amount = v1.yt_amount - arg2 + arg4;
        v1.yt_base = v1.yt_base - arg3 + arg5;
    }

    fun mutate_user_yt_exposure(arg0: &mut PointConfig, arg1: address, arg2: u256, arg3: u256) {
        ensure_user_yt_exposure(arg0, arg1);
        let v0 = UserKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<UserKey, UserYtExposure>(&mut arg0.id, v0);
        assert!(v1.yt_base >= arg2, 9202);
        v1.yt_base = v1.yt_base - arg2 + arg3;
    }

    fun pending_lp_points_for_record(arg0: &LpLegPointRecord, arg1: u128) : u64 {
        let v0 = lp_reward_debt(arg0.lp_amount, arg1);
        if (v0 <= arg0.reward_debt) {
            return 0
        };
        let v1 = (v0 - arg0.reward_debt) / 1000000000000;
        assert!(v1 <= 18446744073709551615, 9201);
        (v1 as u64)
    }

    public fun refresh_pool_lp_points_with_points<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg4: &0x2::clock::Clock) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        update_pool_lp_points<T0>(arg0, arg1, arg3, arg4);
    }

    public fun refresh_user_yt_score_with_points(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: address, arg5: &0x2::clock::Clock) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        apply_user_yt_score(arg0, arg1, arg3, arg4, arg5);
    }

    public fun register_lp_rewarder_by_admin<T0: drop>(arg0: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut LpPointState<T0>, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap) {
        assert!(0x1::option::is_none<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(&arg2.lp_settlement_cap), 9205);
        0x1::option::fill<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(&mut arg2.lp_settlement_cap, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg3, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::lp_scope(), 0x2::object::id<LpPointState<T0>>(arg2), b"liquidlink", b"liquidlink.lp"));
    }

    public fun register_pool_rewarder_by_admin<T0: drop>(arg0: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut LpPointState<T0>, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap) {
        assert!(0x1::option::is_none<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(&arg2.pool_settlement_cap), 9205);
        0x1::option::fill<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(&mut arg2.pool_settlement_cap, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg3, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::pool_scope(), 0x2::object::id<LpPointState<T0>>(arg2), b"liquidlink", b"liquidlink.pool"));
    }

    public fun register_yt_rewarder_by_admin(arg0: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardDistributor, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap) {
        assert!(0x1::option::is_none<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(&arg2.yt_settlement_cap), 9205);
        0x1::option::fill<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(&mut arg2.yt_settlement_cap, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::register_rewarder_with_settlement_cap_by_admin(arg0, arg1, arg3, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::yt_scope(), 0x2::object::id<PointConfig>(arg2), b"liquidlink", b"liquidlink.yt"));
    }

    fun set_enabled(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg3: bool, arg4: &0x2::clock::Clock) {
        0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::router::set_linear_time_pause_by_admin(arg2, &arg0.point_cap, arg1, !arg3, arg4);
        arg0.enabled = arg3;
        bump_config_version(arg0);
        emit_config_updated(arg0);
    }

    public fun set_enabled_by_acl(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg4, 0x2::tx_context::sender(arg7), 0x1::string::utf8(b"points.pause"));
        set_enabled(arg0, arg1, arg3, arg5, arg6);
    }

    public fun set_enabled_by_admin(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg5: bool, arg6: &0x2::clock::Clock) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        set_enabled(arg0, arg1, arg3, arg5, arg6);
    }

    fun set_lp_state_multiplier<T0: drop>(arg0: &mut LpPointState<T0>, arg1: u64) {
        if (arg0.lp_multiplier_bps != arg1) {
            arg0.point_config_version = 18446744073709551615;
        };
        arg0.lp_multiplier_bps = arg1;
        let v0 = LpPointWeightConfiguredEvent{
            state_id       : 0x2::object::id<LpPointState<T0>>(arg0),
            pool_id        : arg0.pool_id,
            multiplier_bps : arg1,
        };
        0x2::event::emit<LpPointWeightConfiguredEvent>(v0);
    }

    public fun set_lp_state_multiplier_by_admin<T0: drop>(arg0: &mut LpPointState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        set_lp_state_multiplier<T0>(arg0, arg3);
    }

    fun set_multipliers(arg0: &mut PointConfig, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg3 > 0, 9200);
        if (arg1 != arg0.yt_multiplier_bps || arg3 != arg0.duration) {
            assert!(arg0.total_yt_amount == 0, 9209);
        };
        arg0.yt_multiplier_bps = arg1;
        arg0.lp_multiplier_bps = arg2;
        arg0.duration = arg3;
        bump_config_version(arg0);
        emit_config_updated(arg0);
    }

    public fun set_multipliers_by_admin(arg0: &mut PointConfig, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: u64, arg4: u64, arg5: u64) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        set_multipliers(arg0, arg3, arg4, arg5);
    }

    fun set_yt_market_multiplier(arg0: &mut PointConfig, arg1: 0x2::object::ID, arg2: u64) {
        allow_yt_market(arg0, arg1);
        if (arg2 != yt_market_multiplier_bps(arg0, arg1)) {
            assert!(yt_market_amount(arg0, arg1) == 0, 9209);
        };
        let v0 = YtPointWeightKey{pos0: arg1};
        let v1 = YtPointWeight{multiplier_bps: arg2};
        if (0x2::dynamic_field::exists<YtPointWeightKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<YtPointWeightKey, YtPointWeight>(&mut arg0.id, v0) = v1;
        } else {
            0x2::dynamic_field::add<YtPointWeightKey, YtPointWeight>(&mut arg0.id, v0, v1);
        };
        let v2 = YtPointWeightConfiguredEvent{
            config_id      : 0x2::object::id<PointConfig>(arg0),
            market_id      : arg1,
            multiplier_bps : arg2,
        };
        0x2::event::emit<YtPointWeightConfiguredEvent>(v2);
    }

    public fun set_yt_market_multiplier_by_admin(arg0: &mut PointConfig, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: 0x2::object::ID, arg4: u64) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        set_yt_market_multiplier(arg0, arg3, arg4);
    }

    fun set_yt_position_contribution(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: address, arg6: u256, arg7: u256, arg8: &0x2::clock::Clock) {
        let v0 = PositionKey{pos0: arg4};
        let v1 = arg5;
        let v2 = 0;
        let v3 = 0;
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            let v4 = YtPositionContribution{
                owner       : arg5,
                raw_amount  : 0,
                base_amount : 0,
            };
            0x2::dynamic_field::add<PositionKey, YtPositionContribution>(&mut arg0.id, v0, v4);
        } else {
            let v5 = 0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0);
            v1 = v5.owner;
            v2 = v5.raw_amount;
            v3 = v5.base_amount;
        };
        if (v3 != 0) {
            mutate_user_yt_exposure(arg0, v1, v3, 0);
        };
        if (v2 != 0 || v3 != 0) {
            mutate_market_yt_exposure(arg0, arg3, v2, v3, 0, 0);
        };
        if (arg7 != 0) {
            mutate_user_yt_exposure(arg0, arg5, 0, arg7);
        };
        if (arg6 != 0 || arg7 != 0) {
            mutate_market_yt_exposure(arg0, arg3, 0, 0, arg6, arg7);
        } else {
            ensure_user_yt_exposure(arg0, arg5);
            ensure_market_yt_exposure(arg0, arg3);
        };
        arg0.total_yt_amount = arg0.total_yt_amount - v2 + arg6;
        arg0.total_yt_base = arg0.total_yt_base - v3 + arg7;
        let v6 = 0x2::dynamic_field::borrow_mut<PositionKey, YtPositionContribution>(&mut arg0.id, v0);
        v6.owner = arg5;
        v6.raw_amount = arg6;
        v6.base_amount = arg7;
        if (v1 != arg5) {
            apply_user_yt_score(arg0, arg1, arg2, v1, arg8);
        };
        let v7 = apply_user_yt_score(arg0, arg1, arg2, arg5, arg8);
        let v8 = YtPointsSyncedEvent{
            config_id                : 0x2::object::id<PointConfig>(arg0),
            position_id              : arg4,
            owner                    : arg5,
            previous_base_amount     : v3,
            new_base_amount          : arg7,
            owner_score_per_duration : v7,
        };
        0x2::event::emit<YtPointsSyncedEvent>(v8);
    }

    fun settle_lp_position<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg5: address) {
        assert_lp_position_match<T0>(arg1, arg4);
        let v0 = 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg4);
        let v1 = PositionKey{pos0: v0};
        let v2 = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::lp_amount(arg4);
        if (!0x2::dynamic_field::exists<PositionKey>(&arg1.id, v1)) {
            let v3 = LpLegPointRecord{
                owner          : arg5,
                lp_amount      : v2,
                reward_debt    : lp_reward_debt(v2, arg1.acc_point_per_lp),
                pending_points : 0,
            };
            0x2::dynamic_field::add<PositionKey, LpLegPointRecord>(&mut arg1.id, v1, v3);
            let v4 = LpLegPointsSettledEvent{
                state_id      : 0x2::object::id<LpPointState<T0>>(arg1),
                position_id   : v0,
                owner         : arg5,
                pending_added : 0,
                pending_total : 0,
                lp_amount     : v2,
                reward_debt   : lp_reward_debt(v2, arg1.acc_point_per_lp),
            };
            0x2::event::emit<LpLegPointsSettledEvent>(v4);
            return
        };
        let v5 = @0x0;
        let v6 = 0;
        let v7 = 0x2::dynamic_field::borrow_mut<PositionKey, LpLegPointRecord>(&mut arg1.id, v1);
        let v8 = pending_lp_points_for_record(v7, arg1.acc_point_per_lp);
        let v9 = v7.pending_points + v8;
        let v10 = v9;
        if (v7.owner != arg5) {
            v5 = v7.owner;
            v6 = v9;
            v7.owner = arg5;
            v7.pending_points = 0;
            v10 = 0;
        } else {
            v7.pending_points = v9;
        };
        v7.lp_amount = v2;
        v7.reward_debt = lp_reward_debt(v2, arg1.acc_point_per_lp);
        if (v6 > 0) {
            add_lp_points_to_liquidlink(arg0, arg2, arg3, v6, v5);
        };
        let v11 = LpLegPointsSettledEvent{
            state_id      : 0x2::object::id<LpPointState<T0>>(arg1),
            position_id   : v0,
            owner         : arg5,
            pending_added : v8,
            pending_total : v10,
            lp_amount     : v2,
            reward_debt   : v7.reward_debt,
        };
        0x2::event::emit<LpLegPointsSettledEvent>(v11);
    }

    public fun settle_lp_position_owner_with_points<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg6: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg7: address, arg8: &0x2::clock::Clock) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg3);
        update_pool_lp_points<T0>(arg0, arg1, arg5, arg8);
        settle_lp_position<T0>(arg0, arg1, arg2, arg4, arg6, arg7);
    }

    public fun settle_lp_position_with_points<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg6: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg3);
        update_pool_lp_points<T0>(arg0, arg1, arg5, arg7);
        settle_lp_position<T0>(arg0, arg1, arg2, arg4, arg6, 0x2::tx_context::sender(arg8));
    }

    public fun settle_lp_reward_operation<T0: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg2: &PointConfig, arg3: &mut LpPointState<T0>, arg4: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardDistributor, arg6: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardOperation, arg7: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg8: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert_lp_state_match<T0>(arg2, arg3, arg7);
        assert_lp_position_match<T0>(arg3, arg8);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_subject(arg6, 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg8));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_owner(arg6, 0x2::tx_context::sender(arg10));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::settle_rewarder_with_cap(arg5, arg0, arg6, settlement_cap_ref(&arg3.lp_settlement_cap));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_operation_profile_matches(arg6, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg7));
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::previous_exposure(arg6) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::lp_amount(arg8), 9208);
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::operation_guard(arg6) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::lp_reward_guard(arg8), 9208);
        update_pool_lp_points<T0>(arg2, arg3, arg7, arg9);
        settle_lp_position<T0>(arg2, arg3, arg4, arg1, arg8, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::operation_owner(arg6));
    }

    public fun settle_pool_reward_operation<T0: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &PointConfig, arg2: &mut LpPointState<T0>, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardDistributor, arg4: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardOperation, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg6: &0x2::clock::Clock) {
        assert_lp_state_match<T0>(arg1, arg2, arg5);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_subject(arg4, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg5));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::settle_rewarder_with_cap(arg3, arg0, arg4, settlement_cap_ref(&arg2.pool_settlement_cap));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_operation_profile_matches(arg4, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg5));
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::previous_exposure(arg4) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::total_sy<T0>(arg5), 9208);
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::operation_guard(arg4) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::reward_guard<T0>(arg5), 9208);
        update_pool_lp_points<T0>(arg1, arg2, arg5, arg6);
    }

    public fun settle_yt_reward_operation<T0: drop>(arg0: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg1: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg2: &mut PointConfig, arg3: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardDistributor, arg5: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardOperation, arg6: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg7: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg6, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::state_id<T0>(arg7));
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::market_id(arg6) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::market_id<T0>(arg7), 9203);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_subject(arg5, 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg6));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_owner(arg5, 0x2::tx_context::sender(arg9));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::settle_rewarder_with_cap(arg4, arg0, arg5, settlement_cap_ref(&arg2.yt_settlement_cap));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_operation_profile_matches(arg5, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::market_id<T0>(arg7));
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::previous_exposure(arg5) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::yt_balance(arg6), 9208);
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::operation_guard(arg5) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::yt_reward_guard(arg6), 9208);
        sync_py_position<T0>(arg2, arg3, arg1, arg6, arg7, arg8, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::operation_owner(arg5));
    }

    fun settlement_cap_ref(arg0: &0x1::option::Option<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>) : &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap {
        assert!(0x1::option::is_some<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(arg0), 9206);
        0x1::option::borrow<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewarderSettlementCap>(arg0)
    }

    fun sync_py_position<T0: drop>(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg5: &0x2::clock::Clock, arg6: address) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg3, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::state_id<T0>(arg4));
        assert!(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::market_id(arg3) == 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::market_id<T0>(arg4), 9203);
        assert_yt_market_allowed(arg0, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::market_id(arg3));
        let v0 = if (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::is_expired_state<T0>(arg4, arg5)) {
            0
        } else {
            (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::yt_balance(arg3) as u256)
        };
        let v1 = weighted_points(v0, yt_market_multiplier_bps(arg0, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::market_id(arg3)));
        set_yt_position_contribution(arg0, arg1, arg2, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::market_id(arg3), 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg3), arg6, v0, v1, arg5);
    }

    public fun sync_py_position_owner_with_points<T0: drop>(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg6: address, arg7: &0x2::clock::Clock) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        sync_py_position<T0>(arg0, arg1, arg3, arg4, arg5, arg7, arg6);
    }

    public fun sync_py_position_with_points<T0: drop>(arg0: &mut PointConfig, arg1: &mut 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::scoreboard::Scoreboard, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg3: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::global_config::GlobalConfig, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg5: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state::PyState<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg2);
        sync_py_position<T0>(arg0, arg1, arg3, arg4, arg5, arg6, 0x2::tx_context::sender(arg7));
    }

    public fun total_lp_points_accrued<T0: drop>(arg0: &LpPointState<T0>) : u64 {
        arg0.total_lp_points_accrued
    }

    public fun total_yt_amount(arg0: &PointConfig) : u256 {
        arg0.total_yt_amount
    }

    public fun total_yt_base(arg0: &PointConfig) : u256 {
        arg0.total_yt_base
    }

    fun update_pool_lp_points<T0: drop>(arg0: &PointConfig, arg1: &mut LpPointState<T0>, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::Pool<T0>, arg3: &0x2::clock::Clock) {
        assert_lp_state_match<T0>(arg0, arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 <= arg1.last_updated_ms) {
            return
        };
        if (arg1.point_config_version != arg0.config_version) {
            arg1.point_config_version = arg0.config_version;
            arg1.last_updated_ms = v0;
            return
        };
        let v1 = arg1.last_updated_ms;
        arg1.last_updated_ms = v0;
        let v2 = if (!arg0.enabled) {
            true
        } else if (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::lp_supply<T0>(arg2) == 0) {
            true
        } else {
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::total_sy<T0>(arg2) == 0
        };
        if (v2) {
            return
        };
        let v3 = if (v0 > 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::expiry<T0>(arg2)) {
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::expiry<T0>(arg2)
        } else {
            v0
        };
        if (v3 <= v1) {
            return
        };
        let v4 = v3 - v1;
        let v5 = calc_lp_points(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::total_sy<T0>(arg2), combined_multiplier_bps(arg0.lp_multiplier_bps, arg1.lp_multiplier_bps), v4, arg0.duration);
        if (v5 == 0) {
            return
        };
        arg1.acc_point_per_lp = arg1.acc_point_per_lp + (((v5 as u256) * (1000000000000 as u256) / (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::lp_supply<T0>(arg2) as u256)) as u128);
        arg1.total_lp_points_accrued = arg1.total_lp_points_accrued + v5;
        let v6 = LpPointAccumulatorUpdatedEvent{
            state_id         : 0x2::object::id<LpPointState<T0>>(arg1),
            pool_id          : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::pool_id<T0>(arg2),
            elapsed_ms       : v4,
            total_sy         : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::total_sy<T0>(arg2),
            lp_supply        : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::pool::lp_supply<T0>(arg2),
            points_accrued   : v5,
            acc_point_per_lp : arg1.acc_point_per_lp,
        };
        0x2::event::emit<LpPointAccumulatorUpdatedEvent>(v6);
    }

    public fun user_yt_base(arg0: &PointConfig, arg1: address) : u256 {
        let v0 = UserKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<UserKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<UserKey, UserYtExposure>(&arg0.id, v0).yt_base
    }

    fun weighted_points(arg0: u256, arg1: u64) : u256 {
        arg0 * (arg1 as u256) / (10000 as u256)
    }

    public fun yt_market_allowed(arg0: &PointConfig, arg1: 0x2::object::ID) : bool {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)
    }

    public fun yt_market_amount(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).yt_amount
    }

    public fun yt_market_base(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = YtMarketAllowedKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtMarketAllowedKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<YtMarketAllowedKey, YtMarketExposure>(&arg0.id, v0).yt_base
    }

    public fun yt_market_multiplier_bps(arg0: &PointConfig, arg1: 0x2::object::ID) : u64 {
        let v0 = YtPointWeightKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<YtPointWeightKey>(&arg0.id, v0)) {
            return 10000
        };
        0x2::dynamic_field::borrow<YtPointWeightKey, YtPointWeight>(&arg0.id, v0).multiplier_bps
    }

    public fun yt_multiplier_bps(arg0: &PointConfig) : u64 {
        arg0.yt_multiplier_bps
    }

    public fun yt_position_amount(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0).raw_amount
    }

    public fun yt_position_base(arg0: &PointConfig, arg1: 0x2::object::ID) : u256 {
        let v0 = PositionKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<PositionKey>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<PositionKey, YtPositionContribution>(&arg0.id, v0).base_amount
    }

    // decompiled from Move bytecode v7
}

