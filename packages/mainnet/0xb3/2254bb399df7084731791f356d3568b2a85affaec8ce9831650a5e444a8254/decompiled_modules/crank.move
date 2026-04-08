module 0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::crank {
    struct CrankConfig has key {
        id: 0x2::object::UID,
    }

    struct AccessCap has key {
        id: 0x2::object::UID,
    }

    public fun get_access_cap(arg0: &CrankConfig, arg1: &0xb32254bb399df7084731791f356d3568b2a85affaec8ce9831650a5e444a8254::strategy::StrategyRegistry) : &AccessCap {
        abort 0
    }

    // decompiled from Move bytecode v6
}

