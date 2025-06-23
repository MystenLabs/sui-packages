module 0xaec914fe1ed3be0aa3fc3cc610cccba02ace491ab45589035f657e1097c75faa::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        2
    }

    // decompiled from Move bytecode v6
}

