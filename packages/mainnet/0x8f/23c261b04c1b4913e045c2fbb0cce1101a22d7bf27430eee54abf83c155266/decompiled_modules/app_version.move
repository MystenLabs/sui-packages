module 0xdc09f42fad92009378d897ba6bb35cd94b51d5268fc36a84b43a79453487229e::app_version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    // decompiled from Move bytecode v7
}

