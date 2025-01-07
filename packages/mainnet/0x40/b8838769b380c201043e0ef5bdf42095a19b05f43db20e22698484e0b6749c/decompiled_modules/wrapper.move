module 0x40b8838769b380c201043e0ef5bdf42095a19b05f43db20e22698484e0b6749c::wrapper {
    struct Rate has copy, drop {
        rate: u64,
    }

    public fun hasui_exchange_rate(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking) {
        let v0 = Rate{rate: 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0)};
        0x2::event::emit<Rate>(v0);
    }

    // decompiled from Move bytecode v6
}

