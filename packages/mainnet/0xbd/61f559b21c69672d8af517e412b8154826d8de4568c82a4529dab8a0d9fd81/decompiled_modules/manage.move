module 0xbd61f559b21c69672d8af517e412b8154826d8de4568c82a4529dab8a0d9fd81::manage {
    struct Manage has store {
        version: u64,
        paused: bool,
    }

    public fun check_not_paused(arg0: &Manage) {
        assert!(!arg0.paused, 50002);
    }

    public fun check_version(arg0: &Manage) {
        assert!(arg0.version == 1, 50001);
    }

    public fun current_version() : u64 {
        1
    }

    public(friend) fun migrate_version(arg0: &mut Manage) {
        assert!(arg0.version <= 1, 50001);
        arg0.version = 1;
    }

    public(friend) fun new() : Manage {
        Manage{
            version : current_version(),
            paused  : true,
        }
    }

    public(friend) fun set_paused(arg0: &mut Manage, arg1: bool) {
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

