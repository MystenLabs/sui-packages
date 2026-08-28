module 0x9eb3dc5fe9b81ba2bcfb07f66db7afb49677667940c43828336d9b8eab1c2a59::bids {
    struct Bid<phantom T0> has key {
        id: 0x2::object::UID,
        target: 0x2::object::ID,
        bidder: address,
        escrow: 0x2::coin::Coin<T0>,
        expires_ms: u64,
    }

    struct BidPlaced has copy, drop {
        bid_id: 0x2::object::ID,
        target: 0x2::object::ID,
        bidder: address,
        amount: u64,
        expires_ms: u64,
    }

    struct BidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        target: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct BidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        target: 0x2::object::ID,
        bidder: address,
        seller: address,
        amount: u64,
    }

    public entry fun accept_bid<T0: store + key, T1>(arg0: Bid<T1>, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_ms, 3);
        assert!(0x2::object::id<T0>(&arg1) == arg0.target, 2);
        let Bid {
            id         : v0,
            target     : v1,
            bidder     : v2,
            escrow     : v3,
            expires_ms : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = 0x2::coin::value<T1>(&v5);
        let v8 = v7 * 500 / 10000;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v5, v8, arg3), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        let v9 = BidAccepted{
            bid_id : 0x2::object::uid_to_inner(&v6),
            target : v1,
            bidder : v2,
            seller : 0x2::tx_context::sender(arg3),
            amount : v7,
        };
        0x2::event::emit<BidAccepted>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<T0>(arg1, v2);
        0x2::object::delete(v6);
    }

    public entry fun cancel_bid<T0>(arg0: Bid<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bidder || 0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 1);
        let Bid {
            id         : v0,
            target     : v1,
            bidder     : v2,
            escrow     : v3,
            expires_ms : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = BidCancelled{
            bid_id : 0x2::object::uid_to_inner(&v6),
            target : v1,
            bidder : v2,
            amount : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<BidCancelled>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v2);
        0x2::object::delete(v6);
    }

    public entry fun place_bid<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2 > v0 && arg2 <= v0 + 2592000000, 6);
        let v1 = Bid<T0>{
            id         : 0x2::object::new(arg4),
            target     : arg0,
            bidder     : 0x2::tx_context::sender(arg4),
            escrow     : arg1,
            expires_ms : arg2,
        };
        let v2 = BidPlaced{
            bid_id     : 0x2::object::id<Bid<T0>>(&v1),
            target     : v1.target,
            bidder     : v1.bidder,
            amount     : 0x2::coin::value<T0>(&v1.escrow),
            expires_ms : arg2,
        };
        0x2::event::emit<BidPlaced>(v2);
        0x2::transfer::share_object<Bid<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

