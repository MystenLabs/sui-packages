module 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct StockRegistry has store, key {
        id: 0x2::object::UID,
        items: 0x2::table::Table<0x1::type_name::TypeName, StockRegistryItem>,
    }

    struct StockRegistryItem has drop, store {
        price_id: vector<u8>,
        spread: u64,
        fee_ratio: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        max_age: u64,
        max_limit: u64,
        protocol_fee_ratio: u64,
        current_count: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
        k_scaled: u128,
        stock_registry: StockRegistry,
    }

    public(friend) fun add_count(arg0: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: u64) {
        let v0 = get_magnitude(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            if (arg1 >= v0) {
                *arg0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(arg1 - v0, false);
            } else {
                *arg0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v0 - arg1, true);
            };
        } else {
            *arg0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v0 + arg1, false);
        };
    }

    public(friend) fun add_count_count(arg0: &mut Config, arg1: u64) {
        let v0 = &mut arg0.current_count;
        add_count(v0, arg1);
    }

    public fun change_xstock_config(arg0: &0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::admin::AdminCap, arg1: &mut Config, arg2: &mut 0x1::option::Option<u64>, arg3: &mut 0x1::option::Option<u64>, arg4: &mut 0x1::option::Option<u64>, arg5: &mut 0x1::option::Option<u64>, arg6: &mut 0x1::option::Option<u128>) {
        if (0x1::option::is_some<u64>(arg2)) {
            arg1.version = 0x1::option::extract<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(arg3)) {
            arg1.max_age = 0x1::option::extract<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(arg4)) {
            arg1.max_limit = 0x1::option::extract<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(arg5)) {
            arg1.protocol_fee_ratio = 0x1::option::extract<u64>(arg5);
        };
        if (0x1::option::is_some<u128>(arg6)) {
            arg1.k_scaled = 0x1::option::extract<u128>(arg6);
        };
    }

    public fun check_max_limit(arg0: &Config, arg1: u64) {
        assert!(arg1 <= arg0.max_limit, 4001);
    }

    public fun check_version(arg0: &Config) {
        0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::version::check_version(arg0.version);
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 4000);
        let v0 = 0x2::object::new(arg1);
        Config{
            id                 : v0,
            version            : 0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::version::current_version(),
            max_age            : 86400,
            max_limit          : 100000,
            protocol_fee_ratio : 0,
            current_count      : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(0, true),
            k_scaled           : 50000000000,
            stock_registry     : new_registry(arg1),
        }
    }

    public fun get_current_count(arg0: &Config) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        arg0.current_count
    }

    public fun get_fee_ratio<T0>(arg0: &Config) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, StockRegistryItem>(&arg0.stock_registry.items, 0x1::type_name::get<T0>()).fee_ratio
    }

    public fun get_k_scaled(arg0: &Config) : u128 {
        arg0.k_scaled
    }

    public fun get_magnitude(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        }
    }

    public fun get_max_age(arg0: &Config) : u64 {
        arg0.max_age
    }

    public fun get_max_limit(arg0: &Config) : u64 {
        arg0.max_limit
    }

    public fun get_protocol_fee_ratio(arg0: &Config) : u64 {
        arg0.protocol_fee_ratio
    }

    public fun get_registry_price_id<T0>(arg0: &Config) : vector<u8> {
        assert!(registry_contains<T0>(arg0), 4003);
        0x2::table::borrow<0x1::type_name::TypeName, StockRegistryItem>(&arg0.stock_registry.items, 0x1::type_name::get<T0>()).price_id
    }

    public fun get_spread<T0>(arg0: &Config) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, StockRegistryItem>(&arg0.stock_registry.items, 0x1::type_name::get<T0>()).spread
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = create_config<CONFIG>(&arg0, arg1);
        0x2::transfer::public_share_object<Config>(v1);
        0x2::transfer::public_share_object<0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::treasury::Treasury>(0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::treasury::create_treasury(arg1));
        0x2::transfer::public_transfer<0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::admin::AdminCap>(0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::admin::create_admin_cap(arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CONFIG>(arg0, arg1), v0);
    }

    public(friend) fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : StockRegistry {
        StockRegistry{
            id    : 0x2::object::new(arg0),
            items : 0x2::table::new<0x1::type_name::TypeName, StockRegistryItem>(arg0),
        }
    }

    public fun registry_add<T0>(arg0: &0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::admin::AdminCap, arg1: &mut Config, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = StockRegistryItem{
            price_id  : arg2,
            spread    : arg3,
            fee_ratio : arg4,
        };
        assert!(!registry_contains<T0>(arg1), 4002);
        0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::events::emit_add_registry_event<T0>(arg2, arg5);
        0x2::table::add<0x1::type_name::TypeName, StockRegistryItem>(&mut arg1.stock_registry.items, 0x1::type_name::get<T0>(), v0);
    }

    public fun registry_contains<T0>(arg0: &Config) : bool {
        0x2::table::contains<0x1::type_name::TypeName, StockRegistryItem>(&arg0.stock_registry.items, 0x1::type_name::get<T0>())
    }

    public fun registry_remove<T0>(arg0: &0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::admin::AdminCap, arg1: &mut Config, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(registry_contains<T0>(arg1), 4003);
        0x14c1f05029a76bb16d95f62ce42a3c195fd67a64a80ec7e10329d4e0334508cf::events::emit_remove_registry_event<T0>(arg2, arg3);
        0x2::table::remove<0x1::type_name::TypeName, StockRegistryItem>(&mut arg1.stock_registry.items, 0x1::type_name::get<T0>());
    }

    public(friend) fun sub_count(arg0: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg1: u64) {
        let v0 = get_magnitude(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            *arg0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v0 + arg1, true);
        } else if (arg1 > v0) {
            *arg0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(arg1 - v0, true);
        } else {
            *arg0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(v0 - arg1, false);
        };
    }

    public(friend) fun sub_count_count(arg0: &mut Config, arg1: u64) {
        let v0 = &mut arg0.current_count;
        sub_count(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

