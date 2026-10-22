module 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::rewards_auth {
    struct RewardsAuth has key {
        id: 0x2::object::UID,
        version: u64,
        authority_count: u64,
        authorities: 0x2::bag::Bag,
        auths: 0x2::bag::Bag,
        timelock_cap: 0x1::option::Option<0x2::object::ID>,
    }

    struct AuthorityRecord has drop, store {
        dummy_field: bool,
    }

    struct AuthRecord has drop, store {
        dummy_field: bool,
    }

    struct MigratorRecord has drop, store {
        dummy_field: bool,
    }

    struct AuthorityKey has copy, drop, store {
        owner: address,
    }

    struct AuthKey has copy, drop, store {
        owner: address,
    }

    struct MigratorKey has copy, drop, store {
        owner: address,
    }

    public fun version(arg0: &RewardsAuth) : u64 {
        arg0.version
    }

    public(friend) fun add_auth(arg0: &mut RewardsAuth, arg1: address) {
        let v0 = AuthKey{owner: arg1};
        let v1 = AuthRecord{dummy_field: false};
        0x2::bag::add<AuthKey, AuthRecord>(&mut arg0.auths, v0, v1);
    }

    public(friend) fun add_authority(arg0: &mut RewardsAuth, arg1: address) {
        assert!(!is_authority(arg0, arg1), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::authority_already_assigned());
        let v0 = AuthorityKey{owner: arg1};
        let v1 = AuthorityRecord{dummy_field: false};
        0x2::bag::add<AuthorityKey, AuthorityRecord>(&mut arg0.authorities, v0, v1);
        arg0.authority_count = arg0.authority_count + 1;
    }

    public(friend) fun add_migrator(arg0: &mut RewardsAuth, arg1: address) {
        let v0 = MigratorKey{owner: arg1};
        let v1 = MigratorRecord{dummy_field: false};
        0x2::bag::add<MigratorKey, MigratorRecord>(&mut arg0.auths, v0, v1);
    }

    public(friend) fun assert_auth(arg0: &RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg2: &0x2::tx_context::TxContext) {
        assert!(is_auth(arg0, 0x2::tx_context::sender(arg2)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::unauthorized());
        assert_ticket(arg0, arg1);
    }

    public fun timelock_cap(arg0: &RewardsAuth) : 0x1::option::Option<0x2::object::ID> {
        arg0.timelock_cap
    }

    public(friend) fun assert_authority(arg0: &RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>, arg2: &0x2::tx_context::TxContext) {
        assert_authority_direct(arg0, arg2);
        assert_ticket(arg0, arg1);
    }

    public(friend) fun assert_authority_direct(arg0: &RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authority(arg0, 0x2::tx_context::sender(arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::only_authority());
    }

    public(friend) fun assert_migrator(arg0: &RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        assert!(is_migrator(arg0, 0x2::tx_context::sender(arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::unauthorized());
    }

    fun assert_ticket(arg0: &RewardsAuth, arg1: 0x1::option::Option<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)) {
            assert!(0x1::option::is_some<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>(&arg1), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::timelock_ticket_required());
            assert!(0x1::option::some<0x2::object::ID>(0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::cap_id(0x1::option::borrow<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket>(&arg1))) == arg0.timelock_cap, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::wrong_timelock_cap());
        };
    }

    public fun assert_version(arg0: &RewardsAuth) {
        assert!(arg0.version == 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::constants::version(), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::wrong_version());
    }

    public(friend) fun disable_timelock(arg0: &mut RewardsAuth, arg1: 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap) {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap>(&arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::wrong_timelock_cap());
        arg0.timelock_cap = 0x1::option::none<0x2::object::ID>();
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::delete(arg1);
    }

    public(friend) fun enable_timelock(arg0: &mut RewardsAuth, arg1: &mut 0x2::tx_context::TxContext) : 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.timelock_cap), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::timelock_already_enabled());
        let v0 = 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::new(arg1);
        arg0.timelock_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun has_auth_record(arg0: &RewardsAuth, arg1: address) : bool {
        let v0 = AuthKey{owner: arg1};
        0x2::bag::contains<AuthKey>(&arg0.auths, v0)
    }

    public fun has_migrator_record(arg0: &RewardsAuth, arg1: address) : bool {
        let v0 = MigratorKey{owner: arg1};
        0x2::bag::contains<MigratorKey>(&arg0.auths, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = AuthorityKey{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AuthorityRecord{dummy_field: false};
        0x2::bag::add<AuthorityKey, AuthorityRecord>(&mut v0, v1, v2);
        let v3 = 0x2::bag::new(arg0);
        let v4 = AuthKey{owner: 0x2::tx_context::sender(arg0)};
        let v5 = AuthRecord{dummy_field: false};
        0x2::bag::add<AuthKey, AuthRecord>(&mut v3, v4, v5);
        let v6 = RewardsAuth{
            id              : 0x2::object::new(arg0),
            version         : 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::constants::version(),
            authority_count : 1,
            authorities     : v0,
            auths           : v3,
            timelock_cap    : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<RewardsAuth>(v6);
    }

    public fun is_auth(arg0: &RewardsAuth, arg1: address) : bool {
        has_auth_record(arg0, arg1) || is_authority(arg0, arg1)
    }

    public fun is_authority(arg0: &RewardsAuth, arg1: address) : bool {
        let v0 = AuthorityKey{owner: arg1};
        0x2::bag::contains<AuthorityKey>(&arg0.authorities, v0)
    }

    public fun is_migrator(arg0: &RewardsAuth, arg1: address) : bool {
        has_migrator_record(arg0, arg1) || is_auth(arg0, arg1)
    }

    public fun is_timelock_enabled(arg0: &RewardsAuth) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.timelock_cap)
    }

    public(friend) fun migrate(arg0: &mut RewardsAuth) {
        assert!(arg0.version < 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::constants::version(), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::already_migrated());
        arg0.version = 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::constants::version();
    }

    public(friend) fun remove_auth(arg0: &mut RewardsAuth, arg1: address) {
        let v0 = AuthKey{owner: arg1};
        let AuthRecord {  } = 0x2::bag::remove<AuthKey, AuthRecord>(&mut arg0.auths, v0);
    }

    public(friend) fun remove_authority(arg0: &mut RewardsAuth, arg1: address) {
        assert!(is_authority(arg0, arg1), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::authority_not_assigned());
        assert!(arg0.authority_count > 1, 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::last_authority_not_removable());
        let v0 = AuthorityKey{owner: arg1};
        let AuthorityRecord {  } = 0x2::bag::remove<AuthorityKey, AuthorityRecord>(&mut arg0.authorities, v0);
        arg0.authority_count = arg0.authority_count - 1;
    }

    public(friend) fun remove_migrator(arg0: &mut RewardsAuth, arg1: address) {
        let v0 = MigratorKey{owner: arg1};
        let MigratorRecord {  } = 0x2::bag::remove<MigratorKey, MigratorRecord>(&mut arg0.auths, v0);
    }

    public fun timelock_ticket(arg0: &RewardsAuth, arg1: &0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap) : 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockTicket {
        assert!(arg0.timelock_cap == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::TimelockCap>(arg1)), 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::errors::wrong_timelock_cap());
        0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::timelock_cap::new_ticket(arg1)
    }

    // decompiled from Move bytecode v7
}

