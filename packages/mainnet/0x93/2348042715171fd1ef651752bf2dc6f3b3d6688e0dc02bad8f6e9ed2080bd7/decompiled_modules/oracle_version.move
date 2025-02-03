module 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_version {
    public fun next_version() : u64 {
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_constants::version(), 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

