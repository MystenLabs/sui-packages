module 0xfcf00fbb8d7cca9787f4842e00563d906e2942c48790027dbb97e63182081a4f::oracle_version {
    public fun next_version() : u64 {
        0xfcf00fbb8d7cca9787f4842e00563d906e2942c48790027dbb97e63182081a4f::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xfcf00fbb8d7cca9787f4842e00563d906e2942c48790027dbb97e63182081a4f::oracle_constants::version(), 0xfcf00fbb8d7cca9787f4842e00563d906e2942c48790027dbb97e63182081a4f::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xfcf00fbb8d7cca9787f4842e00563d906e2942c48790027dbb97e63182081a4f::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

