module 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::marketplace {
    struct PricePoint has copy, drop, store {
        timestamp: u64,
        price: u64,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        card_id: 0x2::object::ID,
        seller: address,
        price: u64,
        listed_at: u64,
        last_activity: u64,
        price_history: vector<PricePoint>,
    }

    struct Offer has key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        expires_at: u64,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct MarketConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        admin: address,
        paused: bool,
        index: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct Delisted has copy, drop {
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
    }

    struct Sold has copy, drop {
        listing_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    struct OfferMade has copy, drop {
        offer_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        card_id: 0x2::object::ID,
        amount: u64,
    }

    struct Repriced has copy, drop {
        listing_id: 0x2::object::ID,
        old_price: u64,
        new_price: u64,
    }

    public fun accept_offer(arg0: &mut MarketConfig, arg1: Listing, arg2: Offer, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.seller == 0x2::tx_context::sender(arg4), 0);
        assert!(arg2.listing_id == 0x2::object::id<Listing>(&arg1), 3);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2.expires_at, 4);
        let v0 = arg2.amount;
        let v1 = arg1.card_id;
        let Offer {
            id         : v2,
            listing_id : _,
            card_id    : _,
            bidder     : _,
            amount     : _,
            expires_at : _,
            balance    : v8,
        } = arg2;
        let v9 = 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v9, v0 * 500 / 10000, arg4), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(v9, arg1.seller);
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.index, v1)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.index, v1);
        };
        let Listing {
            id            : v10,
            card_id       : _,
            seller        : _,
            price         : _,
            listed_at     : _,
            last_activity : _,
            price_history : _,
        } = arg1;
        let v17 = v10;
        0x2::transfer::public_transfer<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(0x2::dynamic_object_field::remove<vector<u8>, 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&mut v17, b"card"), arg2.bidder);
        0x2::object::delete(v17);
        0x2::object::delete(v2);
        let v18 = OfferAccepted{
            offer_id : 0x2::object::id<Offer>(&arg2),
            card_id  : v1,
            amount   : v0,
        };
        0x2::event::emit<OfferAccepted>(v18);
    }

    public fun auto_delist(arg0: &mut MarketConfig, arg1: Listing, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.last_activity + 2592000000, 2);
        let v0 = arg1.card_id;
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.index, v0)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.index, v0);
        };
        let Listing {
            id            : v1,
            card_id       : _,
            seller        : _,
            price         : _,
            listed_at     : _,
            last_activity : _,
            price_history : _,
        } = arg1;
        let v8 = v1;
        0x2::transfer::public_transfer<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(0x2::dynamic_object_field::remove<vector<u8>, 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&mut v8, b"card"), arg1.seller);
        0x2::object::delete(v8);
        let v9 = Delisted{
            listing_id : 0x2::object::id<Listing>(&arg1),
            card_id    : v0,
        };
        0x2::event::emit<Delisted>(v9);
    }

    public fun auto_reprice(arg0: &mut Listing, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.seller == 0x2::tx_context::sender(arg3), 0);
        assert!(arg1 != arg0.price, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.price = arg1;
        arg0.last_activity = v0;
        let v1 = PricePoint{
            timestamp : v0,
            price     : arg1,
        };
        0x1::vector::push_back<PricePoint>(&mut arg0.price_history, v1);
        let v2 = Repriced{
            listing_id : 0x2::object::id<Listing>(arg0),
            old_price  : arg0.price,
            new_price  : arg1,
        };
        0x2::event::emit<Repriced>(v2);
    }

    public fun buy(arg0: &mut MarketConfig, arg1: Listing, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) >= arg1.price, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.listed_at + 2592000000, 5);
        let v0 = arg1.price;
        let v1 = arg1.card_id;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = v0 * 500 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2, v3, arg4), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2, v0 - v3, arg4), arg1.seller);
        if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2, v2);
        } else {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2);
        };
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.index, v1)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.index, v1);
        };
        let Listing {
            id            : v4,
            card_id       : _,
            seller        : _,
            price         : _,
            listed_at     : _,
            last_activity : _,
            price_history : _,
        } = arg1;
        let v11 = v4;
        0x2::transfer::public_transfer<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(0x2::dynamic_object_field::remove<vector<u8>, 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&mut v11, b"card"), v2);
        0x2::object::delete(v11);
        let v12 = Sold{
            listing_id : 0x2::object::id<Listing>(&arg1),
            card_id    : v1,
            buyer      : v2,
            price      : v0,
        };
        0x2::event::emit<Sold>(v12);
    }

    public fun cancel_offer(arg0: Offer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bidder || 0x2::clock::timestamp_ms(arg1) > arg0.expires_at, 0);
        let Offer {
            id         : v0,
            listing_id : _,
            card_id    : _,
            bidder     : v3,
            amount     : _,
            expires_at : _,
            balance    : v6,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6, arg2), v3);
        0x2::object::delete(v0);
    }

    public fun delist(arg0: &mut MarketConfig, arg1: Listing, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.seller == v0, 0);
        let v1 = arg1.card_id;
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.index, v1)) {
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.index, v1);
        };
        let Listing {
            id            : v2,
            card_id       : _,
            seller        : _,
            price         : _,
            listed_at     : _,
            last_activity : _,
            price_history : _,
        } = arg1;
        let v9 = v2;
        0x2::transfer::public_transfer<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(0x2::dynamic_object_field::remove<vector<u8>, 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&mut v9, b"card"), v0);
        0x2::object::delete(v9);
        let v10 = Delisted{
            listing_id : 0x2::object::id<Listing>(&arg1),
            card_id    : v1,
        };
        0x2::event::emit<Delisted>(v10);
    }

    public fun get_price_history(arg0: &Listing) : &vector<PricePoint> {
        &arg0.price_history
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = MarketConfig{
            id       : 0x2::object::new(arg0),
            treasury : v0,
            admin    : v0,
            paused   : false,
            index    : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<MarketConfig>(v1);
    }

    public fun is_listed(arg0: &MarketConfig, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.index, arg1)
    }

    public fun list(arg0: &mut MarketConfig, arg1: 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = PricePoint{
            timestamp : v1,
            price     : arg2,
        };
        let v5 = Listing{
            id            : v2,
            card_id       : v0,
            seller        : 0x2::tx_context::sender(arg4),
            price         : arg2,
            listed_at     : v1,
            last_activity : v1,
            price_history : 0x1::vector::singleton<PricePoint>(v4),
        };
        0x2::dynamic_object_field::add<vector<u8>, 0xf2ea9755cc43fdf81c75b5b4f6d02f4a86076c1be43568b9cc42c511cc39b8cd::player_card::PlayerCard>(&mut v5.id, b"card", arg1);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.index, v0, v3);
        let v6 = Listed{
            listing_id : v3,
            card_id    : v0,
            seller     : v5.seller,
            price      : arg2,
        };
        0x2::event::emit<Listed>(v6);
        0x2::transfer::share_object<Listing>(v5);
    }

    public fun listing_card_id(arg0: &Listing) : 0x2::object::ID {
        arg0.card_id
    }

    public fun listing_id_for(arg0: &MarketConfig, arg1: 0x2::object::ID) : 0x2::object::ID {
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.index, arg1)
    }

    public fun listing_listed_at(arg0: &Listing) : u64 {
        arg0.listed_at
    }

    public fun listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun listing_seller(arg0: &Listing) : address {
        arg0.seller
    }

    public fun make_offer(arg0: &Listing, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        let v1 = arg0.card_id;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = if (arg2 == 0) {
            172800000
        } else {
            arg2
        };
        let v4 = Offer{
            id         : 0x2::object::new(arg4),
            listing_id : 0x2::object::id<Listing>(arg0),
            card_id    : v1,
            bidder     : v2,
            amount     : v0,
            expires_at : 0x2::clock::timestamp_ms(arg3) + v3,
            balance    : 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1),
        };
        let v5 = OfferMade{
            offer_id : 0x2::object::id<Offer>(&v4),
            card_id  : v1,
            bidder   : v2,
            amount   : v0,
        };
        0x2::event::emit<OfferMade>(v5);
        0x2::transfer::share_object<Offer>(v4);
    }

    public fun price_point_price(arg0: &PricePoint) : u64 {
        arg0.price
    }

    public fun price_point_ts(arg0: &PricePoint) : u64 {
        arg0.timestamp
    }

    public fun set_treasury(arg0: &mut MarketConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.treasury = arg1;
    }

    // decompiled from Move bytecode v7
}

