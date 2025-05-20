module 0x5136a57d7c9e317d03562ea53860fbbaac8ae84b23db93bbd8fe64efce40a36f::smc {
    public fun seal_approve(arg0: vector<u8>, arg1: u64) {
        assert!(arg1 == 1, 1);
    }

    // decompiled from Move bytecode v6
}

