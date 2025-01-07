module 0x57dddbc3b95b7c4d7c671cac1cd021c4d05e8d35ec040cd4585c6d9616b875af::haedal_adapter {
    public fun calculate_haedal_price(arg0: u256, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u256 {
        0x57dddbc3b95b7c4d7c671cac1cd021c4d05e8d35ec040cd4585c6d9616b875af::utils::ray_div(arg0, 0x57dddbc3b95b7c4d7c671cac1cd021c4d05e8d35ec040cd4585c6d9616b875af::utils::ray_div((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) as u256), 1000000))
    }

    public fun try_get_haedal_ratio(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0)
    }

    // decompiled from Move bytecode v6
}

