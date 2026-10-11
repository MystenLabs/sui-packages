module 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::yield {
    struct SleeveKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Lent has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        amount: u64,
        value: u64,
    }

    struct Unlent has copy, drop {
        schema: u8,
        market: 0x2::object::ID,
        amount: u64,
        value: u64,
    }

    public fun lend<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::assert_keeper(arg1, arg5);
        let v0 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::settings<T1, T2>(arg0);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::state<T1, T2>(arg0) == 0 && 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::lend_bps(&v0) > 0, 400);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::lending_market(arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2)), 401);
        let (v1, _) = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::last_price<T1, T2>(arg0);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::owed_at<T1, T2>(arg0, v1);
        assert!(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash<T1, T2>(arg0) >= arg3 && 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash<T1, T2>(arg0) - arg3 >= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_up(v3, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::ready_cash_bps(&v0)), 402);
        let v4 = SleeveKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v4)) {
            let v5 = SleeveKey{dummy_field: false};
            0x2::dynamic_field::add<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v5, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::new<T0, T2>(arg2));
        };
        let v6 = SleeveKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow_mut<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v6);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::deposit<T0, T2>(v7, arg2, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_out<T1, T2>(arg0, arg3, 2, arg5), arg4, arg5);
        let v8 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T2>(v7, arg2, arg4);
        assert!(v8 <= 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::math::share_down(v3, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::lend_bps(&v0)), 403);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_lent_mark<T1, T2>(arg0, v8, 0x2::clock::timestamp_ms(arg4));
        let v9 = Lent{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>>(arg0),
            amount : arg3,
            value  : v8,
        };
        0x2::event::emit<Lent>(v9);
    }

    public fun mark<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        let v0 = SleeveKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v0)) {
            let v2 = SleeveKey{dummy_field: false};
            0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T2>(0x2::dynamic_field::borrow<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v2), arg2, arg3)
        } else {
            0
        };
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_lent_mark<T1, T2>(arg0, v1, 0x2::clock::timestamp_ms(arg3));
        v1
    }

    public fun unlend<T0, T1, T2>(arg0: &mut 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>, arg1: &0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::Config, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::assert_config<T1, T2>(arg0, arg1);
        let v0 = SleeveKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SleeveKey>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid<T1, T2>(arg0), v0), 404);
        let v1 = SleeveKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<SleeveKey, 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::Sleeve<T0, T2>>(0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::uid_mut<T1, T2>(arg0), v1);
        let v3 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::withdraw<T0, T2>(v2, arg2, arg3, arg4, arg5);
        let v4 = 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::lending::value<T0, T2>(v2, arg2, arg4);
        let v5 = 0x2::coin::value<T2>(&v3);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::cash_in<T1, T2>(arg0, v3, 2);
        0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::set_lent_mark<T1, T2>(arg0, v4, 0x2::clock::timestamp_ms(arg4));
        let v6 = Unlent{
            schema : 0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::config::schema(),
            market : 0x2::object::id<0xbe9a7d44698458aea5bcf0ebe57b04ca620362644c1572b256ca831896c488c5::market::Market<T1, T2>>(arg0),
            amount : v5,
            value  : v4,
        };
        0x2::event::emit<Unlent>(v6);
        v5
    }

    // decompiled from Move bytecode v7
}

