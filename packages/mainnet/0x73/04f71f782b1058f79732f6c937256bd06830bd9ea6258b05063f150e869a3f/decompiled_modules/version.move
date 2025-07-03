module 0x7304f71f782b1058f79732f6c937256bd06830bd9ea6258b05063f150e869a3f::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

