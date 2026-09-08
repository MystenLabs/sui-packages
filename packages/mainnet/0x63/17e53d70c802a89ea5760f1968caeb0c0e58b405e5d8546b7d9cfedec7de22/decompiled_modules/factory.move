module 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::factory {
    struct PoolInitParams has copy, drop, store {
        active_bin_id: u32,
        fee_params: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters,
        min_liquidity_x: u64,
        min_liquidity_y: u64,
        lazer_feed_id_x: u32,
        lazer_feed_id_y: u32,
    }

    struct PoolMetadata has copy, drop, store {
        coin_type_a: vector<u8>,
        coin_type_b: vector<u8>,
        creator: address,
        created_at: u64,
        bin_step: u16,
        ignored_for_routing: bool,
        swap_enabled: bool,
        base_fee_rate: u64,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        metadata: 0x2::table::Table<0x2::object::ID, PoolMetadata>,
        pool_count: u64,
        creation_paused: bool,
        extra: 0x2::bag::Bag,
    }

    struct FactoryInitialized has copy, drop {
        registry_id: 0x2::object::ID,
        version: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::ascii::String,
        coin_type_b: 0x1::ascii::String,
        bin_step: u16,
        active_bin_id: u32,
        creator: address,
        created_at: u64,
        fee_params: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters,
        min_liquidity_x: u64,
        min_liquidity_y: u64,
    }

    struct CreationPaused has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct CreationUnpaused has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct FactoryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct PoolRoutingFlagChanged has copy, drop {
        pool_id: 0x2::object::ID,
        ignored_for_routing: bool,
        by: address,
    }

    fun active_bin_bounds(arg0: u16) : (u32, u32) {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::bin_id_offset();
        let v1 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::price_range_num_low() / (arg0 as u32);
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            1
        };
        let v3 = (v0 as u64) + ((0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::constants::price_range_num() / (arg0 as u32)) as u64);
        let v4 = if (v3 > (16777215 as u64)) {
            16777215
        } else {
            (v3 as u32)
        };
        (v2, v4)
    }

    fun assert_version(arg0: &PoolRegistry) {
        assert!(arg0.version == 1, 504);
    }

    fun coin_type_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    entry fun create_pool<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut PoolRegistry, arg3: PoolInitParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg1, arg0);
        let (v0, v1) = prepare_create<T0, T1>(arg2, &arg3);
        let v2 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::create_and_share_pool<T0, T1>(arg3.fee_params, arg3.active_bin_id, arg3.min_liquidity_x, arg3.min_liquidity_y, arg3.lazer_feed_id_x, arg3.lazer_feed_id_y, arg5);
        record_pool(arg2, v2, v0, v1, arg3.fee_params, arg3.active_bin_id, arg3.min_liquidity_x, arg3.min_liquidity_y, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4));
        emit_creation_feed_ids(v2, &arg3);
    }

    entry fun create_pool_with_lending<T0, T1>(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut PoolRegistry, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: PoolInitParams, arg5: 0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::PoolLendingConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg1, arg0);
        let (v0, v1) = prepare_create<T0, T1>(arg2, &arg4);
        0x6f5a15f2859ce3b9bdfc82a4fa7419e62b3d4f65b1c333eabaca672a55b7e124::lending::assert_enabled_markets_exist(arg3, &arg5);
        let v2 = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::create_and_share_pool_with_lending<T0, T1>(arg4.fee_params, arg4.active_bin_id, arg4.min_liquidity_x, arg4.min_liquidity_y, arg4.lazer_feed_id_x, arg4.lazer_feed_id_y, arg3, arg5, arg7);
        record_pool(arg2, v2, v0, v1, arg4.fee_params, arg4.active_bin_id, arg4.min_liquidity_x, arg4.min_liquidity_y, 0x2::tx_context::sender(arg7), 0x2::clock::timestamp_ms(arg6));
        emit_creation_feed_ids(v2, &arg4);
    }

    public fun current_version() : u64 {
        1
    }

    fun emit_creation_feed_ids(arg0: 0x2::object::ID, arg1: &PoolInitParams) {
        if (arg1.lazer_feed_id_x != 0 || arg1.lazer_feed_id_y != 0) {
            0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::emit_lazer_feed_ids_set(arg0, arg1.lazer_feed_id_x, arg1.lazer_feed_id_y);
        };
    }

    fun increment_pool_count(arg0: u64) : u64 {
        assert!(arg0 < 18446744073709551615, 506);
        arg0 + 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id              : 0x2::object::new(arg0),
            version         : 1,
            metadata        : 0x2::table::new<0x2::object::ID, PoolMetadata>(arg0),
            pool_count      : 0,
            creation_paused : false,
            extra           : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
        let v1 = FactoryInitialized{
            registry_id : 0x2::object::id<PoolRegistry>(&v0),
            version     : 1,
        };
        0x2::event::emit<FactoryInitialized>(v1);
    }

    public fun is_creation_paused(arg0: &PoolRegistry) : bool {
        arg0.creation_paused
    }

    fun is_less_than(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = 0;
        while (v3 < v2) {
            if (*0x1::vector::borrow<u8>(arg0, v3) < *0x1::vector::borrow<u8>(arg1, v3)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v3) > *0x1::vector::borrow<u8>(arg1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        v0 < v1
    }

    public fun metadata_base_fee_rate(arg0: &PoolMetadata) : u64 {
        arg0.base_fee_rate
    }

    public fun metadata_bin_step(arg0: &PoolMetadata) : u16 {
        arg0.bin_step
    }

    public fun metadata_coin_type_a(arg0: &PoolMetadata) : vector<u8> {
        arg0.coin_type_a
    }

    public fun metadata_coin_type_b(arg0: &PoolMetadata) : vector<u8> {
        arg0.coin_type_b
    }

    public fun metadata_created_at(arg0: &PoolMetadata) : u64 {
        arg0.created_at
    }

    public fun metadata_creator(arg0: &PoolMetadata) : address {
        arg0.creator
    }

    public fun metadata_ignored_for_routing(arg0: &PoolMetadata) : bool {
        arg0.ignored_for_routing
    }

    public fun metadata_swap_enabled(arg0: &PoolMetadata) : bool {
        arg0.swap_enabled
    }

    entry fun migrate(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg2: &mut PoolRegistry) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg0, arg1);
        assert!(arg2.version < 1, 504);
        arg2.version = 1;
        let v0 = FactoryMigrated{
            registry_id  : 0x2::object::id<PoolRegistry>(arg2),
            from_version : arg2.version,
            to_version   : 1,
        };
        0x2::event::emit<FactoryMigrated>(v0);
    }

    public fun new_pool_init_params(arg0: u32, arg1: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg2: u64, arg3: u64) : PoolInitParams {
        assert!(arg2 > 0 && arg3 > 0, 507);
        PoolInitParams{
            active_bin_id   : arg0,
            fee_params      : arg1,
            min_liquidity_x : arg2,
            min_liquidity_y : arg3,
            lazer_feed_id_x : 0,
            lazer_feed_id_y : 0,
        }
    }

    public fun pause_creation(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::GuardianCap, arg2: &mut PoolRegistry) {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_guardian_cap(arg0, arg1);
        assert_version(arg2);
        arg2.creation_paused = true;
        let v0 = CreationPaused{registry_id: 0x2::object::id<PoolRegistry>(arg2)};
        0x2::event::emit<CreationPaused>(v0);
    }

    public fun pool_count(arg0: &PoolRegistry) : u64 {
        arg0.pool_count
    }

    public fun pool_init_active_bin_id(arg0: &PoolInitParams) : u32 {
        arg0.active_bin_id
    }

    public fun pool_init_bin_step(arg0: &PoolInitParams) : u16 {
        0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::bin_step(&arg0.fee_params)
    }

    public fun pool_init_fee_params(arg0: &PoolInitParams) : 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters {
        arg0.fee_params
    }

    public fun pool_init_min_liquidity_x(arg0: &PoolInitParams) : u64 {
        arg0.min_liquidity_x
    }

    public fun pool_init_min_liquidity_y(arg0: &PoolInitParams) : u64 {
        arg0.min_liquidity_y
    }

    public fun pool_metadata(arg0: &PoolRegistry, arg1: 0x2::object::ID) : PoolMetadata {
        *0x2::table::borrow<0x2::object::ID, PoolMetadata>(&arg0.metadata, arg1)
    }

    fun prepare_create<T0, T1>(arg0: &PoolRegistry, arg1: &PoolInitParams) : (vector<u8>, vector<u8>) {
        assert_version(arg0);
        assert!(!arg0.creation_paused, 501);
        let (v0, v1) = active_bin_bounds(0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::bin_step(&arg1.fee_params));
        assert!(arg1.active_bin_id >= v0 && arg1.active_bin_id <= v1, 502);
        let v2 = coin_type_bytes<T0>();
        let v3 = coin_type_bytes<T1>();
        assert!(0x1::type_name::with_defining_ids<T1>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 503);
        assert!(is_less_than(&v2, &v3), 503);
        (v2, v3)
    }

    fun record_pool(arg0: &mut PoolRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::FeeParameters, arg5: u32, arg6: u64, arg7: u64, arg8: address, arg9: u64) {
        let v0 = 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee_params::bin_step(&arg4);
        let v1 = PoolCreated{
            pool_id         : arg1,
            coin_type_a     : 0x1::ascii::string(arg2),
            coin_type_b     : 0x1::ascii::string(arg3),
            bin_step        : v0,
            active_bin_id   : arg5,
            creator         : arg8,
            created_at      : arg9,
            fee_params      : arg4,
            min_liquidity_x : arg6,
            min_liquidity_y : arg7,
        };
        0x2::event::emit<PoolCreated>(v1);
        let v2 = PoolMetadata{
            coin_type_a         : arg2,
            coin_type_b         : arg3,
            creator             : arg8,
            created_at          : arg9,
            bin_step            : v0,
            ignored_for_routing : false,
            swap_enabled        : true,
            base_fee_rate       : 0xa08c847da4b323995ffbe377310aa66cfda56fb54e09df4ca807e8d9bbca7be6::fee::get_base_fee(&arg4),
        };
        0x2::table::add<0x2::object::ID, PoolMetadata>(&mut arg0.metadata, arg1, v2);
        arg0.pool_count = increment_pool_count(arg0.pool_count);
    }

    entry fun refresh_pool_metadata<T0, T1>(arg0: &mut PoolRegistry, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>) {
        assert_version(arg0);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_pool_version<T0, T1>(arg1);
        let v0 = 0x2::object::id<0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, PoolMetadata>(&arg0.metadata, v0), 505);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PoolMetadata>(&mut arg0.metadata, v0);
        v1.swap_enabled = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::is_swap_enabled<T0, T1>(arg1);
        v1.base_fee_rate = 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::base_fee_rate<T0, T1>(arg1);
    }

    public fun registry_version(arg0: &PoolRegistry) : u64 {
        arg0.version
    }

    entry fun set_pool_routing_flag(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::OperatorCap, arg1: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminRegistry, arg2: &mut PoolRegistry, arg3: 0x2::object::ID, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg2);
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::assert_operator_cap(arg1, arg0);
        assert!(0x2::table::contains<0x2::object::ID, PoolMetadata>(&arg2.metadata, arg3), 505);
        0x2::table::borrow_mut<0x2::object::ID, PoolMetadata>(&mut arg2.metadata, arg3).ignored_for_routing = arg4;
        let v0 = PoolRoutingFlagChanged{
            pool_id             : arg3,
            ignored_for_routing : arg4,
            by                  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PoolRoutingFlagChanged>(v0);
    }

    public fun unpause_creation(arg0: &0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin::AdminCap, arg1: &mut PoolRegistry) {
        assert_version(arg1);
        arg1.creation_paused = false;
        let v0 = CreationUnpaused{registry_id: 0x2::object::id<PoolRegistry>(arg1)};
        0x2::event::emit<CreationUnpaused>(v0);
    }

    public fun with_lazer_feed_ids(arg0: PoolInitParams, arg1: u32, arg2: u32) : PoolInitParams {
        0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::pool::assert_valid_lazer_feed_ids(arg1, arg2);
        arg0.lazer_feed_id_x = arg1;
        arg0.lazer_feed_id_y = arg2;
        arg0
    }

    // decompiled from Move bytecode v7
}

