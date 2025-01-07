module 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::dutch_auction {
    struct DutchAuctionMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
        reserve_price: u64,
        bids: 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::CritbitTree<vector<Bid<T0>>>,
        inventory_id: 0x2::object::ID,
    }

    struct Bid<phantom T0> has store {
        amount: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct MarketKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DutchAuctionMarket<T0> {
        DutchAuctionMarket<T0>{
            id            : 0x2::object::new(arg2),
            reserve_price : arg1,
            bids          : 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::new<vector<Bid<T0>>>(arg2),
            inventory_id  : arg0,
        }
    }

    public fun bid_amount<T0>(arg0: &Bid<T0>) : &0x2::balance::Balance<T0> {
        &arg0.amount
    }

    public fun bid_owner<T0>(arg0: &Bid<T0>) : address {
        arg0.owner
    }

    public fun bids<T0>(arg0: &DutchAuctionMarket<T0>) : &0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::CritbitTree<vector<Bid<T0>>> {
        &arg0.bids
    }

    public fun borrow_market<T0>(arg0: &0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::Venue) : &DutchAuctionMarket<T0> {
        let v0 = MarketKey{dummy_field: false};
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::borrow_market<DutchAuctionMarket<T0>, MarketKey>(v0, arg0)
    }

    fun cancel_auction<T0>(arg0: &mut DutchAuctionMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.bids;
        while (!0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::is_empty<vector<Bid<T0>>>(v0)) {
            let (v1, _) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::max_leaf<vector<Bid<T0>>>(v0);
            let v3 = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::remove_leaf_by_key<vector<Bid<T0>>>(v0, v1);
            while (!0x1::vector::is_empty<Bid<T0>>(&v3)) {
                let v4 = 0x1::vector::pop_back<Bid<T0>>(&mut v3);
                let v5 = 0x2::coin::zero<T0>(arg1);
                let v6 = v4.owner;
                let v7 = &mut v5;
                refund_bid<T0>(v4, v7, &v6);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, v6);
            };
            0x1::vector::destroy_empty<Bid<T0>>(v3);
        };
    }

    public entry fun cancel_bid<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::market_internal_mut<DutchAuctionMarket<T0>, MarketKey>(arg1, v0, arg2);
        cancel_bid_<T0>(v1, arg0, arg3, 0x2::tx_context::sender(arg4));
    }

    fun cancel_bid_<T0>(arg0: &mut DutchAuctionMarket<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address) {
        let v0 = &mut arg0.bids;
        let (v1, _) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::find_leaf<vector<Bid<T0>>>(v0, arg2);
        assert!(v1, 2);
        let v3 = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::borrow_mut_leaf_by_key<vector<Bid<T0>>>(v0, arg2);
        let v4 = 0;
        let v5 = 0x1::vector::length<Bid<T0>>(v3);
        while (v5 > v4) {
            if (0x1::vector::borrow<Bid<T0>>(v3, v4).owner == arg3) {
                break
            };
            v4 = v4 + 1;
        };
        assert!(v4 < v5, 3);
        refund_bid<T0>(0x1::vector::remove<Bid<T0>>(v3, v4), arg1, &arg3);
        if (0x1::vector::is_empty<Bid<T0>>(v3)) {
            0x1::vector::destroy_empty<Bid<T0>>(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::remove_leaf_by_key<vector<Bid<T0>>>(v0, arg2));
        };
    }

    fun conclude_auction<T0>(arg0: &mut DutchAuctionMarket<T0>, arg1: u64) : (u64, vector<Bid<T0>>) {
        let v0 = &mut arg0.bids;
        let v1 = 0;
        let v2 = 0x1::vector::empty<Bid<T0>>();
        while (arg1 > 0 && !0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::is_empty<vector<Bid<T0>>>(v0)) {
            let (v3, _) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::max_leaf<vector<Bid<T0>>>(v0);
            let v5 = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::borrow_mut_leaf_by_key<vector<Bid<T0>>>(v0, v3);
            if (0x1::vector::is_empty<Bid<T0>>(v5)) {
                0x1::vector::destroy_empty<Bid<T0>>(0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::remove_leaf_by_key<vector<Bid<T0>>>(v0, v3));
                continue
            };
            v1 = v3;
            arg1 = arg1 - 1;
            0x1::vector::push_back<Bid<T0>>(&mut v2, 0x1::vector::remove<Bid<T0>>(v5, 0));
        };
        (v1, v2)
    }

    public entry fun create_bid<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::venue_internal_mut<DutchAuctionMarket<T0>, MarketKey>(arg1, v0, arg2);
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::assert_is_live(v1);
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::assert_is_not_whitelisted(v1);
        let v2 = MarketKey{dummy_field: false};
        let v3 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::borrow_market_mut<DutchAuctionMarket<T0>, MarketKey>(v2, v1);
        create_bid_<T0>(v3, arg0, arg3, arg4, 0x2::tx_context::sender(arg5));
    }

    fun create_bid_<T0>(arg0: &mut DutchAuctionMarket<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address) {
        assert!(arg2 >= arg0.reserve_price, 1);
        let (v0, _) = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::find_leaf<vector<Bid<T0>>>(&arg0.bids, arg2);
        if (!v0) {
            0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::insert_leaf<vector<Bid<T0>>>(&mut arg0.bids, arg2, 0x1::vector::empty<Bid<T0>>());
        };
        let v2 = 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::crit_bit::borrow_mut_leaf_by_key<vector<Bid<T0>>>(&mut arg0.bids, arg2);
        let v3 = 0;
        while (arg3 > v3) {
            let v4 = Bid<T0>{
                amount : 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), arg2),
                owner  : arg4,
            };
            0x1::vector::push_back<Bid<T0>>(v2, v4);
            v3 = v3 + 1;
        };
    }

    public entry fun create_bid_whitelisted<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg2: 0x2::object::ID, arg3: 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::market_whitelist::Certificate, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::venue_internal_mut<DutchAuctionMarket<T0>, MarketKey>(arg1, v0, arg2);
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::assert_is_live(v1);
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::assert_is_whitelisted(v1);
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::market_whitelist::assert_certificate(&arg3, arg2);
        let v2 = MarketKey{dummy_field: false};
        let v3 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::borrow_market_mut<DutchAuctionMarket<T0>, MarketKey>(v2, v1);
        create_bid_<T0>(v3, arg0, arg4, arg5, 0x2::tx_context::sender(arg6));
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::market_whitelist::burn(arg3);
    }

    public fun create_venue<T0, T1>(arg0: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::assert_inventory<T0>(arg0, arg1);
        let v0 = new<T1>(arg1, arg3, arg4);
        let v1 = MarketKey{dummy_field: false};
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::create_venue<DutchAuctionMarket<T1>, MarketKey>(arg0, v1, v0, arg2, arg4)
    }

    public entry fun init_market<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<DutchAuctionMarket<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun init_venue<T0, T1>(arg0: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        create_venue<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    fun refund_bid<T0>(arg0: Bid<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &address) {
        let Bid {
            amount : v0,
            owner  : v1,
        } = arg0;
        let v2 = v1;
        assert!(arg2 == &v2, 3);
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg1), v0);
    }

    public fun reserve_price<T0>(arg0: &DutchAuctionMarket<T0>) : u64 {
        arg0.reserve_price
    }

    public entry fun sale_cancel<T0>(arg0: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::assert_listing_admin(arg0, arg2);
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::venue_internal_mut<DutchAuctionMarket<T0>, MarketKey>(arg0, v0, arg1);
        let v2 = MarketKey{dummy_field: false};
        let v3 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::borrow_market_mut<DutchAuctionMarket<T0>, MarketKey>(v2, v1);
        cancel_auction<T0>(v3, arg2);
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::venue::set_live(v1, false);
    }

    public entry fun sale_conclude<T0: store + key, T1>(arg0: &mut 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::assert_listing_admin(arg0, arg2);
        let v0 = borrow_market<T1>(0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::borrow_venue(arg0, arg1)).inventory_id;
        let v1 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::supply<T0>(arg0, v0);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::option::destroy_some<u64>(v1)
        } else {
            18446744073709551615
        };
        let v3 = MarketKey{dummy_field: false};
        let v4 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::market_internal_mut<DutchAuctionMarket<T1>, MarketKey>(arg0, v3, arg1);
        let (v5, v6) = conclude_auction<T1>(v4, v2);
        let v7 = v6;
        let v8 = MarketKey{dummy_field: false};
        let v9 = 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::inventory_internal_mut<T0, DutchAuctionMarket<T1>, MarketKey>(arg0, v8, arg1, v0);
        let v10 = 0x2::balance::zero<T1>();
        while (!0x1::vector::is_empty<Bid<T1>>(&v7)) {
            let Bid {
                amount : v11,
                owner  : v12,
            } = 0x1::vector::pop_back<Bid<T1>>(&mut v7);
            let v13 = v11;
            0x2::balance::join<T1>(&mut v10, 0x2::balance::split<T1>(&mut v13, v5));
            let (v14, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg2);
            let v16 = v14;
            0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(&mut v16, 0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::inventory::redeem_pseudorandom_nft<T0>(v9, arg2), arg2);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v16);
            if (0x2::balance::value<T1>(&v13) == 0) {
                0x2::balance::destroy_zero<T1>(v13);
                continue
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v13, arg2), v12);
        };
        0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::pay<T1>(arg0, v10, v2);
        0x1::vector::destroy_empty<Bid<T1>>(v7);
        if (0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::inventory::is_empty<T0>(0x96e49e7f672f3084028e11224a3616c18ab1805db62e6d0037fe56bf2792a1c9::listing::borrow_inventory<T0>(arg0, v0))) {
            sale_cancel<T1>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

