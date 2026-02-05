module 0xa201cbf0eadcfc4ea7b418946fcb3f396ccba2b7075313655112ca7589213aee::oracle_version {
    public fun next_version() : u64 {
        0xa201cbf0eadcfc4ea7b418946fcb3f396ccba2b7075313655112ca7589213aee::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xa201cbf0eadcfc4ea7b418946fcb3f396ccba2b7075313655112ca7589213aee::oracle_constants::version(), 0xa201cbf0eadcfc4ea7b418946fcb3f396ccba2b7075313655112ca7589213aee::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xa201cbf0eadcfc4ea7b418946fcb3f396ccba2b7075313655112ca7589213aee::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

