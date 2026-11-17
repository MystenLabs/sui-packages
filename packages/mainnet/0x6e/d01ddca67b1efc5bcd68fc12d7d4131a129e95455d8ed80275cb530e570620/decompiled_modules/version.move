module 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::version {
    public fun assert_version(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 900);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

