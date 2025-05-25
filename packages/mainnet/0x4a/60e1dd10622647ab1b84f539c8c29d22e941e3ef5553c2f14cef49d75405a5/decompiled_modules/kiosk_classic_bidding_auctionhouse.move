module 0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::kiosk_classic_bidding_auctionhouse {
    struct SimpleAuctionStore has key {
        id: 0x2::object::UID,
        auction_house: 0x2::object::ID,
    }

    struct EnglishAuction<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        reserve_price: u64,
        current_bid: u64,
        current_winner: 0x1::option::Option<address>,
        status: u8,
        fee_bps: u16,
        min_bid_increment_bps: u16,
        end_time_ms: u64,
        created_at_ms: u64,
        original_end_time_ms: u64,
        extensions_used: u8,
        extensions_enabled: bool,
    }

    struct AuctionBid<phantom T0> has store, key {
        id: 0x2::object::UID,
        bidder: address,
        amount: 0x2::balance::Balance<T0>,
        timestamp_ms: u64,
    }

    struct PendingRefund<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        amount: 0x2::balance::Balance<T0>,
        auction_id: 0x2::object::ID,
        created_at_ms: u64,
    }

    struct WinnerClaim<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        auction_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        created_at_ms: u64,
    }

    struct AuctionStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        auction_house: 0x2::object::ID,
        creator: address,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        reserve_price: u64,
        fee_bps: u16,
        min_bid_increment_bps: u16,
        end_time_ms: u64,
        duration_hours: u64,
        extensions_enabled: bool,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        previous_bid: u64,
        previous_bidder: 0x1::option::Option<address>,
        timestamp_ms: u64,
        reserve_met: bool,
        auction_extended: bool,
        new_end_time_ms: 0x1::option::Option<u64>,
    }

    struct AuctionCompleted has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
        winner: address,
        winning_bid: u64,
        fee_amount: u64,
        nft_id: 0x2::object::ID,
        timestamp_ms: u64,
        reserve_met: bool,
    }

    struct NFTClaimed has copy, drop {
        auction_id: 0x2::object::ID,
        winner: address,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
        nft_id: 0x2::object::ID,
        refund_created: bool,
        timestamp_ms: u64,
    }

    struct RefundCreated has copy, drop {
        auction_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct RefundClaimed has copy, drop {
        auction_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct AuctionExtended has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        old_end_time_ms: u64,
        new_end_time_ms: u64,
        extensions_used: u8,
        timestamp_ms: u64,
    }

    public fun auction_exists<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1)
    }

    fun calculate_fee(arg0: u64, arg1: u16) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        safe_div_u64(safe_mul_u64(arg0, (arg1 as u64)), 10000)
    }

    fun calculate_min_bid(arg0: u64, arg1: u64, arg2: u16) : u64 {
        if (arg0 == 0) {
            arg1
        } else {
            safe_add_u64(arg0, safe_div_u64(safe_mul_u64(arg0, (arg2 as u64)), 10000))
        }
    }

    public fun can_extend_auction<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        should_extend_auction(0x2::clock::timestamp_ms(arg2), v0.end_time_ms, v0.extensions_used, v0.extensions_enabled)
    }

    public fun cancel_auction<T0: store + key, T1>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1), 4);
        let v2 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        assert!(v0 == v2.seller, 1);
        assert!(v2.status == 1, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v2.kiosk_id, 1);
        let v3 = v2.nft_id;
        let v4 = v2.current_bid;
        let v5 = v2.current_winner;
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, EnglishAuction<T0>>(&mut arg0.id, arg1).status = 3;
        let v6 = false;
        if (0x1::option::is_some<address>(&v5)) {
            let v7 = *0x1::option::borrow<address>(&v5);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AuctionBid<T1>>(&arg0.id, arg1)) {
                let AuctionBid {
                    id           : v8,
                    bidder       : _,
                    amount       : v10,
                    timestamp_ms : _,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, AuctionBid<T1>>(&mut arg0.id, arg1);
                let v12 = PendingRefund<T1>{
                    id            : 0x2::object::new(arg4),
                    recipient     : v7,
                    amount        : v10,
                    auction_id    : arg1,
                    created_at_ms : v1,
                };
                0x2::dynamic_object_field::add<0x2::object::ID, PendingRefund<T1>>(&mut arg0.id, 0x2::object::id<PendingRefund<T1>>(&v12), v12);
                0x2::object::delete(v8);
                v6 = true;
                let v13 = RefundCreated{
                    auction_id   : arg1,
                    recipient    : v7,
                    amount       : v4,
                    timestamp_ms : v1,
                };
                0x2::event::emit<RefundCreated>(v13);
            };
        };
        let EnglishAuction {
            id                    : v14,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v18,
            reserve_price         : _,
            current_bid           : _,
            current_winner        : _,
            status                : _,
            fee_bps               : _,
            min_bid_increment_bps : _,
            end_time_ms           : _,
            created_at_ms         : _,
            original_end_time_ms  : _,
            extensions_used       : _,
            extensions_enabled    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, EnglishAuction<T0>>(&mut arg0.id, arg1);
        0x2::kiosk::return_purchase_cap<T0>(arg2, v18);
        0x2::object::delete(v14);
        let v30 = AuctionCancelled{
            auction_id     : arg1,
            seller         : v0,
            nft_id         : v3,
            refund_created : v6,
            timestamp_ms   : v1,
        };
        0x2::event::emit<AuctionCancelled>(v30);
    }

    public entry fun cancel_auction_entry<T0: store + key, T1>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        cancel_auction<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun claim_exists<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, WinnerClaim<T0>>(&arg0.id, arg1)
    }

    public fun claim_nft<T0: store + key>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, WinnerClaim<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, WinnerClaim<T0>>(&arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg6) == v0.winner, 21);
        let v1 = v0.nft_id;
        let WinnerClaim {
            id            : v2,
            auction_id    : _,
            winner        : _,
            nft_id        : _,
            purchase_cap  : v6,
            created_at_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, WinnerClaim<T0>>(&mut arg0.id, arg1);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v6, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v10 = v9;
        let (v11, v12) = 0x2::kiosk::new(arg6);
        let v13 = v12;
        let v14 = v11;
        0x2::kiosk::lock<T0>(&mut v14, &v13, arg3, v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v10, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v10, &v14);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v10);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v14);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v14, v13, arg6), arg6);
        0x2::object::delete(v2);
        let v18 = NFTClaimed{
            auction_id   : v0.auction_id,
            winner       : v0.winner,
            nft_id       : v1,
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(&v14),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<NFTClaimed>(v18);
    }

    public entry fun claim_nft_entry<T0: store + key>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        claim_nft<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_refund<T0>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, PendingRefund<T0>>(&arg0.id, arg1), 16);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, PendingRefund<T0>>(&arg0.id, arg1);
        assert!(v0 == v1.recipient, 1);
        let v2 = 0x2::balance::value<T0>(&v1.amount);
        let PendingRefund {
            id            : v3,
            recipient     : _,
            amount        : v5,
            auction_id    : _,
            created_at_ms : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, PendingRefund<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v3);
        let v8 = RefundClaimed{
            auction_id   : v1.auction_id,
            recipient    : v0,
            amount       : v2,
            timestamp_ms : v7,
        };
        0x2::event::emit<RefundClaimed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v0);
    }

    public fun complete_auction<T0: store + key, T1>(arg0: &mut SimpleAuctionStore, arg1: &mut 0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::object::id<0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse>(arg1) == arg0.auction_house, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg2), 4);
        let v1 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg2);
        assert!(v1.status == 1, 2);
        assert!(v0 >= v1.end_time_ms, 7);
        assert!(0x1::option::is_some<address>(&v1.current_winner), 15);
        assert!(v1.current_bid >= v1.reserve_price, 17);
        let v2 = v1.seller;
        let v3 = v1.nft_id;
        let v4 = v1.fee_bps;
        let v5 = v1.current_bid;
        let v6 = v1.reserve_price;
        let v7 = v1.current_winner;
        let v8 = *0x1::option::borrow<address>(&v7);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, EnglishAuction<T0>>(&mut arg0.id, arg2).status = 2;
        let EnglishAuction {
            id                    : v9,
            seller                : _,
            kiosk_id              : _,
            nft_id                : _,
            purchase_cap          : v13,
            reserve_price         : _,
            current_bid           : _,
            current_winner        : _,
            status                : _,
            fee_bps               : _,
            min_bid_increment_bps : _,
            end_time_ms           : _,
            created_at_ms         : _,
            original_end_time_ms  : _,
            extensions_used       : _,
            extensions_enabled    : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, EnglishAuction<T0>>(&mut arg0.id, arg2);
        let AuctionBid {
            id           : v25,
            bidder       : _,
            amount       : v27,
            timestamp_ms : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AuctionBid<T1>>(&mut arg0.id, arg2);
        let v29 = v27;
        let v30 = calculate_fee(0x2::balance::value<T1>(&v29), v4);
        let v31 = WinnerClaim<T0>{
            id            : 0x2::object::new(arg4),
            auction_id    : arg2,
            winner        : v8,
            nft_id        : v3,
            purchase_cap  : v13,
            created_at_ms : v0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, WinnerClaim<T0>>(&mut arg0.id, 0x2::object::id<WinnerClaim<T0>>(&v31), v31);
        0x2::object::delete(v9);
        0x2::object::delete(v25);
        let v32 = AuctionCompleted{
            auction_id   : arg2,
            seller       : v2,
            winner       : v8,
            winning_bid  : v5,
            fee_amount   : v30,
            nft_id       : v3,
            timestamp_ms : v0,
            reserve_met  : v5 >= v6,
        };
        0x2::event::emit<AuctionCompleted>(v32);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v29, v30), arg4), 0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::get_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v29, arg4), v2);
    }

    public entry fun complete_auction_entry<T0: store + key, T1>(arg0: &mut SimpleAuctionStore, arg1: &mut 0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        complete_auction<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun create_and_share_simple_auction_store(arg0: &0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SimpleAuctionStore>(create_simple_auction_store(arg0, arg1));
    }

    public fun create_auction<T0: store + key>(arg0: &mut SimpleAuctionStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u16, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg4 >= 10000000, 11);
        assert!(arg4 <= 100000000000000000, 14);
        validate_fee_bps(arg5);
        validate_bid_increment(arg6);
        validate_duration(arg7);
        assert!(0x2::kiosk::has_item(arg1, arg3), 3);
        assert!(0x2::kiosk::has_access(arg1, arg2), 6);
        let v2 = safe_add_u64(v1, arg7);
        let v3 = EnglishAuction<T0>{
            id                    : 0x2::object::new(arg10),
            seller                : v0,
            kiosk_id              : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id                : arg3,
            purchase_cap          : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg10),
            reserve_price         : arg4,
            current_bid           : 0,
            current_winner        : 0x1::option::none<address>(),
            status                : 1,
            fee_bps               : arg5,
            min_bid_increment_bps : arg6,
            end_time_ms           : v2,
            created_at_ms         : v1,
            original_end_time_ms  : v2,
            extensions_used       : 0,
            extensions_enabled    : arg8,
        };
        let v4 = 0x2::object::id<EnglishAuction<T0>>(&v3);
        0x2::dynamic_object_field::add<0x2::object::ID, EnglishAuction<T0>>(&mut arg0.id, v4, v3);
        let v5 = AuctionCreated{
            auction_id            : v4,
            seller                : v0,
            kiosk_id              : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id                : arg3,
            reserve_price         : arg4,
            fee_bps               : arg5,
            min_bid_increment_bps : arg6,
            end_time_ms           : v2,
            duration_hours        : safe_div_u64(arg7, 3600000),
            extensions_enabled    : arg8,
        };
        0x2::event::emit<AuctionCreated>(v5);
        v4
    }

    public entry fun create_auction_entry<T0: store + key>(arg0: &mut SimpleAuctionStore, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u16, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        create_auction<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 100, hours_to_ms(arg6), arg7, arg8, arg9);
    }

    public fun create_simple_auction_store(arg0: &0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : SimpleAuctionStore {
        let v0 = 0x2::object::new(arg1);
        let v1 = SimpleAuctionStore{
            id            : v0,
            auction_house : 0x2::object::id<0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse>(arg0),
        };
        let v2 = AuctionStoreCreated{
            store_id      : 0x2::object::uid_to_inner(&v0),
            auction_house : 0x2::object::id<0x4a60e1dd10622647ab1b84f539c8c29d22e941e3ef5553c2f14cef49d75405a5::auctionhouse::AuctionHouse>(arg0),
            creator       : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AuctionStoreCreated>(v2);
        v1
    }

    public fun get_auction_house_id(arg0: &SimpleAuctionStore) : 0x2::object::ID {
        arg0.auction_house
    }

    public fun get_auction_info<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (address, 0x2::object::ID, u64, u64, 0x1::option::Option<address>, u8, u16, u64, bool, bool, u8, bool) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        (v0.seller, v0.nft_id, v0.reserve_price, v0.current_bid, v0.current_winner, v0.status, v0.fee_bps, v0.end_time_ms, 0x2::clock::timestamp_ms(arg2) >= v0.end_time_ms, v0.current_bid >= v0.reserve_price, v0.extensions_used, v0.extensions_enabled)
    }

    public fun get_claim_info<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID) : (0x2::object::ID, address, 0x2::object::ID, u64) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, WinnerClaim<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, WinnerClaim<T0>>(&arg0.id, arg1);
        (v0.auction_id, v0.winner, v0.nft_id, v0.created_at_ms)
    }

    public fun get_min_bid<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        calculate_min_bid(v0.current_bid, v0.reserve_price, v0.min_bid_increment_bps)
    }

    public fun get_system_constants() : (u64, u64, u64, u64, u64, u8) {
        (3600000, 2592000000, 600000, 600000, 10000000, 3)
    }

    public fun get_time_remaining<T0: store + key>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v1 >= v0.end_time_ms) {
            0
        } else {
            v0.end_time_ms - v1
        }
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        let v0 = safe_mul_u64(arg0, 3600000);
        validate_duration(v0);
        v0
    }

    public fun place_bid<T0: store + key, T1>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1), 4);
        assert!(v2 >= 10000000, 10);
        assert!(v2 <= 100000000000000000, 14);
        let v3 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        assert!(v3.status == 1, 2);
        assert!(v1 < v3.end_time_ms, 8);
        assert!(v0 != v3.seller, 9);
        assert!(v2 >= calculate_min_bid(v3.current_bid, v3.reserve_price, v3.min_bid_increment_bps), 10);
        let v4 = v3.current_bid;
        let _ = v3.seller;
        let v6 = v3.end_time_ms;
        let v7 = v3.reserve_price;
        let v8 = v3.current_winner;
        let v9 = 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1);
        let v10 = should_extend_auction(v1, v9.end_time_ms, v9.extensions_used, v9.extensions_enabled);
        let v11 = if (v10) {
            safe_add_u64(v9.end_time_ms, 600000)
        } else {
            v9.end_time_ms
        };
        if (0x1::option::is_some<address>(&v8)) {
            let v12 = *0x1::option::borrow<address>(&v8);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AuctionBid<T1>>(&arg0.id, arg1)) {
                let AuctionBid {
                    id           : v13,
                    bidder       : _,
                    amount       : v15,
                    timestamp_ms : _,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, AuctionBid<T1>>(&mut arg0.id, arg1);
                let v17 = PendingRefund<T1>{
                    id            : 0x2::object::new(arg4),
                    recipient     : v12,
                    amount        : v15,
                    auction_id    : arg1,
                    created_at_ms : v1,
                };
                0x2::dynamic_object_field::add<0x2::object::ID, PendingRefund<T1>>(&mut arg0.id, 0x2::object::id<PendingRefund<T1>>(&v17), v17);
                0x2::object::delete(v13);
                let v18 = RefundCreated{
                    auction_id   : arg1,
                    recipient    : v12,
                    amount       : v4,
                    timestamp_ms : v1,
                };
                0x2::event::emit<RefundCreated>(v18);
            };
        };
        let v19 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, EnglishAuction<T0>>(&mut arg0.id, arg1);
        v19.current_bid = v2;
        v19.current_winner = 0x1::option::some<address>(v0);
        if (v10) {
            v19.end_time_ms = v11;
            v19.extensions_used = v19.extensions_used + 1;
        };
        let v20 = AuctionBid<T1>{
            id           : 0x2::object::new(arg4),
            bidder       : v0,
            amount       : 0x2::coin::into_balance<T1>(arg2),
            timestamp_ms : v1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AuctionBid<T1>>(&mut arg0.id, arg1, v20);
        let v21 = if (v10) {
            0x1::option::some<u64>(v11)
        } else {
            0x1::option::none<u64>()
        };
        let v22 = BidPlaced{
            auction_id       : arg1,
            bidder           : v0,
            amount           : v2,
            previous_bid     : v4,
            previous_bidder  : v8,
            timestamp_ms     : v1,
            reserve_met      : v2 >= v7,
            auction_extended : v10,
            new_end_time_ms  : v21,
        };
        0x2::event::emit<BidPlaced>(v22);
        if (v10) {
            let v23 = AuctionExtended{
                auction_id      : arg1,
                bidder          : v0,
                old_end_time_ms : v6,
                new_end_time_ms : v11,
                extensions_used : 0x2::dynamic_object_field::borrow<0x2::object::ID, EnglishAuction<T0>>(&arg0.id, arg1).extensions_used,
                timestamp_ms    : v1,
            };
            0x2::event::emit<AuctionExtended>(v23);
        };
    }

    public entry fun place_bid_entry<T0: store + key, T1>(arg0: &mut SimpleAuctionStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        place_bid<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun refund_exists<T0>(arg0: &SimpleAuctionStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, PendingRefund<T0>>(&arg0.id, arg1)
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 14);
        arg0 + arg1
    }

    fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 14);
        arg0 / arg1
    }

    fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 14);
        arg0 * arg1
    }

    fun should_extend_auction(arg0: u64, arg1: u64, arg2: u8, arg3: bool) : bool {
        if (!arg3 || arg2 >= 3) {
            return false
        };
        arg0 + 600000 >= arg1
    }

    fun validate_bid_increment(arg0: u16) {
        assert!(arg0 >= 50, 13);
        assert!(arg0 <= 2500, 13);
    }

    fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 18);
        assert!(arg0 <= 2592000000, 18);
    }

    fun validate_fee_bps(arg0: u16) {
        assert!(arg0 <= 1000, 12);
    }

    // decompiled from Move bytecode v6
}

