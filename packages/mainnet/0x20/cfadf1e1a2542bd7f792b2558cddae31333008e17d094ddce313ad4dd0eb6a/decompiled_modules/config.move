module 0xf245105e9896942a02614e4dbbb6c6636452879d58b1e12db1e0364c0d1532a7::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        allowed_works: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        platform_fee_bps: u64,
        allowed_stablecoins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun add_allowed_stablecoins<T0>(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_stablecoins, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun add_allowed_works<T0: store + key>(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_works, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun add_version(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun allowed_stablecoins(arg0: &Config) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.allowed_stablecoins
    }

    public fun allowed_works(arg0: &Config) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.allowed_works
    }

    public(friend) fun assert_allowed_stablecoins<T0>(arg0: &Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_stablecoins, &v0), 104);
    }

    public(friend) fun assert_allowed_works<T0: store + key>(arg0: &Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_works, &v0), 102);
    }

    public(friend) fun assert_version(arg0: &Config) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 101);
    }

    public fun blob_extended_duration() : u32 {
        2
    }

    public(friend) fun config_uid_mut(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun day_in_milliesecond() : u64 {
        86400000
    }

    public fun fee_scaling() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            versions            : 0x2::vec_set::singleton<u64>(1),
            allowed_works       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            platform_fee_bps    : 1000,
            allowed_stablecoins : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun month_duration_in_walrus_epoch() : u32 {
        2
    }

    public fun package_version() : u64 {
        1
    }

    public fun platform_fee_bps(arg0: &Config) : u64 {
        arg0.platform_fee_bps
    }

    public fun remove_allowed_stablecoins<T0>(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_stablecoins, &v0);
    }

    public fun remove_allowed_works<T0: store + key>(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_works, &v0);
    }

    public fun remove_version(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public(friend) fun uid_borrow(arg0: &Config) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun update_platform_fee_bps(arg0: &mut Config, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 103);
        arg0.platform_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

