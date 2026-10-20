module 0xed9458d2f8b0b54399d086f43e3369f0397d2aea330544512b08f84f2a41209f::marketplace {
    struct Listing has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
        treasury: address,
        created_at: u64,
    }

    struct CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OfferEscrowKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Offer has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        bidder: address,
        amount: u64,
        total_escrow: u64,
        fee_amount: u64,
        royalty_amount: u64,
        expires_at_ms: u64,
        kiosk_trade: bool,
        active: bool,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        bidder: address,
        amount: u64,
        total_escrow: u64,
        fee_amount: u64,
        royalty_amount: u64,
        expires_at_ms: u64,
        kiosk_trade: bool,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        amount: u64,
        fee_amount: u64,
        royalty_amount: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct V4Listing has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        seller: address,
        price: u64,
        treasury: address,
        created_at: u64,
        kiosk_id: 0x2::object::ID,
        kiosk_trade: bool,
        active: bool,
        next_offer_nonce: u64,
        offers: vector<V4OfferRecord>,
    }

    struct V4OfferRecord has store {
        nonce: u64,
        bidder: address,
        amount: u64,
        total_escrow: u64,
        fee_amount: u64,
        royalty_amount: u64,
        expires_at_ms: u64,
        payment: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct V4NftKey has copy, drop, store {
        seal: bool,
    }

    struct V4PurchaseCapKey has copy, drop, store {
        seal: bool,
    }

    struct MarketplaceV4Rule has drop {
        seal: bool,
    }

    struct MarketplaceV4Config has drop, store {
        enabled: bool,
    }

    struct V4ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        seller: address,
        price: u64,
        kiosk_id: 0x2::object::ID,
        kiosk_trade: bool,
    }

    struct V4OfferCreated has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nonce: u64,
        bidder: address,
        amount: u64,
        total_escrow: u64,
        expires_at_ms: u64,
        kiosk_trade: bool,
    }

    struct V4OfferCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nonce: u64,
        bidder: address,
        amount: u64,
    }

    struct V4OfferRefunded has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nonce: u64,
        bidder: address,
        amount: u64,
    }

    struct V4OfferExpired has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nonce: u64,
        bidder: address,
        amount: u64,
    }

    struct V4OfferAccepted has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nonce: u64,
        bidder: address,
        seller: address,
        amount: u64,
        fee_amount: u64,
        royalty_amount: u64,
    }

    struct V4NFTSold has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        fee_amount: u64,
        royalty_amount: u64,
        kiosk_trade: bool,
    }

    struct V4NFTDelisted has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        kiosk_trade: bool,
    }

    struct NFTListed has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        seller: address,
        price: u64,
    }

    struct NFTSold has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        fee: u64,
    }

    struct NFTDelisted has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun delist<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_standard_bid_type<T0>(), 12);
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 2);
        let v0 = arg0.nft_id;
        let v1 = CapKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v1);
        0x2::kiosk::delist<T0>(arg1, &v2, v0);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, &v2, v0), arg0.seller);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg0.seller);
        let v3 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v0,
            seller     : arg0.seller,
        };
        0x2::event::emit<NFTDelisted>(v3);
    }

    public entry fun list<T0: store + key>(arg0: T0, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_standard_bid_type<T0>(), 12);
        assert!(arg1 > 0, 1);
        assert!(arg2 == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg0);
        let (v2, v3) = 0x2::kiosk::new(arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::place<T0>(&mut v5, &v4, arg0);
        0x2::kiosk::list<T0>(&mut v5, &v4, v1, arg1);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(&v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
        let v7 = Listing{
            id         : 0x2::object::new(arg3),
            nft_id     : v1,
            kiosk_id   : v6,
            seller     : v0,
            price      : arg1,
            treasury   : @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc,
            created_at : 0x2::tx_context::epoch(arg3),
        };
        let v8 = CapKey{dummy_field: false};
        0x2::dynamic_field::add<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut v7.id, v8, v4);
        0x2::transfer::share_object<Listing>(v7);
        let v9 = NFTListed{
            listing_id : 0x2::object::id<Listing>(&v7),
            nft_id     : v1,
            kiosk_id   : v6,
            seller     : v0,
            price      : arg1,
        };
        0x2::event::emit<NFTListed>(v9);
    }

    public entry fun accept_kiosk_offer<T0: store + key>(arg0: &mut Offer, arg1: &Listing, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_offer_open(arg0, arg5);
        assert!(arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(arg1.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::tx_context::sender(arg6) == arg1.seller, 2);
        assert!(arg1.nft_id == arg0.nft_id, 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.kiosk_id, 10);
        assert!(arg1.seller != arg0.bidder, 9);
        let v0 = 0x2::object::id<Offer>(arg0);
        let v1 = 0x2::object::id<Listing>(arg1);
        let v2 = arg0.nft_id;
        let v3 = arg0.bidder;
        let v4 = arg1.seller;
        let v5 = arg0.amount;
        let v6 = percentage_fee(v5);
        let v7 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, v5);
        assert!(v6 == arg0.fee_amount && v7 == arg0.royalty_amount, 13);
        let v8 = take_offer_escrow(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v8) == arg0.total_escrow, 13);
        0x2::kiosk::delist<T0>(arg2, arg3, v2);
        0x2::kiosk::list<T0>(arg2, arg3, v2, v5);
        let (v9, v10) = 0x2::kiosk::purchase<T0>(arg2, v2, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v5, arg6));
        let v11 = v10;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg2, arg3, 0x1::option::some<u64>(v5), arg6), v4);
        let (v12, v13) = 0x2::kiosk::new(arg6);
        let v14 = v13;
        let v15 = v12;
        0x2::kiosk::set_owner_custom(&mut v15, &v14, v3);
        0x2::kiosk::lock<T0>(&mut v15, &v14, arg4, v9);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v11, &v15);
        if (v7 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v11, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v7, arg6));
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v6, arg6), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v11);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v15);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v14, v3);
        let v19 = NFTSold{
            listing_id : v1,
            nft_id     : v2,
            buyer      : v3,
            seller     : v4,
            price      : v5,
            fee        : v6,
        };
        0x2::event::emit<NFTSold>(v19);
        let v20 = NFTDelisted{
            listing_id : v1,
            nft_id     : v2,
            seller     : v4,
        };
        0x2::event::emit<NFTDelisted>(v20);
        let v21 = OfferAccepted{
            offer_id       : v0,
            nft_id         : v2,
            bidder         : v3,
            seller         : v4,
            amount         : v5,
            fee_amount     : v6,
            royalty_amount : v7,
        };
        0x2::event::emit<OfferAccepted>(v21);
    }

    public entry fun accept_kiosk_offer_v4<T0: store + key>(arg0: &mut V4Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        accept_kiosk_offer_v4_impl<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun accept_kiosk_offer_v4_impl<T0: store + key>(arg0: &mut V4Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.active, 17);
        assert!(arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::tx_context::sender(arg5) == arg0.seller, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        ensure_v4_policy<T0>(arg2);
        purge_expired_v4_offers(arg0, arg4);
        let v0 = v4_offer_index(arg0, arg3);
        assert!(v0 < 0x1::vector::length<V4OfferRecord>(&arg0.offers), 18);
        assert_v4_offer_is_highest(arg0, arg3);
        let V4OfferRecord {
            nonce          : v1,
            bidder         : v2,
            amount         : v3,
            total_escrow   : v4,
            fee_amount     : v5,
            royalty_amount : v6,
            expires_at_ms  : v7,
            payment        : v8,
        } = 0x1::vector::remove<V4OfferRecord>(&mut arg0.offers, v0);
        let v9 = v8;
        assert!(v7 > 0x2::clock::timestamp_ms(arg4), 5);
        assert!(v2 != arg0.seller, 9);
        let v10 = percentage_fee(v3);
        let v11 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, v3);
        assert!(v5 == v10 && v6 == v11, 13);
        assert!(v4 == checked_total_escrow(v3, v10, v11), 13);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v9) == v4, 13);
        let v12 = V4PurchaseCapKey{seal: true};
        let (v13, v14) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_field::remove<V4PurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v12), 0x2::coin::split<0x2::sui::SUI>(&mut v9, v3, arg5));
        let v15 = v14;
        let (v16, v17) = 0x2::kiosk::new(arg5);
        let v18 = v17;
        let v19 = v16;
        0x2::kiosk::set_owner_custom(&mut v19, &v18, v2);
        0x2::kiosk::lock<T0>(&mut v19, &v18, arg2, v13);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v15, &v19);
        if (v11 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v15, 0x2::coin::split<0x2::sui::SUI>(&mut v9, v11, arg5));
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v9, v10, arg5), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        };
        let v20 = &mut v15;
        add_marketplace_v4_receipt_if_installed<T0>(arg2, v20);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v15);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v9);
        refund_all_v4_offers(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v19);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v18, v2);
        arg0.active = false;
        let v24 = V4NFTSold{
            listing_id     : 0x2::object::id<V4Listing>(arg0),
            nft_id         : arg0.nft_id,
            buyer          : v2,
            seller         : arg0.seller,
            price          : v3,
            fee_amount     : v10,
            royalty_amount : v11,
            kiosk_trade    : true,
        };
        0x2::event::emit<V4NFTSold>(v24);
        let v25 = V4OfferAccepted{
            listing_id     : 0x2::object::id<V4Listing>(arg0),
            nft_id         : arg0.nft_id,
            nonce          : v1,
            bidder         : v2,
            seller         : arg0.seller,
            amount         : v3,
            fee_amount     : v10,
            royalty_amount : v11,
        };
        0x2::event::emit<V4OfferAccepted>(v25);
        0x2::object::id<0x2::kiosk::Kiosk>(&v19)
    }

    public entry fun accept_offer<T0: store + key>(arg0: &mut Offer, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_offer_open(arg0, arg2);
        assert!(!arg0.kiosk_trade, 12);
        assert!(is_standard_bid_type<T0>(), 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(0x2::object::id<T0>(&arg1) == arg0.nft_id, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 != arg0.bidder, 9);
        let v1 = 0x2::object::id<Offer>(arg0);
        let v2 = arg0.nft_id;
        let v3 = arg0.bidder;
        let v4 = arg0.amount;
        0x2::transfer::public_transfer<T0>(arg1, v3);
        let v5 = OfferAccepted{
            offer_id       : v1,
            nft_id         : v2,
            bidder         : v3,
            seller         : v0,
            amount         : v4,
            fee_amount     : pay_standard_offer(take_offer_escrow(arg0), v0, arg3),
            royalty_amount : 0,
        };
        0x2::event::emit<OfferAccepted>(v5);
    }

    public entry fun accept_offer_listing<T0: store + key>(arg0: &mut Offer, arg1: &mut Listing, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_offer_open(arg0, arg3);
        assert!(!arg0.kiosk_trade, 12);
        assert!(is_standard_bid_type<T0>(), 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(arg1.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::tx_context::sender(arg4) == arg1.seller, 2);
        assert!(arg1.nft_id == arg0.nft_id, 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.kiosk_id, 10);
        assert!(arg1.seller != arg0.bidder, 9);
        let v0 = 0x2::object::id<Offer>(arg0);
        let v1 = arg0.nft_id;
        let v2 = arg0.bidder;
        let v3 = arg1.seller;
        let v4 = arg0.amount;
        let v5 = CapKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg1.id, v5);
        0x2::kiosk::delist<T0>(arg2, &v6, v1);
        let v7 = pay_standard_offer(take_offer_escrow(arg0), v3, arg4);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg2, &v6, v1), v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v6, v3);
        let v8 = NFTSold{
            listing_id : 0x2::object::id<Listing>(arg1),
            nft_id     : v1,
            buyer      : v2,
            seller     : v3,
            price      : v4,
            fee        : v7,
        };
        0x2::event::emit<NFTSold>(v8);
        let v9 = OfferAccepted{
            offer_id       : v0,
            nft_id         : v1,
            bidder         : v2,
            seller         : v3,
            amount         : v4,
            fee_amount     : v7,
            royalty_amount : 0,
        };
        0x2::event::emit<OfferAccepted>(v9);
    }

    public entry fun accept_offer_v4<T0: store + key>(arg0: &mut V4Listing, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 17);
        assert!(!arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 2);
        assert_v4_no_empty_check_after_purge(arg0, arg2);
        let v0 = v4_offer_index(arg0, arg1);
        assert!(v0 < 0x1::vector::length<V4OfferRecord>(&arg0.offers), 18);
        assert_v4_offer_is_highest(arg0, arg1);
        let V4OfferRecord {
            nonce          : v1,
            bidder         : v2,
            amount         : v3,
            total_escrow   : v4,
            fee_amount     : v5,
            royalty_amount : v6,
            expires_at_ms  : v7,
            payment        : v8,
        } = 0x1::vector::remove<V4OfferRecord>(&mut arg0.offers, v0);
        let v9 = v8;
        assert!(v7 > 0x2::clock::timestamp_ms(arg2), 5);
        assert!(v2 != arg0.seller, 9);
        assert!(v4 == v3 && v6 == 0, 13);
        let v10 = percentage_fee(v3);
        assert!(v5 == v10 && 0x2::coin::value<0x2::sui::SUI>(&v9) == v3, 13);
        refund_all_v4_offers(arg0);
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v9, v10, arg3), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, arg0.seller);
        let v11 = V4NftKey{seal: true};
        let v12 = arg0.seller;
        let v13 = arg0.nft_id;
        arg0.active = false;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<V4NftKey, T0>(&mut arg0.id, v11), v2);
        let v14 = V4NFTSold{
            listing_id     : 0x2::object::id<V4Listing>(arg0),
            nft_id         : v13,
            buyer          : v2,
            seller         : v12,
            price          : v3,
            fee_amount     : v10,
            royalty_amount : 0,
            kiosk_trade    : false,
        };
        0x2::event::emit<V4NFTSold>(v14);
        let v15 = V4OfferAccepted{
            listing_id     : 0x2::object::id<V4Listing>(arg0),
            nft_id         : v13,
            nonce          : v1,
            bidder         : v2,
            seller         : v12,
            amount         : v3,
            fee_amount     : v10,
            royalty_amount : 0,
        };
        0x2::event::emit<V4OfferAccepted>(v15);
    }

    fun add_marketplace_v4_receipt_if_installed<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        if (0x2::transfer_policy::has_rule<T0, MarketplaceV4Rule>(arg0)) {
            let v0 = MarketplaceV4Rule{seal: true};
            0x2::transfer_policy::add_receipt<T0, MarketplaceV4Rule>(v0, arg1);
        };
    }

    fun assert_offer_open(arg0: &Offer, arg1: &0x2::clock::Clock) {
        assert!(arg0.active, 7);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms, 5);
    }

    fun assert_v4_no_empty_check_after_purge(arg0: &mut V4Listing, arg1: &0x2::clock::Clock) {
        purge_expired_v4_offers(arg0, arg1);
        assert!(!0x1::vector::is_empty<V4OfferRecord>(&arg0.offers), 18);
    }

    fun assert_v4_no_live_offers(arg0: &mut V4Listing, arg1: &0x2::clock::Clock) {
        purge_expired_v4_offers(arg0, arg1);
        assert!(0x1::vector::is_empty<V4OfferRecord>(&arg0.offers), 15);
    }

    fun assert_v4_offer_is_highest(arg0: &V4Listing, arg1: u64) {
        let v0 = 0x1::vector::length<V4OfferRecord>(&arg0.offers);
        assert!(v0 > 0, 18);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<V4OfferRecord>(&arg0.offers, v3);
            if (v4.amount > v1) {
                v1 = v4.amount;
                v2 = v4.nonce;
            };
            v3 = v3 + 1;
        };
        assert!(arg1 == v2, 21);
    }

    public entry fun buy<T0: store + key>(arg0: &mut Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_standard_bid_type<T0>(), 12);
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        let v0 = arg0.price;
        let v1 = arg0.seller;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = arg0.nft_id;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v4 >= v0, 3);
        if (v4 > v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v4 - v0, arg4), v2);
        };
        let v5 = percentage_fee(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v1);
        let v6 = CapKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v6);
        0x2::kiosk::delist<T0>(arg1, &v7, v3);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, &v7, v3), v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, v1);
        let v8 = NFTSold{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v3,
            buyer      : v2,
            seller     : v1,
            price      : v0,
            fee        : v5,
        };
        0x2::event::emit<NFTSold>(v8);
    }

    public entry fun buy_kiosk<T0: store + key>(arg0: &Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        let v0 = arg0.price;
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = arg0.nft_id;
        let v3 = percentage_fee(v0);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, v0);
        let v5 = checked_total_escrow(v0, v3, v4);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v6 >= v5, 3);
        if (v6 > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v6 - v5, arg6), v1);
        };
        let (v7, v8) = 0x2::kiosk::purchase<T0>(arg1, v2, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v0, arg6));
        let v9 = v8;
        0x2::kiosk::lock<T0>(arg3, arg4, arg2, v7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v9, arg3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v9, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v4, arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v3, arg6), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v9);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        let v13 = NFTSold{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v2,
            buyer      : v1,
            seller     : arg0.seller,
            price      : v0,
            fee        : v3,
        };
        0x2::event::emit<NFTSold>(v13);
    }

    public entry fun buy_kiosk_v4<T0: store + key>(arg0: &mut V4Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 17);
        assert!(arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        assert!(0x2::tx_context::sender(arg7) != arg0.seller, 9);
        assert!(0x2::kiosk::has_access(arg3, arg4), 20);
        ensure_v4_policy<T0>(arg2);
        let v0 = arg0.price;
        let v1 = percentage_fee(v0);
        let v2 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg2, v0);
        let v3 = checked_total_escrow(v0, v1, v2);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        assert!(v4 >= v3, 3);
        if (v4 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v4 - v3, arg7), 0x2::tx_context::sender(arg7));
        };
        let v5 = V4PurchaseCapKey{seal: true};
        let (v6, v7) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::dynamic_field::remove<V4PurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v5), 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v0, arg7));
        let v8 = v7;
        0x2::kiosk::lock<T0>(arg3, arg4, arg2, v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v8, arg3);
        if (v2 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v8, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v2, arg7));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v1, arg7), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        };
        let v9 = &mut v8;
        add_marketplace_v4_receipt_if_installed<T0>(arg2, v9);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v8);
        0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        refund_v4_offers_for_sale(arg0, arg6);
        arg0.active = false;
        let v13 = V4NFTSold{
            listing_id     : 0x2::object::id<V4Listing>(arg0),
            nft_id         : arg0.nft_id,
            buyer          : 0x2::tx_context::sender(arg7),
            seller         : arg0.seller,
            price          : v0,
            fee_amount     : v1,
            royalty_amount : v2,
            kiosk_trade    : true,
        };
        0x2::event::emit<V4NFTSold>(v13);
    }

    public entry fun buy_v4<T0: store + key>(arg0: &mut V4Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 17);
        assert!(!arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.price, 3);
        if (v0 > arg0.price) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - arg0.price, arg3), 0x2::tx_context::sender(arg3));
        };
        let v1 = percentage_fee(arg0.price);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        };
        let v2 = V4NftKey{seal: true};
        let v3 = 0x2::dynamic_field::remove<V4NftKey, T0>(&mut arg0.id, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.seller);
        refund_v4_offers_for_sale(arg0, arg2);
        arg0.active = false;
        let v4 = V4NFTSold{
            listing_id     : 0x2::object::id<V4Listing>(arg0),
            nft_id         : arg0.nft_id,
            buyer          : 0x2::tx_context::sender(arg3),
            seller         : arg0.seller,
            price          : arg0.price,
            fee_amount     : v1,
            royalty_amount : 0,
            kiosk_trade    : false,
        };
        0x2::event::emit<V4NFTSold>(v4);
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg3));
    }

    public entry fun cancel_offer(arg0: &mut Offer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 7);
        assert!(0x2::tx_context::sender(arg1) == arg0.bidder, 6);
        let v0 = take_offer_escrow(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.bidder);
        let v1 = OfferCancelled{
            offer_id : 0x2::object::id<Offer>(arg0),
            nft_id   : arg0.nft_id,
            bidder   : arg0.bidder,
            amount   : arg0.amount,
        };
        0x2::event::emit<OfferCancelled>(v1);
    }

    public entry fun cancel_offer_v4(arg0: &mut V4Listing, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = v4_offer_index(arg0, arg1);
        assert!(v0 < 0x1::vector::length<V4OfferRecord>(&arg0.offers), 18);
        let V4OfferRecord {
            nonce          : v1,
            bidder         : v2,
            amount         : v3,
            total_escrow   : _,
            fee_amount     : _,
            royalty_amount : _,
            expires_at_ms  : _,
            payment        : v8,
        } = 0x1::vector::remove<V4OfferRecord>(&mut arg0.offers, v0);
        assert!(0x2::tx_context::sender(arg2) == v2, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v2);
        let v9 = V4OfferCancelled{
            listing_id : 0x2::object::id<V4Listing>(arg0),
            nft_id     : arg0.nft_id,
            nonce      : v1,
            bidder     : v2,
            amount     : v3,
        };
        0x2::event::emit<V4OfferCancelled>(v9);
    }

    fun checked_expiry(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0 > v0, 5);
        assert!(arg0 - v0 <= 2592000000, 5);
    }

    fun checked_total_escrow(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128) + (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 13);
        (v0 as u64)
    }

    fun create_offer_record(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        checked_expiry(arg6, arg9);
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == arg3, 13);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Offer{
            id             : 0x2::object::new(arg10),
            nft_id         : arg0,
            nft_type       : arg1,
            bidder         : v0,
            amount         : arg2,
            total_escrow   : arg3,
            fee_amount     : arg4,
            royalty_amount : arg5,
            expires_at_ms  : arg6,
            kiosk_trade    : arg7,
            active         : true,
        };
        let v2 = OfferEscrowKey{dummy_field: false};
        0x2::dynamic_field::add<OfferEscrowKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v1.id, v2, arg8);
        let v3 = OfferCreated{
            offer_id       : 0x2::object::id<Offer>(&v1),
            nft_id         : arg0,
            nft_type       : arg1,
            bidder         : v0,
            amount         : arg2,
            total_escrow   : arg3,
            fee_amount     : arg4,
            royalty_amount : arg5,
            expires_at_ms  : arg6,
            kiosk_trade    : arg7,
        };
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<Offer>(v1);
    }

    fun create_v4_kiosk_listing<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(0x2::kiosk::has_access(arg0, arg1), 2);
        ensure_v4_policy<T0>(arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 1, arg5);
        let v2 = new_v4_listing(arg2, 0x1::type_name::with_defining_ids<T0>(), v0, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), true, arg5);
        let v3 = V4PurchaseCapKey{seal: true};
        0x2::dynamic_field::add<V4PurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut v2.id, v3, v1);
        emit_v4_listing_created(&v2);
        0x2::transfer::share_object<V4Listing>(v2);
    }

    fun create_v4_offer_record(arg0: &mut V4Listing, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 17);
        assert!(arg0.kiosk_trade == arg6, 12);
        assert!(arg1 > 0, 1);
        checked_expiry(arg5, arg8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) == arg2, 13);
        purge_expired_v4_offers(arg0, arg8);
        let v0 = 0x1::vector::length<V4OfferRecord>(&arg0.offers);
        assert!(v0 < 16, 16);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<V4OfferRecord>(&arg0.offers, v3).amount;
            if (v4 > v1) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        assert!(arg1 > v2, 14);
        assert!(arg0.next_offer_nonce < 18446744073709551615, 7);
        let v5 = arg0.next_offer_nonce;
        arg0.next_offer_nonce = v5 + 1;
        let v6 = 0x2::tx_context::sender(arg9);
        let v7 = V4OfferRecord{
            nonce          : v5,
            bidder         : v6,
            amount         : arg1,
            total_escrow   : arg2,
            fee_amount     : arg3,
            royalty_amount : arg4,
            expires_at_ms  : arg5,
            payment        : arg7,
        };
        0x1::vector::push_back<V4OfferRecord>(&mut arg0.offers, v7);
        let v8 = V4OfferCreated{
            listing_id    : 0x2::object::id<V4Listing>(arg0),
            nft_id        : arg0.nft_id,
            nonce         : v5,
            bidder        : v6,
            amount        : arg1,
            total_escrow  : arg2,
            expires_at_ms : arg5,
            kiosk_trade   : arg6,
        };
        0x2::event::emit<V4OfferCreated>(v8);
    }

    public entry fun delist_kiosk<T0: store + key>(arg0: &Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        0x2::kiosk::delist<T0>(arg1, arg2, arg0.nft_id);
        let v0 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : arg0.nft_id,
            seller     : arg0.seller,
        };
        0x2::event::emit<NFTDelisted>(v0);
    }

    public entry fun delist_kiosk_v4<T0: store + key>(arg0: &mut V4Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.active, 17);
        assert!(arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        assert_v4_no_live_offers(arg0, arg2);
        let v0 = V4PurchaseCapKey{seal: true};
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x2::dynamic_field::remove<V4PurchaseCapKey, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v0));
        arg0.active = false;
        let v1 = V4NFTDelisted{
            listing_id  : 0x2::object::id<V4Listing>(arg0),
            nft_id      : arg0.nft_id,
            seller      : arg0.seller,
            kiosk_trade : true,
        };
        0x2::event::emit<V4NFTDelisted>(v1);
    }

    public entry fun delist_v4<T0: store + key>(arg0: &mut V4Listing, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.active, 17);
        assert!(!arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 2);
        assert_v4_no_live_offers(arg0, arg1);
        let v0 = V4NftKey{seal: true};
        arg0.active = false;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_field::remove<V4NftKey, T0>(&mut arg0.id, v0), arg0.seller);
        let v1 = V4NFTDelisted{
            listing_id  : 0x2::object::id<V4Listing>(arg0),
            nft_id      : arg0.nft_id,
            seller      : arg0.seller,
            kiosk_trade : false,
        };
        0x2::event::emit<V4NFTDelisted>(v1);
    }

    fun emit_v4_listing_created(arg0: &V4Listing) {
        let v0 = V4ListingCreated{
            listing_id  : 0x2::object::id<V4Listing>(arg0),
            nft_id      : arg0.nft_id,
            nft_type    : arg0.nft_type,
            seller      : arg0.seller,
            price       : arg0.price,
            kiosk_id    : arg0.kiosk_id,
            kiosk_trade : arg0.kiosk_trade,
        };
        0x2::event::emit<V4ListingCreated>(v0);
    }

    fun ensure_v4_policy<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0), 19);
        assert!(0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg0), 19);
    }

    public entry fun install_marketplace_v4_rule<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        assert!(0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg0), 19);
        assert!(0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg0), 19);
        assert!(!0x2::transfer_policy::has_rule<T0, MarketplaceV4Rule>(arg0), 19);
        let v0 = MarketplaceV4Rule{seal: true};
        let v1 = MarketplaceV4Config{enabled: true};
        0x2::transfer_policy::add_rule<T0, MarketplaceV4Rule, MarketplaceV4Config>(v0, arg0, arg1, v1);
    }

    fun is_standard_bid_type<T0: store + key>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT"
    }

    public fun kiosk_offer_total<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        checked_total_escrow(arg1, percentage_fee(arg1), 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg0, arg1))
    }

    public entry fun list_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg4 == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v2 = Listing{
            id         : 0x2::object::new(arg5),
            nft_id     : arg2,
            kiosk_id   : v1,
            seller     : v0,
            price      : arg3,
            treasury   : @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc,
            created_at : 0x2::tx_context::epoch(arg5),
        };
        0x2::transfer::share_object<Listing>(v2);
        let v3 = NFTListed{
            listing_id : 0x2::object::id<Listing>(&v2),
            nft_id     : arg2,
            kiosk_id   : v1,
            seller     : v0,
            price      : arg3,
        };
        0x2::event::emit<NFTListed>(v3);
    }

    public entry fun list_kiosk_v4<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::kiosk::is_listed(arg0, arg2), 17);
        assert!(!0x2::kiosk::is_listed_exclusively(arg0, arg2), 17);
        create_v4_kiosk_listing<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun list_v4<T0: store + key>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT>(), 12);
        assert!(arg1 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = new_v4_listing(0x2::object::id<T0>(&arg0), 0x1::type_name::with_defining_ids<T0>(), v0, arg1, 0x2::object::id_from_address(@0x0), false, arg2);
        let v2 = V4NftKey{seal: true};
        0x2::dynamic_field::add<V4NftKey, T0>(&mut v1.id, v2, arg0);
        emit_v4_listing_created(&v1);
        0x2::transfer::share_object<V4Listing>(v1);
    }

    public fun listing_kiosk_id(arg0: &Listing) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun listing_nft_id(arg0: &Listing) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun listing_price(arg0: &Listing) : u64 {
        arg0.price
    }

    public fun listing_seller(arg0: &Listing) : address {
        arg0.seller
    }

    public entry fun make_kiosk_offer<T0: store + key>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = percentage_fee(arg1);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg3, arg1);
        create_offer_record(arg0, 0x1::type_name::with_defining_ids<T0>(), arg1, checked_total_escrow(arg1, v0, v1), v0, v1, arg4, true, arg2, arg5, arg6);
    }

    public entry fun make_kiosk_offer_v4<T0: store + key>(arg0: &mut V4Listing, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(0x2::tx_context::sender(arg6) != arg0.seller, 9);
        ensure_v4_policy<T0>(arg3);
        let v0 = percentage_fee(arg1);
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg3, arg1);
        create_v4_offer_record(arg0, arg1, checked_total_escrow(arg1, v0, v1), v0, v1, arg4, true, arg2, arg5, arg6);
    }

    public entry fun make_offer<T0: store + key>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_standard_bid_type<T0>(), 12);
        create_offer_record(arg0, 0x1::type_name::with_defining_ids<T0>(), arg1, arg1, percentage_fee(arg1), 0, arg3, false, arg2, arg4, arg5);
    }

    public entry fun make_offer_v4<T0: store + key>(arg0: &mut V4Listing, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.kiosk_trade, 12);
        assert!(arg0.nft_type == 0x1::type_name::with_defining_ids<T0>(), 8);
        assert!(0x2::tx_context::sender(arg5) != arg0.seller, 9);
        create_v4_offer_record(arg0, arg1, arg1, percentage_fee(arg1), 0, arg3, false, arg2, arg4, arg5);
    }

    public entry fun migrate_kiosk_listing_v4<T0: store + key>(arg0: &Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.seller, 2);
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        assert!(0x2::kiosk::has_access(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg0.nft_id), 17);
        let v0 = arg0.nft_id;
        0x2::kiosk::delist<T0>(arg1, arg2, v0);
        let v1 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v0,
            seller     : arg0.seller,
        };
        0x2::event::emit<NFTDelisted>(v1);
        create_v4_kiosk_listing<T0>(arg1, arg2, v0, arg0.price, arg3, arg4);
    }

    public entry fun migrate_standard_listing_v4(arg0: &mut Listing, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 2);
        assert!(arg0.treasury == @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc, 4);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.kiosk_id, 10);
        let v0 = CapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CapKey>(&arg0.id, v0), 2);
        let v1 = arg0.nft_id;
        let v2 = arg0.seller;
        let v3 = CapKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::remove<CapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v3);
        0x2::kiosk::delist<0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT>(arg1, &v4, v1);
        let v5 = 0x2::kiosk::take<0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT>(arg1, &v4, v1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, v2);
        let v6 = new_v4_listing(0x2::object::id<0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT>(&v5), 0x1::type_name::with_defining_ids<0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT>(), v2, arg0.price, 0x2::object::id_from_address(@0x0), false, arg2);
        let v7 = V4NftKey{seal: true};
        0x2::dynamic_field::add<V4NftKey, 0x3607d74b9141ed61882e77cf367038f782cd29ad4c5687e25652809fd97e7ade::suimon_nft::SuimonNFT>(&mut v6.id, v7, v5);
        let v8 = NFTDelisted{
            listing_id : 0x2::object::id<Listing>(arg0),
            nft_id     : v1,
            seller     : v2,
        };
        0x2::event::emit<NFTDelisted>(v8);
        emit_v4_listing_created(&v6);
        0x2::transfer::share_object<V4Listing>(v6);
    }

    fun new_v4_listing(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: 0x2::object::ID, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : V4Listing {
        assert!(arg3 > 0, 1);
        V4Listing{
            id               : 0x2::object::new(arg6),
            nft_id           : arg0,
            nft_type         : arg1,
            seller           : arg2,
            price            : arg3,
            treasury         : @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc,
            created_at       : 0x2::tx_context::epoch(arg6),
            kiosk_id         : arg4,
            kiosk_trade      : arg5,
            active           : true,
            next_offer_nonce : 1,
            offers           : 0x1::vector::empty<V4OfferRecord>(),
        }
    }

    fun pay_standard_offer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = percentage_fee(0x2::coin::value<0x2::sui::SUI>(&arg0));
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg2), @0x75b926ca6d0caa45c846cbcc0191ff03af3ef479729709b0a20a75fbf2fab0fc);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        v0
    }

    fun percentage_fee(arg0: u64) : u64 {
        (((arg0 as u128) * (500 as u128) / (10000 as u128)) as u64)
    }

    fun purge_expired_v4_offers(arg0: &mut V4Listing, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<V4OfferRecord>(&arg0.offers)) {
            if (0x2::clock::timestamp_ms(arg1) >= 0x1::vector::borrow<V4OfferRecord>(&arg0.offers, v0).expires_at_ms) {
                let V4OfferRecord {
                    nonce          : v1,
                    bidder         : v2,
                    amount         : v3,
                    total_escrow   : _,
                    fee_amount     : _,
                    royalty_amount : _,
                    expires_at_ms  : _,
                    payment        : v8,
                } = 0x1::vector::swap_remove<V4OfferRecord>(&mut arg0.offers, v0);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v2);
                let v9 = V4OfferExpired{
                    listing_id : 0x2::object::id<V4Listing>(arg0),
                    nft_id     : arg0.nft_id,
                    nonce      : v1,
                    bidder     : v2,
                    amount     : v3,
                };
                0x2::event::emit<V4OfferExpired>(v9);
                continue
            };
            v0 = v0 + 1;
        };
    }

    fun refund_all_v4_offers(arg0: &mut V4Listing) {
        while (!0x1::vector::is_empty<V4OfferRecord>(&arg0.offers)) {
            let V4OfferRecord {
                nonce          : v0,
                bidder         : v1,
                amount         : v2,
                total_escrow   : _,
                fee_amount     : _,
                royalty_amount : _,
                expires_at_ms  : _,
                payment        : v7,
            } = 0x1::vector::swap_remove<V4OfferRecord>(&mut arg0.offers, 0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v1);
            let v8 = V4OfferRefunded{
                listing_id : 0x2::object::id<V4Listing>(arg0),
                nft_id     : arg0.nft_id,
                nonce      : v0,
                bidder     : v1,
                amount     : v2,
            };
            0x2::event::emit<V4OfferRefunded>(v8);
        };
    }

    public entry fun refund_expired_offer(arg0: &mut Offer, arg1: &0x2::clock::Clock) {
        assert!(arg0.active, 7);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at_ms, 11);
        let v0 = take_offer_escrow(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.bidder);
        let v1 = OfferExpired{
            offer_id : 0x2::object::id<Offer>(arg0),
            nft_id   : arg0.nft_id,
            bidder   : arg0.bidder,
            amount   : arg0.amount,
        };
        0x2::event::emit<OfferExpired>(v1);
    }

    public entry fun refund_expired_offers_v4(arg0: &mut V4Listing, arg1: &0x2::clock::Clock) {
        purge_expired_v4_offers(arg0, arg1);
    }

    fun refund_v4_offers_for_sale(arg0: &mut V4Listing, arg1: &0x2::clock::Clock) {
        purge_expired_v4_offers(arg0, arg1);
        refund_all_v4_offers(arg0);
    }

    fun take_offer_escrow(arg0: &mut Offer) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0.active = false;
        let v0 = OfferEscrowKey{dummy_field: false};
        0x2::dynamic_field::remove<OfferEscrowKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0)
    }

    fun v4_offer_index(arg0: &V4Listing, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<V4OfferRecord>(&arg0.offers);
        while (v0 < v1) {
            if (0x1::vector::borrow<V4OfferRecord>(&arg0.offers, v0).nonce == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

