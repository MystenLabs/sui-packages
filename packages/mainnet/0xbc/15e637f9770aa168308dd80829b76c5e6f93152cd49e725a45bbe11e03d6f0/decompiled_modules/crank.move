module 0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::crank {
    struct CrankConfig has key {
        id: 0x2::object::UID,
    }

    struct AccessCap has key {
        id: 0x2::object::UID,
    }

    public fun get_access_cap(arg0: &CrankConfig, arg1: &0xbc15e637f9770aa168308dd80829b76c5e6f93152cd49e725a45bbe11e03d6f0::strategy::StrategyRegistry) : &AccessCap {
        abort 0
    }

    // decompiled from Move bytecode v6
}

