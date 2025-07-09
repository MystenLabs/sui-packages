module 0x2171fb2445adafd1137b7a966c4a0f3f22636e7641edb0eb8f03b075019a9d58::oracle_version {
    public fun next_version() : u64 {
        0x2171fb2445adafd1137b7a966c4a0f3f22636e7641edb0eb8f03b075019a9d58::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x2171fb2445adafd1137b7a966c4a0f3f22636e7641edb0eb8f03b075019a9d58::oracle_constants::version(), 0x2171fb2445adafd1137b7a966c4a0f3f22636e7641edb0eb8f03b075019a9d58::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x2171fb2445adafd1137b7a966c4a0f3f22636e7641edb0eb8f03b075019a9d58::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

