module 0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        registry: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        versions: 0x2::vec_set::VecSet<u64>,
        base_read_fee: u64,
    }

    public(friend) fun add_registry<T0>(arg0: &mut Config) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.registry, 0x1::type_name::with_original_ids<T0>());
    }

    public fun add_version(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public(friend) fun assert_version(arg0: &Config) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 101);
    }

    public fun base_read_fee(arg0: &Config) : u64 {
        arg0.base_read_fee
    }

    public(friend) fun config_uid_mut(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derived_object_key<T0>(arg0: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        0x1::ascii::append(&mut v0, 0x1::ascii::string(b"-"));
        0x1::ascii::append(&mut v0, arg0);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            registry      : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            versions      : 0x2::vec_set::singleton<u64>(1),
            base_read_fee : 1000000,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public(friend) fun remove_registry<T0>(arg0: &mut Config) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.registry, &v0);
    }

    public fun remove_version(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun update_read_fee(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        arg0.base_read_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

