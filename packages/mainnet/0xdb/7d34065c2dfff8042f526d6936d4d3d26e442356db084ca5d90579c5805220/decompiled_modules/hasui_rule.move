module 0xdb7d34065c2dfff8042f526d6936d4d3d26e442356db084ca5d90579c5805220::hasui_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun update_price(arg0: &mut 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle::StingrayOracle, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: &0x2::clock::Clock) {
        let v0 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle::get_price(arg0, arg2, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()));
        let v1 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::stingray_oracle::borrow_oracle_aggregator_mut(arg0, 0x1::type_name::into_string(0x1::type_name::get<0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::hasui::HASUI>()));
        let v2 = 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::price_info(v1);
        let v3 = Rule{dummy_field: false};
        0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::update_oracle_price_with_rule<Rule>(v1, v3, arg2, ((0x1::u128::pow(10, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::decimals(&v2)) * ((0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::price(&v0) * 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg1) / 1000000) as u128) / 0x1::u128::pow(10, 0xe007d0aff9155276a962b8cfab25d42b6d220b3cbfd5a0b525e00e737b3e2799::oracle_aggregator::decimals(&v0))) as u64));
    }

    // decompiled from Move bytecode v6
}

