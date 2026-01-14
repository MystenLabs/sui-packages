module 0xe75f54892ab7df6ebf160ed5197dd17c67192211811b1e9a19220fb84217a03::version {
    public fun next_version() : u64 {
        0xe75f54892ab7df6ebf160ed5197dd17c67192211811b1e9a19220fb84217a03::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xe75f54892ab7df6ebf160ed5197dd17c67192211811b1e9a19220fb84217a03::constants::version(), 0xe75f54892ab7df6ebf160ed5197dd17c67192211811b1e9a19220fb84217a03::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xe75f54892ab7df6ebf160ed5197dd17c67192211811b1e9a19220fb84217a03::constants::version()
    }

    // decompiled from Move bytecode v6
}

