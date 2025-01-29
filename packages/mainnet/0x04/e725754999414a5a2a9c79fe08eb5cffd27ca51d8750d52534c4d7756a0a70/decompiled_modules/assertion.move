module 0x4e725754999414a5a2a9c79fe08eb5cffd27ca51d8750d52534c4d7756a0a70::assertion {
    public fun assert_end_time<T0>(arg0: &0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::Status<T0>, arg1: u64) {
        assert!(0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::status::end_time<T0>(arg0) == arg1, 0);
    }

    // decompiled from Move bytecode v6
}

