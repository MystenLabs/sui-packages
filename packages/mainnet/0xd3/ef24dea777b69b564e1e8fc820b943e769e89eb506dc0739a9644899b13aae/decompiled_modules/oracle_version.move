module 0xd3ef24dea777b69b564e1e8fc820b943e769e89eb506dc0739a9644899b13aae::oracle_version {
    public fun next_version() : u64 {
        0xd3ef24dea777b69b564e1e8fc820b943e769e89eb506dc0739a9644899b13aae::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xd3ef24dea777b69b564e1e8fc820b943e769e89eb506dc0739a9644899b13aae::oracle_constants::version(), 0xd3ef24dea777b69b564e1e8fc820b943e769e89eb506dc0739a9644899b13aae::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xd3ef24dea777b69b564e1e8fc820b943e769e89eb506dc0739a9644899b13aae::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

