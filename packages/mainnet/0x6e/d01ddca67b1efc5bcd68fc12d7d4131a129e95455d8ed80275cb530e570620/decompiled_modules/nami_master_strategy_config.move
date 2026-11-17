module 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config {
    struct MasterStrategyCap has store, key {
        id: 0x2::object::UID,
    }

    struct MasterStrategyConfig has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        performance_fee_bps: u16,
        creator_fee_bps: u16,
        min_crystallize_interval_ms: u64,
        fulfillment_window: u64,
        lno_address: address,
        community_treasury_address: address,
        community_treasury_locked: bool,
        fee_anchor_rate_bps_per_day: u16,
        lending_min_health_bps: u64,
        lp_price_band_bps: u64,
        paused: bool,
        paused_total_ms: u64,
        paused_at_ms: u64,
        cetus_partner_id: 0x1::option::Option<0x2::object::ID>,
        base_coin_floors: 0x2::vec_map::VecMap<0x1::type_name::TypeName, BaseCoinFloors>,
    }

    struct BaseCoinFloors has copy, drop, store {
        min_deposit: u64,
        isolation_bond: u64,
    }

    struct ConfigUpdatedEvent has copy, drop {
        performance_fee_bps: u16,
        creator_fee_bps: u16,
        min_crystallize_interval_ms: u64,
        fulfillment_window: u64,
        lno_address: address,
        community_treasury_address: address,
        fee_anchor_rate_bps_per_day: u16,
        lending_min_health_bps: u64,
        lp_price_band_bps: u64,
    }

    struct BaseCoinFloorsSetEvent has copy, drop {
        coin: 0x1::type_name::TypeName,
        min_deposit: u64,
        isolation_bond: u64,
    }

    struct CommunityTreasuryLockedEvent has copy, drop {
        community_treasury_address: address,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct CetusPartnerUpdatedEvent has copy, drop {
        old_partner_id: 0x1::option::Option<0x2::object::ID>,
        new_partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PausedEvent has copy, drop {
        config_id: 0x2::object::ID,
    }

    struct UnpausedEvent has copy, drop {
        config_id: 0x2::object::ID,
    }

    public fun allowed_versions(arg0: &MasterStrategyConfig) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    public fun assert_community_treasury_locked(arg0: &MasterStrategyConfig) {
        assert!(arg0.community_treasury_locked, 10);
    }

    public fun assert_not_paused(arg0: &MasterStrategyConfig) {
        assert!(!arg0.paused, 24);
    }

    public fun cetus_partner_id(arg0: &MasterStrategyConfig) : 0x1::option::Option<0x2::object::ID> {
        arg0.cetus_partner_id
    }

    public fun community_treasury_address(arg0: &MasterStrategyConfig) : address {
        arg0.community_treasury_address
    }

    public fun community_treasury_locked(arg0: &MasterStrategyConfig) : bool {
        arg0.community_treasury_locked
    }

    public fun creator_fee_bps(arg0: &MasterStrategyConfig) : u16 {
        arg0.creator_fee_bps
    }

    public fun disable_version(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64) {
        assert!(arg2 != 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 23);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<MasterStrategyConfig>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    fun emit_config_updated(arg0: &MasterStrategyConfig) {
        let v0 = ConfigUpdatedEvent{
            performance_fee_bps         : arg0.performance_fee_bps,
            creator_fee_bps             : arg0.creator_fee_bps,
            min_crystallize_interval_ms : arg0.min_crystallize_interval_ms,
            fulfillment_window          : arg0.fulfillment_window,
            lno_address                 : arg0.lno_address,
            community_treasury_address  : arg0.community_treasury_address,
            fee_anchor_rate_bps_per_day : arg0.fee_anchor_rate_bps_per_day,
            lending_min_health_bps      : arg0.lending_min_health_bps,
            lp_price_band_bps           : arg0.lp_price_band_bps,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    public fun enable_version(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64) {
        assert!(arg2 <= 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::current_version() + 1, 22);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<MasterStrategyConfig>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    public fun fee_anchor_rate_bps_per_day(arg0: &MasterStrategyConfig) : u16 {
        arg0.fee_anchor_rate_bps_per_day
    }

    fun floors_of<T0>(arg0: &MasterStrategyConfig) : BaseCoinFloors {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, BaseCoinFloors>(&arg0.base_coin_floors, &v0), 25);
        *0x2::vec_map::get<0x1::type_name::TypeName, BaseCoinFloors>(&arg0.base_coin_floors, &v0)
    }

    public fun fulfillment_window(arg0: &MasterStrategyConfig) : u64 {
        arg0.fulfillment_window
    }

    public(friend) fun initialize(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : MasterStrategyCap {
        assert!(arg0 != @0x0, 7);
        assert!(arg1 != @0x0, 7);
        let v0 = new_config(arg0, arg1, false, 0x2::vec_set::singleton<u64>(0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::current_version()), arg2);
        let v1 = MasterStrategyCap{id: 0x2::object::new(arg2)};
        0x2::transfer::share_object<MasterStrategyConfig>(v0);
        v1
    }

    public fun is_base_coin<T0>(arg0: &MasterStrategyConfig) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_map::contains<0x1::type_name::TypeName, BaseCoinFloors>(&arg0.base_coin_floors, &v0)
    }

    public fun isolation_bond_floor<T0>(arg0: &MasterStrategyConfig) : u64 {
        let v0 = floors_of<T0>(arg0);
        v0.isolation_bond
    }

    public fun lending_min_health_bps(arg0: &MasterStrategyConfig) : u64 {
        arg0.lending_min_health_bps
    }

    public fun lno_address(arg0: &MasterStrategyConfig) : address {
        arg0.lno_address
    }

    public fun lock_community_treasury_address(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(!arg1.community_treasury_locked, 9);
        arg1.community_treasury_locked = true;
        let v0 = CommunityTreasuryLockedEvent{community_treasury_address: arg1.community_treasury_address};
        0x2::event::emit<CommunityTreasuryLockedEvent>(v0);
    }

    public fun lp_price_band_bps(arg0: &MasterStrategyConfig) : u64 {
        arg0.lp_price_band_bps
    }

    public fun min_crystallize_interval_ms(arg0: &MasterStrategyConfig) : u64 {
        arg0.min_crystallize_interval_ms
    }

    public fun min_deposit_floor<T0>(arg0: &MasterStrategyConfig) : u64 {
        let v0 = floors_of<T0>(arg0);
        v0.min_deposit
    }

    fun new_config(arg0: address, arg1: address, arg2: bool, arg3: 0x2::vec_set::VecSet<u64>, arg4: &mut 0x2::tx_context::TxContext) : MasterStrategyConfig {
        MasterStrategyConfig{
            id                          : 0x2::object::new(arg4),
            allowed_versions            : arg3,
            performance_fee_bps         : 2000,
            creator_fee_bps             : 5000,
            min_crystallize_interval_ms : 2592000000,
            fulfillment_window          : 259200000,
            lno_address                 : arg0,
            community_treasury_address  : arg1,
            community_treasury_locked   : arg2,
            fee_anchor_rate_bps_per_day : 100,
            lending_min_health_bps      : 12000,
            lp_price_band_bps           : 100,
            paused                      : false,
            paused_total_ms             : 0,
            paused_at_ms                : 0,
            cetus_partner_id            : 0x1::option::none<0x2::object::ID>(),
            base_coin_floors            : 0x2::vec_map::empty<0x1::type_name::TypeName, BaseCoinFloors>(),
        }
    }

    public fun pause(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: &0x2::clock::Clock) {
        if (arg1.paused) {
            return
        };
        arg1.paused = true;
        arg1.paused_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = PausedEvent{config_id: 0x2::object::id<MasterStrategyConfig>(arg1)};
        0x2::event::emit<PausedEvent>(v0);
    }

    public fun paused(arg0: &MasterStrategyConfig) : bool {
        arg0.paused
    }

    public fun paused_at_ms(arg0: &MasterStrategyConfig) : u64 {
        arg0.paused_at_ms
    }

    public fun paused_total_ms(arg0: &MasterStrategyConfig) : u64 {
        arg0.paused_total_ms
    }

    public fun performance_fee_bps(arg0: &MasterStrategyConfig) : u16 {
        arg0.performance_fee_bps
    }

    public fun set_base_coin_floors<T0>(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64, arg3: u64) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 > 0, 6);
        assert!(arg3 > 0, 8);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = BaseCoinFloors{
            min_deposit    : arg2,
            isolation_bond : arg3,
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, BaseCoinFloors>(&arg1.base_coin_floors, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, BaseCoinFloors>(&mut arg1.base_coin_floors, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, BaseCoinFloors>(&mut arg1.base_coin_floors, v0, v1);
        };
        let v2 = BaseCoinFloorsSetEvent{
            coin           : v0,
            min_deposit    : arg2,
            isolation_bond : arg3,
        };
        0x2::event::emit<BaseCoinFloorsSetEvent>(v2);
    }

    public fun set_cetus_partner_id(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: 0x1::option::Option<0x2::object::ID>) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        arg1.cetus_partner_id = arg2;
        let v0 = CetusPartnerUpdatedEvent{
            old_partner_id : arg1.cetus_partner_id,
            new_partner_id : arg2,
        };
        0x2::event::emit<CetusPartnerUpdatedEvent>(v0);
    }

    public fun set_community_treasury_address(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: address) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(!arg1.community_treasury_locked, 9);
        assert!(arg2 != @0x0, 7);
        arg1.community_treasury_address = arg2;
        emit_config_updated(arg1);
    }

    public fun unpause(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: &0x2::clock::Clock) {
        if (!arg1.paused) {
            return
        };
        arg1.paused = false;
        arg1.paused_total_ms = arg1.paused_total_ms + 0x2::clock::timestamp_ms(arg2) - arg1.paused_at_ms;
        arg1.paused_at_ms = 0;
        let v0 = UnpausedEvent{config_id: 0x2::object::id<MasterStrategyConfig>(arg1)};
        0x2::event::emit<UnpausedEvent>(v0);
    }

    public fun unpaused_ms(arg0: &MasterStrategyConfig, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = if (arg0.paused) {
            v0 - arg0.paused_at_ms
        } else {
            0
        };
        v0 - arg0.paused_total_ms - v1
    }

    public fun update_creator_fee_bps(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u16) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= 1000, 2);
        assert!(arg2 <= 9000, 3);
        arg1.creator_fee_bps = arg2;
        emit_config_updated(arg1);
    }

    public fun update_fee_anchor_rate_bps_per_day(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u16) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= 5, 13);
        assert!(arg2 <= 300, 14);
        arg1.fee_anchor_rate_bps_per_day = arg2;
        emit_config_updated(arg1);
    }

    public fun update_fulfillment_window(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= 86400000, 4);
        assert!(arg2 <= 604800000, 5);
        arg1.fulfillment_window = arg2;
        emit_config_updated(arg1);
    }

    public fun update_lending_min_health_bps(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= 10000, 18);
        assert!(arg2 <= 30000, 19);
        arg1.lending_min_health_bps = arg2;
        emit_config_updated(arg1);
    }

    public fun update_lno_address(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: address) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 != @0x0, 7);
        arg1.lno_address = arg2;
        emit_config_updated(arg1);
    }

    public fun update_lp_price_band_bps(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= 10, 20);
        assert!(arg2 <= 1000, 21);
        arg1.lp_price_band_bps = arg2;
        emit_config_updated(arg1);
    }

    public fun update_min_crystallize_interval_ms(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u64) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= 604800000, 11);
        assert!(arg2 <= 31536000000, 12);
        arg1.min_crystallize_interval_ms = arg2;
        emit_config_updated(arg1);
    }

    public fun update_performance_fee_bps(arg0: &MasterStrategyCap, arg1: &mut MasterStrategyConfig, arg2: u16) {
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 <= 5000, 1);
        arg1.performance_fee_bps = arg2;
        emit_config_updated(arg1);
    }

    // decompiled from Move bytecode v7
}

