module 0x314f74b5ac9db1d1456348c3c1b4b0dc809b1f65c636a61a7c67c0ce64170c7b::marketplace {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        next_id: u64,
        listings: 0x2::table::Table<u64, ListingInfo>,
        nfts: 0x2::object_bag::ObjectBag,
        offers: 0x2::table::Table<u64, OfferInfo>,
        offer_escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        paused: bool,
    }

    struct ListingInfo has copy, drop, store {
        seller: address,
        price: u64,
    }

    struct OfferInfo has copy, drop, store {
        buyer: address,
        amount: u64,
        listing_id: u64,
    }

    struct ListingCreated has copy, drop {
        listing_id: u64,
        seller: address,
        price: u64,
    }

    struct ListingSold has copy, drop {
        listing_id: u64,
        seller: address,
        buyer: address,
        price: u64,
        fee: u64,
    }

    struct ListingCancelled has copy, drop {
        listing_id: u64,
        seller: address,
    }

    struct FeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct OfferCreated has copy, drop {
        offer_id: u64,
        listing_id: u64,
        buyer: address,
        amount: u64,
    }

    struct OfferAccepted has copy, drop {
        offer_id: u64,
        listing_id: u64,
        seller: address,
        buyer: address,
        amount: u64,
        fee: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: u64,
        buyer: address,
    }

    entry fun accept_offer<T0: store + key>(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(0x2::table::contains<u64, OfferInfo>(&arg0.offers, arg1), 6);
        let v0 = 0x2::table::remove<u64, OfferInfo>(&mut arg0.offers, arg1);
        assert!(0x2::table::contains<u64, ListingInfo>(&arg0.listings, v0.listing_id), 3);
        assert!(0x2::table::borrow<u64, ListingInfo>(&arg0.listings, v0.listing_id).seller == 0x2::tx_context::sender(arg2), 2);
        let v1 = 0x2::table::remove<u64, ListingInfo>(&mut arg0.listings, v0.listing_id);
        let v2 = (((v0.amount as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.offer_escrow, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.offer_escrow, v0.amount - v2), arg2), v1.seller);
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<u64, T0>(&mut arg0.nfts, v0.listing_id), v0.buyer);
        let v3 = OfferAccepted{
            offer_id   : arg1,
            listing_id : v0.listing_id,
            seller     : v1.seller,
            buyer      : v0.buyer,
            amount     : v0.amount,
            fee        : v2,
        };
        0x2::event::emit<OfferAccepted>(v3);
    }

    entry fun admin_cancel_offer(arg0: &mut Marketplace, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, OfferInfo>(&arg0.offers, arg2), 6);
        let v0 = 0x2::table::remove<u64, OfferInfo>(&mut arg0.offers, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.offer_escrow, v0.amount), arg3), v0.buyer);
        let v1 = OfferCancelled{
            offer_id : arg2,
            buyer    : v0.buyer,
        };
        0x2::event::emit<OfferCancelled>(v1);
    }

    entry fun admin_delist<T0: store + key>(arg0: &mut Marketplace, arg1: &AdminCap, arg2: u64) {
        assert!(0x2::table::contains<u64, ListingInfo>(&arg0.listings, arg2), 3);
        let v0 = 0x2::table::remove<u64, ListingInfo>(&mut arg0.listings, arg2);
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<u64, T0>(&mut arg0.nfts, arg2), v0.seller);
        let v1 = ListingCancelled{
            listing_id : arg2,
            seller     : v0.seller,
        };
        0x2::event::emit<ListingCancelled>(v1);
    }

    entry fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(0x2::table::contains<u64, ListingInfo>(&arg0.listings, arg1), 3);
        let v0 = 0x2::table::remove<u64, ListingInfo>(&mut arg0.listings, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0.price, 5);
        let v1 = (((v0.price as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2, v0.price - v1), arg3), v0.seller);
        if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<u64, T0>(&mut arg0.nfts, arg1), 0x2::tx_context::sender(arg3));
        let v3 = ListingSold{
            listing_id : arg1,
            seller     : v0.seller,
            buyer      : 0x2::tx_context::sender(arg3),
            price      : v0.price,
            fee        : v1,
        };
        0x2::event::emit<ListingSold>(v3);
    }

    entry fun cancel_offer(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, OfferInfo>(&arg0.offers, arg1), 6);
        let v0 = 0x2::table::remove<u64, OfferInfo>(&mut arg0.offers, arg1);
        assert!(v0.buyer == 0x2::tx_context::sender(arg2), 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.offer_escrow, v0.amount), arg2), v0.buyer);
        let v1 = OfferCancelled{
            offer_id : arg1,
            buyer    : v0.buyer,
        };
        0x2::event::emit<OfferCancelled>(v1);
    }

    entry fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, ListingInfo>(&arg0.listings, arg1), 3);
        let v0 = 0x2::table::remove<u64, ListingInfo>(&mut arg0.listings, arg1);
        assert!(v0.seller == 0x2::tx_context::sender(arg2), 2);
        0x2::transfer::public_transfer<T0>(0x2::object_bag::remove<u64, T0>(&mut arg0.nfts, arg1), 0x2::tx_context::sender(arg2));
        let v1 = ListingCancelled{
            listing_id : arg1,
            seller     : v0.seller,
        };
        0x2::event::emit<ListingCancelled>(v1);
    }

    public fun get_fee(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    public fun get_listing(arg0: &Marketplace, arg1: u64) : (address, u64) {
        let v0 = 0x2::table::borrow<u64, ListingInfo>(&arg0.listings, arg1);
        (v0.seller, v0.price)
    }

    public fun get_next_id(arg0: &Marketplace) : u64 {
        arg0.next_id
    }

    public fun get_treasury_value(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Marketplace{
            id           : 0x2::object::new(arg0),
            fee_bps      : 1000,
            treasury     : 0x2::balance::zero<0x2::sui::SUI>(),
            next_id      : 0,
            listings     : 0x2::table::new<u64, ListingInfo>(arg0),
            nfts         : 0x2::object_bag::new(arg0),
            offers       : 0x2::table::new<u64, OfferInfo>(arg0),
            offer_escrow : 0x2::balance::zero<0x2::sui::SUI>(),
            paused       : false,
        };
        0x2::transfer::share_object<Marketplace>(v1);
    }

    public fun is_paused(arg0: &Marketplace) : bool {
        arg0.paused
    }

    entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg2 > 0, 1);
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = ListingInfo{
            seller : v1,
            price  : arg2,
        };
        0x2::table::add<u64, ListingInfo>(&mut arg0.listings, v0, v2);
        0x2::object_bag::add<u64, T0>(&mut arg0.nfts, v0, arg1);
        let v3 = ListingCreated{
            listing_id : v0,
            seller     : v1,
            price      : arg2,
        };
        0x2::event::emit<ListingCreated>(v3);
    }

    entry fun make_offer(arg0: &mut Marketplace, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(0x2::table::contains<u64, ListingInfo>(&arg0.listings, arg1), 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = arg0.next_id;
        arg0.next_id = v1 + 1;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = OfferInfo{
            buyer      : v2,
            amount     : v0,
            listing_id : arg1,
        };
        0x2::table::add<u64, OfferInfo>(&mut arg0.offers, v1, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.offer_escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v4 = OfferCreated{
            offer_id   : v1,
            listing_id : arg1,
            buyer      : v2,
            amount     : v0,
        };
        0x2::event::emit<OfferCreated>(v4);
    }

    entry fun set_fee(arg0: &mut Marketplace, arg1: &AdminCap, arg2: u64) {
        arg0.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee : arg0.fee_bps,
            new_fee : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    entry fun set_paused(arg0: &mut Marketplace, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun withdraw_treasury(arg0: &mut Marketplace, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            let v1 = 0x2::tx_context::sender(arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0), arg2), v1);
            let v2 = TreasuryWithdrawn{
                amount    : v0,
                recipient : v1,
            };
            0x2::event::emit<TreasuryWithdrawn>(v2);
        };
    }

    // decompiled from Move bytecode v6
}

