module 0xb816cdb0f6e5e7c3f6bd5fb13d2d027ffbcb63059e7d7625b8260c5e89b15945::deepbook {
    public fun when_not_paused(arg0: &0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::Config) {
        0x882cd9388d35a141614a7beb28ec14f7aaf54f8372ccc1dd64046efd82866043::active_vault::when_not_paused(arg0);
    }

    public fun adjust_input_amount(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 % arg1
    }

    // decompiled from Move bytecode v6
}

