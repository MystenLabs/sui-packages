module 0x1a8030383676140111bf453c60cfda101ba84a7d2b19004edef37a5df3af5370::oracle_version {
    public fun next_version() : u64 {
        0x1a8030383676140111bf453c60cfda101ba84a7d2b19004edef37a5df3af5370::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x1a8030383676140111bf453c60cfda101ba84a7d2b19004edef37a5df3af5370::oracle_constants::version(), 0x1a8030383676140111bf453c60cfda101ba84a7d2b19004edef37a5df3af5370::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x1a8030383676140111bf453c60cfda101ba84a7d2b19004edef37a5df3af5370::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

