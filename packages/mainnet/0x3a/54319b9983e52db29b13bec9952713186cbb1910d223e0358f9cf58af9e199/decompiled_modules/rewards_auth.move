module 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::rewards_auth {
    struct RewardsAuth has key {
        id: 0x2::object::UID,
        version: u64,
        authority: address,
        auths: 0x2::bag::Bag,
    }

    struct AuthRecord has drop, store {
        dummy_field: bool,
    }

    struct AuthKey has copy, drop, store {
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

    public(friend) fun assert_auth(arg0: &RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        assert!(is_auth(arg0, 0x2::tx_context::sender(arg1)), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::unauthorized());
    }

    public(friend) fun assert_authority(arg0: &RewardsAuth, arg1: &0x2::tx_context::TxContext) {
        assert!(is_authority(arg0, 0x2::tx_context::sender(arg1)), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::only_authority());
    }

    public fun assert_version(arg0: &RewardsAuth) {
        assert!(arg0.version == 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants::version(), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::wrong_version());
    }

    public fun authority(arg0: &RewardsAuth) : address {
        arg0.authority
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg0);
        let v1 = AuthKey{owner: 0x2::tx_context::sender(arg0)};
        let v2 = AuthRecord{dummy_field: false};
        0x2::bag::add<AuthKey, AuthRecord>(&mut v0, v1, v2);
        let v3 = RewardsAuth{
            id        : 0x2::object::new(arg0),
            version   : 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants::version(),
            authority : 0x2::tx_context::sender(arg0),
            auths     : v0,
        };
        0x2::transfer::share_object<RewardsAuth>(v3);
    }

    public fun is_auth(arg0: &RewardsAuth, arg1: address) : bool {
        let v0 = AuthKey{owner: arg1};
        0x2::bag::contains<AuthKey>(&arg0.auths, v0)
    }

    public fun is_authority(arg0: &RewardsAuth, arg1: address) : bool {
        arg0.authority == arg1
    }

    public(friend) fun migrate(arg0: &mut RewardsAuth) {
        assert!(arg0.version < 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants::version(), 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::errors::already_migrated());
        arg0.version = 0x3a54319b9983e52db29b13bec9952713186cbb1910d223e0358f9cf58af9e199::constants::version();
    }

    public(friend) fun remove_auth(arg0: &mut RewardsAuth, arg1: address) {
        let v0 = AuthKey{owner: arg1};
        let AuthRecord {  } = 0x2::bag::remove<AuthKey, AuthRecord>(&mut arg0.auths, v0);
    }

    public(friend) fun set_authority(arg0: &mut RewardsAuth, arg1: address) {
        arg0.authority = arg1;
    }

    // decompiled from Move bytecode v7
}

