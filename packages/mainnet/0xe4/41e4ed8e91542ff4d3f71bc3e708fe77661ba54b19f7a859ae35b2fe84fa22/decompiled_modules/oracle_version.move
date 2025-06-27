module 0xe441e4ed8e91542ff4d3f71bc3e708fe77661ba54b19f7a859ae35b2fe84fa22::oracle_version {
    public fun next_version() : u64 {
        0xe441e4ed8e91542ff4d3f71bc3e708fe77661ba54b19f7a859ae35b2fe84fa22::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xe441e4ed8e91542ff4d3f71bc3e708fe77661ba54b19f7a859ae35b2fe84fa22::oracle_constants::version(), 0xe441e4ed8e91542ff4d3f71bc3e708fe77661ba54b19f7a859ae35b2fe84fa22::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xe441e4ed8e91542ff4d3f71bc3e708fe77661ba54b19f7a859ae35b2fe84fa22::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

