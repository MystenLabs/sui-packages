module 0xac05fba3c5adc6296d3b65c0d09cc9d579f0e1ad8f0a8a6e734feaa0fb8b7c8b::manage {
    struct Manage has store {
        version: u64,
        paused: bool,
    }

    public fun check_not_paused(arg0: &Manage) {
        assert!(!arg0.paused, 50002);
    }

    public fun check_version(arg0: &Manage) {
        assert!(arg0.version == 2, 50001);
    }

    public fun current_version() : u64 {
        2
    }

    public(friend) fun migrate_version(arg0: &mut Manage) {
        assert!(arg0.version <= 2, 50001);
        arg0.version = 2;
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

