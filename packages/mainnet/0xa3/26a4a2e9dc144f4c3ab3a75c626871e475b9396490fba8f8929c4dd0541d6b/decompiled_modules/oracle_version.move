module 0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::oracle_version {
    public fun next_version() : u64 {
        0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::oracle_constants::version(), 0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xa326a4a2e9dc144f4c3ab3a75c626871e475b9396490fba8f8929c4dd0541d6b::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

