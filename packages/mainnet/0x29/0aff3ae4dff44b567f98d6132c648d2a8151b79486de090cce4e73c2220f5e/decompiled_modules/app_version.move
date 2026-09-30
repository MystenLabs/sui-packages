module 0xf1980203ac583f48fdc4cde7b8dfe8b6a46952db239cf03eeb4282174dd0d275::app_version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    public fun is_compatible_version(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 1001);
    }

    // decompiled from Move bytecode v7
}

