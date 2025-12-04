module 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::version {
    public fun next_version() : u64 {
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::constants::version(), 0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x5fa69bf9ee044aa987ba1b776ea21fecbb0bce52cf171badf2a5fc880ae50af9::constants::version()
    }

    // decompiled from Move bytecode v6
}

