module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::registry {
    struct LendingRegistry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun version(arg0: &LendingRegistry) : u64 {
        arg0.version
    }

    public fun assert_version(arg0: &LendingRegistry) {
        assert!(arg0.version == 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::version(), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::wrong_version());
    }

    public fun get_lending_state_address<T0>(arg0: &LendingRegistry) : address {
        0x2::derived_object::derive_address<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::keys::LendingStateKey<T0>>(0x2::object::uid_to_inner(&arg0.id), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::keys::lending_state_key<T0>())
    }

    public fun get_lending_state_exists<T0>(arg0: &LendingRegistry) : bool {
        0x2::derived_object::exists<0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::keys::LendingStateKey<T0>>(&arg0.id, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::keys::lending_state_key<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingRegistry{
            id      : 0x2::object::new(arg0),
            version : 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::version(),
        };
        0x2::transfer::share_object<LendingRegistry>(v0);
    }

    public(friend) fun migrate(arg0: &mut LendingRegistry) {
        assert!(arg0.version < 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::version(), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::already_migrated());
        arg0.version = 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::version();
    }

    public(friend) fun uid_mut(arg0: &mut LendingRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

