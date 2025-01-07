module 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::adapter_haedal {
    public fun calculate_haedal_price(arg0: u256, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u256 {
        0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::utils::ray_div(arg0, 0x7876f0f63934c9f2b08b9f9ef7b2bb675efc83efd0230f8afd9d2d1847e89f3e::utils::ray_div((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) as u256), 1000000))
    }

    public fun try_get_haedal_ratio(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0)
    }

    // decompiled from Move bytecode v6
}

