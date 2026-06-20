module 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::app_version {
    public fun check_version(arg0: u64) {
        assert!(1 == arg0, 1001);
    }

    // decompiled from Move bytecode v7
}

