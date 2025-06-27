module 0x3c0b5fc04d9495d137ca8ed165b5a86e09929596bc04c407924dc383b77813fb::oracle_version {
    public fun next_version() : u64 {
        0x3c0b5fc04d9495d137ca8ed165b5a86e09929596bc04c407924dc383b77813fb::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x3c0b5fc04d9495d137ca8ed165b5a86e09929596bc04c407924dc383b77813fb::oracle_constants::version(), 0x3c0b5fc04d9495d137ca8ed165b5a86e09929596bc04c407924dc383b77813fb::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x3c0b5fc04d9495d137ca8ed165b5a86e09929596bc04c407924dc383b77813fb::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

