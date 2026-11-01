module 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry {
    struct LendingRegistry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun version(arg0: &LendingRegistry) : u64 {
        arg0.version
    }

    public fun assert_version(arg0: &LendingRegistry) {
        assert!(arg0.version == 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::version(), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::wrong_version());
    }

    public fun get_lending_state_address<T0>(arg0: &LendingRegistry) : address {
        0x2::derived_object::derive_address<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::keys::LendingStateKey<T0>>(0x2::object::uid_to_inner(&arg0.id), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::keys::lending_state_key<T0>())
    }

    public fun get_lending_state_exists<T0>(arg0: &LendingRegistry) : bool {
        0x2::derived_object::exists<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::keys::LendingStateKey<T0>>(&arg0.id, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::keys::lending_state_key<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingRegistry{
            id      : 0x2::object::new(arg0),
            version : 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::version(),
        };
        0x2::transfer::share_object<LendingRegistry>(v0);
    }

    public(friend) fun migrate(arg0: &mut LendingRegistry) {
        assert!(arg0.version < 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::version(), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::already_migrated());
        arg0.version = 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::version();
    }

    public(friend) fun uid_mut(arg0: &mut LendingRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

