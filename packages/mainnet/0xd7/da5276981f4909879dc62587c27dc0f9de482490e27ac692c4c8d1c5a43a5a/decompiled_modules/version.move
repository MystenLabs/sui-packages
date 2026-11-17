module 0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version {
    public fun assert_version(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 900);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

