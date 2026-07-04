module 0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::PACKAGE, T0>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::source_id<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: u64) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            (((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u256) * 1000000000000000000 / (0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8)) as u256)) as u128)
        } else {
            (((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u256) * (0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8)) as u256) * 1000000000000000000) as u128)
        };
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::new_price_feed<T0, T1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3, arg1, arg2, 0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::source_cap(arg0), arg4, v3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000, arg5);
    }

    public fun remove_price_feed<T0>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, 0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::ADMIN>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::authority::VENDOR<T0>, T1>, arg2: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg3: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::source_id<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>(arg0), arg4);
    }

    public fun update_price_feed(arg0: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::source::Source<0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::PYTH>, arg1: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::config::Config, arg2: &mut 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v3 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v2)) {
            (((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u256) * 1000000000000000000 / (0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v2) as u8)) as u256)) as u128)
        } else {
            (((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u256) * (0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) as u8)) as u256) * 1000000000000000000) as u128)
        };
        0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::update_price_feed<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2, arg1, 0x95c26907367b8c4defd108c6cee70b9499cbf02d34f636c210095597cc95803::source::source_cap(arg0), arg3, v3, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) * 1000);
    }

    // decompiled from Move bytecode v7
}

