module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::price_feed {
    public(friend) fun get_validated_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::TokenInfo, arg2: &0x2::clock::Clock) : (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, u64, u8) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::vector_to_hex_char(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1)) == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::pyth_price_feed_id(arg1), 4003);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::max_age_price_seconds(arg1));
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v2);
        let v6 = if (is_negative(&v5)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(i64_to_u64(&v3)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::power(10, i64_to_u64(&v4))))
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(i64_to_u64(&v3)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::power(10, i64_to_u64(&v4))))
        };
        let v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::power(10, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::exp_heuristic(arg1));
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::lt(v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::upper_heuristic(arg1)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v7))), 4001);
        assert!(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(v6, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info::lower_heuristic(arg1)), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v7))), 4002);
        (v6, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v2), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::last_update::all_checks())
    }

    public(friend) fun i64_to_u64(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        if (!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(arg0)
        }
    }

    public(friend) fun is_negative(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : bool {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0)
    }

    // decompiled from Move bytecode v6
}

