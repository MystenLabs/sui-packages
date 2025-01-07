module 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::platform {
    struct Platform has store, key {
        id: 0x2::object::UID,
        version: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PLATFORM has drop {
        dummy_field: bool,
    }

    public(friend) fun assert_current_version(arg0: &Platform) {
        assert!(arg0.version == 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::version::current_version(), 1);
    }

    fun init(arg0: PLATFORM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Platform{
            id      : 0x2::object::new(arg1),
            version : 0x1::string::utf8(b"1.0.0"),
        };
        assert_current_version(&v0);
        0x2::package::claim_and_keep<PLATFORM>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Platform>(v0);
    }

    entry fun migrate(arg0: &AdminCap, arg1: &mut Platform) {
        assert!(arg1.version != 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::version::current_version(), 0);
        arg1.version = 0xfc43051466df65fb00171e654c8857eb5c058f958fe04deec03323b2c0bc9559::version::current_version();
    }

    public(friend) fun uid(arg0: &Platform) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Platform) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun version(arg0: &Platform) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

