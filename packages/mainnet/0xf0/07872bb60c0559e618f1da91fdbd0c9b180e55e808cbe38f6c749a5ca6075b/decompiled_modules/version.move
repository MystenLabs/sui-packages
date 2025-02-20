module 0xf007872bb60c0559e618f1da91fdbd0c9b180e55e808cbe38f6c749a5ca6075b::version {
    public fun next_version() : u64 {
        0xf007872bb60c0559e618f1da91fdbd0c9b180e55e808cbe38f6c749a5ca6075b::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xf007872bb60c0559e618f1da91fdbd0c9b180e55e808cbe38f6c749a5ca6075b::constants::version(), 0xf007872bb60c0559e618f1da91fdbd0c9b180e55e808cbe38f6c749a5ca6075b::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xf007872bb60c0559e618f1da91fdbd0c9b180e55e808cbe38f6c749a5ca6075b::constants::version()
    }

    // decompiled from Move bytecode v6
}

