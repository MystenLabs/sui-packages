module 0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        whitelisted_stables: vector<0x1::ascii::String>,
        max_fee_bps: u64,
        active_assistant: 0x2::object::ID,
    }

    public(friend) fun assert_is_whitelisted(arg0: &Config, arg1: &0x1::ascii::String) {
        assert!(is_whitelisted(arg0, arg1), 2);
    }

    public(friend) fun assert_package_version(arg0: &Config) {
        assert!(arg0.version <= 1, 1);
    }

    public(friend) fun assert_valid_fee_bps(arg0: &Config, arg1: u64) {
        assert!(arg1 <= arg0.max_fee_bps, 4);
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = Config{
            id                  : 0x2::object::new(arg1),
            version             : 1,
            whitelisted_stables : 0x1::vector::empty<0x1::ascii::String>(),
            max_fee_bps         : 0,
            active_assistant    : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_whitelisted(arg0: &Config, arg1: &0x1::ascii::String) : bool {
        0x1::vector::contains<0x1::ascii::String>(&arg0.whitelisted_stables, arg1)
    }

    public fun set_max_fee_bps<T0>(arg0: &mut Config, arg1: &0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::AuthorityCap<0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::PACKAGE, T0>, arg2: u64) {
        assert_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::is_admin(v0) || 0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::AuthorityCap<0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::PACKAGE, T0>>(arg1), 5);
        arg0.max_fee_bps = arg2;
    }

    public fun whitelist_stable<T0, T1>(arg0: &mut Config, arg1: &0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::AuthorityCap<0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::PACKAGE, T0>) {
        assert_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::is_admin(v0) || 0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::is_assistant(v0) && arg0.active_assistant == 0x2::object::id<0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::AuthorityCap<0xb894f4862e13f99c1d3fc3115ff311af9b449b3024d8c7c004978cba0a3d04b::authority::PACKAGE, T0>>(arg1), 5);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x1::vector::contains<0x1::ascii::String>(&arg0.whitelisted_stables, &v1), 3);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.whitelisted_stables, v1);
    }

    // decompiled from Move bytecode v6
}

