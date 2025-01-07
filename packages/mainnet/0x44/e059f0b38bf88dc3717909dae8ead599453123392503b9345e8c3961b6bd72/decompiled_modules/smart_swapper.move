module 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::smart_swapper {
    struct ETH {
        dummy_field: bool,
    }

    struct BTC {
        dummy_field: bool,
    }

    struct KTS {
        dummy_field: bool,
    }

    entry fun cross_pool_swap(arg0: &mut 0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::Subscription<0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::some_amm::DEVPASS>) {
        0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::some_amm::dev_swap(0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::use_pass<0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::some_amm::DEVPASS>(arg0));
        0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::some_amm::dev_swap(0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::dev_pass::use_pass<0x44e059f0b38bf88dc3717909dae8ead599453123392503b9345e8c3961b6bd72::some_amm::DEVPASS>(arg0));
    }

    // decompiled from Move bytecode v6
}

