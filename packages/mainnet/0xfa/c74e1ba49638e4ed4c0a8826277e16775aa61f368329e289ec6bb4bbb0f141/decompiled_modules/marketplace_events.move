module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events {
    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        price: u64,
        listing_type: u8,
        expires_at: u64,
        timestamp: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ListingPriceUpdated has copy, drop {
        listing_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
        timestamp: u64,
    }

    struct NFTPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        platform_fee: u64,
        royalty_fee: u64,
        timestamp: u64,
    }

    struct OfferMade has copy, drop {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offerer: address,
        offer_amount: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        amount: u64,
        platform_fee: u64,
        royalty_fee: u64,
        timestamp: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        offerer: address,
        timestamp: u64,
    }

    struct AuctionStarted has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        starting_price: u64,
        reserve_price: u64,
        start_time: u64,
        end_time: u64,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        bid_amount: u64,
        previous_bid: u64,
        timestamp: u64,
    }

    struct AuctionEnded has copy, drop {
        auction_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        winner: address,
        winning_bid: u64,
        platform_fee: u64,
        royalty_fee: u64,
        timestamp: u64,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct CollectionRegistered has copy, drop {
        collection_id: 0x2::object::ID,
        name: vector<u8>,
        verified: bool,
        timestamp: u64,
    }

    struct CollectionVerificationUpdated has copy, drop {
        collection_id: 0x2::object::ID,
        verified: bool,
        timestamp: u64,
    }

    struct PlatformFeeUpdated has copy, drop {
        old_fee_bps: u16,
        new_fee_bps: u16,
        timestamp: u64,
    }

    struct MarketplacePausedStatusChanged has copy, drop {
        paused: bool,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct ListingExpiredCleanup has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        expires_at: u64,
        timestamp: u64,
    }

    struct OfferExpiredCleanup has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        expires_at: u64,
        timestamp: u64,
    }

    public(friend) fun emit_auction_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = AuctionCancelled{
            auction_id : arg0,
            seller     : arg1,
            nft_id     : arg2,
            timestamp  : arg3,
        };
        0x2::event::emit<AuctionCancelled>(v0);
    }

    public(friend) fun emit_auction_ended(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = AuctionEnded{
            auction_id   : arg0,
            nft_id       : arg1,
            seller       : arg2,
            winner       : arg3,
            winning_bid  : arg4,
            platform_fee : arg5,
            royalty_fee  : arg6,
            timestamp    : arg7,
        };
        0x2::event::emit<AuctionEnded>(v0);
    }

    public(friend) fun emit_auction_started(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = AuctionStarted{
            auction_id     : arg0,
            seller         : arg1,
            nft_id         : arg2,
            collection_id  : arg3,
            starting_price : arg4,
            reserve_price  : arg5,
            start_time     : arg6,
            end_time       : arg7,
        };
        0x2::event::emit<AuctionStarted>(v0);
    }

    public(friend) fun emit_bid_placed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BidPlaced{
            auction_id   : arg0,
            bidder       : arg1,
            bid_amount   : arg2,
            previous_bid : arg3,
            timestamp    : arg4,
        };
        0x2::event::emit<BidPlaced>(v0);
    }

    public(friend) fun emit_collection_registered(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: bool, arg3: u64) {
        let v0 = CollectionRegistered{
            collection_id : arg0,
            name          : arg1,
            verified      : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<CollectionRegistered>(v0);
    }

    public(friend) fun emit_collection_verification_updated(arg0: 0x2::object::ID, arg1: bool, arg2: u64) {
        let v0 = CollectionVerificationUpdated{
            collection_id : arg0,
            verified      : arg1,
            timestamp     : arg2,
        };
        0x2::event::emit<CollectionVerificationUpdated>(v0);
    }

    public(friend) fun emit_fees_withdrawn(arg0: address, arg1: u64, arg2: u64) {
        let v0 = FeesWithdrawn{
            recipient : arg0,
            amount    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public(friend) fun emit_listing_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = ListingCancelled{
            listing_id : arg0,
            seller     : arg1,
            nft_id     : arg2,
            timestamp  : arg3,
        };
        0x2::event::emit<ListingCancelled>(v0);
    }

    public(friend) fun emit_listing_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u8, arg7: u64, arg8: u64) {
        let v0 = ListingCreated{
            listing_id    : arg0,
            seller        : arg1,
            kiosk_id      : arg2,
            nft_id        : arg3,
            collection_id : arg4,
            price         : arg5,
            listing_type  : arg6,
            expires_at    : arg7,
            timestamp     : arg8,
        };
        0x2::event::emit<ListingCreated>(v0);
    }

    public(friend) fun emit_listing_expired_cleanup(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = ListingExpiredCleanup{
            listing_id : arg0,
            seller     : arg1,
            nft_id     : arg2,
            expires_at : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<ListingExpiredCleanup>(v0);
    }

    public(friend) fun emit_listing_price_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = ListingPriceUpdated{
            listing_id : arg0,
            old_price  : arg1,
            new_price  : arg2,
            timestamp  : arg3,
        };
        0x2::event::emit<ListingPriceUpdated>(v0);
    }

    public(friend) fun emit_marketplace_paused_status_changed(arg0: bool, arg1: u64) {
        let v0 = MarketplacePausedStatusChanged{
            paused    : arg0,
            timestamp : arg1,
        };
        0x2::event::emit<MarketplacePausedStatusChanged>(v0);
    }

    public(friend) fun emit_nft_purchased(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = NFTPurchased{
            listing_id    : arg0,
            nft_id        : arg1,
            collection_id : arg2,
            seller        : arg3,
            buyer         : arg4,
            price         : arg5,
            platform_fee  : arg6,
            royalty_fee   : arg7,
            timestamp     : arg8,
        };
        0x2::event::emit<NFTPurchased>(v0);
    }

    public(friend) fun emit_offer_accepted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = OfferAccepted{
            offer_id     : arg0,
            listing_id   : arg1,
            nft_id       : arg2,
            seller       : arg3,
            buyer        : arg4,
            amount       : arg5,
            platform_fee : arg6,
            royalty_fee  : arg7,
            timestamp    : arg8,
        };
        0x2::event::emit<OfferAccepted>(v0);
    }

    public(friend) fun emit_offer_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = OfferCancelled{
            offer_id   : arg0,
            listing_id : arg1,
            offerer    : arg2,
            timestamp  : arg3,
        };
        0x2::event::emit<OfferCancelled>(v0);
    }

    public(friend) fun emit_offer_expired_cleanup(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OfferExpiredCleanup{
            offer_id   : arg0,
            offerer    : arg1,
            amount     : arg2,
            expires_at : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<OfferExpiredCleanup>(v0);
    }

    public(friend) fun emit_offer_made(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = OfferMade{
            offer_id     : arg0,
            listing_id   : arg1,
            nft_id       : arg2,
            offerer      : arg3,
            offer_amount : arg4,
            expires_at   : arg5,
            timestamp    : arg6,
        };
        0x2::event::emit<OfferMade>(v0);
    }

    public(friend) fun emit_platform_fee_updated(arg0: u16, arg1: u16, arg2: u64) {
        let v0 = PlatformFeeUpdated{
            old_fee_bps : arg0,
            new_fee_bps : arg1,
            timestamp   : arg2,
        };
        0x2::event::emit<PlatformFeeUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

