module 0x5ea91cfad5399ecbf7ef1669379ea305e9bf9a4fda50667b8be82bda5da452ee::version {
    struct VersionState has store {
        package_version: u64,
        paused_version_backup: u64,
    }

    public fun bump_to(arg0: &mut VersionState, arg1: u64) {
        assert!(arg1 > arg0.package_version, 4);
        arg0.package_version = arg1;
    }

    public fun checked(arg0: &VersionState, arg1: u64) {
        assert!(arg1 >= arg0.package_version, 1);
    }

    public fun emergency_pause_version_const() : u64 {
        18446744073709551615
    }

    public fun is_paused(arg0: &VersionState) : bool {
        arg0.package_version == 18446744073709551615
    }

    public fun new(arg0: u64) : VersionState {
        assert!(arg0 > 0, 3);
        VersionState{
            package_version       : arg0,
            paused_version_backup : 0,
        }
    }

    public fun package_version(arg0: &VersionState) : u64 {
        arg0.package_version
    }

    public fun pause(arg0: &mut VersionState) {
        if (arg0.package_version == 18446744073709551615) {
            return
        };
        arg0.paused_version_backup = arg0.package_version;
        arg0.package_version = 18446744073709551615;
    }

    public fun paused_version_backup(arg0: &VersionState) : u64 {
        arg0.paused_version_backup
    }

    public fun unpause(arg0: &mut VersionState, arg1: u64) {
        assert!(arg0.package_version == 18446744073709551615, 2);
        let v0 = if (arg1 > 0) {
            arg1
        } else {
            arg0.paused_version_backup
        };
        assert!(v0 > 0, 3);
        arg0.package_version = v0;
        arg0.paused_version_backup = 0;
    }

    // decompiled from Move bytecode v7
}

