module 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: 0x2::vec_set::VecSet<u8>,
        broker_allowlist: vector<address>,
        quote_allowlist: vector<0x1::type_name::TypeName>,
        bro_asset_allowlist: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        paused: bool,
        min_grace_period_ms: u64,
    }

    public fun add_bro_asset<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.bro_asset_allowlist, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg1.bro_asset_allowlist, v0) = true;
        } else {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.bro_asset_allowlist, v0, true);
        };
    }

    public fun add_broker(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert_version(arg1);
        if (!0x1::vector::contains<address>(&arg1.broker_allowlist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.broker_allowlist, arg2);
        };
    }

    public fun add_quote_type<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.quote_allowlist, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.quote_allowlist, v0);
        };
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u8) {
        if (!0x2::vec_set::contains<u8>(&arg1.version, &arg2)) {
            0x2::vec_set::insert<u8>(&mut arg1.version, arg2);
        };
    }

    public fun allowed_quotes(arg0: &GlobalConfig) : vector<0x1::type_name::TypeName> {
        arg0.quote_allowlist
    }

    public fun assert_bro_asset_allowed<T0>(arg0: &GlobalConfig) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.bro_asset_allowlist, v0) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.bro_asset_allowlist, v0), 3);
    }

    public fun assert_broker(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.broker_allowlist, &arg1), 1);
    }

    public fun assert_quote_allowed<T0>(arg0: &GlobalConfig) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg0.quote_allowlist, &v0), 2);
    }

    public fun assert_version(arg0: &GlobalConfig) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u8>(&arg0.version, &v0), 0);
    }

    public fun current_version() : u8 {
        1
    }

    public fun has_version(arg0: &GlobalConfig, arg1: u8) : bool {
        0x2::vec_set::contains<u8>(&arg0.version, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                  : 0x2::object::new(arg0),
            version             : 0x2::vec_set::singleton<u8>(1),
            broker_allowlist    : vector[],
            quote_allowlist     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            bro_asset_allowlist : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            paused              : false,
            min_grace_period_ms : 10000,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_bro_asset_allowed<T0>(arg0: &GlobalConfig) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.bro_asset_allowlist, v0) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.bro_asset_allowlist, v0)
    }

    public fun is_broker(arg0: &GlobalConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.broker_allowlist, &arg1)
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun is_quote_allowed<T0>(arg0: &GlobalConfig) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.quote_allowlist, &v0)
    }

    public fun min_grace_period_ms(arg0: &GlobalConfig) : u64 {
        arg0.min_grace_period_ms
    }

    public fun remove_bro_asset<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.bro_asset_allowlist, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg1.bro_asset_allowlist, v0);
        };
    }

    public fun remove_broker(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert_version(arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.broker_allowlist, &arg2);
        if (v0) {
            0x1::vector::swap_remove<address>(&mut arg1.broker_allowlist, v1);
        };
    }

    public fun remove_quote_type<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg1.quote_allowlist, &v0);
        if (v1) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg1.quote_allowlist, v2);
        };
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u8) {
        assert_version(arg1);
        if (0x2::vec_set::contains<u8>(&arg1.version, &arg2)) {
            0x2::vec_set::remove<u8>(&mut arg1.version, &arg2);
        };
    }

    public fun set_bro_asset_enabled<T0>(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        assert_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.bro_asset_allowlist, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg1.bro_asset_allowlist, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.bro_asset_allowlist, v0, arg2);
        };
    }

    public fun set_min_grace_period_ms(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert_version(arg1);
        arg1.min_grace_period_ms = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
    }

    // decompiled from Move bytecode v7
}

