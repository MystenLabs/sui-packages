module 0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::smart_swapper {
    struct ETH {
        dummy_field: bool,
    }

    struct BTC {
        dummy_field: bool,
    }

    struct KTS {
        dummy_field: bool,
    }

    entry fun cross_pool_swap(arg0: &mut 0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::dev_pass::Subscription<0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::some_amm::DEVPASS>) {
        0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::some_amm::dev_swap<ETH, BTC>(0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::dev_pass::use_pass<0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::some_amm::DEVPASS>(arg0));
        0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::some_amm::dev_swap<BTC, KTS>(0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::dev_pass::use_pass<0xece8bb012c7646b84ccb2eac17a293eab4aca5d20e6bd168972327373b836a20::some_amm::DEVPASS>(arg0));
    }

    // decompiled from Move bytecode v6
}

