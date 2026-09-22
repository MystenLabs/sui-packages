module 0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        min_lock_to_propose: u64,
        voting_ms: u64,
    }

    struct ParamsChanged has copy, drop {
        min_lock_to_propose: u64,
        voting_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            version             : 1,
            min_lock_to_propose : 1500000000000,
            voting_ms           : 345600000,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 101);
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun min_lock_to_propose(arg0: &Config) : u64 {
        arg0.min_lock_to_propose
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 102);
        assert!(arg3 >= 86400000 && arg3 <= 1209600000, 102);
        arg1.min_lock_to_propose = arg2;
        arg1.voting_ms = arg3;
        let v0 = ParamsChanged{
            min_lock_to_propose : arg2,
            voting_ms           : arg3,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun voting_ms(arg0: &Config) : u64 {
        arg0.voting_ms
    }

    // decompiled from Move bytecode v7
}

