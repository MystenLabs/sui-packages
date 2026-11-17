module 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::feed_registry {
    struct FeedRegistry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        feeds: 0x2::table::Table<0x1::type_name::TypeName, FeedConfig>,
        removed_at: 0x2::table::Table<0x1::type_name::TypeName, u64>,
    }

    struct FeedConfig has copy, drop, store {
        feed_id: vector<u8>,
        decimals: u8,
        max_confidence_bps: u16,
        removal_due_ms: u64,
        pending_feed_id: vector<u8>,
        update_due_ms: u64,
    }

    struct MasterValuerPythCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeedRegisteredEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        feed_id: vector<u8>,
        decimals: u8,
        max_confidence_bps: u16,
    }

    struct FeedConfidenceUpdatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        max_confidence_bps: u16,
    }

    struct FeedRemovalScheduledEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        removal_due_ms: u64,
    }

    struct FeedRemovalCancelledEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
    }

    struct FeedRemovedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
    }

    struct FeedUpdateScheduledEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        pending_feed_id: vector<u8>,
        update_due_ms: u64,
    }

    struct FeedUpdateCancelledEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        feed_id: vector<u8>,
    }

    struct FeedUpdatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        old_feed_id: vector<u8>,
        feed_id: vector<u8>,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    public fun allowed_versions(arg0: &FeedRegistry) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    public fun assert_not_scheduled_for_removal(arg0: &FeedConfig) {
        assert!(arg0.removal_due_ms == 0, 1506);
    }

    public fun borrow_feed<T0>(arg0: &FeedRegistry) : FeedConfig {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, v0), 1501);
        *0x2::table::borrow<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, v0)
    }

    public fun cancel_feed_removal<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        assert!(v1.removal_due_ms != 0, 1504);
        v1.removal_due_ms = 0;
        let v2 = FeedRemovalCancelledEvent{
            registry_id : 0x2::object::id<FeedRegistry>(arg1),
            asset_type  : v0,
        };
        0x2::event::emit<FeedRemovalCancelledEvent>(v2);
    }

    public fun cancel_feed_update<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        assert!(v1.update_due_ms != 0, 1510);
        v1.pending_feed_id = b"";
        v1.update_due_ms = 0;
        let v2 = FeedUpdateCancelledEvent{
            registry_id : 0x2::object::id<FeedRegistry>(arg1),
            asset_type  : v0,
            feed_id     : v1.pending_feed_id,
        };
        0x2::event::emit<FeedUpdateCancelledEvent>(v2);
    }

    public fun config_decimals(arg0: &FeedConfig) : u8 {
        arg0.decimals
    }

    public fun config_feed_id(arg0: &FeedConfig) : vector<u8> {
        arg0.feed_id
    }

    public fun config_max_confidence_bps(arg0: &FeedConfig) : u16 {
        arg0.max_confidence_bps
    }

    public fun config_pending_feed_id(arg0: &FeedConfig) : vector<u8> {
        arg0.pending_feed_id
    }

    public fun config_removal_due_ms(arg0: &FeedConfig) : u64 {
        arg0.removal_due_ms
    }

    public fun config_update_due_ms(arg0: &FeedConfig) : u64 {
        arg0.update_due_ms
    }

    public fun default_confidence_bps() : u16 {
        500
    }

    public fun disable_version(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: u64) {
        assert!(arg2 != 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 1515);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<FeedRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    public fun enable_version(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: u64) {
        assert!(arg2 <= 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version() + 1, 1514);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<FeedRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    public fun execute_feed_removal<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0).removal_due_ms;
        assert!(v1 != 0, 1504);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v1, 1503);
        0x2::table::remove<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg1.removed_at, v0, v2);
        let v3 = FeedRemovedEvent{
            registry_id : 0x2::object::id<FeedRegistry>(arg1),
            asset_type  : v0,
        };
        0x2::event::emit<FeedRemovedEvent>(v3);
    }

    public fun execute_feed_update<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        assert!(v1.update_due_ms != 0, 1510);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(pio_feed_id(arg3) == v1.pending_feed_id, 1513);
        let v3 = v2 / 1000;
        let v4 = pio_published_ms(arg3) / 1000;
        let v5 = if (v3 > v4) {
            v3 - v4
        } else {
            v4 - v3
        };
        assert!(v5 < 30, 1513);
        let v6 = 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::pyth_reader::get_validated_price_with_age(arg3, v1.pending_feed_id, arg4, 30);
        assert!(0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::within_confidence(&v6, (v1.max_confidence_bps as u64)), 1513);
        let v7 = v1.update_due_ms - 604800000;
        let v8 = v2 - v7;
        let v9 = if (v8 >= 604800000) {
            true
        } else if (v8 >= 86400000) {
            if (pio_feed_id(arg2) == v1.feed_id) {
                pio_published_ms(arg2) < v7
            } else {
                false
            }
        } else {
            false
        };
        assert!(v9, 1511);
        let v10 = v1.pending_feed_id;
        v1.feed_id = v10;
        v1.pending_feed_id = b"";
        v1.update_due_ms = 0;
        let v11 = FeedUpdatedEvent{
            registry_id : 0x2::object::id<FeedRegistry>(arg1),
            asset_type  : v0,
            old_feed_id : v1.feed_id,
            feed_id     : v10,
        };
        0x2::event::emit<FeedUpdatedEvent>(v11);
    }

    public fun feed<T0>(arg0: &FeedRegistry) : 0x1::option::Option<FeedConfig> {
        feed_by_type(arg0, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun feed_by_type(arg0: &FeedRegistry, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<FeedConfig> {
        if (0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, arg1)) {
            0x1::option::some<FeedConfig>(*0x2::table::borrow<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, arg1))
        } else {
            0x1::option::none<FeedConfig>()
        }
    }

    public fun feed_count(arg0: &FeedRegistry) : u64 {
        0x2::table::length<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds)
    }

    public fun feed_dead_ms() : u64 {
        86400000
    }

    public fun feed_removal_delay_ms() : u64 {
        604800000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_registry(arg0);
        0x2::transfer::share_object<FeedRegistry>(v0);
        let v1 = MasterValuerPythCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterValuerPythCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun is_dead(arg0: u64, arg1: u64) : bool {
        arg1 > arg0 && arg1 - arg0 > 86400000
    }

    public fun is_registered<T0>(arg0: &FeedRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg0.feeds, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun max_confidence_ceiling_bps() : u16 {
        500
    }

    public fun max_price_age_secs() : u64 {
        30
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : FeedRegistry {
        FeedRegistry{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::current_version()),
            feeds            : 0x2::table::new<0x1::type_name::TypeName, FeedConfig>(arg0),
            removed_at       : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
        }
    }

    public(friend) fun pio_feed_id(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : vector<u8> {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1)
    }

    public(friend) fun pio_published_ms(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v0) * 1000
    }

    fun register<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: vector<u8>, arg3: u8, arg4: u16, arg5: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1500);
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.removed_at, v0)) {
            assert!(0x2::clock::timestamp_ms(arg5) >= *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg1.removed_at, v0) + 604800000, 1508);
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg1.removed_at, v0);
        };
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1507);
        assert!(arg3 <= 18, 1505);
        assert!(arg4 <= 500, 1502);
        let v1 = FeedConfig{
            feed_id            : arg2,
            decimals           : arg3,
            max_confidence_bps : arg4,
            removal_due_ms     : 0,
            pending_feed_id    : b"",
            update_due_ms      : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0, v1);
        let v2 = FeedRegisteredEvent{
            registry_id        : 0x2::object::id<FeedRegistry>(arg1),
            asset_type         : v0,
            feed_id            : arg2,
            decimals           : arg3,
            max_confidence_bps : arg4,
        };
        0x2::event::emit<FeedRegisteredEvent>(v2);
    }

    public fun register_feed<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: vector<u8>, arg4: u16, arg5: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        register<T0>(arg0, arg1, arg3, 0x2::coin::get_decimals<T0>(arg2), arg4, arg5);
    }

    public fun register_feed_from_currency<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: &0x2::coin_registry::Currency<T0>, arg3: vector<u8>, arg4: u16, arg5: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        register<T0>(arg0, arg1, arg3, 0x2::coin_registry::decimals<T0>(arg2), arg4, arg5);
    }

    public fun removal_cooldown_ms() : u64 {
        604800000
    }

    public fun removed_at<T0>(arg0: &FeedRegistry) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.removed_at, v0)) {
            0x1::option::some<u64>(*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.removed_at, v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun schedule_feed_removal<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        assert!(v1.update_due_ms == 0, 1509);
        let v2 = 0x2::clock::timestamp_ms(arg2) + 604800000;
        v1.removal_due_ms = v2;
        let v3 = FeedRemovalScheduledEvent{
            registry_id    : 0x2::object::id<FeedRegistry>(arg1),
            asset_type     : v0,
            removal_due_ms : v2,
        };
        0x2::event::emit<FeedRemovalScheduledEvent>(v3);
    }

    public fun schedule_feed_update<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1507);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0);
        assert!(v1.removal_due_ms == 0, 1506);
        assert!(arg2 != v1.feed_id, 1512);
        let v2 = 0x2::clock::timestamp_ms(arg3) + 604800000;
        v1.pending_feed_id = arg2;
        v1.update_due_ms = v2;
        let v3 = FeedUpdateScheduledEvent{
            registry_id     : 0x2::object::id<FeedRegistry>(arg1),
            asset_type      : v0,
            pending_feed_id : arg2,
            update_due_ms   : v2,
        };
        0x2::event::emit<FeedUpdateScheduledEvent>(v3);
    }

    public fun set_max_confidence_bps<T0>(arg0: &MasterValuerPythCap, arg1: &mut FeedRegistry, arg2: u16) {
        0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 <= 500, 1502);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedConfig>(&arg1.feeds, v0), 1501);
        0x2::table::borrow_mut<0x1::type_name::TypeName, FeedConfig>(&mut arg1.feeds, v0).max_confidence_bps = arg2;
        let v1 = FeedConfidenceUpdatedEvent{
            registry_id        : 0x2::object::id<FeedRegistry>(arg1),
            asset_type         : v0,
            max_confidence_bps : arg2,
        };
        0x2::event::emit<FeedConfidenceUpdatedEvent>(v1);
    }

    // decompiled from Move bytecode v7
}

