module 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::user {
    struct ListEvent has copy, drop {
        asker: address,
        price: u64,
    }

    struct UnListEvent has copy, drop {
        asker: address,
    }

    struct OfferEvent has copy, drop {
        bidder: address,
        price: u64,
    }

    struct CancelOfferEvent has copy, drop {
        bidder: address,
    }

    struct TakeOfferEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct TakeListEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct RedeemCoinEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct RedeemTokenEvent has copy, drop {
        user: address,
        token_address: 0x2::object::ID,
    }

    public entry fun cancel_offer<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::OfferMarket, arg1: &0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg2: 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&arg2);
        let v1 = 0x2::object::id_to_address(&v0);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg1, v1);
        let (v2, _) = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::cancel_offer_in_offermarket(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg3));
        let v4 = CancelOfferEvent{bidder: 0x2::tx_context::sender(arg3)};
        0x2::event::emit<CancelOfferEvent>(v4);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_ordernft(arg2);
    }

    public entry fun change_vetoken_price<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::ListMarket<T0>, arg1: &0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg2: &0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft, arg3: u64) {
        let v0 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(arg2);
        let v1 = 0x2::object::id_to_address(&v0);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg1, v1);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::change_price_in_listmarket<T0>(arg0, v1, arg3);
    }

    public entry fun list_vetoken<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::ListMarket<T0>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::create_order_nft(arg3);
        let v1 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&v0);
        let v2 = 0x2::object::id_to_address(&v1);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::add_price_to_listmarket<T0>(arg0, v2, arg2);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::list_order_in_listmarket<T0>(arg0, v2, arg1);
        let v3 = ListEvent{
            asker : 0x2::tx_context::sender(arg3),
            price : arg2,
        };
        0x2::event::emit<ListEvent>(v3);
        0x2::transfer::public_transfer<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun make_offer_by_amount<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::OfferMarket, arg1: &0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        let v0 = OfferEvent{
            bidder : 0x2::tx_context::sender(arg5),
            price  : arg3,
        };
        0x2::event::emit<OfferEvent>(v0);
        let v1 = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::create_order_nft(arg5);
        let v2 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&v1);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::make_offer_in_offermarket(arg0, 0x2::object::id_to_address(&v2), 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg5), arg4);
        0x2::transfer::public_transfer<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun make_offer_by_coin<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::OfferMarket, arg1: &0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg1, arg3);
        let v0 = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::create_order_nft(arg4);
        let v1 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&v0);
        let v2 = OfferEvent{
            bidder : 0x2::tx_context::sender(arg4),
            price  : 0x2::coin::value<0x2::sui::SUI>(&arg2),
        };
        0x2::event::emit<OfferEvent>(v2);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::make_offer_in_offermarket(arg0, 0x2::object::id_to_address(&v1), arg2, arg3);
        0x2::transfer::public_transfer<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun redeem_coins<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg1: 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&arg1);
        let v1 = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::get_coin_from_reserve_and_pay_fee<T0>(arg0, 0x2::object::id_to_address(&v0), arg2);
        let v2 = RedeemCoinEvent{
            user   : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<RedeemCoinEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg2));
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_ordernft(arg1);
    }

    public entry fun redeem_vested_token<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg1: 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&arg1);
        let v1 = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::get_vested_token_from_reserve<T0>(arg0, 0x2::object::id_to_address(&v0));
        let v2 = RedeemTokenEvent{
            user          : 0x2::tx_context::sender(arg2),
            token_address : 0x2::object::id<T0>(&v1),
        };
        0x2::event::emit<RedeemTokenEvent>(v2);
        0x2::transfer::public_transfer<T0>(v1, 0x2::tx_context::sender(arg2));
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_ordernft(arg1);
    }

    public entry fun take_list<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::ListMarket<T0>, arg1: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg1, arg2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = *0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::get_price_in_listmarket<T0>(arg0, arg2);
        assert!(v0 > v1, 1);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_price_in_listmarket<T0>(arg0, arg2);
        0x2::transfer::public_transfer<T0>(0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::unlist_order_in_listmarket<T0>(arg0, arg2), 0x2::tx_context::sender(arg4));
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::add_coin_to_reserve<T0>(arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4));
        let v2 = TakeListEvent{
            user   : 0x2::tx_context::sender(arg4),
            amount : v0,
        };
        0x2::event::emit<TakeListEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
    }

    public entry fun take_offer<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::ListMarket<T0>, arg1: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::OfferMarket, arg2: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg3: 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&arg3);
        let v1 = 0x2::object::id_to_address(&v0);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg2, v1);
        let (v2, v3) = 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::cancel_offer_in_offermarket(arg1, arg4);
        let v4 = v2;
        assert!(v1 == v3, 2);
        let v5 = TakeOfferEvent{
            user   : 0x2::tx_context::sender(arg5),
            amount : 0x2::coin::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<TakeOfferEvent>(v5);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_price_in_listmarket<T0>(arg0, v1);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_ordernft(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::add_vested_token_to_reserve_and_pay_fee<T0>(arg2, arg4, 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::unlist_order_in_listmarket<T0>(arg0, v1), v4, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun unlist_vetoken<T0: store + key>(arg0: &mut 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::ListMarket<T0>, arg1: &0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::Reserve<T0>, arg2: 0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::Ordernft>(&arg2);
        let v1 = 0x2::object::id_to_address(&v0);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::reserve::assert_order_exist<T0>(arg1, v1);
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_price_in_listmarket<T0>(arg0, v1);
        let v2 = UnListEvent{asker: 0x2::tx_context::sender(arg3)};
        0x2::event::emit<UnListEvent>(v2);
        0x2::transfer::public_transfer<T0>(0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::unlist_order_in_listmarket<T0>(arg0, v1), 0x2::tx_context::sender(arg3));
        0x4fa5c4166d472223e0033126da35caa8a37951a33c6f29fc25c95afe67a4bc22::vesca_market::delete_ordernft(arg2);
    }

    // decompiled from Move bytecode v6
}

