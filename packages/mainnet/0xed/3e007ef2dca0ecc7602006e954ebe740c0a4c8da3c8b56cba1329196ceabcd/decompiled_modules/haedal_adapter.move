module 0xed3e007ef2dca0ecc7602006e954ebe740c0a4c8da3c8b56cba1329196ceabcd::haedal_adapter {
    public fun calculate_haedal_price(arg0: u256, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u256 {
        (arg0 * ((0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) / 1000000) as u256) + 500000000000000000) / 1000000000000000000
    }

    public fun try_get_haedal_ratio(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) : u64 {
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0)
    }

    // decompiled from Move bytecode v6
}

