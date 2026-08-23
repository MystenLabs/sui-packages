module 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::bids {
    struct Bid<phantom T0> has key {
        id: 0x2::object::UID,
        marketplace_id: 0x2::object::ID,
        bidder: address,
        kind: u8,
        item_id: 0x1::option::Option<0x2::object::ID>,
        merkle_root: 0x1::option::Option<vector<u8>>,
        trait_key: 0x1::option::Option<0x1::string::String>,
        trait_value: 0x1::option::Option<0x1::string::String>,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        price_per_item: u64,
        fee_per_item: u64,
        quantity_remaining: u64,
        quantity_filled: u64,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct Reservation<T0: store + key> has key {
        id: 0x2::object::UID,
        marketplace_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        seller: address,
        bidder: address,
        item_id: 0x2::object::ID,
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        expires_at_ms: u64,
    }

    struct BidReserved has copy, drop {
        reservation_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        seller: address,
        bidder: address,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        expires_at_ms: u64,
    }

    struct ReservationCancelled has copy, drop {
        reservation_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        refunded_to: address,
        amount: u64,
    }

    struct BidCreated has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
        item_type: 0x1::string::String,
        kind: u8,
        item_id: 0x1::option::Option<0x2::object::ID>,
        merkle_root: 0x1::option::Option<vector<u8>>,
        trait_key: 0x1::option::Option<0x1::string::String>,
        trait_value: 0x1::option::Option<0x1::string::String>,
        price_per_item: u64,
        fee_per_item: u64,
        quantity: u64,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct BidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        item_type: 0x1::string::String,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        marketplace_fee: u64,
        quantity_remaining: u64,
        timestamp_ms: u64,
    }

    struct BidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
        item_type: 0x1::string::String,
        refunded: u64,
        expired: bool,
        timestamp_ms: u64,
    }

    public fun accept_bid<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 0);
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg1.expires_at_ms, 0);
        assert!(arg1.quantity_remaining > 0, 5);
        assert!(0x2::tx_context::sender(arg7) != arg1.bidder, 13);
        if (arg1.kind == 0) {
            assert!(0x1::option::borrow<0x2::object::ID>(&arg1.item_id) == &arg4, 3);
        } else {
            assert!(arg1.kind == 1, 6);
            0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::attestation::assert_membership(0x1::option::borrow<vector<u8>>(&arg1.merkle_root), arg4, &arg5);
        };
        settle<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg7)
    }

    public fun accept_trait_bid<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 0);
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        assert!(arg1.kind == 2, 6);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 <= arg1.expires_at_ms, 0);
        assert!(arg1.quantity_remaining > 0, 5);
        assert!(0x2::tx_context::sender(arg8) != arg1.bidder, 13);
        let v1 = 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::attestor_pubkey(arg0);
        0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::attestation::verify_trait(&v1, arg1.marketplace_id, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), arg4, *0x1::option::borrow<0x1::string::String>(&arg1.trait_key), *0x1::option::borrow<0x1::string::String>(&arg1.trait_value), arg5, &arg6, v0);
        settle<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg8)
    }

    public fun bid_on_collection<T0: store + key>(arg0: &0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bid<T0>(arg0, 1, 0x1::option::none<0x2::object::ID>(), 0x1::option::some<vector<u8>>(arg1), 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun bid_on_item<T0: store + key>(arg0: &0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bid<T0>(arg0, 0, 0x1::option::some<0x2::object::ID>(arg1), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), arg2, 1, arg3, arg4, arg5, arg6)
    }

    public fun bid_on_trait<T0: store + key>(arg0: &0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_bid<T0>(arg0, 2, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::some<0x1::string::String>(arg1), 0x1::option::some<0x1::string::String>(arg2), arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun bidder<T0>(arg0: &Bid<T0>) : address {
        arg0.bidder
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut Bid<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.bidder, 2);
        refund<T0>(arg0, false, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    public fun cancel_reservation<T0: store + key>(arg0: Reservation<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Reservation {
            id             : v0,
            marketplace_id : _,
            bid_id         : v2,
            seller         : _,
            bidder         : v4,
            item_id        : v5,
            payment        : v6,
            fee            : v7,
            purchase_cap   : v8,
            expires_at_ms  : v9,
        } = arg0;
        let v10 = v8;
        let v11 = v7;
        let v12 = v6;
        let v13 = v0;
        assert!(0x2::clock::timestamp_ms(arg2) > v9, 17);
        assert!(0x2::kiosk::purchase_cap_kiosk<T0>(&v10) == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 19);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v10);
        let v14 = 0x2::coin::from_balance<0x2::sui::SUI>(v12, arg3);
        0x2::coin::join<0x2::sui::SUI>(&mut v14, 0x2::coin::from_balance<0x2::sui::SUI>(v11, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v14, v4);
        let v15 = ReservationCancelled{
            reservation_id : 0x2::object::uid_to_inner(&v13),
            bid_id         : v2,
            item_id        : v5,
            refunded_to    : v4,
            amount         : 0x2::balance::value<0x2::sui::SUI>(&v12) + 0x2::balance::value<0x2::sui::SUI>(&v11),
        };
        0x2::event::emit<ReservationCancelled>(v15);
        0x2::object::delete(v13);
    }

    public fun claim_reserved<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: Reservation<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let Reservation {
            id             : v0,
            marketplace_id : v1,
            bid_id         : v2,
            seller         : v3,
            bidder         : v4,
            item_id        : v5,
            payment        : v6,
            fee            : v7,
            purchase_cap   : v8,
            expires_at_ms  : v9,
        } = arg2;
        let v10 = v8;
        let v11 = v7;
        let v12 = v6;
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == v1, 11);
        assert!(0x2::object::id<Bid<T0>>(arg1) == v2, 18);
        assert!(0x2::tx_context::sender(arg5) == v4, 15);
        assert!(0x2::clock::timestamp_ms(arg4) <= v9, 16);
        assert!(0x2::kiosk::purchase_cap_kiosk<T0>(&v10) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 19);
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v12);
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        let (v15, v16) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v10, 0x2::coin::from_balance<0x2::sui::SUI>(v12, arg5));
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v11, arg5), 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::fee_recipient(arg0));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v11);
        };
        arg1.quantity_filled = arg1.quantity_filled + 1;
        0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::record_trade(arg0, v13);
        let v17 = BidAccepted{
            bid_id             : v2,
            bidder             : v4,
            seller             : v3,
            item_type          : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            item_id            : v5,
            kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            price              : v13,
            marketplace_fee    : v14,
            quantity_remaining : arg1.quantity_remaining,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BidAccepted>(v17);
        0x2::object::delete(v0);
        (v15, v16)
    }

    fun create_bid<T0: store + key>(arg0: &0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: u8, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: u64, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 0);
        assert!(arg1 <= 2, 6);
        assert!(arg6 >= 1000000, 9);
        assert!(arg7 > 0, 10);
        assert!(arg7 <= 1000, 14);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg9 > v0, 8);
        assert!(arg9 - v0 <= 7776000000, 7);
        let (v1, v2) = 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::quote<T0>(arg0, arg6);
        let v3 = v2 * arg7;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= v3, 4);
        let v4 = Bid<T0>{
            id                 : 0x2::object::new(arg11),
            marketplace_id     : 0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0),
            bidder             : 0x2::tx_context::sender(arg11),
            kind               : arg1,
            item_id            : arg2,
            merkle_root        : arg3,
            trait_key          : arg4,
            trait_value        : arg5,
            escrow             : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg8, v3, arg11)),
            price_per_item     : arg6,
            fee_per_item       : v1,
            quantity_remaining : arg7,
            quantity_filled    : 0,
            expires_at_ms      : arg9,
            created_at_ms      : v0,
        };
        let v5 = 0x2::object::id<Bid<T0>>(&v4);
        let v6 = BidCreated{
            bid_id         : v5,
            bidder         : 0x2::tx_context::sender(arg11),
            item_type      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            kind           : arg1,
            item_id        : arg2,
            merkle_root    : arg3,
            trait_key      : arg4,
            trait_value    : arg5,
            price_per_item : arg6,
            fee_per_item   : v1,
            quantity       : arg7,
            expires_at_ms  : arg9,
            timestamp_ms   : v0,
        };
        0x2::event::emit<BidCreated>(v6);
        0x2::transfer::share_object<Bid<T0>>(v4);
        v5
    }

    public fun escrow_value<T0>(arg0: &Bid<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun expires_at_ms<T0>(arg0: &Bid<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun fee_per_item<T0>(arg0: &Bid<T0>) : u64 {
        arg0.fee_per_item
    }

    public fun is_active<T0>(arg0: &Bid<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.quantity_remaining > 0 && 0x2::clock::timestamp_ms(arg1) <= arg0.expires_at_ms
    }

    public fun kind<T0>(arg0: &Bid<T0>) : u8 {
        arg0.kind
    }

    public fun price_per_item<T0>(arg0: &Bid<T0>) : u64 {
        arg0.price_per_item
    }

    public fun quantity_filled<T0>(arg0: &Bid<T0>) : u64 {
        arg0.quantity_filled
    }

    public fun quantity_remaining<T0>(arg0: &Bid<T0>) : u64 {
        arg0.quantity_remaining
    }

    public fun reclaim_expired<T0: store + key>(arg0: &mut Bid<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg0.expires_at_ms, 1);
        refund<T0>(arg0, true, v0, arg2);
    }

    fun refund<T0: store + key>(arg0: &mut Bid<T0>, arg1: bool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg3), arg0.bidder);
        };
        arg0.quantity_remaining = 0;
        let v1 = BidCancelled{
            bid_id       : 0x2::object::id<Bid<T0>>(arg0),
            bidder       : arg0.bidder,
            item_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            refunded     : v0,
            expired      : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<BidCancelled>(v1);
    }

    public fun reservation_bidder<T0: store + key>(arg0: &Reservation<T0>) : address {
        arg0.bidder
    }

    public fun reservation_expires_at_ms<T0: store + key>(arg0: &Reservation<T0>) : u64 {
        arg0.expires_at_ms
    }

    public fun reservation_item<T0: store + key>(arg0: &Reservation<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun reservation_seller<T0: store + key>(arg0: &Reservation<T0>) : address {
        arg0.seller
    }

    public fun reservation_value<T0: store + key>(arg0: &Reservation<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.payment)
    }

    fun reserve<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.price_per_item;
        let v1 = arg1.fee_per_item;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.escrow) >= v0 + v1, 4);
        if (0x2::kiosk::is_listed(arg2, arg4)) {
            0x2::kiosk::delist<T0>(arg2, arg3, arg4);
        };
        arg1.quantity_remaining = arg1.quantity_remaining - 1;
        let v2 = Reservation<T0>{
            id             : 0x2::object::new(arg6),
            marketplace_id : arg1.marketplace_id,
            bid_id         : 0x2::object::id<Bid<T0>>(arg1),
            seller         : 0x2::tx_context::sender(arg6),
            bidder         : arg1.bidder,
            item_id        : arg4,
            payment        : 0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v0),
            fee            : 0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v1),
            purchase_cap   : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, v0, arg6),
            expires_at_ms  : arg5 + 86400000,
        };
        let v3 = BidReserved{
            reservation_id : 0x2::object::id<Reservation<T0>>(&v2),
            bid_id         : 0x2::object::id<Bid<T0>>(arg1),
            seller         : 0x2::tx_context::sender(arg6),
            bidder         : arg1.bidder,
            item_id        : arg4,
            kiosk_id       : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            price          : v0,
            expires_at_ms  : v2.expires_at_ms,
        };
        0x2::event::emit<BidReserved>(v3);
        0x2::transfer::share_object<Reservation<T0>>(v2);
    }

    public fun reserve_for_bid<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 0);
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg1.expires_at_ms, 0);
        assert!(arg1.quantity_remaining > 0, 5);
        assert!(0x2::tx_context::sender(arg7) != arg1.bidder, 13);
        if (arg1.kind == 0) {
            assert!(0x1::option::borrow<0x2::object::ID>(&arg1.item_id) == &arg4, 3);
        } else {
            assert!(arg1.kind == 1, 6);
            0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::attestation::assert_membership(0x1::option::borrow<vector<u8>>(&arg1.merkle_root), arg4, &arg5);
        };
        reserve<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg7);
    }

    public fun reserve_for_trait_bid<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::is_paused(arg0), 0);
        assert!(0x2::object::id<0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace>(arg0) == arg1.marketplace_id, 11);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(v0 <= arg1.expires_at_ms, 0);
        assert!(arg1.quantity_remaining > 0, 5);
        assert!(0x2::tx_context::sender(arg8) != arg1.bidder, 13);
        assert!(arg1.kind == 2, 6);
        let v1 = 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::attestor_pubkey(arg0);
        0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::attestation::verify_trait(&v1, arg1.marketplace_id, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), arg4, *0x1::option::borrow<0x1::string::String>(&arg1.trait_key), *0x1::option::borrow<0x1::string::String>(&arg1.trait_value), arg5, &arg6, v0);
        reserve<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg8);
    }

    fun settle<T0: store + key>(arg0: &mut 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::Marketplace, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = arg1.price_per_item;
        let v1 = arg1.fee_per_item;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.escrow) >= v0 + v1, 4);
        if (0x2::kiosk::is_listed(arg2, arg4)) {
            0x2::kiosk::delist<T0>(arg2, arg3, arg4);
        };
        0x2::kiosk::list<T0>(arg2, arg3, arg4, v0);
        let (v2, v3) = 0x2::kiosk::purchase<T0>(arg2, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v0), arg6));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v1), arg6), 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::fee_recipient(arg0));
        };
        arg1.quantity_remaining = arg1.quantity_remaining - 1;
        arg1.quantity_filled = arg1.quantity_filled + 1;
        0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace::record_trade(arg0, v0);
        let v4 = BidAccepted{
            bid_id             : 0x2::object::id<Bid<T0>>(arg1),
            bidder             : arg1.bidder,
            seller             : 0x2::tx_context::sender(arg6),
            item_type          : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            item_id            : arg4,
            kiosk_id           : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            price              : v0,
            marketplace_fee    : v1,
            quantity_remaining : arg1.quantity_remaining,
            timestamp_ms       : arg5,
        };
        0x2::event::emit<BidAccepted>(v4);
        0x2::transfer::public_transfer<T0>(v2, arg1.bidder);
        v3
    }

    // decompiled from Move bytecode v7
}

