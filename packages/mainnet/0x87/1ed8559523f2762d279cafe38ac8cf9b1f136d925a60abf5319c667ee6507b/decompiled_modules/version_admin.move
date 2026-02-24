module 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::version_admin {
    public fun migrate(arg0: &0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::AdminCap, arg1: &mut 0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::ProtocolApp) : u64 {
        0x871ed8559523f2762d279cafe38ac8cf9b1f136d925a60abf5319c667ee6507b::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

