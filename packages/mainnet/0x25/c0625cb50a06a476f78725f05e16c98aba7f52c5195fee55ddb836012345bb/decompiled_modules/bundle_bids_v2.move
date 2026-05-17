module 0x25c0625cb50a06a476f78725f05e16c98aba7f52c5195fee55ddb836012345bb::bundle_bids_v2 {
    struct Bundle3Bid has key {
        id: 0x2::object::UID,
        bundle_id: 0x2::object::ID,
        bidder: address,
        bidder_kiosk_id: 0x2::object::ID,
        bid_amount: u64,
        total_amount: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        expiry_ms: u64,
        consumed: bool,
        cancelled: bool,
    }

    struct KioskCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReserveRegistry has key {
        id: 0x2::object::UID,
    }

    struct ReserveKey has copy, drop, store {
        bundle_id: 0x2::object::ID,
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
        bid_amount: u64,
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
        bid_amount: u64,
        total_amount: u64,
    }

    struct ReserveSet has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
    }

    struct ReserveCleared has copy, drop {
        bundle_id: 0x2::object::ID,
        seller: address,
    }

    public fun accept_bid(arg0: &mut Bundle3Bid, arg1: &mut 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg2: &ReserveRegistry, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, AcceptanceTicket) {
        let v0 = 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::seller(arg1);
        assert!(0x2::tx_context::sender(arg6) == v0, 5);
        assert!(0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::is_active(arg1), 1);
        assert!(!arg0.consumed, 2);
        assert!(!arg0.cancelled, 3);
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expiry_ms, 10);
        assert!(arg0.bundle_id == 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1), 6);
        let v1 = 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1);
        let v2 = ReserveKey{bundle_id: v1};
        if (0x2::dynamic_field::exists_<ReserveKey>(&arg2.id, v2)) {
            let v3 = 0x2::bcs::to_bytes<u64>(&arg3);
            0x1::vector::append<u8>(&mut v3, arg4);
            assert!(0x2::hash::blake2b256(&v3) == *0x2::dynamic_field::borrow<ReserveKey, vector<u8>>(&arg2.id, v2), 21);
            assert!(arg0.bid_amount >= arg3, 22);
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg6);
        arg0.consumed = true;
        0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::pay_fee(arg1, &mut v4, arg6);
        let v5 = AcceptanceTicket{
            bid_id              : 0x2::object::id<Bundle3Bid>(arg0),
            bundle_id           : v1,
            bidder              : arg0.bidder,
            seller              : v0,
            expected_deliveries : 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::total_count(arg1),
            deliveries_done     : 0,
        };
        (v4, v5)
    }

    public fun bid_amount(arg0: &Bundle3Bid) : u64 {
        arg0.bid_amount
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

    public fun clear_reserve(arg0: &mut ReserveRegistry, arg1: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::seller(arg1), 5);
        let v0 = ReserveKey{bundle_id: 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1)};
        assert!(0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v0), 24);
        0x2::dynamic_field::remove<ReserveKey, vector<u8>>(&mut arg0.id, v0);
        let v1 = ReserveCleared{
            bundle_id : 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1),
            seller    : 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::seller(arg1),
        };
        0x2::event::emit<ReserveCleared>(v1);
    }

    public fun create_and_share(arg0: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_bid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::share_object<Bundle3Bid>(v0);
        0x2::object::id<Bundle3Bid>(&v0)
    }

    public fun create_bid(arg0: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Bundle3Bid {
        assert!(0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::is_active(arg0), 1);
        assert!(arg4 > 0, 20);
        assert!(0x2::kiosk::has_access(arg2, &arg3), 14);
        let v0 = arg4 + 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::fee_amount(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 11);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 > v1, 12);
        assert!(arg5 - v1 >= 60000, 13);
        let v2 = Bundle3Bid{
            id              : 0x2::object::new(arg7),
            bundle_id       : 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg0),
            bidder          : 0x2::tx_context::sender(arg7),
            bidder_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            bid_amount      : arg4,
            total_amount    : v0,
            escrow          : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0, arg7)),
            expiry_ms       : arg5,
            consumed        : false,
            cancelled       : false,
        };
        let v3 = KioskCapKey{dummy_field: false};
        0x2::dynamic_field::add<KioskCapKey, 0x2::kiosk::KioskOwnerCap>(&mut v2.id, v3, arg3);
        let v4 = BidCreated{
            bid_id       : 0x2::object::id<Bundle3Bid>(&v2),
            bundle_id    : v2.bundle_id,
            bidder       : v2.bidder,
            bid_amount   : arg4,
            total_amount : v0,
            expiry_ms    : arg5,
        };
        0x2::event::emit<BidCreated>(v4);
        v2
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
            bid_amount   : arg1.bid_amount,
            total_amount : arg1.total_amount,
        };
        0x2::event::emit<BidAccepted>(v7);
    }

    public fun has_reserve(arg0: &ReserveRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = ReserveKey{bundle_id: arg1};
        0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReserveRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ReserveRegistry>(v0);
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
            bid_amount      : _,
            total_amount    : _,
            escrow          : v6,
            expiry_ms       : _,
            consumed        : _,
            cancelled       : _,
        } = arg0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        0x2::object::delete(v0);
    }

    fun refund_to_bidder(arg0: &mut Bundle3Bid, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg1), arg0.bidder);
        let v0 = KioskCapKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_field::remove<KioskCapKey, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v0), arg0.bidder);
        arg0.cancelled = true;
    }

    public fun set_reserve(arg0: &mut ReserveRegistry, arg1: &0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::seller(arg1), 5);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 25);
        let v0 = ReserveKey{bundle_id: 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1)};
        assert!(!0x2::dynamic_field::exists_<ReserveKey>(&arg0.id, v0), 23);
        0x2::dynamic_field::add<ReserveKey, vector<u8>>(&mut arg0.id, v0, arg2);
        let v1 = ReserveSet{
            bundle_id : 0x2::object::id<0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::Bundle3>(arg1),
            seller    : 0x5b911f908050c37aebe92d07d7f16a8bd0d1f141e80810df1f44854c1ffbc9e4::bundle_v3::seller(arg1),
        };
        0x2::event::emit<ReserveSet>(v1);
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

