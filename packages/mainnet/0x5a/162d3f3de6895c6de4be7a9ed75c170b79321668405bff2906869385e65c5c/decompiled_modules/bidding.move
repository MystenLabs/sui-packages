module 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::bidding {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Bid<phantom T0> has key {
        id: 0x2::object::UID,
        nft: 0x2::object::ID,
        buyer: address,
        kiosk: 0x2::object::ID,
        offer: 0x2::balance::Balance<T0>,
        commission: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>,
    }

    struct BidCreatedEvent has copy, drop {
        bid: 0x2::object::ID,
        nft: 0x2::object::ID,
        price: u64,
        commission: u64,
        buyer: address,
        buyer_kiosk: 0x2::object::ID,
        ft_type: 0x1::ascii::String,
    }

    struct BidClosedEvent has copy, drop {
        bid: 0x2::object::ID,
        nft: 0x2::object::ID,
        buyer: address,
        price: u64,
        ft_type: 0x1::ascii::String,
    }

    struct BidMatchedEvent has copy, drop {
        bid: 0x2::object::ID,
        nft: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        ft_type: 0x1::ascii::String,
        nft_type: 0x1::ascii::String,
    }

    public fun close_bid<T0>(arg0: &mut Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        close_bid_<T0>(arg0, arg1);
    }

    fun close_bid_<T0>(arg0: &mut Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.buyer == v0, 3);
        let v1 = 0x2::balance::value<T0>(&arg0.offer);
        assert!(v1 != 0, 1);
        let v2 = 0x2::coin::take<T0>(&mut arg0.offer, v1, arg1);
        if (0x1::option::is_some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>(&arg0.commission)) {
            let (v3, _) = 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::destroy_bid_commission<T0>(0x1::option::extract<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>(&mut arg0.commission));
            0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(&mut v2), v3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = BidClosedEvent{
            bid     : 0x2::object::id<Bid<T0>>(arg0),
            nft     : arg0.nft,
            buyer   : v0,
            price   : v1,
            ft_type : *0x1::type_name::borrow_string(&v5),
        };
        0x2::event::emit<BidClosedEvent>(v6);
    }

    public fun create_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_bid<T0>(arg0, arg1, arg2, 0x1::option::none<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>(), arg3, arg4);
        0x2::transfer::share_object<Bid<T0>>(v0);
        0x2::object::id<Bid<T0>>(&v0)
    }

    public fun create_bid_with_commission<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::option::some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::new_bid_commission<T0>(arg3, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), arg4)));
        let v1 = new_bid<T0>(arg0, arg1, arg2, v0, arg5, arg6);
        0x2::transfer::share_object<Bid<T0>>(v1);
        0x2::object::id<Bid<T0>>(&v1)
    }

    public fun new_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : Bid<T0> {
        assert!(arg2 != 0, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = if (0x1::option::is_some<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>(&arg3)) {
            0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::bid_commission_amount<T0>(0x1::option::borrow<0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::BidCommission<T0>>(&arg3))
        } else {
            0
        };
        let v2 = Bid<T0>{
            id         : 0x2::object::new(arg5),
            nft        : arg1,
            buyer      : v0,
            kiosk      : arg0,
            offer      : 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg4), arg2),
            commission : arg3,
        };
        let v3 = 0x1::type_name::get<T0>();
        let v4 = BidCreatedEvent{
            bid         : 0x2::object::id<Bid<T0>>(&v2),
            nft         : arg1,
            price       : arg2,
            commission  : v1,
            buyer       : v0,
            buyer_kiosk : arg0,
            ft_type     : *0x1::type_name::borrow_string(&v3),
        };
        0x2::event::emit<BidCreatedEvent>(v4);
        v2
    }

    public fun sell_nft<T0: store + key, T1>(arg0: &mut Bid<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::object::id<T0>(&arg2);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg1, arg2, arg3);
        let v1 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::new<T0>(v0, 0x2::object::uid_to_address(&arg0.id), arg0.kiosk, 0x2::balance::value<T1>(&arg0.offer), arg3);
        sell_nft_common<T0, T1>(arg0, arg1, v1, v0, arg3)
    }

    fun sell_nft_common<T0: store + key, T1>(arg0: &mut Bid<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::assert_kiosk_id(arg1, arg0.kiosk);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::balance::value<T1>(&arg0.offer);
        assert!(v1 != 0, 1);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, T1>(&mut arg2, 0x2::balance::withdraw_all<T1>(&mut arg0.offer), v0);
        let v2 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut arg2, &v2);
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::trading::transfer_bid_commission<T1>(&mut arg0.commission, arg4);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x1::type_name::get<T0>();
        let v5 = BidMatchedEvent{
            bid      : 0x2::object::id<Bid<T1>>(arg0),
            nft      : arg3,
            price    : v1,
            seller   : v0,
            buyer    : arg0.buyer,
            ft_type  : *0x1::type_name::borrow_string(&v3),
            nft_type : *0x1::type_name::borrow_string(&v4),
        };
        0x2::event::emit<BidMatchedEvent>(v5);
        arg2
    }

    public fun sell_nft_from_kiosk<T0: store + key, T1>(arg0: &mut Bid<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_signed<T0>(arg1, arg2, arg3, 0x2::balance::value<T1>(&arg0.offer), arg4);
        sell_nft_common<T0, T1>(arg0, arg2, v0, arg3, arg4)
    }

    public fun share<T0>(arg0: Bid<T0>) {
        0x2::transfer::share_object<Bid<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

