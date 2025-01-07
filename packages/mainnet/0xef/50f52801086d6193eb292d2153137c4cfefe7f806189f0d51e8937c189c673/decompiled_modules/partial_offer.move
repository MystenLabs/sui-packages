module 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::partial_offer {
    struct PartialOffer has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        status: u8,
        buy_or_sell: bool,
        creator: address,
        fillers: 0x2::vec_map::VecMap<address, u64>,
        amount: u64,
        filled_amount: u64,
        collateral_value: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
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

    fun assert_active(arg0: &PartialOffer) {
        assert!(arg0.status == 0, 3);
    }

    fun add_filler(arg0: &mut PartialOffer, arg1: address, arg2: u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.fillers, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.fillers, &arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.fillers, arg1, arg2);
        };
    }

    fun assert_closable(arg0: &PartialOffer) {
        let v0 = if (arg0.status == 3) {
            true
        } else if (arg0.status == 4) {
            true
        } else if (arg0.status == 2) {
            true
        } else {
            arg0.status == 6
        };
        assert!(v0, 4);
    }

    fun assert_creator(arg0: &PartialOffer, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 5);
    }

    fun assert_fillable(arg0: &PartialOffer) {
        assert!(arg0.status == 0 || arg0.status == 4, 3);
    }

    fun assert_filled(arg0: &PartialOffer) {
        assert!(arg0.status == 3, 4);
    }

    fun assert_filler(arg0: &PartialOffer, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.fillers, &v0), 6);
    }

    fun assert_minimal_amount(arg0: u64) {
        assert!(arg0 > 0, 0);
    }

    fun assert_minimal_collateral_value(arg0: u64) {
        assert!(arg0 >= 1000000, 1);
    }

    fun assert_not_creator(arg0: &PartialOffer, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator != 0x2::tx_context::sender(arg1), 5);
    }

    fun assert_partial_filled(arg0: &PartialOffer) {
        assert!(arg0.status == 4, 4);
    }

    fun assert_valid_full_settlement<T0>(arg0: &PartialOffer, arg1: &0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: &0x2::coin::Coin<T0>) {
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::assert_coin_type<T0>(arg1);
        assert!(0x2::coin::value<T0>(arg2) == arg0.filled_amount * 0x1::u64::pow(10, 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::coin_decimals(arg1)), 7);
    }

    public entry fun cancel(arg0: &mut PartialOffer, arg1: &mut 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: &mut 0x2::tx_context::TxContext) {
        assert_fillable(arg0);
        assert_creator(arg0, arg2);
        if (arg0.status == 0) {
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::cancel_offer(arg1, 0x2::object::id<PartialOffer>(arg0), arg0.buy_or_sell, arg0.collateral_value, arg0.amount);
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::utils::withdraw_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg2);
            arg0.status = 1;
        } else {
            let v0 = arg0.filled_amount;
            let v1 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) - v0 * arg0.collateral_value / arg0.amount;
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::cancel_offer(arg1, 0x2::object::id<PartialOffer>(arg0), arg0.buy_or_sell, v1, arg0.amount - v0);
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::utils::withdraw_balance_value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, v1, arg2);
            arg0.status = 2;
        };
        let v2 = OfferCanceled{offer: 0x2::object::id<PartialOffer>(arg0)};
        0x2::event::emit<OfferCanceled>(v2);
    }

    public entry fun close(arg0: &mut PartialOffer, arg1: &mut 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::assert_closed(arg1, arg2);
        assert_closable(arg0);
        if (arg0.buy_or_sell) {
            assert_creator(arg0, arg3);
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::utils::withdraw_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg3);
        } else {
            assert_filler(arg0, arg3);
            let (v0, v1) = 0x2::vec_map::into_keys_values<address, u64>(arg0.fillers);
            let v2 = v1;
            let v3 = v0;
            let v4 = 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::utils::withdraw_balance_to_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(&v3)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4, 2 * arg0.collateral_value / arg0.amount * *0x1::vector::borrow<u64>(&v2, v5), arg3), *0x1::vector::borrow<address>(&v3, v5));
                v5 = v5 + 1;
            };
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4);
        };
        arg0.status = 5;
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::update_closed_offers(arg1, 0x2::object::id<PartialOffer>(arg0));
        let v6 = OfferClosed{offer: 0x2::object::id<PartialOffer>(arg0)};
        0x2::event::emit<OfferClosed>(v6);
    }

    public entry fun create(arg0: &mut 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::assert_active(arg0, arg5);
        assert_minimal_amount(arg2);
        assert_minimal_collateral_value(arg3);
        let v0 = PartialOffer{
            id                      : 0x2::object::new(arg6),
            market_id               : 0x2::object::id<0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market>(arg0),
            status                  : 0,
            buy_or_sell             : arg1,
            creator                 : 0x2::tx_context::sender(arg6),
            fillers                 : 0x2::vec_map::empty<address, u64>(),
            amount                  : arg2,
            filled_amount           : 0,
            collateral_value        : arg3,
            balance                 : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            created_at_timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = &mut arg4;
        let v2 = split_fee(&v0, arg0, v1, arg6);
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::add_offer(arg0, 0x2::object::id<PartialOffer>(&v0), v0.buy_or_sell, false, v0.collateral_value, v0.amount, v2, arg6);
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0.balance, arg4);
        let v3 = OfferCreated{offer: 0x2::object::id<PartialOffer>(&v0)};
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<PartialOffer>(v0);
    }

    public entry fun fill(arg0: &mut PartialOffer, arg1: &mut 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: u64, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::assert_active(arg1, arg4);
        assert_fillable(arg0);
        assert_not_creator(arg0, arg5);
        assert_minimal_amount(arg2);
        assert!(arg2 <= arg0.amount - arg0.filled_amount, 0);
        let v0 = &mut arg3;
        let v1 = split_fee_partial(arg0, arg1, v0, arg2, arg5);
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::add_offer(arg1, 0x2::object::id<PartialOffer>(arg0), !arg0.buy_or_sell, true, arg0.collateral_value, arg0.amount, v1, arg5);
        0x2::coin::put<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg3);
        add_filler(arg0, 0x2::tx_context::sender(arg5), arg2);
        arg0.filled_amount = arg0.filled_amount + arg2;
        let v2 = if (arg0.filled_amount >= arg0.amount) {
            3
        } else {
            4
        };
        arg0.status = v2;
        let v3 = OfferFilled{offer: 0x2::object::id<PartialOffer>(arg0)};
        0x2::event::emit<OfferFilled>(v3);
    }

    public entry fun settle_and_close<T0>(arg0: &mut PartialOffer, arg1: &mut 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::assert_settlement(arg1, arg3);
        assert_closable(arg0);
        if (arg0.buy_or_sell) {
            assert_filler(arg0, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg0.creator);
            let v0 = 0x2::tx_context::sender(arg4);
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::utils::withdraw_balance_value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg0.collateral_value / arg0.amount * *0x2::vec_map::get_mut<address, u64>(&mut arg0.fillers, &v0), arg4);
            let v1 = if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance) > 0) {
                6
            } else {
                5
            };
            arg0.status = v1;
        } else {
            assert_creator(arg0, arg4);
            assert_valid_full_settlement<T0>(arg0, arg1, &arg2);
            let (v2, v3) = 0x2::vec_map::into_keys_values<address, u64>(arg0.fillers);
            let v4 = v3;
            let v5 = v2;
            let v6 = 0;
            while (v6 < 0x1::vector::length<address>(&v5)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, *0x1::vector::borrow<u64>(&v4, v6) * 0x1::u64::pow(10, 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::coin_decimals(arg1)), arg4), *0x1::vector::borrow<address>(&v5, v6));
                v6 = v6 + 1;
            };
            0x2::coin::destroy_zero<T0>(arg2);
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::utils::withdraw_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.balance, arg4);
            arg0.status = 5;
            0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::update_closed_offers(arg1, 0x2::object::id<PartialOffer>(arg0));
            let v7 = OfferClosed{offer: 0x2::object::id<PartialOffer>(arg0)};
            0x2::event::emit<OfferClosed>(v7);
        };
    }

    fun split_fee(arg0: &PartialOffer, arg1: &0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = arg0.collateral_value * 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::fee_percentage(arg1) / 100;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2) == arg0.collateral_value + v0, 2);
        0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v0, arg3)
    }

    fun split_fee_partial(arg0: &PartialOffer, arg1: &0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::Market, arg2: &mut 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = arg0.collateral_value / arg0.amount * arg3;
        assert_minimal_collateral_value(v0);
        let v1 = v0 * 0xef50f52801086d6193eb292d2153137c4cfefe7f806189f0d51e8937c189c673::market::fee_percentage(arg1) / 100;
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2) == v0 + v1, 2);
        0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v1, arg4)
    }

    // decompiled from Move bytecode v6
}

