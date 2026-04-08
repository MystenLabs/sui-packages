module 0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::crank {
    struct CrankConfig has key {
        id: 0x2::object::UID,
    }

    struct AccessCap has key {
        id: 0x2::object::UID,
    }

    public fun get_access_cap(arg0: &CrankConfig, arg1: &0x3bbf4eca337ecc0aa414d5299042ca5f234e9ecd94c30eb40b0c52ee0acb624b::strategy::StrategyRegistry) : &AccessCap {
        abort 0
    }

    // decompiled from Move bytecode v6
}

