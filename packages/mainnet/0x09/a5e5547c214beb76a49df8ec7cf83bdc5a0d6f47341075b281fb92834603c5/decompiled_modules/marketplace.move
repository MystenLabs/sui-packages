module 0x9a5e5547c214beb76a49df8ec7cf83bdc5a0d6f47341075b281fb92834603c5::marketplace {
    struct MarketplaceRegistry has key {
        id: 0x2::object::UID,
        platform_wallet: address,
        total_listings: u64,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        listing_id: u64,
        seller: address,
        card_name: 0x1::string::String,
        game: 0x1::string::String,
        condition: 0x1::string::String,
        price_mist: u64,
        image_url: 0x1::string::String,
        is_active: bool,
    }

    struct Tournament has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        prize_pool_mist: u64,
        max_participants: u64,
        participant_count: u64,
        participants: 0x2::table::Table<address, bool>,
        is_active: bool,
        organizer: address,
    }

    struct ListingCreated has copy, drop {
        listing_id: u64,
        seller: address,
        card_name: 0x1::string::String,
        game: 0x1::string::String,
        price_mist: u64,
    }

    struct ListingSold has copy, drop {
        listing_id: u64,
        seller: address,
        buyer: address,
        price_mist: u64,
    }

    struct TournamentJoined has copy, drop {
        tournament_id: 0x2::object::ID,
        participant: address,
        entry_fee_mist: u64,
    }

    struct Offer has key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        offer_mist: u64,
        payment: 0x2::coin::Coin<0x2::sui::SUI>,
        is_active: bool,
        expires_epoch: u64,
    }

    struct OfferMade has copy, drop {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        offer_mist: u64,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        offer_mist: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        buyer: address,
    }

    public fun accept_offer(arg0: &MarketplaceRegistry, arg1: &mut Offer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seller == 0x2::tx_context::sender(arg2), 4);
        assert!(arg1.is_active, 3);
        arg1.is_active = false;
        let v0 = arg1.offer_mist * 100 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.payment, v0, arg2), arg0.platform_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.payment, arg1.offer_mist - v0, arg2), arg1.seller);
        let v1 = OfferAccepted{
            offer_id   : 0x2::object::id<Offer>(arg1),
            buyer      : arg1.buyer,
            seller     : arg1.seller,
            offer_mist : arg1.offer_mist,
        };
        0x2::event::emit<OfferAccepted>(v1);
    }

    public fun buy_listing(arg0: &mut MarketplaceRegistry, arg1: &mut Listing, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_active, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg1.price_mist, 0);
        let v0 = arg1.price_mist * 100 / 10000;
        arg1.is_active = false;
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3), arg0.platform_wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg1.price_mist - v0, arg3), arg1.seller);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        let v2 = ListingSold{
            listing_id : arg1.listing_id,
            seller     : arg1.seller,
            buyer      : v1,
            price_mist : arg1.price_mist,
        };
        0x2::event::emit<ListingSold>(v2);
    }

    public fun cancel_listing(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg1), 4);
        assert!(arg0.is_active, 3);
        arg0.is_active = false;
    }

    public fun cancel_offer(arg0: &mut Offer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.buyer == 0x2::tx_context::sender(arg1), 4);
        assert!(arg0.is_active, 3);
        arg0.is_active = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.payment, 0x2::coin::value<0x2::sui::SUI>(&arg0.payment), arg1), arg0.buyer);
        let v0 = OfferCancelled{
            offer_id : 0x2::object::id<Offer>(arg0),
            buyer    : arg0.buyer,
        };
        0x2::event::emit<OfferCancelled>(v0);
    }

    public fun create_listing(arg0: &mut MarketplaceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 5);
        arg0.total_listings = arg0.total_listings + 1;
        let v0 = Listing{
            id         : 0x2::object::new(arg6),
            listing_id : arg0.total_listings,
            seller     : 0x2::tx_context::sender(arg6),
            card_name  : 0x1::string::utf8(arg1),
            game       : 0x1::string::utf8(arg2),
            condition  : 0x1::string::utf8(arg3),
            price_mist : arg4,
            image_url  : 0x1::string::utf8(arg5),
            is_active  : true,
        };
        let v1 = ListingCreated{
            listing_id : arg0.total_listings,
            seller     : 0x2::tx_context::sender(arg6),
            card_name  : 0x1::string::utf8(arg1),
            game       : 0x1::string::utf8(arg2),
            price_mist : arg4,
        };
        0x2::event::emit<ListingCreated>(v1);
        0x2::transfer::share_object<Listing>(v0);
    }

    public fun create_tournament(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Tournament{
            id                : 0x2::object::new(arg2),
            name              : 0x1::string::utf8(arg0),
            prize_pool_mist   : 0,
            max_participants  : arg1,
            participant_count : 0,
            participants      : 0x2::table::new<address, bool>(arg2),
            is_active         : true,
            organizer         : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Tournament>(v0);
    }

    public fun edit_listing(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg2), 4);
        assert!(arg0.is_active, 3);
        assert!(arg1 > 0, 5);
        arg0.price_mist = arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceRegistry{
            id              : 0x2::object::new(arg0),
            platform_wallet : 0x2::tx_context::sender(arg0),
            total_listings  : 0,
        };
        0x2::transfer::share_object<MarketplaceRegistry>(v0);
    }

    public fun join_tournament(arg0: &mut Tournament, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.is_active, 3);
        assert!(arg0.participant_count < arg0.max_participants, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.participants, v0), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 0);
        0x2::table::add<address, bool>(&mut arg0.participants, v0, true);
        arg0.participant_count = arg0.participant_count + 1;
        arg0.prize_pool_mist = arg0.prize_pool_mist + 10000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.organizer);
        let v1 = TournamentJoined{
            tournament_id  : 0x2::object::id<Tournament>(arg0),
            participant    : v0,
            entry_fee_mist : 10000000000,
        };
        0x2::event::emit<TournamentJoined>(v1);
    }

    public fun make_offer(arg0: &Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 5);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg0.seller, 4);
        let v1 = Offer{
            id            : 0x2::object::new(arg2),
            listing_id    : 0x2::object::id<Listing>(arg0),
            buyer         : v0,
            seller        : arg0.seller,
            offer_mist    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            payment       : arg1,
            is_active     : true,
            expires_epoch : 0x2::tx_context::epoch(arg2) + 7,
        };
        let v2 = OfferMade{
            offer_id   : 0x2::object::id<Offer>(&v1),
            listing_id : 0x2::object::id<Listing>(arg0),
            buyer      : v0,
            seller     : arg0.seller,
            offer_mist : 0x2::coin::value<0x2::sui::SUI>(&v1.payment),
        };
        0x2::event::emit<OfferMade>(v2);
        0x2::transfer::share_object<Offer>(v1);
    }

    // decompiled from Move bytecode v6
}

