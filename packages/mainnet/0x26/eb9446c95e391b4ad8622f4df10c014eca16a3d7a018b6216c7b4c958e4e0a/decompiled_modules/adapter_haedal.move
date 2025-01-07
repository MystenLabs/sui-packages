module 0x26eb9446c95e391b4ad8622f4df10c014eca16a3d7a018b6216c7b4c958e4e0a::adapter_haedal {
    public fun calculate_haedal_price(arg0: u256, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u256 {
        0x26eb9446c95e391b4ad8622f4df10c014eca16a3d7a018b6216c7b4c958e4e0a::utils::ray_div(arg0, 0x26eb9446c95e391b4ad8622f4df10c014eca16a3d7a018b6216c7b4c958e4e0a::utils::ray_div((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) as u256), 1000000))
    }

    public fun try_get_haedal_ratio(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0)
    }

    // decompiled from Move bytecode v6
}

