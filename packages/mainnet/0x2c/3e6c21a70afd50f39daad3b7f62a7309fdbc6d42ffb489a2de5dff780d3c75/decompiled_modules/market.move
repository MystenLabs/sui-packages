module 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::market {
    struct MarketCap has store, key {
        id: 0x2::object::UID,
    }

    struct Listing has drop, store {
        seller: address,
        price: u64,
        expires: u64,
    }

    struct Offer has store {
        bidder: address,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        target: 0x1::option::Option<0x2::object::ID>,
        expires: u64,
    }

    struct Market has key {
        id: 0x2::object::UID,
        treasury: address,
        ready: bool,
        listings: 0x2::table::Table<0x2::object::ID, Listing>,
        offers: 0x2::table::Table<u64, Offer>,
        next_offer: u64,
        sales: u64,
    }

    struct Listed has copy, drop {
        id: 0x2::object::ID,
        seller: address,
        price: u64,
        expires: u64,
    }

    struct Repriced has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        expires: u64,
    }

    struct Delisted has copy, drop {
        id: 0x2::object::ID,
    }

    struct Sold has copy, drop {
        id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        offer: 0x1::option::Option<u64>,
    }

    struct OfferMade has copy, drop {
        offer: u64,
        bidder: address,
        price: u64,
        target: 0x1::option::Option<0x2::object::ID>,
        expires: u64,
    }

    struct OfferCancelled has copy, drop {
        offer: u64,
    }

    public fun accept_offer(arg0: &mut Market, arg1: u64, arg2: 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let (v2, v3) = take_offer(arg0, arg1, v0, arg3, v1);
        let v4 = v3;
        pay(arg0, v4, v1, arg4);
        0x2::transfer::public_transfer<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(arg2, v2);
        let v5 = Sold{
            id     : v0,
            seller : v1,
            buyer  : v2,
            price  : 0x2::balance::value<0x2::sui::SUI>(&v4),
            offer  : 0x1::option::some<u64>(arg1),
        };
        0x2::event::emit<Sold>(v5);
    }

    public fun accept_offer_listed(arg0: &mut Market, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg2), 13906835295329976323);
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg2).seller;
        assert!(v0 == 0x2::tx_context::sender(arg4), 13906835303920041989);
        0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg2);
        let (v1, v2) = take_offer(arg0, arg1, arg2, arg3, v0);
        let v3 = v2;
        pay(arg0, v3, v0, arg4);
        0x2::transfer::public_transfer<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&mut arg0.id, arg2), v1);
        let v4 = Sold{
            id     : arg2,
            seller : v0,
            buyer  : v1,
            price  : 0x2::balance::value<0x2::sui::SUI>(&v3),
            offer  : 0x1::option::some<u64>(arg1),
        };
        0x2::event::emit<Sold>(v4);
    }

    fun assert_live(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 == 0 || 0x2::clock::timestamp_ms(arg1) < arg0, 13906834857243574279);
    }

    public fun buy(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 13906835067696709635);
        let Listing {
            seller  : v0,
            price   : v1,
            expires : v2,
        } = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert_live(v2, arg4);
        assert!(v1 <= arg3, 13906835080582004745);
        assert!(v0 != 0x2::tx_context::sender(arg5), 13906835089172463633);
        pay(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v1), v0, arg5);
        let v3 = Sold{
            id     : arg1,
            seller : v0,
            buyer  : 0x2::tx_context::sender(arg5),
            price  : v1,
            offer  : 0x1::option::none<u64>(),
        };
        0x2::event::emit<Sold>(v3);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&mut arg0.id, arg1)
    }

    public fun cancel(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 13906835024747036675);
        let v0 = 0x2::table::remove<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg2), 13906835033337102341);
        let v1 = Delisted{id: arg1};
        0x2::event::emit<Delisted>(v1);
        0x2::dynamic_object_field::remove<0x2::object::ID, 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&mut arg0.id, arg1)
    }

    public fun cancel_offer(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::table::contains<u64, Offer>(&arg0.offers, arg1), 13906835205136187403);
        let Offer {
            bidder  : v0,
            amount  : v1,
            target  : _,
            expires : _,
        } = 0x2::table::remove<u64, Offer>(&mut arg0.offers, arg1);
        assert!(v0 == 0x2::tx_context::sender(arg2), 13906835213726253069);
        let v4 = OfferCancelled{offer: arg1};
        0x2::event::emit<OfferCancelled>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = new_market(v0, arg0);
        0x2::transfer::share_object<Market>(v1);
        let v2 = MarketCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MarketCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_listed(arg0: &Market, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1)
    }

    public fun list(arg0: &mut Market, arg1: 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.ready, 13906834925963968533);
        assert!(arg2 > 0, 13906834930257625089);
        let v0 = 0x2::object::id<0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2c3e6c21a70afd50f39daad3b7f62a7309fdbc6d42ffb489a2de5dff780d3c75::hashbits::Hashbit>(&mut arg0.id, v0, arg1);
        let v2 = Listing{
            seller  : v1,
            price   : arg2,
            expires : arg3,
        };
        0x2::table::add<0x2::object::ID, Listing>(&mut arg0.listings, v0, v2);
        let v3 = Listed{
            id      : v0,
            seller  : v1,
            price   : arg2,
            expires : arg3,
        };
        0x2::event::emit<Listed>(v3);
    }

    public fun listing(arg0: &Market, arg1: 0x2::object::ID) : (address, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Listing>(&arg0.listings, arg1);
        (v0.seller, v0.price, v0.expires)
    }

    public fun make_offer(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.ready, 13906835149302267925);
        assert!(v0 > 0, 13906835153595924481);
        let v1 = arg0.next_offer;
        arg0.next_offer = v1 + 1;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = Offer{
            bidder  : v2,
            amount  : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            target  : arg2,
            expires : arg3,
        };
        0x2::table::add<u64, Offer>(&mut arg0.offers, v1, v3);
        let v4 = OfferMade{
            offer   : v1,
            bidder  : v2,
            price   : v0,
            target  : arg2,
            expires : arg3,
        };
        0x2::event::emit<OfferMade>(v4);
        v1
    }

    fun new_market(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Market {
        Market{
            id         : 0x2::object::new(arg1),
            treasury   : arg0,
            ready      : false,
            listings   : 0x2::table::new<0x2::object::ID, Listing>(arg1),
            offers     : 0x2::table::new<u64, Offer>(arg1),
            next_offer : 0,
            sales      : 0,
        }
    }

    public fun offer_price(arg0: &Market, arg1: u64) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&0x2::table::borrow<u64, Offer>(&arg0.offers, arg1).amount)
    }

    fun pay(arg0: &mut Market, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1, 0x2::balance::value<0x2::sui::SUI>(&arg1) / 20), arg3), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg3), arg2);
        arg0.sales = arg0.sales + 1;
    }

    public fun reprice(arg0: &mut Market, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Listing>(&arg0.listings, arg1), 13906834973207429123);
        assert!(arg2 > 0, 13906834977502265345);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg4), 13906834986092462085);
        v0.price = arg2;
        v0.expires = arg3;
        let v1 = Repriced{
            id      : arg1,
            price   : arg2,
            expires : arg3,
        };
        0x2::event::emit<Repriced>(v1);
    }

    public fun sales(arg0: &Market) : u64 {
        arg0.sales
    }

    public fun set_treasury(arg0: &MarketCap, arg1: &mut Market, arg2: address) {
        assert!(!arg1.ready, 13906834814294687763);
        arg1.treasury = arg2;
        arg1.ready = true;
    }

    fun take_offer(arg0: &mut Market, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: address) : (address, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(0x2::table::contains<u64, Offer>(&arg0.offers, arg1), 13906835351165075467);
        let Offer {
            bidder  : v0,
            amount  : v1,
            target  : v2,
            expires : v3,
        } = 0x2::table::remove<u64, Offer>(&mut arg0.offers, arg1);
        let v4 = v2;
        assert_live(v3, arg3);
        assert!(v0 != arg4, 13906835364050370577);
        assert!(0x1::option::is_none<0x2::object::ID>(&v4) || 0x1::option::destroy_some<0x2::object::ID>(v4) == arg2, 13906835368345206799);
        (v0, v1)
    }

    public fun treasury(arg0: &Market) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

