module 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::offer {
    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        status: u8,
        is_buy: bool,
        creator: address,
        filler: 0x1::option::Option<address>,
        amount: u64,
        collateral_value: u64,
        balance: 0x2::balance::Balance<T0>,
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

    fun assert_active<T0>(arg0: &Offer<T0>) {
        assert!(arg0.status == 0, 3);
    }

    fun assert_creator<T0>(arg0: &Offer<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 5);
    }

    fun assert_filled<T0>(arg0: &Offer<T0>) {
        assert!(arg0.status == 2, 4);
    }

    fun assert_filler<T0>(arg0: &Offer<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<address>(&arg0.filler)) {
            let v1 = 0x2::tx_context::sender(arg1);
            0x1::option::borrow<address>(&arg0.filler) == &v1
        } else {
            false
        };
        assert!(v0, 6);
    }

    fun assert_not_creator<T0>(arg0: &Offer<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator != 0x2::tx_context::sender(arg1), 5);
    }

    fun assert_valid_settlement<T0, T1>(arg0: &Offer<T1>, arg1: &0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T1>, arg2: &0x2::coin::Coin<T0>) {
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::assert_coin_type<T0, T1>(arg1);
        assert!(0x2::coin::value<T0>(arg2) == arg0.amount * 0x1::u64::pow(10, 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::coin_decimals<T1>(arg1)), 7);
    }

    public entry fun cancel<T0>(arg0: &mut Offer<T0>, arg1: &mut 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active<T0>(arg0);
        assert_creator<T0>(arg0, arg2);
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::cancel_offer<T0>(arg1, 0x2::object::id<Offer<T0>>(arg0), arg0.is_buy, arg0.collateral_value, arg0.amount);
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::utils::withdraw_balance<T0>(&mut arg0.balance, arg2);
        arg0.status = 1;
        let v0 = OfferCanceled{offer: 0x2::object::id<Offer<T0>>(arg0)};
        0x2::event::emit<OfferCanceled>(v0);
    }

    public entry fun close<T0>(arg0: &mut Offer<T0>, arg1: &mut 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::assert_closed<T0>(arg1, arg2);
        assert_filled<T0>(arg0);
        if (arg0.is_buy) {
            assert_creator<T0>(arg0, arg3);
        } else {
            assert_filler<T0>(arg0, arg3);
        };
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::utils::withdraw_balance<T0>(&mut arg0.balance, arg3);
        arg0.status = 3;
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::update_closed_offers<T0>(arg1, 0x2::object::id<Offer<T0>>(arg0));
        let v0 = OfferClosed{offer: 0x2::object::id<Offer<T0>>(arg0)};
        0x2::event::emit<OfferClosed>(v0);
    }

    public entry fun create<T0>(arg0: &mut 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::assert_active<T0>(arg0, arg5);
        assert!(arg2 > 0, 0);
        assert!(arg3 >= 1000000, 1);
        let v0 = Offer<T0>{
            id                      : 0x2::object::new(arg6),
            market_id               : 0x2::object::id<0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T0>>(arg0),
            status                  : 0,
            is_buy                  : arg1,
            creator                 : 0x2::tx_context::sender(arg6),
            filler                  : 0x1::option::none<address>(),
            amount                  : arg2,
            collateral_value        : arg3,
            balance                 : 0x2::balance::zero<T0>(),
            created_at_timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = &mut arg4;
        let v2 = split_fee<T0>(&v0, arg0, v1, arg6);
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::add_offer<T0>(arg0, 0x2::object::id<Offer<T0>>(&v0), v0.is_buy, false, v0.collateral_value, v0.amount, v2, arg6);
        0x2::coin::put<T0>(&mut v0.balance, arg4);
        let v3 = OfferCreated{offer: 0x2::object::id<Offer<T0>>(&v0)};
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<Offer<T0>>(v0);
    }

    public entry fun fill<T0>(arg0: &mut Offer<T0>, arg1: &mut 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::assert_active<T0>(arg1, arg3);
        assert_active<T0>(arg0);
        assert_not_creator<T0>(arg0, arg4);
        let v0 = &mut arg2;
        let v1 = split_fee<T0>(arg0, arg1, v0, arg4);
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::add_offer<T0>(arg1, 0x2::object::id<Offer<T0>>(arg0), !arg0.is_buy, true, arg0.collateral_value, arg0.amount, v1, arg4);
        0x2::coin::put<T0>(&mut arg0.balance, arg2);
        arg0.filler = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        arg0.status = 2;
        let v2 = OfferFilled{offer: 0x2::object::id<Offer<T0>>(arg0)};
        0x2::event::emit<OfferFilled>(v2);
    }

    public entry fun settle_and_close<T0, T1>(arg0: &mut Offer<T1>, arg1: &mut 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::assert_settlement<T1>(arg1, arg3);
        assert_filled<T1>(arg0);
        let v0 = if (arg0.is_buy) {
            assert_filler<T1>(arg0, arg4);
            arg0.creator
        } else {
            assert_creator<T1>(arg0, arg4);
            *0x1::option::borrow<address>(&arg0.filler)
        };
        assert_valid_settlement<T0, T1>(arg0, arg1, &arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::utils::withdraw_balance<T1>(&mut arg0.balance, arg4);
        arg0.status = 3;
        0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::update_closed_offers<T1>(arg1, 0x2::object::id<Offer<T1>>(arg0));
        let v1 = OfferClosed{offer: 0x2::object::id<Offer<T1>>(arg0)};
        0x2::event::emit<OfferClosed>(v1);
    }

    fun split_fee<T0>(arg0: &Offer<T0>, arg1: &0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::Market<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg0.collateral_value * 0x921fb6e1c3ec786a2ec23ce1fd97edaf48b99fb288a8fdf4c0ac7062c1838980::market::fee_percentage<T0>(arg1) / 100;
        assert!(0x2::coin::value<T0>(arg2) == arg0.collateral_value + v0, 2);
        0x2::coin::split<T0>(arg2, v0, arg3)
    }

    // decompiled from Move bytecode v6
}

