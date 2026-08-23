module 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::auction {
    struct Auction<T0: store + key> has key {
        id: 0x2::object::UID,
        marketplace_id: 0x2::object::ID,
        seller: address,
        item: 0x1::option::Option<T0>,
        item_id: 0x2::object::ID,
        reserve_price: u64,
        buy_now_price: 0x1::option::Option<u64>,
        min_increment_bps: u16,
        fee_bps: u16,
        starts_at_ms: u64,
        ends_at_ms: u64,
        max_ends_at_ms: u64,
        extension_window_ms: u64,
        extension_ms: u64,
        highest_bidder: 0x1::option::Option<address>,
        highest_bid: 0x2::balance::Balance<0x2::sui::SUI>,
        bid_count: u64,
        settled: bool,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
        item_type: 0x1::string::String,
        item_id: 0x2::object::ID,
        reserve_price: u64,
        buy_now_price: 0x1::option::Option<u64>,
        starts_at_ms: u64,
        ends_at_ms: u64,
        min_increment_bps: u16,
        timestamp_ms: u64,
    }

    struct AuctionBid has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        extended_to_ms: u64,
        bid_count: u64,
        timestamp_ms: u64,
    }

    struct AuctionSettled has copy, drop {
        auction_id: 0x2::object::ID,
        item_type: 0x1::string::String,
        item_id: 0x2::object::ID,
        seller: address,
        winner: 0x1::option::Option<address>,
        winning_bid: u64,
        marketplace_fee: u64,
        reserve_not_met: bool,
        timestamp_ms: u64,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        timestamp_ms: u64,
    }

    public fun bid<T0: store + key>(arg0: &0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Auction<T0>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 12);
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        assert!(!arg1.settled, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.starts_at_ms, 3);
        assert!(v0 < arg1.ends_at_ms, 1);
        assert!(0x2::tx_context::sender(arg5) != arg1.seller, 10);
        assert!(arg2 >= min_next_bid<T0>(arg1), 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg2, 14);
        if (0x1::option::is_some<address>(&arg1.highest_bidder)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bid), arg5), *0x1::option::borrow<address>(&arg1.highest_bidder));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.highest_bid, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, arg2, arg5)));
        arg1.highest_bidder = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
        arg1.bid_count = arg1.bid_count + 1;
        let v1 = 0;
        if (arg1.ends_at_ms - v0 <= arg1.extension_window_ms) {
            let v2 = arg1.ends_at_ms + arg1.extension_ms;
            let v3 = if (v2 > arg1.max_ends_at_ms) {
                arg1.max_ends_at_ms
            } else {
                v2
            };
            arg1.ends_at_ms = v3;
            v1 = arg1.ends_at_ms;
        };
        let v4 = AuctionBid{
            auction_id     : 0x2::object::id<Auction<T0>>(arg1),
            bidder         : 0x2::tx_context::sender(arg5),
            amount         : arg2,
            extended_to_ms : v1,
            bid_count      : arg1.bid_count,
            timestamp_ms   : v0,
        };
        0x2::event::emit<AuctionBid>(v4);
    }

    public fun bid_count<T0: store + key>(arg0: &Auction<T0>) : u64 {
        arg0.bid_count
    }

    public fun buy_now<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Auction<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 12);
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        assert!(!arg1.settled, 6);
        assert!(0x1::option::is_some<u64>(&arg1.buy_now_price), 13);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg1.ends_at_ms, 1);
        assert!(0x2::tx_context::sender(arg4) != arg1.seller, 10);
        let v1 = *0x1::option::borrow<u64>(&arg1.buy_now_price);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v1, 14);
        if (0x1::option::is_some<address>(&arg1.highest_bidder)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bid), arg4), *0x1::option::borrow<address>(&arg1.highest_bidder));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.highest_bid, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg4)));
        arg1.highest_bidder = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        arg1.ends_at_ms = v0;
        finalize<T0>(arg0, arg1, v0, arg4)
    }

    public fun buy_now_price<T0: store + key>(arg0: &Auction<T0>) : 0x1::option::Option<u64> {
        arg0.buy_now_price
    }

    public fun cancel<T0: store + key>(arg0: &mut Auction<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 0);
        assert!(!arg0.settled, 6);
        assert!(arg0.bid_count == 0, 5);
        arg0.settled = true;
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.item), arg0.seller);
        let v0 = AuctionCancelled{
            auction_id   : 0x2::object::id<Auction<T0>>(arg0),
            item_id      : arg0.item_id,
            seller       : arg0.seller,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AuctionCancelled>(v0);
    }

    public fun create<T0: store + key>(arg0: &0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: T0, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: u16, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 12);
        assert!(arg4 >= 600000 && arg4 <= 2592000000, 7);
        assert!(arg5 >= 100 && arg5 <= 5000, 8);
        assert!(arg2 >= 1000000, 9);
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) > arg2, 9);
        };
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = v0 + arg4;
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = Auction<T0>{
            id                  : 0x2::object::new(arg7),
            marketplace_id      : 0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0),
            seller              : 0x2::tx_context::sender(arg7),
            item                : 0x1::option::some<T0>(arg1),
            item_id             : v2,
            reserve_price       : arg2,
            buy_now_price       : arg3,
            min_increment_bps   : arg5,
            fee_bps             : 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::fee_bps(arg0),
            starts_at_ms        : v0,
            ends_at_ms          : v1,
            max_ends_at_ms      : v1 + 86400000,
            extension_window_ms : 600000,
            extension_ms        : 600000,
            highest_bidder      : 0x1::option::none<address>(),
            highest_bid         : 0x2::balance::zero<0x2::sui::SUI>(),
            bid_count           : 0,
            settled             : false,
        };
        let v4 = 0x2::object::id<Auction<T0>>(&v3);
        let v5 = AuctionCreated{
            auction_id        : v4,
            seller            : 0x2::tx_context::sender(arg7),
            item_type         : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            item_id           : v2,
            reserve_price     : arg2,
            buy_now_price     : arg3,
            starts_at_ms      : v0,
            ends_at_ms        : v1,
            min_increment_bps : arg5,
            timestamp_ms      : v0,
        };
        0x2::event::emit<AuctionCreated>(v5);
        0x2::transfer::share_object<Auction<T0>>(v3);
        v4
    }

    public fun ends_at_ms<T0: store + key>(arg0: &Auction<T0>) : u64 {
        arg0.ends_at_ms
    }

    fun finalize<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Auction<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        arg1.settled = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.highest_bid);
        let v1 = v0 < arg1.reserve_price;
        let v2 = arg1.item_id;
        let (v3, v4) = if (0x1::option::is_none<address>(&arg1.highest_bidder) || v1) {
            if (v0 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bid), arg3), *0x1::option::borrow<address>(&arg1.highest_bidder));
            };
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg1.item), arg1.seller);
            (0x1::option::none<address>(), 0)
        } else {
            let v5 = *0x1::option::borrow<address>(&arg1.highest_bidder);
            let v6 = (((v0 as u128) * (arg1.fee_bps as u128) / 10000) as u64);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.highest_bid, v6), arg3), 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::fee_recipient(arg0));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bid), arg3), arg1.seller);
            0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::record_trade(arg0, v0);
            0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg1.item), v5);
            (0x1::option::some<address>(v5), v6)
        };
        let v7 = AuctionSettled{
            auction_id      : 0x2::object::id<Auction<T0>>(arg1),
            item_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            item_id         : v2,
            seller          : arg1.seller,
            winner          : v3,
            winning_bid     : v0,
            marketplace_fee : v4,
            reserve_not_met : v1,
            timestamp_ms    : arg2,
        };
        0x2::event::emit<AuctionSettled>(v7);
        0x2::transfer_policy::new_request<T0>(v2, v0, 0x2::object::id<Auction<T0>>(arg1))
    }

    public fun highest_bid<T0: store + key>(arg0: &Auction<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.highest_bid)
    }

    public fun highest_bidder<T0: store + key>(arg0: &Auction<T0>) : 0x1::option::Option<address> {
        arg0.highest_bidder
    }

    public fun is_settled<T0: store + key>(arg0: &Auction<T0>) : bool {
        arg0.settled
    }

    public fun item_id<T0: store + key>(arg0: &Auction<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun min_next_bid<T0: store + key>(arg0: &Auction<T0>) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.highest_bid);
        if (v0 == 0) {
            arg0.reserve_price
        } else {
            let v2 = (((v0 as u128) * (arg0.min_increment_bps as u128) / 10000) as u64);
            let v3 = if (v2 == 0) {
                1
            } else {
                v2
            };
            v0 + v3
        }
    }

    public fun reserve_price<T0: store + key>(arg0: &Auction<T0>) : u64 {
        arg0.reserve_price
    }

    public fun seller<T0: store + key>(arg0: &Auction<T0>) : address {
        arg0.seller
    }

    public fun settle<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Auction<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        assert!(!arg1.settled, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.ends_at_ms, 2);
        finalize<T0>(arg0, arg1, v0, arg3)
    }

    // decompiled from Move bytecode v7
}

