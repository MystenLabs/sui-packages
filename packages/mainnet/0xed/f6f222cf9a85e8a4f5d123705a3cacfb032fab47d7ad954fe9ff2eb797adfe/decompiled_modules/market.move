module 0xedf6f222cf9a85e8a4f5d123705a3cacfb032fab47d7ad954fe9ff2eb797adfe::market {
    struct Buyer has copy, drop, store {
        account: address,
        encryption_address: address,
        signing_public_key: vector<u8>,
        amount: u64,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        coordinator_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        source_share_id: 0x2::object::ID,
        seller: address,
        curve: u32,
        public_output_hash: vector<u8>,
        mode: u8,
        price_mist: u64,
        min_increment_mist: u64,
        closes_at_ms: u64,
        seller_window_ms: u64,
        buyer_window_ms: u64,
        state: u8,
        cap: 0x1::option::Option<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>,
        buyer: 0x1::option::Option<Buyer>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        seller_deadline_ms: u64,
        claim_deadline_ms: u64,
        destination_share_id: 0x1::option::Option<0x2::object::ID>,
        title: 0x1::string::String,
    }

    struct Offer has key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        buyer: Buyer,
        expires_at_ms: u64,
        state: u8,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MarketClaimReceipt has copy, drop, store {
        listing_id: 0x2::object::ID,
        coordinator_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        source_share_id: 0x2::object::ID,
        destination_share_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        encryption_address: address,
        amount: u64,
        seller_deadline_ms: u64,
        claim_deadline_ms: u64,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        seller: address,
        mode: u8,
        price_mist: u64,
        closes_at_ms: u64,
        title: 0x1::string::String,
    }

    struct BidPlaced has copy, drop {
        listing_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        previous_bidder: 0x1::option::Option<address>,
        previous_amount: u64,
    }

    struct Offered has copy, drop {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        expires_at_ms: u64,
    }

    struct OfferWithdrawn has copy, drop {
        offer_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
    }

    struct BuyerSelected has copy, drop {
        listing_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        encryption_address: address,
        seller_deadline_ms: u64,
        offer_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct DeliveryRequested has copy, drop {
        listing_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        source_share_id: 0x2::object::ID,
        buyer: address,
        encryption_address: address,
        claim_deadline_ms: u64,
    }

    struct Sold has copy, drop {
        listing_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        amount: u64,
        destination_share_id: 0x2::object::ID,
    }

    struct Closed has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        refunded_buyer: 0x1::option::Option<address>,
        refund_amount: u64,
        expired: bool,
    }

    public fun dwallet_id(arg0: &Listing) : 0x2::object::ID {
        arg0.dwallet_id
    }

    fun accept(arg0: &mut Listing, arg1: &mut Offer, arg2: u64, arg3: address) {
        require_open(arg0, 2, arg2);
        assert!(arg3 == arg0.seller, 0);
        assert!(arg1.listing_id == 0x2::object::id<Listing>(arg0) && arg1.state == 0, 12);
        assert!(arg2 < arg1.expires_at_ms, 3);
        let v0 = if (0x1::option::is_none<Buyer>(&arg0.buyer)) {
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg1.funds) == arg1.buyer.amount
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        0x1::option::fill<Buyer>(&mut arg0.buyer, arg1.buyer);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.funds));
        arg1.state = 1;
        let v1 = arg2 + arg0.seller_window_ms;
        select(arg0, v1, 0x1::option::some<0x2::object::ID>(0x2::object::id<Offer>(arg1)));
    }

    public fun accept_offer(arg0: &mut Listing, arg1: &mut Offer, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        accept(arg0, arg1, 0x2::clock::timestamp_ms(arg2), 0x2::tx_context::sender(arg3));
    }

    fun begin_delivery(arg0: &mut Listing, arg1: u64, arg2: address) {
        assert!(arg2 == arg0.seller, 0);
        let v0 = if (arg0.state == 1) {
            if (0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap)) {
                0x1::option::is_some<Buyer>(&arg0.buyer)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg1 < arg0.seller_deadline_ms, 3);
        arg0.state = 2;
        arg0.claim_deadline_ms = arg1 + arg0.buyer_window_ms;
    }

    public fun bid(arg0: &mut Listing, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: address, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        require_registered(arg0, arg1, arg3);
        place_bid(arg0, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg2), arg6);
    }

    public fun cancel_listing(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        assert!(arg0.state == 0 && 0x1::option::is_none<Buyer>(&arg0.buyer), 1);
        close(arg0, false, arg1);
    }

    public fun cap_id(arg0: &Listing) : 0x2::object::ID {
        arg0.cap_id
    }

    fun check_wallet(arg0: &Listing, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator) {
        assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg1) == arg0.coordinator_id, 2);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg1, arg0.dwallet_id);
        assert!(!0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_imported_key_dwallet(v0), 8);
        assert!(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::curve(v0) == arg0.curve && 0x2::hash::blake2b256(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::validate_active_and_get_public_output(v0)) == arg0.public_output_hash, 2);
    }

    public fun claim(arg0: &mut Listing, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        check_wallet(arg0, arg1);
        claim_verified(arg0, 0x2::clock::timestamp_ms(arg2), arg3, arg4, arg5);
    }

    public fun claim_receipt_bytes(arg0: &Listing, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = *0x1::option::borrow<Buyer>(&arg0.buyer);
        let v1 = MarketClaimReceipt{
            listing_id           : 0x2::object::id<Listing>(arg0),
            coordinator_id       : arg0.coordinator_id,
            dwallet_id           : arg0.dwallet_id,
            cap_id               : arg0.cap_id,
            source_share_id      : arg0.source_share_id,
            destination_share_id : arg1,
            seller               : arg0.seller,
            buyer                : v0.account,
            encryption_address   : v0.encryption_address,
            amount               : v0.amount,
            seller_deadline_ms   : arg0.seller_deadline_ms,
            claim_deadline_ms    : arg0.claim_deadline_ms,
        };
        let v2 = b"m1k4.market.claim.v1";
        0x1::vector::push_back<u8>(&mut v2, 0);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<MarketClaimReceipt>(&v1));
        v2
    }

    fun claim_verified(arg0: &mut Listing, arg1: u64, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.state == 2) {
            if (0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap)) {
                0x1::option::is_some<Buyer>(&arg0.buyer)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = *0x1::option::borrow<Buyer>(&arg0.buyer);
        assert!(0x2::tx_context::sender(arg4) == v1.account, 0);
        assert!(arg1 < arg0.claim_deadline_ms, 3);
        assert!(0x2::object::id_to_address(&arg2) != @0x0 && arg2 != arg0.source_share_id, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == v1.amount && v1.amount > 0, 6);
        let v2 = if (0x1::vector::length<u8>(&arg3) == 64) {
            let v3 = claim_receipt_bytes(arg0, arg2);
            0x2::ed25519::ed25519_verify(&arg3, &v1.signing_public_key, &v3)
        } else {
            false
        };
        assert!(v2, 7);
        arg0.state = 3;
        arg0.destination_share_id = 0x1::option::some<0x2::object::ID>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg4), arg0.seller);
        0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.cap), v1.account);
        let v4 = Sold{
            listing_id           : 0x2::object::id<Listing>(arg0),
            dwallet_id           : arg0.dwallet_id,
            cap_id               : arg0.cap_id,
            seller               : arg0.seller,
            buyer                : v1.account,
            amount               : v1.amount,
            destination_share_id : arg2,
        };
        0x2::event::emit<Sold>(v4);
    }

    fun close(arg0: &mut Listing, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state <= 2 && 0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap), 1);
        let v0 = 0x1::option::none<address>();
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.funds);
        if (0x1::option::is_some<Buyer>(&arg0.buyer)) {
            let v2 = *0x1::option::borrow<Buyer>(&arg0.buyer);
            assert!(v1 == v2.amount, 6);
            v0 = 0x1::option::some<address>(v2.account);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg2), v2.account);
        } else {
            assert!(v1 == 0, 6);
        };
        0x2::transfer::public_transfer<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(0x1::option::extract<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&mut arg0.cap), arg0.seller);
        arg0.state = 4;
        let v3 = Closed{
            listing_id     : 0x2::object::id<Listing>(arg0),
            seller         : arg0.seller,
            refunded_buyer : v0,
            refund_amount  : v1,
            expired        : arg1,
        };
        0x2::event::emit<Closed>(v3);
    }

    public fun commit_delivery(arg0: &mut Listing, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier, arg5: &mut 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        check_wallet(arg0, arg1);
        begin_delivery(arg0, 0x2::clock::timestamp_ms(arg2), 0x2::tx_context::sender(arg7));
        let v0 = *0x1::option::borrow<Buyer>(&arg0.buyer);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_re_encrypt_user_share_for(arg1, arg0.dwallet_id, v0.encryption_address, arg3, arg0.source_share_id, arg4, arg5, arg6, arg7);
        let v1 = DeliveryRequested{
            listing_id         : 0x2::object::id<Listing>(arg0),
            dwallet_id         : arg0.dwallet_id,
            cap_id             : arg0.cap_id,
            source_share_id    : arg0.source_share_id,
            buyer              : v0.account,
            encryption_address : v0.encryption_address,
            claim_deadline_ms  : arg0.claim_deadline_ms,
        };
        0x2::event::emit<DeliveryRequested>(v1);
    }

    public fun create_listing(arg0: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &0x2::clock::Clock, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_dwallet(arg0, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg2));
        assert!(!0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::is_imported_key_dwallet(v0), 8);
        let v1 = new_listing(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator>(arg0), arg2, arg3, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::curve(v0), 0x2::hash::blake2b256(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::validate_active_and_get_public_output(v0)), arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x2::clock::timestamp_ms(arg1), arg11);
        let v2 = Listed{
            listing_id   : 0x2::object::id<Listing>(&v1),
            dwallet_id   : v1.dwallet_id,
            cap_id       : v1.cap_id,
            seller       : v1.seller,
            mode         : arg4,
            price_mist   : arg5,
            closes_at_ms : arg7,
            title        : v1.title,
        };
        0x2::event::emit<Listed>(v2);
        0x2::transfer::share_object<Listing>(v1);
    }

    public fun deposit(arg0: &Listing) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    fun expire(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state <= 2, 1);
        let v0 = if (arg0.state == 1) {
            arg0.seller_deadline_ms
        } else if (arg0.state == 2) {
            arg0.claim_deadline_ms
        } else if (arg0.mode == 1 && 0x1::option::is_some<Buyer>(&arg0.buyer)) {
            arg0.closes_at_ms + arg0.seller_window_ms
        } else {
            arg0.closes_at_ms
        };
        assert!(arg1 >= v0, 4);
        close(arg0, true, arg2);
    }

    public fun expire_listing(arg0: &mut Listing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        expire(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    fun finalize(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mode == 1 && arg0.state == 0, 1);
        assert!(arg1 >= arg0.closes_at_ms, 4);
        let v0 = arg0.closes_at_ms + arg0.seller_window_ms;
        if (0x1::option::is_none<Buyer>(&arg0.buyer) || arg1 >= v0) {
            close(arg0, true, arg2);
        } else {
            select(arg0, v0, 0x1::option::none<0x2::object::ID>());
        };
    }

    public fun finalize_auction(arg0: &mut Listing, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        finalize(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    public fun make_offer(arg0: &Listing, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: address, arg4: vector<u8>, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        require_registered(arg0, arg1, arg3);
        let v0 = new_offer(arg0, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg2), arg7);
        let v1 = Offered{
            offer_id      : 0x2::object::id<Offer>(&v0),
            listing_id    : v0.listing_id,
            buyer         : v0.buyer.account,
            amount        : v0.buyer.amount,
            expires_at_ms : arg5,
        };
        0x2::event::emit<Offered>(v1);
        0x2::transfer::share_object<Offer>(v0);
    }

    fun new_buyer(arg0: &Listing, arg1: address, arg2: vector<u8>, arg3: u64, arg4: address) : Buyer {
        assert!(arg4 != arg0.seller && arg4 != @0x0, 0);
        assert!(0x1::vector::length<u8>(&arg2) == 32 && arg3 >= arg0.price_mist, 6);
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg2);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&v0)) == arg1 && arg1 != @0x0, 11);
        Buyer{
            account            : arg4,
            encryption_address : arg1,
            signing_public_key : arg2,
            amount             : arg3,
        }
    }

    fun new_listing(arg0: 0x2::object::ID, arg1: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg2: 0x2::object::ID, arg3: u32, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : Listing {
        assert!(arg5 <= 2 && arg6 > 0, 5);
        assert!(arg5 == 1 && arg7 > 0 || arg7 == 0, 5);
        let v0 = if (arg8 > arg12) {
            if (arg8 - arg12 >= 60000) {
                arg8 - arg12 <= 604800000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = if (arg9 >= 60000) {
            if (arg9 <= 172800000) {
                if (arg10 >= 60000) {
                    arg10 <= 172800000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 5);
        assert!(arg8 <= 18446744073709551615 - arg9 - arg10, 5);
        let v2 = if (0x2::object::id_to_address(&arg2) != @0x0) {
            if (0x2::object::id_to_address(&arg0) != @0x0) {
                0x1::vector::length<u8>(&arg4) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 5);
        assert!(!0x1::vector::is_empty<u8>(&arg11) && 0x1::vector::length<u8>(&arg11) <= 80, 5);
        Listing{
            id                   : 0x2::object::new(arg13),
            coordinator_id       : arg0,
            dwallet_id           : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg1),
            cap_id               : 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg1),
            source_share_id      : arg2,
            seller               : 0x2::tx_context::sender(arg13),
            curve                : arg3,
            public_output_hash   : arg4,
            mode                 : arg5,
            price_mist           : arg6,
            min_increment_mist   : arg7,
            closes_at_ms         : arg8,
            seller_window_ms     : arg9,
            buyer_window_ms      : arg10,
            state                : 0,
            cap                  : 0x1::option::some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(arg1),
            buyer                : 0x1::option::none<Buyer>(),
            funds                : 0x2::balance::zero<0x2::sui::SUI>(),
            seller_deadline_ms   : 0,
            claim_deadline_ms    : 0,
            destination_share_id : 0x1::option::none<0x2::object::ID>(),
            title                : 0x1::string::utf8(arg11),
        }
    }

    fun new_offer(arg0: &Listing, arg1: address, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Offer {
        require_open(arg0, 2, arg5);
        assert!(arg3 > arg5 && arg3 <= arg0.closes_at_ms, 5);
        Offer{
            id            : 0x2::object::new(arg6),
            listing_id    : 0x2::object::id<Listing>(arg0),
            buyer         : new_buyer(arg0, arg1, arg2, 0x2::coin::value<0x2::sui::SUI>(&arg4), 0x2::tx_context::sender(arg6)),
            expires_at_ms : arg3,
            state         : 0,
            funds         : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
        }
    }

    public fun offer_deposit(arg0: &Offer) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun offer_state(arg0: &Offer) : u8 {
        arg0.state
    }

    fun place_bid(arg0: &mut Listing, arg1: address, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        require_open(arg0, 1, arg4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = new_buyer(arg0, arg1, arg2, v0, 0x2::tx_context::sender(arg5));
        let v2 = 0x1::option::none<address>();
        let v3 = 0;
        if (0x1::option::is_some<Buyer>(&arg0.buyer)) {
            let v4 = 0x1::option::extract<Buyer>(&mut arg0.buyer);
            v3 = v4.amount;
            assert!(v4.amount <= 18446744073709551615 - arg0.min_increment_mist && v0 >= v4.amount + arg0.min_increment_mist, 10);
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == v4.amount, 6);
            v2 = 0x1::option::some<address>(v4.account);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg5), v4.account);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == 0, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        0x1::option::fill<Buyer>(&mut arg0.buyer, v1);
        let v5 = BidPlaced{
            listing_id      : 0x2::object::id<Listing>(arg0),
            bidder          : v1.account,
            amount          : v0,
            previous_bidder : v2,
            previous_amount : v3,
        };
        0x2::event::emit<BidPlaced>(v5);
    }

    public fun price(arg0: &Listing) : u64 {
        arg0.price_mist
    }

    fun require_open(arg0: &Listing, arg1: u8, arg2: u64) {
        assert!(arg0.mode == arg1, 9);
        assert!(arg0.state == 0 && 0x1::option::is_some<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&arg0.cap), 1);
        assert!(arg2 < arg0.closes_at_ms, 3);
    }

    fun require_registered(arg0: &Listing, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: address) {
        check_wallet(arg0, arg1);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::get_active_encryption_key(arg1, arg2);
    }

    fun reserve(arg0: &mut Listing, arg1: address, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address) {
        require_open(arg0, 0, arg4);
        let v0 = if (0x2::coin::value<0x2::sui::SUI>(&arg3) == arg0.price_mist) {
            if (0x1::option::is_none<Buyer>(&arg0.buyer)) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        0x1::option::fill<Buyer>(&mut arg0.buyer, new_buyer(arg0, arg1, arg2, 0x2::coin::value<0x2::sui::SUI>(&arg3), arg5));
        let v1 = arg4 + arg0.seller_window_ms;
        select(arg0, v1, 0x1::option::none<0x2::object::ID>());
    }

    public fun reserve_fixed(arg0: &mut Listing, arg1: &0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &0x2::clock::Clock, arg3: address, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        require_registered(arg0, arg1, arg3);
        reserve(arg0, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg2), 0x2::tx_context::sender(arg6));
    }

    fun select(arg0: &mut Listing, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>) {
        assert!(arg0.state == 0 && 0x1::option::is_some<Buyer>(&arg0.buyer), 1);
        let v0 = *0x1::option::borrow<Buyer>(&arg0.buyer);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == v0.amount, 6);
        arg0.state = 1;
        arg0.seller_deadline_ms = arg1;
        let v1 = BuyerSelected{
            listing_id         : 0x2::object::id<Listing>(arg0),
            buyer              : v0.account,
            amount             : v0.amount,
            encryption_address : v0.encryption_address,
            seller_deadline_ms : arg1,
            offer_id           : arg2,
        };
        0x2::event::emit<BuyerSelected>(v1);
    }

    public fun state(arg0: &Listing) : u8 {
        arg0.state
    }

    fun withdraw(arg0: &mut Offer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 12);
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer.account || arg1 >= arg0.expires_at_ms, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.funds) == arg0.buyer.amount, 6);
        arg0.state = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg2), arg0.buyer.account);
        let v0 = OfferWithdrawn{
            offer_id   : 0x2::object::id<Offer>(arg0),
            listing_id : arg0.listing_id,
            buyer      : arg0.buyer.account,
            amount     : arg0.buyer.amount,
        };
        0x2::event::emit<OfferWithdrawn>(v0);
    }

    public fun withdraw_offer(arg0: &mut Offer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        withdraw(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

