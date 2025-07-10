module 0x4fcbbc848845b64d776b8ebc72e0ae2f06f835018dd6f9894d5ce669b9277d3::oracle_version {
    public fun next_version() : u64 {
        0x4fcbbc848845b64d776b8ebc72e0ae2f06f835018dd6f9894d5ce669b9277d3::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x4fcbbc848845b64d776b8ebc72e0ae2f06f835018dd6f9894d5ce669b9277d3::oracle_constants::version(), 0x4fcbbc848845b64d776b8ebc72e0ae2f06f835018dd6f9894d5ce669b9277d3::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x4fcbbc848845b64d776b8ebc72e0ae2f06f835018dd6f9894d5ce669b9277d3::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

