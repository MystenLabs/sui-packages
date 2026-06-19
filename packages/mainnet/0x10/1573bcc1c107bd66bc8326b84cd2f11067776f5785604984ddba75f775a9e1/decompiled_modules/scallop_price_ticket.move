module 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_price_ticket {
    struct QuoteCollectedEvent has copy, drop {
        market_id: 0x2::object::ID,
        scallop_market_id: 0x2::object::ID,
        sy_index: u128,
        updated_at: u64,
    }

    public fun quote<T0: drop, T1: drop, T2: drop, T3: drop>(arg0: &mut 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::PriceCollector<T1>, arg1: &0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_market_vault::ScallopMarketVault<T0, T1, T2, T3>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock) {
        0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_market_vault::assert_scallop_market_match<T0, T1, T2, T3>(arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg3, arg4);
        let v0 = 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_market_vault::current_sy_index<T0>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::assert_market_id<T1>(arg0, 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_market_vault::market_id<T0, T1, T2, T3>(arg1));
        0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector::collect<T1, 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::sign::SCALLOP>(arg0, 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::sign::sign(), v0, v1);
        let v2 = QuoteCollectedEvent{
            market_id         : 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_market_vault::market_id<T0, T1, T2, T3>(arg1),
            scallop_market_id : 0x101573bcc1c107bd66bc8326b84cd2f11067776f5785604984ddba75f775a9e1::scallop_market_vault::scallop_market_id<T0, T1, T2, T3>(arg1),
            sy_index          : v0,
            updated_at        : v1,
        };
        0x2::event::emit<QuoteCollectedEvent>(v2);
    }

    // decompiled from Move bytecode v7
}

