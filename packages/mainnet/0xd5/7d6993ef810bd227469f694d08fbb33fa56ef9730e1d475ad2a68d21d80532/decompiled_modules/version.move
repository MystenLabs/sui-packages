module 0xd57d6993ef810bd227469f694d08fbb33fa56ef9730e1d475ad2a68d21d80532::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

