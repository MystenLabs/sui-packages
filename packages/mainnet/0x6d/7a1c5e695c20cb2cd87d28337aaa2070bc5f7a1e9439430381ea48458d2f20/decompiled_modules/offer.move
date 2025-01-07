module 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::offer {
    struct Offer has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        status: u8,
        is_buy: bool,
        creator: address,
        filler: 0x1::option::Option<address>,
        amount: u64,
        collateral_value: u64,
        balance: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
        created_at_timestamp_ms: u64,
    }

    struct OfferCreated has copy, drop {
        offer: 0x2::object::ID,
    }

    struct OfferCanceled has copy, drop {
        offer: 0x2::object::ID,
    }

    struct OfferFilled has copy, drop {
        offer: 0x2::object::ID,
    }

    struct OfferClosed has copy, drop {
        offer: 0x2::object::ID,
    }

    fun assert_active(arg0: &Offer) {
        assert!(arg0.status == 0, 3);
    }

    fun assert_creator(arg0: &Offer, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 5);
    }

    fun assert_filled(arg0: &Offer) {
        assert!(arg0.status == 2, 4);
    }

    fun assert_filler(arg0: &Offer, arg1: &0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg0.filler)) {
            let v1 = 0x2::tx_context::sender(arg1);
            0x1::option::borrow<address>(&arg0.filler) == &v1
        } else {
            false
        };
        assert!(v0, 6);
    }

    fun assert_not_creator(arg0: &Offer, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator != 0x2::tx_context::sender(arg1), 5);
    }

    fun assert_valid_settlement<T0>(arg0: &Offer, arg1: &0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market, arg2: &0x2::coin::Coin<T0>) {
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::assert_coin_type<T0>(arg1);
        assert!(0x2::coin::value<T0>(arg2) == arg0.amount * 0x1::u64::pow(10, 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::coin_decimals(arg1)), 7);
    }

    public entry fun cancel(arg0: &mut Offer, arg1: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_creator(arg0, arg1);
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::utils::withdraw_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, arg1);
        arg0.status = 1;
        let v0 = OfferCanceled{offer: 0x2::object::id<Offer>(arg0)};
        0x2::event::emit<OfferCanceled>(v0);
    }

    public entry fun close(arg0: &mut Offer, arg1: &mut 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::assert_closed(arg1, arg2);
        assert_filled(arg0);
        if (arg0.is_buy) {
            assert_creator(arg0, arg3);
        } else {
            assert_filler(arg0, arg3);
        };
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::utils::withdraw_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, arg3);
        arg0.status = 3;
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::update_closed_offers(arg1, 0x2::object::id<Offer>(arg0));
        let v0 = OfferClosed{offer: 0x2::object::id<Offer>(arg0)};
        0x2::event::emit<OfferClosed>(v0);
    }

    public entry fun create(arg0: &mut 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::assert_active(arg0, arg5);
        assert!(arg2 > 0, 0);
        assert!(arg3 >= 1000000, 1);
        let v0 = Offer{
            id                      : 0x2::object::new(arg6),
            market_id               : 0x2::object::id<0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market>(arg0),
            status                  : 0,
            is_buy                  : arg1,
            creator                 : 0x2::tx_context::sender(arg6),
            filler                  : 0x1::option::none<address>(),
            amount                  : arg2,
            collateral_value        : arg3,
            balance                 : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
            created_at_timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = &mut arg4;
        let v2 = split_fee(&v0, arg0, v1, arg6);
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::add_offer(arg0, 0x2::object::id<Offer>(&v0), v0.is_buy, false, v0.collateral_value, v0.amount, v2, arg6);
        0x2::coin::put<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v0.balance, arg4);
        let v3 = OfferCreated{offer: 0x2::object::id<Offer>(&v0)};
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<Offer>(v0);
    }

    public entry fun fill(arg0: &mut Offer, arg1: &mut 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market, arg2: 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::assert_active(arg1, arg3);
        assert_active(arg0);
        assert_not_creator(arg0, arg4);
        let v0 = &mut arg2;
        let v1 = split_fee(arg0, arg1, v0, arg4);
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::add_offer(arg1, 0x2::object::id<Offer>(arg0), !arg0.is_buy, true, arg0.collateral_value, arg0.amount, v1, arg4);
        0x2::coin::put<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, arg2);
        arg0.filler = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        arg0.status = 2;
        let v2 = OfferFilled{offer: 0x2::object::id<Offer>(arg0)};
        0x2::event::emit<OfferFilled>(v2);
    }

    public entry fun settle_and_close<T0>(arg0: &mut Offer, arg1: &mut 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::assert_settlement(arg1, arg3);
        assert_filled(arg0);
        let v0 = if (arg0.is_buy) {
            assert_filler(arg0, arg4);
            arg0.creator
        } else {
            assert_creator(arg0, arg4);
            *0x1::option::borrow<address>(&arg0.filler)
        };
        assert_valid_settlement<T0>(arg0, arg1, &arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::utils::withdraw_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.balance, arg4);
        arg0.status = 3;
        0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::update_closed_offers(arg1, 0x2::object::id<Offer>(arg0));
        let v1 = OfferClosed{offer: 0x2::object::id<Offer>(arg0)};
        0x2::event::emit<OfferClosed>(v1);
    }

    fun split_fee(arg0: &Offer, arg1: &0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::Market, arg2: &mut 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN> {
        let v0 = arg0.collateral_value * 0x6d7a1c5e695c20cb2cd87d28337aaa2070bc5f7a1e9439430381ea48458d2f20::market::fee_percentage(arg1) / 100;
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2) == arg0.collateral_value + v0, 2);
        0x2::coin::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

