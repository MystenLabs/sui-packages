module 0x2df5c91780cd41fd744379a5f76e5d235077b71253ffb15a45a2316337211132::bundle_bids_v1 {
    struct Bundle3Bid has key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        bidder: address,
        bidder_kiosk_id: 0x2::object::ID,
        total_amount: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        expiry_ms: u64,
        consumed: bool,
        cancelled: bool,
    }

    struct KioskCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AcceptanceTicket {
        bid_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        expected_deliveries: u64,
        deliveries_done: u64,
    }

    struct BidCreated has copy, drop {
        bid_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        bidder: address,
        total_amount: u64,
        expiry_ms: u64,
    }

    struct BidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        bidder: address,
        reason: u8,
    }

    struct BidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        bundle_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        total_amount: u64,
    }

    public fun accept_bid(arg0: &mut Bundle3Bid, arg1: &mut 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, AcceptanceTicket) {
        let v0 = 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::seller(arg1);
        assert!(0x2::tx_context::sender(arg3) == v0, 5);
        assert!(0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::is_active(arg1), 1);
        assert!(!arg0.consumed, 2);
        assert!(!arg0.cancelled, 3);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expiry_ms, 10);
        assert!(arg0.bundle_id == 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1), 6);
        assert!(arg0.total_amount == 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::price(arg1) + 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::fee_amount(arg1), 7);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg3);
        arg0.consumed = true;
        0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::pay_fee(arg1, &mut v1, arg3);
        let v2 = AcceptanceTicket{
            bid_id              : 0x2::object::id<Bundle3Bid>(arg0),
            bundle_id           : arg0.bundle_id,
            bidder              : arg0.bidder,
            seller              : v0,
            expected_deliveries : 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::total_count(arg1),
            deliveries_done     : 0,
        };
        (v1, v2)
    }

    public fun bidder(arg0: &Bundle3Bid) : address {
        arg0.bidder
    }

    public fun bidder_kiosk_id(arg0: &Bundle3Bid) : 0x2::object::ID {
        arg0.bidder_kiosk_id
    }

    public fun bundle_id(arg0: &Bundle3Bid) : 0x2::object::ID {
        arg0.bundle_id
    }

    public fun cancel_bid(arg0: &mut Bundle3Bid, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.bidder, 4);
        assert!(!arg0.consumed, 2);
        assert!(!arg0.cancelled, 3);
        refund_to_bidder(arg0, arg1);
        let v0 = BidCancelled{
            bid_id    : 0x2::object::id<Bundle3Bid>(arg0),
            bundle_id : arg0.bundle_id,
            bidder    : arg0.bidder,
            reason    : 0,
        };
        0x2::event::emit<BidCancelled>(v0);
    }

    public fun create_and_share(arg0: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_bid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::share_object<Bundle3Bid>(v0);
        0x2::object::id<Bundle3Bid>(&v0)
    }

    public fun create_bid(arg0: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Bundle3Bid {
        assert!(0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::is_active(arg0), 1);
        assert!(0x2::kiosk::has_access(arg2, &arg3), 14);
        assert!(arg4 == 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::price(arg0) + 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::fee_amount(arg0), 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg4, 11);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 > v0, 12);
        assert!(arg5 - v0 >= 60000, 13);
        let v1 = Bundle3Bid{
            id              : 0x2::object::new(arg7),
            bundle_id       : 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg0),
            bidder          : 0x2::tx_context::sender(arg7),
            bidder_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            total_amount    : arg4,
            escrow          : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg4, arg7)),
            expiry_ms       : arg5,
            consumed        : false,
            cancelled       : false,
        };
        let v2 = KioskCapKey{dummy_field: false};
        0x2::dynamic_field::add<KioskCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v1.id, v2, arg3);
        let v3 = BidCreated{
            bid_id       : 0x2::object::id<Bundle3Bid>(&v1),
            bundle_id    : v1.bundle_id,
            bidder       : v1.bidder,
            total_amount : arg4,
            expiry_ms    : arg5,
        };
        0x2::event::emit<BidCreated>(v3);
        v1
    }

    public fun deliver_to_bidder<T0: store + key>(arg0: &mut AcceptanceTicket, arg1: &Bundle3Bid, arg2: &mut 0x2::kiosk::Kiosk, arg3: T0, arg4: &0x2::transfer_policy::TransferPolicy<T0>) {
        assert!(arg0.bid_id == 0x2::object::id<Bundle3Bid>(arg1), 17);
        assert!(arg0.bidder == arg1.bidder, 17);
        assert!(arg1.consumed, 16);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == arg1.bidder_kiosk_id, 15);
        assert!(arg0.deliveries_done < arg0.expected_deliveries, 19);
        let v0 = KioskCapKey{dummy_field: false};
        0x2::kiosk::lock<T0>(arg2, 0x2::dynamic_field::borrow<KioskCapKey, 0x2::kiosk::KioskOwnerCap>(&arg1.id, v0), arg4, arg3);
        arg0.deliveries_done = arg0.deliveries_done + 1;
    }

    public fun escrow_value(arg0: &Bundle3Bid) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun expire_bid(arg0: &mut Bundle3Bid, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.consumed, 2);
        assert!(!arg0.cancelled, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 10);
        refund_to_bidder(arg0, arg2);
        let v0 = BidCancelled{
            bid_id    : 0x2::object::id<Bundle3Bid>(arg0),
            bundle_id : arg0.bundle_id,
            bidder    : arg0.bidder,
            reason    : 1,
        };
        0x2::event::emit<BidCancelled>(v0);
    }

    public fun expiry_ms(arg0: &Bundle3Bid) : u64 {
        arg0.expiry_ms
    }

    public fun finalize_accept(arg0: AcceptanceTicket, arg1: &mut Bundle3Bid, arg2: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3) {
        assert!(arg0.bid_id == 0x2::object::id<Bundle3Bid>(arg1), 17);
        assert!(arg1.consumed, 16);
        assert!(arg0.deliveries_done == arg0.expected_deliveries, 18);
        assert!(0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::is_fee_paid(arg2), 8);
        assert!(0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::caps_taken(arg2) == 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::total_count(arg2), 9);
        assert!(arg0.bundle_id == 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg2), 6);
        let v0 = KioskCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_field::remove<KioskCapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg1.id, v0), arg1.bidder);
        let AcceptanceTicket {
            bid_id              : v1,
            bundle_id           : v2,
            bidder              : v3,
            seller              : v4,
            expected_deliveries : _,
            deliveries_done     : _,
        } = arg0;
        let v7 = BidAccepted{
            bid_id       : v1,
            bundle_id    : v2,
            bidder       : v3,
            seller       : v4,
            total_amount : 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::price(arg2) + 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::fee_amount(arg2),
        };
        0x2::event::emit<BidAccepted>(v7);
    }

    public fun is_cancelled(arg0: &Bundle3Bid) : bool {
        arg0.cancelled
    }

    public fun is_consumed(arg0: &Bundle3Bid) : bool {
        arg0.consumed
    }

    public fun is_settled(arg0: &Bundle3Bid) : bool {
        arg0.consumed || arg0.cancelled
    }

    public fun reclaim_settled(arg0: Bundle3Bid, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.bidder, 4);
        assert!(arg0.consumed || arg0.cancelled, 2);
        let Bundle3Bid {
            id              : v0,
            bundle_id       : _,
            bidder          : _,
            bidder_kiosk_id : _,
            total_amount    : _,
            escrow          : v5,
            expiry_ms       : _,
            consumed        : _,
            cancelled       : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        0x2::object::delete(v0);
    }

    fun refund_to_bidder(arg0: &mut Bundle3Bid, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg1), arg0.bidder);
        let v0 = KioskCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_field::remove<KioskCapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v0), arg0.bidder);
        arg0.cancelled = true;
    }

    public fun ticket_bid_id(arg0: &AcceptanceTicket) : 0x2::object::ID {
        arg0.bid_id
    }

    public fun ticket_bidder(arg0: &AcceptanceTicket) : address {
        arg0.bidder
    }

    public fun ticket_deliveries_done(arg0: &AcceptanceTicket) : u64 {
        arg0.deliveries_done
    }

    public fun ticket_expected_deliveries(arg0: &AcceptanceTicket) : u64 {
        arg0.expected_deliveries
    }

    public fun total_amount(arg0: &Bundle3Bid) : u64 {
        arg0.total_amount
    }

    // decompiled from Move bytecode v7
}

