module 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::price_feed_storage {
    fun extract(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) : (u128, u64) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg0);
        if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v0)) {
            abort 13835341136576774147
        };
        let v1 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v1)) {
            abort 13835341149461676035
        };
        let v2 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v1);
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v2), 13835904112300261383);
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v3)) {
            abort 13835622650208321541
        };
        (scaled_by_exponent(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v2), 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v3)), timestamp_ms(arg0, arg1))
    }

    fun timestamp_ms(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) : u64 {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(arg0);
        if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0)) {
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0))) {
                return to_ms(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1))
            };
        };
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg0);
        if (0x1::option::is_none<0x1::option::Option<u64>>(&v1)) {
            return to_ms(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1))
        };
        let v2 = 0x1::option::extract<0x1::option::Option<u64>>(&mut v1);
        if (0x1::option::is_none<u64>(&v2)) {
            return to_ms(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1))
        };
        to_ms(0x1::option::extract<u64>(&mut v2))
    }

    fun blended_price_and_timestamp_ms(arg0: &0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock) : (u128, u64) {
        let v0 = 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::roll_start_timestamp_ms(arg0);
        let v1 = 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::roll_end_timestamp_ms(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (v2 <= v0) {
            return extract(feed_for_id(arg1, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::front_feed_id(arg0)), arg1)
        };
        if (v1 <= v2) {
            return extract(feed_for_id(arg1, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::next_feed_id(arg0)), arg1)
        };
        let (v3, v4) = extract(feed_for_id(arg1, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::front_feed_id(arg0)), arg1);
        let (v5, v6) = extract(feed_for_id(arg1, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::next_feed_id(arg0)), arg1);
        let v7 = ((v1 - v2) as u256) * 1000000000000000000 / ((v1 - v0) as u256);
        if (v4 > v6) {
            return (((v7 * (v3 as u256) / 1000000000000000000 + (1000000000000000000 - v7) * (v5 as u256) / 1000000000000000000) as u128), v4)
        };
        (((v7 * (v3 as u256) / 1000000000000000000 + (1000000000000000000 - v7) * (v5 as u256) / 1000000000000000000) as u128), v6)
    }

    fun feed_for_id(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0)) {
            let v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == arg1) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 13835059382427058177
    }

    public fun force_remove_price_feed<T0>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::source_id<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &mut 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg5, arg8, arg6);
        new_price_feed_from_update<T0, T1>(arg0, arg1, arg2, arg3, arg4, &v0, arg7, arg8);
    }

    public fun new_price_feed_from_update<T0, T1>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &mut 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg6: u64, arg7: &0x2::clock::Clock) {
        let (v0, v1) = blended_price_and_timestamp_ms(arg4, arg5, arg7);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::new_price_feed<T0, T1, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject>(arg3, arg1, arg2, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::source_cap(arg0), arg4, v0, v1, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::source_cap(arg0));
    }

    fun scaled_by_exponent(arg0: u64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : u128 {
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            return (((arg0 as u256) * 1000000000000000000 / (0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1) as u8)) as u256)) as u128)
        };
        (((arg0 as u256) * (0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1) as u8)) as u256) * 1000000000000000000) as u128)
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::source_id<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>(arg0), arg4);
    }

    fun to_ms(arg0: u64) : u64 {
        arg0 / 1000
    }

    public fun update_price_feed(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &mut 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg4, arg6, arg5);
        update_price_feed_from_update(arg0, arg1, arg2, arg3, &v0, arg6);
    }

    public fun update_price_feed_from_update(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::PYTH_LAZER_ROLLING>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &mut 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg5: &0x2::clock::Clock) {
        let (v0, v1) = blended_price_and_timestamp_ms(arg3, arg4, arg5);
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::update_price_feed<0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::feed_info_object::FeedInfoObject>(arg2, arg1, 0x1701f7e71bb1b853d5f9fb794172486ffa5b51c7059ba168a7fbaab69ad9c46::source::source_cap(arg0), arg3, v0, v1);
    }

    // decompiled from Move bytecode v7
}

