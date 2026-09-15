module 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::engine {
    struct Engine<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        sleeve: 0x2::object::ID,
        registry: 0x2::object::ID,
        base_oracle: 0x2::object::ID,
        collateral_oracle: 0x2::object::ID,
        custody_cap: 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::OwnerCap,
        lending_cap: 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::OwnerCap,
        supply: u64,
        lend_bps: u64,
        margin_bps: u64,
        buffer_bps: u64,
        max_nav: u64,
        active: bool,
        long: bool,
        leverage_bps: u64,
    }

    struct Shares<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        engine: 0x2::object::ID,
        amount: u64,
    }

    struct Created has copy, drop {
        engine: 0x2::object::ID,
        vault: 0x2::object::ID,
        sleeve: 0x2::object::ID,
        account: 0x2::object::ID,
        market: 0x2::object::ID,
        lend_bps: u64,
        margin_bps: u64,
        long: bool,
        leverage_bps: u64,
    }

    struct Minted has copy, drop {
        engine: 0x2::object::ID,
        deposit: u64,
        shares: u64,
        nav: u64,
        supply: u64,
    }

    struct Redeemed has copy, drop {
        engine: 0x2::object::ID,
        shares: u64,
        payout: u64,
        nav: u64,
        supply: u64,
    }

    struct MarginRestored has copy, drop {
        engine: 0x2::object::ID,
        collateral_added: u64,
        ctokens_redeemed: u64,
        nav: u64,
    }

    struct RedeemedToSleeve has copy, drop {
        engine: 0x2::object::ID,
        shares: u64,
        ctokens: u64,
        receipt_value: u64,
        cash_payout: u64,
        nav: u64,
        supply: u64,
    }

    struct MarginPolicyStatus has copy, drop {
        engine: 0x2::object::ID,
        market: 0x2::object::ID,
        timestamp_ms: u64,
        target_bps: u64,
        floor_bps: u64,
        target_shortfall: u64,
        floor_shortfall: u64,
    }

    public fun new<T0, T1>(arg0: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (Engine<T0, T1>, 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>) {
        let v0 = if (arg5 <= 4500) {
            if (arg6 >= 5500) {
                if (arg6 <= 10000) {
                    arg5 + arg6 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = if (arg7 >= 100) {
            if (arg7 <= 1000) {
                arg8 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::exposure_policy::assert_leverage(arg10);
        assert!((((arg10 as u256) * 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::margin_ratio_initial(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg1)) / 1000000000000000000) as u64) + 500 <= arg6, 2);
        let v2 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::prices<T1>(arg1, arg3, arg4, arg11);
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::assert_collateral_scaling(0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::collateral_scaling(&v2));
        let (v3, v4) = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::new<T1>(arg0, 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg1), 18446744073709551615, arg12);
        let v5 = v3;
        let (v6, v7) = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::new<T0, T1>(arg2, arg12);
        let v8 = v6;
        let v9 = Engine<T0, T1>{
            id                : 0x2::object::new(arg12),
            vault             : 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(&v5),
            sleeve            : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(&v8),
            registry          : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg0),
            base_oracle       : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3),
            collateral_oracle : 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4),
            custody_cap       : v4,
            lending_cap       : v7,
            supply            : 0,
            lend_bps          : arg5,
            margin_bps        : arg6,
            buffer_bps        : arg7,
            max_nav           : arg8,
            active            : false,
            long              : arg9,
            leverage_bps      : arg10,
        };
        let v10 = Created{
            engine       : 0x2::object::id<Engine<T0, T1>>(&v9),
            vault        : 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(&v5),
            sleeve       : 0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(&v8),
            account      : 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::account_id<T1>(&v5),
            market       : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg1),
            lend_bps     : arg5,
            margin_bps   : arg6,
            long         : arg9,
            leverage_bps : arg10,
        };
        0x2::event::emit<Created>(v10);
        (v9, v5, v8)
    }

    public fun market_id<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>) : 0x2::object::ID {
        assert!(0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg1) == arg0.vault, 1);
        0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::market_id<T1>(arg1)
    }

    public fun redeem<T0, T1>(arg0: &mut Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: Shares<T0, T1>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        check<T0, T1>(arg0, arg1, arg4, arg6, arg7, arg8);
        timely(arg12, arg11);
        let Shares {
            id     : v0,
            engine : v1,
            amount : v2,
        } = arg9;
        let v3 = if (v1 == 0x2::object::id<Engine<T0, T1>>(arg0)) {
            if (v2 > 0) {
                v2 <= arg0.supply
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        let (v4, v5, v6, v7) = close_redemption<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, v2, arg12, arg13);
        let v8 = v5;
        arg3 = v4;
        let v9 = ((((0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg4) as u128) * (v2 as u128) + (arg0.supply as u128) - 1) / (arg0.supply as u128)) as u64);
        if (v9 > 0) {
            0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::deposit<T1>(arg1, arg2, arg6, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg4, &arg0.lending_cap, arg5, v9, 0, arg12, arg13));
        };
        if (v2 == arg0.supply) {
            assert!(base<T1>(&arg3, arg2, arg0.long) == 0 && 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg4) == 0, 5);
        };
        let v10 = nav<T0, T1>(arg1, arg2, &arg3, arg4, arg5, &v8, arg12);
        let v11 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::redemption_payout(v7, v6, v10);
        assert!(v11 >= arg10 && v11 <= 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg1, arg2), 6);
        arg0.supply = arg0.supply - v2;
        0x2::object::delete(v0);
        let v12 = Redeemed{
            engine : 0x2::object::id<Engine<T0, T1>>(arg0),
            shares : v2,
            payout : v11,
            nav    : v10 - v11,
            supply : arg0.supply,
        };
        0x2::event::emit<Redeemed>(v12);
        (arg3, 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg1, &arg0.custody_cap, arg2, arg6, v11, arg13))
    }

    public fun activate<T0, T1>(arg0: &mut Engine<T0, T1>, arg1: &mut 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>) {
        assert!(!arg0.active && 0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg1) == arg0.vault, 2);
        0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::configure_margin<T1>(arg1, &arg0.custody_cap, arg2, arg3, arg0.margin_bps);
        0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::set_paused<T1>(arg1, &arg0.custody_cap, false);
        arg0.active = true;
    }

    public fun amount<T0, T1>(arg0: &Shares<T0, T1>) : u64 {
        arg0.amount
    }

    fun base<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T0>, arg2: bool) : u256 {
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::position<T0>(arg0, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::account_id<T0>(arg1));
        let (v1, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v0);
        if (arg2) {
            assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v0), 2);
            v1
        } else {
            assert!(v1 == 0 || 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1), 2);
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v1)
        }
    }

    public fun cash_quote_price<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock) : (u256, u256) {
        assert!(market_id<T0, T1>(arg0, arg1) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg2) && arg0.collateral_oracle == 0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg3), 1);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(arg2);
        let v1 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::collateral_oracle_price(v0, arg3, arg4);
        assert!(v1 > 0 && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v1), 3);
        let v2 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::scaling_factor(v0);
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::assert_collateral_scaling(v2);
        (v1, v2)
    }

    fun check<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg4: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg5: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        let v0 = if (arg0.active) {
            if (0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg1) == arg0.vault) {
                if (0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(arg2) == arg0.sleeve) {
                    if (0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry>(arg3) == arg0.registry) {
                        if (0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg4) == arg0.base_oracle) {
                            0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg5) == arg0.collateral_oracle
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
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public(friend) fun checked_deposit_notional(arg0: u64, arg1: u64, arg2: u256, arg3: u256, arg4: u64) : u64 {
        let v0 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::collateral_usd_e6(arg0, arg2, arg3, true);
        let v1 = if (arg1 > 0) {
            if (v0 <= arg4) {
                0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::collateral_usd_e6(arg1, arg2, arg3, true) <= arg4 - v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::collateral_usd_e6(arg1, arg2, arg3, false)
    }

    fun close_redemption<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::Prices, u64, u64) {
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::settle<T1>(arg1, arg2, &mut arg3, arg6, arg7, arg9);
        let v0 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::prices<T1>(&arg3, arg6, arg7, arg9);
        let v1 = nav<T0, T1>(arg1, arg2, &arg3, arg4, arg5, &v0, arg9);
        let v2 = base<T1>(&arg3, arg2, arg0.long);
        let v3 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::closing_size(((v2 / 1000000000) as u64), arg8, arg0.supply, 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg3)));
        if (v3 > 0) {
            let (v4, _) = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::trade<T1>(arg1, &arg0.custody_cap, arg2, arg3, arg6, arg7, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::exposure_policy::closing_side(arg0.long), v3, true, arg9, arg10);
            arg3 = v4;
            assert!(base<T1>(&arg3, arg2, arg0.long) + (v3 as u256) * 1000000000 == v2, 5);
        };
        (arg3, v0, v1, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::redeem_assets_scaled(arg8, v1, arg0.supply, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::collateral_scaling(&v0)))
    }

    public fun engine_id<T0, T1>(arg0: &Shares<T0, T1>) : 0x2::object::ID {
        arg0.engine
    }

    public fun join<T0, T1>(arg0: &mut Shares<T0, T1>, arg1: Shares<T0, T1>) {
        let Shares {
            id     : v0,
            engine : v1,
            amount : v2,
        } = arg1;
        assert!(v1 == arg0.engine, 1);
        arg0.amount = arg0.amount + v2;
        0x2::object::delete(v0);
    }

    fun lend<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::Prices, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = nav<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        let v1 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg4, arg5, arg8);
        let v2 = (((v0 as u128) * (arg0.lend_bps as u128) / 10000) as u64);
        let v3 = ((((v0 as u128) * (arg0.buffer_bps as u128) + 9999) / 10000) as u64);
        let v4 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg1, arg2);
        let v5 = if (v4 > v3) {
            v4 - v3
        } else {
            0
        };
        let v6 = if (v2 > v1) {
            0x1::u64::min(v2 - v1, v5)
        } else {
            0
        };
        if (v6 > 0) {
            0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::deposit<T0, T1>(arg4, arg5, 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg1, &arg0.custody_cap, arg2, arg6, v6, arg9), arg8, arg9);
        };
    }

    public fun leverage_bps<T0, T1>(arg0: &Engine<T0, T1>) : u64 {
        arg0.leverage_bps
    }

    public fun long<T0, T1>(arg0: &Engine<T0, T1>) : bool {
        arg0.long
    }

    public(friend) fun margin_floor_bps(arg0: u64) : u64 {
        assert!(arg0 >= 5500 && arg0 <= 10000, 2);
        arg0 - 100
    }

    public fun margin_policy_status<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) : MarginPolicyStatus {
        let v0 = snapshot<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = margin_floor_bps(arg0.margin_bps);
        MarginPolicyStatus{
            engine           : 0x2::object::id<Engine<T0, T1>>(arg0),
            market           : 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3),
            timestamp_ms     : 0x2::clock::timestamp_ms(arg8),
            target_bps       : arg0.margin_bps,
            floor_bps        : v1,
            target_shortfall : 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::margin_shortfall<T1>(arg2, arg3, &v0, arg0.margin_bps),
            floor_shortfall  : 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::margin_shortfall<T1>(arg2, arg3, &v0, v1),
        }
    }

    public fun mint<T0, T1>(arg0: &mut Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, Shares<T0, T1>) {
        check<T0, T1>(arg0, arg1, arg4, arg6, arg7, arg8);
        timely(arg12, arg11);
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::settle<T1>(arg1, arg2, &mut arg3, arg7, arg8, arg12);
        let v0 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::prices<T1>(&arg3, arg7, arg8, arg12);
        let v1 = nav<T0, T1>(arg1, arg2, &arg3, arg4, arg5, &v0, arg12);
        let v2 = 0x2::coin::value<T1>(&arg9);
        let v3 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::collateral_scaling(&v0);
        assert!(arg0.supply == 0 || v1 > 0, 3);
        let v4 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::order_size(0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::exposure_policy::entry_notional(checked_deposit_notional(v1, v2, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::collateral_price(&v0), v3, arg0.max_nav), arg0.leverage_bps), 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::mark(&v0), 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::lot_size(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T1>(&arg3)));
        assert!(v4 > 0, 3);
        let v5 = base<T1>(&arg3, arg2, arg0.long);
        assert!(arg0.supply > 0 || v5 == 0, 2);
        let v6 = v5 + (v4 as u256) * 1000000000;
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::assert_notional_limit(v6, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::mark(&v0), arg0.max_nav);
        0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::deposit<T1>(arg1, arg2, arg6, arg9);
        let (v7, _) = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::trade<T1>(arg1, &arg0.custody_cap, arg2, arg3, arg7, arg8, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::exposure_policy::opening_side(arg0.long), v4, false, arg12, arg13);
        arg3 = v7;
        assert!(base<T1>(&arg3, arg2, arg0.long) == v6, 5);
        lend<T0, T1>(arg0, arg1, arg2, &arg3, arg4, arg5, arg6, &v0, arg12, arg13);
        let v9 = nav<T0, T1>(arg1, arg2, &arg3, arg4, arg5, &v0, arg12);
        let v10 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::mint_shares_scaled(0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::contribution(v1, v9, v2), v1, arg0.supply, v3);
        assert!(v10 >= arg10, 3);
        arg0.supply = arg0.supply + v10;
        let v11 = Minted{
            engine  : 0x2::object::id<Engine<T0, T1>>(arg0),
            deposit : v2,
            shares  : v10,
            nav     : v9,
            supply  : arg0.supply,
        };
        0x2::event::emit<Minted>(v11);
        let v12 = Shares<T0, T1>{
            id     : 0x2::object::new(arg13),
            engine : 0x2::object::id<Engine<T0, T1>>(arg0),
            amount : v10,
        };
        (arg3, v12)
    }

    fun nav<T0, T1>(arg0: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg1: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg3: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::Prices, arg6: &0x2::clock::Clock) : u64 {
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::total<T1>(arg0, arg1, arg2, arg5, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg3, arg4, arg6))
    }

    public fun redeem_to_sleeve<T0, T1>(arg0: &mut Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg7: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg10: Shares<T0, T1>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, 0x2::coin::Coin<T1>) {
        check<T0, T1>(arg0, arg1, arg4, arg7, arg8, arg9);
        timely(arg13, arg12);
        let Shares {
            id     : v0,
            engine : v1,
            amount : v2,
        } = arg10;
        let v3 = if (v1 == 0x2::object::id<Engine<T0, T1>>(arg0)) {
            if (v2 > 0) {
                v2 <= arg0.supply
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        let (v4, v5, v6, v7) = close_redemption<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg8, arg9, v2, arg13, arg14);
        let v8 = v5;
        arg3 = v4;
        let v9 = nav<T0, T1>(arg1, arg2, &arg3, arg4, arg5, &v8, arg13);
        let v10 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::redemption_payout(v7, v6, v9);
        let v11 = (((0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg4) as u128) * (v2 as u128) / (arg0.supply as u128)) as u64);
        let v12 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::moved_value<T0, T1>(arg4, arg5, v11, arg13);
        assert!(v10 >= arg11 && v10 >= v12, 6);
        let v13 = v10 - v12;
        assert!(v13 <= 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg1, arg2), 6);
        if (v11 > 0) {
            0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::move_receipts<T0, T1>(arg4, &arg0.lending_cap, arg6, v11);
        };
        if (v2 == arg0.supply) {
            assert!(base<T1>(&arg3, arg2, arg0.long) == 0 && 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg4) == 0, 5);
        };
        let v14 = if (v13 == 0) {
            0x2::coin::zero<T1>(arg14)
        } else {
            0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::withdraw<T1>(arg1, &arg0.custody_cap, arg2, arg7, v13, arg14)
        };
        arg0.supply = arg0.supply - v2;
        0x2::object::delete(v0);
        let v15 = RedeemedToSleeve{
            engine        : 0x2::object::id<Engine<T0, T1>>(arg0),
            shares        : v2,
            ctokens       : v11,
            receipt_value : v12,
            cash_payout   : v13,
            nav           : v9 - v10,
            supply        : arg0.supply,
        };
        0x2::event::emit<RedeemedToSleeve>(v15);
        (arg3, v14)
    }

    public fun restore_margin<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0, arg1, arg4, arg6, arg7, arg8);
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::settle<T1>(arg1, arg2, arg3, arg7, arg8, arg9);
        let v0 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::prices<T1>(arg3, arg7, arg8, arg9);
        let v1 = 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::margin_shortfall<T1>(arg2, arg3, &v0, arg0.margin_bps);
        let v2 = 0;
        if (v1 > 0) {
            let v3 = 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::balance<T1>(arg1, arg2);
            if (v3 < v1) {
                let v4 = v1 - v3;
                let v5 = 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::value<T0, T1>(arg4, arg5, arg9);
                assert!(v5 >= v4, 6);
                let v6 = ((((v4 as u128) * (0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::ctoken_balance<T0, T1>(arg4) as u128) + (v5 as u128) - 1) / (v5 as u128)) as u64);
                v2 = v6;
                0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::deposit<T1>(arg1, arg2, arg6, 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::redeem<T0, T1>(arg4, &arg0.lending_cap, arg5, v6, v4, arg9, arg10));
            };
            0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::allocate_margin<T1>(arg1, &arg0.custody_cap, arg2, arg3, v1);
        };
        assert!(0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::margin_shortfall<T1>(arg2, arg3, &v0, arg0.margin_bps) == 0, 2);
        let v7 = MarginRestored{
            engine           : 0x2::object::id<Engine<T0, T1>>(arg0),
            collateral_added : v1,
            ctokens_redeemed : v2,
            nav              : nav<T0, T1>(arg1, arg2, arg3, arg4, arg5, &v0, arg9),
        };
        0x2::event::emit<MarginRestored>(v7);
    }

    public fun share<T0, T1>(arg0: Engine<T0, T1>) {
        0x2::transfer::share_object<Engine<T0, T1>>(arg0);
    }

    public fun share_value_at<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::Prices, arg7: &0x2::clock::Clock, arg8: &Shares<T0, T1>) : u64 {
        let v0 = if (arg0.active) {
            if (0x2::object::id<0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>>(arg1) == arg0.vault) {
                if (0x2::object::id<0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>>(arg4) == arg0.sleeve) {
                    arg8.engine == 0x2::object::id<Engine<T0, T1>>(arg0)
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
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::share_math::redeem_assets_scaled(arg8.amount, nav<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7), arg0.supply, 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::collateral_scaling(arg6))
    }

    public fun snapshot<T0, T1>(arg0: &Engine<T0, T1>, arg1: &0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::Vault<T1>, arg2: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg6: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x2::clock::Clock) : 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::Prices {
        check<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
        assert!(0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::market_id<T1>(arg1) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>>(arg3) && 0x44dc40bdf536875f2e8640b82b51f72e769fe4fe358679388bd5520753462a28::custody::account_id<T1>(arg1) == 0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>>(arg2), 1);
        if (0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T1>(arg3) == 0 && !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T1>(arg3)) {
            0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::settle<T1>(arg1, arg2, arg3, arg6, arg7, arg8);
        };
        0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::valuation::prices<T1>(arg3, arg6, arg7, arg8)
    }

    public fun split<T0, T1>(arg0: &mut Shares<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Shares<T0, T1> {
        assert!(arg1 > 0 && arg1 < arg0.amount, 3);
        arg0.amount = arg0.amount - arg1;
        Shares<T0, T1>{
            id     : 0x2::object::new(arg2),
            engine : arg0.engine,
            amount : arg1,
        }
    }

    public fun supply<T0, T1>(arg0: &Engine<T0, T1>) : u64 {
        arg0.supply
    }

    fun timely(arg0: &0x2::clock::Clock, arg1: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 <= arg1 && arg1 - v0 <= 120000, 4);
    }

    // decompiled from Move bytecode v7
}

