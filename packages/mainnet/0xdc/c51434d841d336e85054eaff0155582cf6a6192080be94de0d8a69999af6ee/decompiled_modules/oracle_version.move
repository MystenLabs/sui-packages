module 0xdcc51434d841d336e85054eaff0155582cf6a6192080be94de0d8a69999af6ee::oracle_version {
    public fun next_version() : u64 {
        0xdcc51434d841d336e85054eaff0155582cf6a6192080be94de0d8a69999af6ee::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xdcc51434d841d336e85054eaff0155582cf6a6192080be94de0d8a69999af6ee::oracle_constants::version(), 0xdcc51434d841d336e85054eaff0155582cf6a6192080be94de0d8a69999af6ee::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xdcc51434d841d336e85054eaff0155582cf6a6192080be94de0d8a69999af6ee::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

