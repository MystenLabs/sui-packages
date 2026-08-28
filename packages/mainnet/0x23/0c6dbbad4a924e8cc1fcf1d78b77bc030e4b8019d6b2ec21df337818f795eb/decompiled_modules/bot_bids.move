module 0x9eb3dc5fe9b81ba2bcfb07f66db7afb49677667940c43828336d9b8eab1c2a59::bot_bids {
    struct BoomBids has drop {
        dummy_field: bool,
    }

    struct BotBid<phantom T0> has key {
        id: 0x2::object::UID,
        target: 0x2::object::ID,
        bidder: address,
        bidder_kiosk: 0x2::object::ID,
        escrow: 0x2::coin::Coin<T0>,
        expires_ms: u64,
    }

    struct BotBidPlaced has copy, drop {
        bid_id: 0x2::object::ID,
        target: 0x2::object::ID,
        bidder: address,
        bidder_kiosk: 0x2::object::ID,
        amount: u64,
        expires_ms: u64,
    }

    struct BotBidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        target: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct BotBidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        target: 0x2::object::ID,
        bidder: address,
        seller: address,
        amount: u64,
    }

    public fun accept_bot_bid<T0: store + key, T1>(arg0: BotBid<T1>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expires_ms, 3);
        let BotBid {
            id           : v0,
            target       : v1,
            bidder       : v2,
            bidder_kiosk : v3,
            escrow       : v4,
            expires_ms   : _,
        } = arg0;
        let v6 = v4;
        let v7 = v0;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == v3, 7);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, v1, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v10 = BoomBids{dummy_field: false};
        0x2::kiosk_extension::lock<BoomBids, T0>(v10, arg3, v8, arg4);
        let v11 = 0x2::coin::value<T1>(&v6);
        let v12 = v11 * 500 / 10000;
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v6, v12, arg6), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        let v13 = BotBidAccepted{
            bid_id : 0x2::object::uid_to_inner(&v7),
            target : v1,
            bidder : v2,
            seller : 0x2::tx_context::sender(arg6),
            amount : v11,
        };
        0x2::event::emit<BotBidAccepted>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg6));
        0x2::object::delete(v7);
        v9
    }

    public fun cancel_bot_bid<T0>(arg0: BotBid<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bidder || 0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 1);
        let BotBid {
            id           : v0,
            target       : v1,
            bidder       : v2,
            bidder_kiosk : _,
            escrow       : v4,
            expires_ms   : _,
        } = arg0;
        let v6 = v4;
        let v7 = v0;
        let v8 = BotBidCancelled{
            bid_id : 0x2::object::uid_to_inner(&v7),
            target : v1,
            bidder : v2,
            amount : 0x2::coin::value<T0>(&v6),
        };
        0x2::event::emit<BotBidCancelled>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v2);
        0x2::object::delete(v7);
    }

    public fun place_bot_bid<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg3) > 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg4 > v0 && arg4 <= v0 + 2592000000, 6);
        if (!0x2::kiosk_extension::is_installed<BoomBids>(arg1)) {
            let v1 = BoomBids{dummy_field: false};
            0x2::kiosk_extension::add<BoomBids>(v1, arg1, arg2, 2, arg6);
        } else if (!0x2::kiosk_extension::is_enabled<BoomBids>(arg1)) {
            0x2::kiosk_extension::enable<BoomBids>(arg1, arg2);
        };
        let v2 = BotBid<T0>{
            id           : 0x2::object::new(arg6),
            target       : arg0,
            bidder       : 0x2::tx_context::sender(arg6),
            bidder_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            escrow       : arg3,
            expires_ms   : arg4,
        };
        let v3 = BotBidPlaced{
            bid_id       : 0x2::object::id<BotBid<T0>>(&v2),
            target       : v2.target,
            bidder       : v2.bidder,
            bidder_kiosk : v2.bidder_kiosk,
            amount       : 0x2::coin::value<T0>(&v2.escrow),
            expires_ms   : arg4,
        };
        0x2::event::emit<BotBidPlaced>(v3);
        0x2::transfer::share_object<BotBid<T0>>(v2);
    }

    // decompiled from Move bytecode v7
}

