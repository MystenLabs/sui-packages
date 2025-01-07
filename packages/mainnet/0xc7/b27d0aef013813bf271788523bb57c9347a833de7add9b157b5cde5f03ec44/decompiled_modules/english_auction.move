module 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::english_auction {
    struct Bid<phantom T0> has store {
        bidder: address,
        offer: 0x2::balance::Balance<T0>,
    }

    struct EnglishAuction<T0, phantom T1> has store {
        nft: T0,
        bid: Bid<T1>,
        concluded: bool,
    }

    struct MarketKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0, T1>(arg0: T0, arg1: Bid<T1>) : EnglishAuction<T0, T1> {
        EnglishAuction<T0, T1>{
            nft       : arg0,
            bid       : arg1,
            concluded : false,
        }
    }

    public fun assert_concluded<T0: store + key, T1>(arg0: &EnglishAuction<T0, T1>) {
        assert!(arg0.concluded, 3);
    }

    public fun assert_not_concluded<T0: store + key, T1>(arg0: &EnglishAuction<T0, T1>) {
        assert!(!arg0.concluded, 2);
    }

    public fun bid_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Bid<T0> {
        Bid<T0>{
            bidder : 0x2::tx_context::sender(arg1),
            offer  : arg0,
        }
    }

    public fun bid_from_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Bid<T0> {
        bid_from_balance<T0>(0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg0), arg1), arg2)
    }

    public fun borrow_market<T0: store + key, T1>(arg0: &0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::Venue) : &EnglishAuction<T0, T1> {
        let v0 = MarketKey{dummy_field: false};
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::borrow_market<EnglishAuction<T0, T1>, MarketKey>(v0, arg0)
    }

    public entry fun claim_nft<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, _) = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::new(arg2);
        let v2 = v0;
        let v3 = &mut v2;
        claim_nft_into_kiosk<T0, T1>(arg0, arg1, v3, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    fun claim_nft_<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = MarketKey{dummy_field: false};
        let v1 = MarketKey{dummy_field: false};
        let v2 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::delete<EnglishAuction<T0, T1>, MarketKey>(v1, 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::remove_venue<EnglishAuction<T0, T1>, MarketKey>(arg0, v0, arg1));
        assert_concluded<T0, T1>(&v2);
        let (v3, v4) = delete<T0, T1>(v2);
        let v5 = v4;
        let v6 = v3;
        let v7 = v5.bidder;
        assert!(v7 == 0x2::tx_context::sender(arg2), 4);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::pay_and_emit_sold_event<T1, T0>(arg0, &v6, delete_bid<T1>(v5), v7);
        v6
    }

    public entry fun claim_nft_into_kiosk<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_nft_<T0, T1>(arg0, arg1, arg3);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::deposit<T0>(arg2, v0, arg3);
    }

    public entry fun conclude_auction<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::assert_listing_admin(arg0, arg2);
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::market_internal_mut<EnglishAuction<T0, T1>, MarketKey>(arg0, v0, arg1);
        assert_not_concluded<T0, T1>(v1);
        v1.concluded = true;
    }

    public fun create_auction<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: &mut 0x2::coin::Coin<T1>, arg2: bool, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = bid_from_coin<T1>(arg1, arg5, arg6);
        let v1 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::inventory_admin_mut<T0>(arg0, arg3, arg6);
        let v2 = MarketKey{dummy_field: false};
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::create_venue<EnglishAuction<T0, T1>, MarketKey>(arg0, v2, from_inventory<T0, T1>(v1, arg4, v0), arg2, arg6)
    }

    public entry fun create_bid<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: &mut 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::venue_internal_mut<EnglishAuction<T0, T1>, MarketKey>(arg0, v0, arg2);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::assert_is_live(v1);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::assert_is_not_whitelisted(v1);
        let v2 = MarketKey{dummy_field: false};
        let v3 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::borrow_market_mut<EnglishAuction<T0, T1>, MarketKey>(v2, v1);
        create_bid_<T0, T1>(v3, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg3), arg4);
    }

    fun create_bid_<T0: store + key, T1>(arg0: &mut EnglishAuction<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg1) > 0x2::balance::value<T1>(&arg0.bid.offer), 1);
        assert_not_concluded<T0, T1>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.bid.offer), arg2), arg0.bid.bidder);
        arg0.bid.bidder = 0x2::tx_context::sender(arg2);
        0x2::balance::join<T1>(&mut arg0.bid.offer, arg1);
    }

    public entry fun create_bid_whitelisted<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: &mut 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::market_whitelist::Certificate, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketKey{dummy_field: false};
        let v1 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::venue_internal_mut<EnglishAuction<T0, T1>, MarketKey>(arg0, v0, arg2);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::assert_is_live(v1);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::assert_is_whitelisted(v1);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::market_whitelist::assert_certificate(&arg3, arg2);
        let v2 = MarketKey{dummy_field: false};
        let v3 = 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::venue::borrow_market_mut<EnglishAuction<T0, T1>, MarketKey>(v2, v1);
        create_bid_<T0, T1>(v3, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg1), arg4), arg5);
        0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::market_whitelist::burn(arg3);
    }

    public fun current_bid<T0, T1>(arg0: &EnglishAuction<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.bid.offer)
    }

    public fun current_bidder<T0, T1>(arg0: &EnglishAuction<T0, T1>) : address {
        arg0.bid.bidder
    }

    public fun delete<T0: store + key, T1>(arg0: EnglishAuction<T0, T1>) : (T0, Bid<T1>) {
        let EnglishAuction {
            nft       : v0,
            bid       : v1,
            concluded : _,
        } = arg0;
        (v0, v1)
    }

    public fun delete_bid<T0>(arg0: Bid<T0>) : 0x2::balance::Balance<T0> {
        let Bid {
            bidder : _,
            offer  : v1,
        } = arg0;
        v1
    }

    public fun from_inventory<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::inventory::Inventory<T0>, arg1: 0x2::object::ID, arg2: Bid<T1>) : EnglishAuction<T0, T1> {
        new<T0, T1>(0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::inventory::redeem_nft_with_id<T0>(arg0, arg1), arg2)
    }

    public fun from_warehouse<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::Warehouse<T0>, arg1: 0x2::object::ID, arg2: Bid<T1>) : EnglishAuction<T0, T1> {
        new<T0, T1>(0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::warehouse::redeem_nft_with_id<T0>(arg0, arg1), arg2)
    }

    public entry fun init_auction<T0: store + key, T1>(arg0: &mut 0xc7b27d0aef013813bf271788523bb57c9347a833de7add9b157b5cde5f03ec44::listing::Listing, arg1: &mut 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: bool, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        create_auction<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5, arg6);
    }

    public fun is_concluded<T0, T1>(arg0: &EnglishAuction<T0, T1>) : bool {
        arg0.concluded
    }

    // decompiled from Move bytecode v6
}

