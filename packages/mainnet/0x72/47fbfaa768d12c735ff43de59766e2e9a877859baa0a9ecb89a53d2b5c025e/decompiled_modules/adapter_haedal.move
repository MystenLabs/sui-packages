module 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::adapter_haedal {
    public fun calculate_haedal_price(arg0: u256, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u256 {
        0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::utils::ray_div(arg0, 0x7247fbfaa768d12c735ff43de59766e2e9a877859baa0a9ecb89a53d2b5c025e::utils::ray_div((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) as u256), 1000000))
    }

    public fun try_get_haedal_ratio(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0)
    }

    // decompiled from Move bytecode v6
}

