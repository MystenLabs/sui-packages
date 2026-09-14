module 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket {
    struct Basket<phantom T0, phantom T1> has store {
        id: 0x2::object::UID,
        engine: 0x2::object::ID,
        market: 0x2::object::ID,
        registry: 0x2::object::ID,
        lending_market: 0x2::object::ID,
        sleeve: 0x2::object::ID,
        reserve: 0x2::object::ID,
        lending_cap: 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::OwnerCap,
        reserve_cap: 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::OwnerCap,
        synth: 0x1::option::Option<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>,
        hot: 0x2::balance::Balance<T1>,
        synth_bps: u64,
        hot_bps: u64,
        lent_bps: u64,
        reserve_bps: u64,
    }

    struct Deposited has copy, drop {
        basket: 0x2::object::ID,
        deposit: u64,
        added: u64,
        before: u64,
        after: u64,
    }

    struct Withdrawn has copy, drop {
        basket: 0x2::object::ID,
        numerator: u64,
        denominator: u64,
        payout: u64,
        before: u64,
        after: u64,
    }

    struct HotWithdrawn has copy, drop {
        basket: 0x2::object::ID,
        payout: u64,
        remaining: u64,
    }

    struct HotRefilled has copy, drop {
        basket: 0x2::object::ID,
        target: u64,
        ctokens_redeemed: u64,
        added: u64,
        hot: u64,
        before: u64,
        after: u64,
    }

    struct SynthSwept has copy, drop {
        basket: 0x2::object::ID,
        shares_burned: u64,
        remaining_shares: u64,
        ctokens_moved: u64,
        cash_added: u64,
        before: u64,
        after: u64,
    }

    public fun id<T0, T1>(arg0: &Basket<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun new<T0, T1>(arg0: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (Basket<T0, T1>, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>) {
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::validate(arg4, arg5, arg6, arg7);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::market_id<T0, T1>(arg0, arg1);
        let (v1, v2) = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::new<T0, T1>(arg3, arg8);
        let v3 = v1;
        let (v4, v5) = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::new<T1>(arg2, v0, 1, arg8);
        let v6 = v4;
        let v7 = Basket<T0, T1>{
            id             : 0x2::object::new(arg8),
            engine         : 0x2::object::id<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>>(arg0),
            market         : v0,
            registry       : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg2),
            lending_market : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3),
            sleeve         : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(&v3),
            reserve        : 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(&v6),
            lending_cap    : v2,
            reserve_cap    : v5,
            synth          : 0x1::option::none<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(),
            hot            : 0x2::balance::zero<T1>(),
            synth_bps      : arg4,
            hot_bps        : arg5,
            lent_bps       : arg6,
            reserve_bps    : arg7,
        };
        (v7, v3, v6)
    }

    public fun deposit<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg9: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: 0x2::coin::Coin<T1>, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, u64) {
        check<T0, T1>(arg0, arg1, &arg4, arg7, arg8, arg6);
        timely<T0, T1>(arg0, arg10, arg15, arg16);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T0, T1>(arg1, arg2, arg3, &mut arg4, arg5, arg10, arg11, arg12, arg16);
        let v1 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg16);
        let v2 = 0x2::coin::value<T1>(&arg13);
        let (v3, _, v5, v6) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::allocations(v2, arg0.synth_bps, arg0.hot_bps, arg0.lent_bps, arg0.reserve_bps);
        assert!(v3 > 0, 2);
        let (v7, v8) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::mint<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, arg12, 0x2::coin::split<T1>(&mut arg13, v3, arg17), 1, arg15, arg16, arg17);
        arg4 = v7;
        if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::join<T0, T1>(0x1::option::borrow_mut<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth), v8);
        } else {
            0x1::option::fill<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth, v8);
        };
        if (v5 > 0) {
            0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::deposit<T0, T1>(arg7, arg6, 0x2::coin::split<T1>(&mut arg13, v5, arg17), arg16, arg17);
        };
        if (v6 > 0) {
            0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::deposit<T1>(arg8, arg9, arg10, 0x2::coin::split<T1>(&mut arg13, v6, arg17));
        };
        0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(arg13));
        let v9 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg16);
        let v10 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::share_math::contribution(v1, v9, v2);
        assert!(v10 >= arg14, 2);
        let v11 = Deposited{
            basket  : 0x2::object::uid_to_inner(&arg0.id),
            deposit : v2,
            added   : v10,
            before  : v1,
            after   : v9,
        };
        0x2::event::emit<Deposited>(v11);
        (arg4, v10)
    }

    public fun withdraw<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg9: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        check<T0, T1>(arg0, arg1, &arg4, arg7, arg8, arg6);
        timely<T0, T1>(arg0, arg10, arg16, arg17);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T0, T1>(arg1, arg2, arg3, &mut arg4, arg5, arg10, arg11, arg12, arg17);
        let v1 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg17);
        let v2 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(0x2::balance::value<T1>(&arg0.hot), arg13, arg14)), arg18);
        if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            let v3 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::amount<T0, T1>(0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth));
            let v4 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(v3, arg13, arg14);
            if (v4 > 0) {
                let v5 = if (v4 == v3) {
                    0x1::option::extract<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth)
                } else {
                    0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::split<T0, T1>(0x1::option::borrow_mut<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth), v4, arg18)
                };
                let (v6, v7) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::redeem<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, arg12, v5, 0, arg16, arg17, arg18);
                arg4 = v6;
                0x2::coin::join<T1>(&mut v2, v7);
            };
        };
        let v8 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg7), arg13, arg14);
        if (v8 > 0) {
            0x2::coin::join<T1>(&mut v2, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg7, &arg0.lending_cap, arg6, v8, 0, arg17, arg18));
        };
        let v9 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg8, arg9), arg13, arg14);
        if (v9 > 0) {
            0x2::coin::join<T1>(&mut v2, 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg8, &arg0.reserve_cap, arg9, arg10, v9, arg18));
        };
        let v10 = 0x2::coin::value<T1>(&v2);
        assert!(v10 > 0 && v10 >= arg15, 4);
        let v11 = Withdrawn{
            basket      : 0x2::object::uid_to_inner(&arg0.id),
            numerator   : arg13,
            denominator : arg14,
            payout      : v10,
            before      : v1,
            after       : value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg17),
        };
        0x2::event::emit<Withdrawn>(v11);
        (arg4, v2)
    }

    public fun cash_maintenance<T0, T1>(arg0: &Basket<T0, T1>, arg1: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock) : (u64, u64, u64, u64, bool) {
        let v0 = if (arg0.sleeve == 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(arg1)) {
            if (arg0.reserve == 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg2)) {
                arg0.lending_market == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg4)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = shares<T0, T1>(arg0);
        let v2 = 0x2::balance::value<T1>(&arg0.hot);
        let v3 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg1, arg4, arg5);
        let v4 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg2, arg3);
        let v5 = ((((v2 as u128) + (v3 as u128) + (v4 as u128)) * (arg0.hot_bps as u128) / 10000) as u64);
        let v6 = if (v2 > v5) {
            v2 - v5
        } else {
            0
        };
        let v7 = v1 == 0 && lendable<T0, T1>(arg4, v6, arg5);
        (v1, v2, v3, v4, v7)
    }

    public fun cash_value<T0, T1>(arg0: &Basket<T0, T1>, arg1: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock) : u64 {
        check_cash<T0, T1>(arg0, arg1, arg2, arg4);
        0x2::balance::value<T1>(&arg0.hot) + 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg1, arg4, arg5) + 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg2, arg3)
    }

    fun check<T0, T1>(arg0: &Basket<T0, T1>, arg1: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg4: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        let v0 = if (0x2::object::id<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>>(arg1) == arg0.engine) {
            if (0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2) == arg0.market) {
                if (0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(arg3) == arg0.sleeve) {
                    if (0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg4) == arg0.reserve) {
                        0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg5) == arg0.lending_market
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun check_cash<T0, T1>(arg0: &Basket<T0, T1>, arg1: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        let v0 = if (0x1::option::is_none<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            if (arg0.sleeve == 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(arg1)) {
                if (arg0.reserve == 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg2)) {
                    arg0.lending_market == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun deposit_cash<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v1 = 0x2::coin::value<T1>(&arg5);
        0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(arg5));
        park_cash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg8);
        let v2 = cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v3 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::share_math::contribution(v0, v2, v1);
        assert!(v3 >= arg6, 2);
        let v4 = Deposited{
            basket  : id<T0, T1>(arg0),
            deposit : v1,
            added   : v3,
            before  : v0,
            after   : v2,
        };
        0x2::event::emit<Deposited>(v4);
        v3
    }

    fun distribute_cash<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::cash_targets(0x2::balance::value<T1>(&arg0.hot) + 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg2, arg1, arg6) + 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg3, arg4), arg0.synth_bps, arg0.hot_bps, arg0.lent_bps, arg0.reserve_bps);
        gather_cash<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v1, v2, arg6, arg7);
        let v3 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg3, arg4);
        let v4 = if (0x2::balance::value<T1>(&arg0.hot) > v0) {
            0x2::balance::value<T1>(&arg0.hot) - v0
        } else {
            0
        };
        let v5 = if (v2 > v3) {
            0x1::u64::min(v2 - v3, v4)
        } else {
            0
        };
        if (v5 > 0) {
            0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::deposit<T1>(arg3, arg4, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, v5), arg7));
        };
        let v6 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg2, arg1, arg6);
        let v7 = if (0x2::balance::value<T1>(&arg0.hot) > v0) {
            0x2::balance::value<T1>(&arg0.hot) - v0
        } else {
            0
        };
        let v8 = if (v1 > v6) {
            0x1::u64::min(v1 - v6, v7)
        } else {
            0
        };
        if (lendable<T0, T1>(arg1, v8, arg6)) {
            0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::deposit<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, v8), arg7), arg6, arg7);
        };
    }

    public fun engine_id<T0, T1>(arg0: &Basket<T0, T1>) : 0x2::object::ID {
        arg0.engine
    }

    fun gather_cash<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg3: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg3, arg4);
        if (v0 > arg7) {
            0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg3, &arg0.reserve_cap, arg4, arg5, v0 - arg7, arg9)));
        };
        let v1 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg2, arg1, arg8);
        if (v1 > arg6) {
            let v2 = 0x1::u64::min(0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1 - arg6), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1), arg8))));
            if (v2 > 0) {
                0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg2, &arg0.lending_cap, arg1, v2, 0, arg8, arg9)));
            };
        };
    }

    public fun hot<T0, T1>(arg0: &Basket<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.hot)
    }

    fun lendable<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        arg1 > 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0), arg2))
    }

    public fun market_id<T0, T1>(arg0: &Basket<T0, T1>) : 0x2::object::ID {
        arg0.market
    }

    public fun park_cash<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (((cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5) as u128) * (arg0.hot_bps as u128) / 10000) as u64);
        let v1 = if (0x2::balance::value<T1>(&arg0.hot) > v0) {
            0x2::balance::value<T1>(&arg0.hot) - v0
        } else {
            0
        };
        if (!lendable<T0, T1>(arg4, v1, arg5)) {
            return 0
        };
        0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::deposit<T0, T1>(arg1, arg4, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, v1), arg6), arg5, arg6);
        v1
    }

    public fun rebalance<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg9: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, u64, u64, u64, u64) {
        check<T0, T1>(arg0, arg1, &arg4, arg7, arg8, arg6);
        timely<T0, T1>(arg0, arg10, arg14, arg15);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T0, T1>(arg1, arg2, arg3, &mut arg4, arg5, arg10, arg11, arg12, arg15);
        let v1 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg15);
        let v2 = if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::share_value_at<T0, T1>(arg1, arg2, arg3, &arg4, arg5, arg6, &v0, arg15, 0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth))
        } else {
            0
        };
        let (v3, v4) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::rebalance_plan(v1, v2, arg0.synth_bps, arg13);
        if (v4 == 0) {
            return (arg4, v1, v1, v2, v2)
        };
        let v5 = v4;
        if (v3) {
            let (_, v7, v8) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::cash_targets(v1 - v2 - v4, arg0.synth_bps, arg0.hot_bps, arg0.lent_bps, arg0.reserve_bps);
            gather_cash<T0, T1>(arg0, arg6, arg7, arg8, arg9, arg10, v7, v8, arg15, arg16);
            assert!(0x2::balance::value<T1>(&arg0.hot) >= v4, 4);
            let (v9, v10) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::mint<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, arg12, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, v4), arg16), 1, arg14, arg15, arg16);
            arg4 = v9;
            if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
                0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::join<T0, T1>(0x1::option::borrow_mut<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth), v10);
            } else {
                0x1::option::fill<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth, v10);
            };
        } else {
            let v11 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::amount<T0, T1>(0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth));
            let v12 = (((v11 as u128) * (v4 as u128) / (v2 as u128)) as u64);
            if (v12 == 0) {
                return (arg4, v1, v1, v2, v2)
            };
            v5 = ((((v2 as u128) * (v12 as u128) + (v11 as u128) - 1) / (v11 as u128)) as u64);
            let v13 = if (v12 == v11) {
                0x1::option::extract<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth)
            } else {
                0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::split<T0, T1>(0x1::option::borrow_mut<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth), v12, arg16)
            };
            let (v14, v15) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::redeem<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, arg12, v13, 0, arg14, arg15, arg16);
            arg4 = v14;
            0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(v15));
        };
        distribute_cash<T0, T1>(arg0, arg6, arg7, arg8, arg9, arg10, arg15, arg16);
        let v16 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg15);
        let v17 = if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::share_value_at<T0, T1>(arg1, arg2, arg3, &arg4, arg5, arg6, &v0, arg15, 0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth))
        } else {
            0
        };
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::assert_rebalance_progress(v1, v2, v16, v17, arg0.synth_bps, v5);
        (arg4, v1, v16, v2, v17)
    }

    public fun refill_cash<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        timely<T0, T1>(arg0, arg5, arg6, arg7);
        let v0 = cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v1 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::refill_amount(v0, 0x2::balance::value<T1>(&arg0.hot), arg0.hot_bps, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg1, arg4, arg7));
        let v2 = 0;
        let v3 = 0;
        if (v1 > 0) {
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg4), arg7);
            let v5 = 0x1::u64::min(0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg1), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v1), v4)));
            v2 = v5;
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v5), v4)) == 0) {
                v2 = 0;
            };
            if (v2 > 0) {
                let v6 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg1, &arg0.lending_cap, arg4, v2, 1, arg7, arg8);
                let v7 = 0x2::coin::value<T1>(&v6);
                v3 = v7;
                assert!(v7 <= v1, 4);
                0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(v6));
            };
        };
        let v8 = cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        assert!((v8 as u128) + 1 >= (v0 as u128), 4);
        let v9 = HotRefilled{
            basket           : id<T0, T1>(arg0),
            target           : (((v0 as u128) * (arg0.hot_bps as u128) / 10000) as u64),
            ctokens_redeemed : v2,
            added            : v3,
            hot              : 0x2::balance::value<T1>(&arg0.hot),
            before           : v0,
            after            : v8,
        };
        0x2::event::emit<HotRefilled>(v9);
        v3
    }

    public fun refill_hot<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg6: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : u64 {
        check<T0, T1>(arg0, arg1, arg4, arg7, arg8, arg6);
        timely<T0, T1>(arg0, arg10, arg13, arg14);
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg10, arg11, arg12, arg14);
        let v1 = value_at<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg14);
        let v2 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::refill_amount(v1, 0x2::balance::value<T1>(&arg0.hot), arg0.hot_bps, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg7, arg6, arg14));
        let v3 = 0;
        let v4 = 0;
        if (v2 > 0) {
            let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg6), arg14);
            let v6 = 0x1::u64::min(0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg7), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v2), v5)));
            v3 = v6;
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v6), v5)) == 0) {
                v3 = 0;
            };
            if (v3 > 0) {
                let v7 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg7, &arg0.lending_cap, arg6, v3, 1, arg14, arg15);
                let v8 = 0x2::coin::value<T1>(&v7);
                v4 = v8;
                assert!(v8 <= v2, 4);
                0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(v7));
            };
        };
        let v9 = value_at<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg14);
        assert!((v9 as u128) + 1 >= (v1 as u128), 4);
        let v10 = HotRefilled{
            basket           : 0x2::object::uid_to_inner(&arg0.id),
            target           : (((v1 as u128) * (arg0.hot_bps as u128) / 10000) as u64),
            ctokens_redeemed : v3,
            added            : v4,
            hot              : 0x2::balance::value<T1>(&arg0.hot),
            before           : v1,
            after            : v9,
        };
        0x2::event::emit<HotRefilled>(v10);
        v4
    }

    public fun shares<T0, T1>(arg0: &Basket<T0, T1>) : u64 {
        if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::amount<T0, T1>(0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth))
        } else {
            0
        }
    }

    public fun sweep_reserve<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.reserve == 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg1) && arg0.registry == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg3), 1);
        let v0 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg1, arg2);
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg1, &arg0.reserve_cap, arg2, arg3, v0, arg4)));
        };
        v0
    }

    public fun sweep_synth<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg10: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg11: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1> {
        check<T0, T1>(arg0, arg1, &arg4, arg7, arg8, arg6);
        timely<T0, T1>(arg0, arg10, arg14, arg15);
        if (0x1::option::is_none<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            return arg4
        };
        let v0 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::snapshot<T0, T1>(arg1, arg2, arg3, &mut arg4, arg5, arg10, arg11, arg12, arg15);
        let v1 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg15);
        let v2 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::amount<T0, T1>(0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth));
        let v3 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::share_value_at<T0, T1>(arg1, arg2, arg3, &arg4, arg5, arg6, &v0, arg15, 0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth));
        let v4 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::sweep_shares(v2, v3, v1, arg13);
        let v5 = if (v4 == v2) {
            0x1::option::extract<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth)
        } else {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::split<T0, T1>(0x1::option::borrow_mut<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&mut arg0.synth), v4, arg16)
        };
        let (v6, v7) = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::redeem_to_sleeve<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10, arg11, arg12, v5, 0, arg14, arg15, arg16);
        let v8 = v7;
        arg4 = v6;
        0x2::balance::join<T1>(&mut arg0.hot, 0x2::coin::into_balance<T1>(v8));
        let v9 = value_at<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8, arg9, &v0, arg15);
        0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::assert_sweep_cost(v1, v9, ((((v3 as u128) * (v4 as u128) + (v2 as u128) - 1) / (v2 as u128)) as u64));
        let v10 = SynthSwept{
            basket           : id<T0, T1>(arg0),
            shares_burned    : v4,
            remaining_shares : shares<T0, T1>(arg0),
            ctokens_moved    : 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg7) - 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg7),
            cash_added       : 0x2::coin::value<T1>(&v8),
            before           : v1,
            after            : v9,
        };
        0x2::event::emit<SynthSwept>(v10);
        arg4
    }

    fun timely<T0, T1>(arg0: &Basket<T0, T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg1) == arg0.registry, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg2 && arg2 - v0 <= 120000, 3);
    }

    public fun value_at<T0, T1>(arg0: &Basket<T0, T1>, arg1: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Engine<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg5: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg7: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg8: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg9: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg10: &0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::valuation::Prices, arg11: &0x2::clock::Clock) : u64 {
        check<T0, T1>(arg0, arg1, arg4, arg7, arg8, arg6);
        let v0 = if (0x1::option::is_some<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth)) {
            0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::share_value_at<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg10, arg11, 0x1::option::borrow<0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::engine::Shares<T0, T1>>(&arg0.synth))
        } else {
            0
        };
        0x2::balance::value<T1>(&arg0.hot) + v0 + 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg7, arg6, arg11) + 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg8, arg9)
    }

    public fun withdraw_cash<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg2: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.registry == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg5), 1);
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(0x2::balance::value<T1>(&arg0.hot), arg6, arg7)), arg10);
        let v1 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg1), arg6, arg7);
        if (v1 > 0) {
            0x2::coin::join<T1>(&mut v0, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg1, &arg0.lending_cap, arg4, v1, 0, arg9, arg10));
        };
        let v2 = 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::basket_math::portion(0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg2, arg3), arg6, arg7);
        if (v2 > 0) {
            0x2::coin::join<T1>(&mut v0, 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg2, &arg0.reserve_cap, arg3, arg5, v2, arg10));
        };
        let v3 = 0x2::coin::value<T1>(&v0);
        assert!(v3 > 0 && v3 >= arg8, 4);
        let v4 = Withdrawn{
            basket      : id<T0, T1>(arg0),
            numerator   : arg6,
            denominator : arg7,
            payout      : v3,
            before      : cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg9),
            after       : cash_value<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg9),
        };
        0x2::event::emit<Withdrawn>(v4);
        v0
    }

    public fun withdraw_hot<T0, T1>(arg0: &mut Basket<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<T1>(&arg0.hot), 4);
        let v0 = HotWithdrawn{
            basket    : 0x2::object::uid_to_inner(&arg0.id),
            payout    : arg1,
            remaining : 0x2::balance::value<T1>(&arg0.hot),
        };
        0x2::event::emit<HotWithdrawn>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.hot, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

