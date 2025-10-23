module 0x6bed49142a6264e6c55a486134d055d95499105ccec1dc47802315f84d8ee913::oracle_version {
    public fun next_version() : u64 {
        0x6bed49142a6264e6c55a486134d055d95499105ccec1dc47802315f84d8ee913::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x6bed49142a6264e6c55a486134d055d95499105ccec1dc47802315f84d8ee913::oracle_constants::version(), 0x6bed49142a6264e6c55a486134d055d95499105ccec1dc47802315f84d8ee913::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x6bed49142a6264e6c55a486134d055d95499105ccec1dc47802315f84d8ee913::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

