module 0xbb9f99769d126ba5bb5322d59bcc700d2f87fa56a3f5ae4ccf912c9d879d9c7a::manage {
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

