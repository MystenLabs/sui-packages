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

    fun assert_offer_open(arg0: &Offer, arg1: &0x2::clock::Clock) {
        assert!(arg0.active, 7);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms, 5);
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

    public entry fun make_offer<T0: store + key>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_standard_bid_type<T0>(), 12);
        create_offer_record(arg0, 0x1::type_name::with_defining_ids<T0>(), arg1, arg1, percentage_fee(arg1), 0, arg3, false, arg2, arg4, arg5);
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

    fun take_offer_escrow(arg0: &mut Offer) : 0x2::coin::Coin<0x2::sui::SUI> {
        arg0.active = false;
        let v0 = OfferEscrowKey{dummy_field: false};
        0x2::dynamic_field::remove<OfferEscrowKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v7
}

