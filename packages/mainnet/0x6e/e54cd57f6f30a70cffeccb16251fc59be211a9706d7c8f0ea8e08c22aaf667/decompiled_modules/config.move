module 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        is_paused: bool,
        managers: 0x2::vec_set::VecSet<address>,
        allowed_works: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        platform_fee_bps: u64,
        allowed_stablecoins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        max_num_of_subscription_level: u8,
    }

    public fun add_allowed_stablecoins<T0>(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        assert_version(arg0);
        assert_not_paused(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_stablecoins, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun add_allowed_works<T0: store + key>(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        assert_version(arg0);
        assert_not_paused(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_works, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun add_version(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) {
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

    public(friend) fun assert_manager(arg0: &Config, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.managers, &arg1), 101);
    }

    public(friend) fun assert_not_exceed_max_subscription_level(arg0: &Config, arg1: u8) {
        assert!(arg1 <= arg0.max_num_of_subscription_level - 1, 105);
    }

    public(friend) fun assert_not_paused(arg0: &Config) {
        assert!(arg0.is_paused == false, 2);
    }

    public(friend) fun assert_version(arg0: &Config) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 1);
    }

    public fun blob_extended_duration() : u32 {
        2
    }

    public fun day_in_milliesecond() : u64 {
        86400000
    }

    public fun fee_scaling() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                            : 0x2::object::new(arg0),
            versions                      : 0x2::vec_set::singleton<u64>(1),
            is_paused                     : false,
            managers                      : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            allowed_works                 : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            platform_fee_bps              : 1000,
            allowed_stablecoins           : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            max_num_of_subscription_level : 3,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.is_paused
    }

    public fun managers(arg0: &Config) : 0x2::vec_set::VecSet<address> {
        arg0.managers
    }

    public fun month_duration_in_walrus_epoch() : u32 {
        2
    }

    public fun package_version() : u64 {
        1
    }

    public fun pause(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        assert_version(arg0);
        arg0.is_paused = true;
    }

    public fun platform_fee_bps(arg0: &Config) : u64 {
        arg0.platform_fee_bps
    }

    public fun remove_allowed_stablecoins<T0>(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_stablecoins, &v0);
    }

    public fun remove_allowed_works<T0: store + key>(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        assert_version(arg0);
        assert_not_paused(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_works, &v0);
    }

    public fun remove_version(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public(friend) fun uid_borrow(arg0: &Config) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap) {
        assert_version(arg0);
        arg0.is_paused = false;
    }

    public fun updaqte_max_num_of_subscription_level(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u8) {
        assert_version(arg0);
        assert_not_paused(arg0);
        arg0.max_num_of_subscription_level = arg2;
    }

    public fun update_platform_fee_bps(arg0: &mut Config, arg1: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_not_paused(arg0);
        assert!(arg2 <= 10000, 103);
        arg0.platform_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

