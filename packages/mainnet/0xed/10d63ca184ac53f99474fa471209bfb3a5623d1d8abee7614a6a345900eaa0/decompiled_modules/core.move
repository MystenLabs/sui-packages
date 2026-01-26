module 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::core {
    struct TypeKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SymbolPriceConfig<phantom T0> has store {
        pyth_feeder_id: 0x1::option::Option<0x2::object::ID>,
        stork_feeder_id: 0x1::option::Option<vector<u8>>,
        enabled_sources: u8,
        max_slippage: u64,
    }

    struct NormalizedPrice has copy, drop, store {
        price: u128,
        expo: 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64,
        conf: u64,
        publish_time: u64,
        source: u8,
    }

    struct ConfigAdded<phantom T0> has copy, drop {
        enabled_sources: u8,
        max_slippage: u64,
    }

    struct ConfigUpdated<phantom T0> has copy, drop {
        enabled_sources: u8,
        max_slippage: u64,
    }

    struct ConfigRemoved<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct OracleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        configs: 0x2::bag::Bag,
    }

    public fun add_symbol_price_config<T0>(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::oracle_admin::AdminCap, arg1: &mut OracleRegistry, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: u8, arg5: u64) {
        check_version(arg1);
        validate_config(&arg2, &arg3, arg4, arg5);
        let v0 = TypeKey<T0>{dummy_field: false};
        assert!(!0x2::bag::contains<TypeKey<T0>>(&arg1.configs, v0), 2);
        let v1 = SymbolPriceConfig<T0>{
            pyth_feeder_id  : arg2,
            stork_feeder_id : arg3,
            enabled_sources : arg4,
            max_slippage    : arg5,
        };
        0x2::bag::add<TypeKey<T0>, SymbolPriceConfig<T0>>(&mut arg1.configs, v0, v1);
        let v2 = ConfigAdded<T0>{
            enabled_sources : arg4,
            max_slippage    : arg5,
        };
        0x2::event::emit<ConfigAdded<T0>>(v2);
    }

    public fun check_version(arg0: &OracleRegistry) {
        assert!(arg0.version >= 1, 23);
    }

    public fun conf(arg0: &NormalizedPrice) : u64 {
        arg0.conf
    }

    public fun config_enabled_sources<T0>(arg0: &SymbolPriceConfig<T0>) : u8 {
        arg0.enabled_sources
    }

    public fun config_max_slippage<T0>(arg0: &SymbolPriceConfig<T0>) : u64 {
        arg0.max_slippage
    }

    public fun config_pyth_feeder_id<T0>(arg0: &SymbolPriceConfig<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pyth_feeder_id
    }

    public fun config_stork_feeder_id<T0>(arg0: &SymbolPriceConfig<T0>) : 0x1::option::Option<vector<u8>> {
        arg0.stork_feeder_id
    }

    public fun expo(arg0: &NormalizedPrice) : 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64 {
        arg0.expo
    }

    public fun get_config<T0>(arg0: &OracleRegistry) : &SymbolPriceConfig<T0> {
        check_version(arg0);
        let v0 = TypeKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<TypeKey<T0>>(&arg0.configs, v0), 1);
        0x2::bag::borrow<TypeKey<T0>, SymbolPriceConfig<T0>>(&arg0.configs, v0)
    }

    public fun has_config<T0>(arg0: &OracleRegistry) : bool {
        let v0 = TypeKey<T0>{dummy_field: false};
        0x2::bag::contains<TypeKey<T0>>(&arg0.configs, v0)
    }

    public fun is_pyth_enabled<T0>(arg0: &SymbolPriceConfig<T0>) : bool {
        arg0.enabled_sources & 1 == 1
    }

    public fun is_stork_enabled<T0>(arg0: &SymbolPriceConfig<T0>) : bool {
        arg0.enabled_sources & 2 == 2
    }

    public fun make_price(arg0: u128, arg1: 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64, arg2: u64, arg3: u64, arg4: u8) : NormalizedPrice {
        NormalizedPrice{
            price        : arg0,
            expo         : arg1,
            conf         : arg2,
            publish_time : arg3,
            source       : arg4,
        }
    }

    public fun make_pyth_price(arg0: u128, arg1: 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64, arg2: u64, arg3: u64) : NormalizedPrice {
        make_price(arg0, arg1, arg2, arg3, 1)
    }

    public fun make_stork_price(arg0: u128, arg1: 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i64::I64, arg2: u64, arg3: u64) : NormalizedPrice {
        make_price(arg0, arg1, arg2, arg3, 2)
    }

    public fun migrate_version(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::oracle_admin::AdminCap, arg1: &mut OracleRegistry) {
        assert!(1 >= arg1.version, 23);
        arg1.version = 1;
    }

    public fun new_registry(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::oracle_admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id      : 0x2::object::new(arg1),
            version : 1,
            configs : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public fun price(arg0: &NormalizedPrice) : u128 {
        arg0.price
    }

    public fun price_deviation_scale() : u128 {
        1000000000000000000
    }

    public fun publish_time(arg0: &NormalizedPrice) : u64 {
        arg0.publish_time
    }

    public fun registry_version(arg0: &OracleRegistry) : u64 {
        arg0.version
    }

    public fun remove_symbol_price_config<T0>(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::oracle_admin::AdminCap, arg1: &mut OracleRegistry) {
        check_version(arg1);
        let v0 = TypeKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<TypeKey<T0>>(&arg1.configs, v0), 1);
        let SymbolPriceConfig {
            pyth_feeder_id  : _,
            stork_feeder_id : _,
            enabled_sources : _,
            max_slippage    : _,
        } = 0x2::bag::remove<TypeKey<T0>, SymbolPriceConfig<T0>>(&mut arg1.configs, v0);
        let v5 = ConfigRemoved<T0>{dummy_field: false};
        0x2::event::emit<ConfigRemoved<T0>>(v5);
    }

    public fun source(arg0: &NormalizedPrice) : u8 {
        arg0.source
    }

    public fun source_pyth() : u8 {
        1
    }

    public fun source_stork() : u8 {
        2
    }

    public fun update_symbol_price_config<T0>(arg0: &0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::oracle_admin::AdminCap, arg1: &mut OracleRegistry, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: u8, arg5: u64) {
        check_version(arg1);
        validate_config(&arg2, &arg3, arg4, arg5);
        let v0 = TypeKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<TypeKey<T0>>(&arg1.configs, v0), 1);
        let v1 = 0x2::bag::borrow_mut<TypeKey<T0>, SymbolPriceConfig<T0>>(&mut arg1.configs, v0);
        v1.pyth_feeder_id = arg2;
        v1.stork_feeder_id = arg3;
        v1.enabled_sources = arg4;
        v1.max_slippage = arg5;
        let v2 = ConfigUpdated<T0>{
            enabled_sources : arg4,
            max_slippage    : arg5,
        };
        0x2::event::emit<ConfigUpdated<T0>>(v2);
    }

    fun validate_config(arg0: &0x1::option::Option<0x2::object::ID>, arg1: &0x1::option::Option<vector<u8>>, arg2: u8, arg3: u64) {
        assert!(arg2 >= 1 && arg2 <= 3, 19);
        if (arg2 & 1 == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(arg0), 20);
        };
        if (arg2 & 2 == 2) {
            assert!(0x1::option::is_some<vector<u8>>(arg1), 21);
        };
        assert!(arg3 > 0 && arg3 <= (1000000000000000000 as u64), 22);
    }

    // decompiled from Move bytecode v6
}

