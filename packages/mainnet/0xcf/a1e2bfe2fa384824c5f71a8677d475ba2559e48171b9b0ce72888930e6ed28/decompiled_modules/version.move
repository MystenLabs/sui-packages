module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::version {
    public fun check_version(arg0: u64) {
        assert!(arg0 == current_version(), 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::errors::invalid_version());
    }

    public fun current_version() : u64 {
        0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::constants::version()
    }

    // decompiled from Move bytecode v6
}

