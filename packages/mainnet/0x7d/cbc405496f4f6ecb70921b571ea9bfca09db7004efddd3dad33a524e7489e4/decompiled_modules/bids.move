module 0x7dcbc405496f4f6ecb70921b571ea9bfca09db7004efddd3dad33a524e7489e4::bids {
    struct Bid<phantom T0> has key {
        id: 0x2::object::UID,
        bidder: address,
        seller_amount: u64,
        drip_fee: u64,
        treasury: address,
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at_ms: u64,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        bidder: address,
        target_item_id: 0x2::object::ID,
        seller_amount: u64,
        drip_fee: u64,
        treasury: address,
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at_ms: u64,
    }

    struct BidCreated has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
        seller_amount: u64,
        drip_fee: u64,
    }

    struct BidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        bidder: address,
    }

    struct BidAccepted has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        seller_amount: u64,
        drip_fee: u64,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        bidder: address,
        target_item_id: 0x2::object::ID,
        seller_amount: u64,
        drip_fee: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        bidder: address,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        seller_amount: u64,
        drip_fee: u64,
    }

    public fun accept_bid<T0: store + key>(arg0: Bid<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let Bid {
            id            : v0,
            bidder        : v1,
            seller_amount : v2,
            drip_fee      : v3,
            treasury      : v4,
            payment       : v5,
            created_at_ms : _,
        } = arg0;
        let v7 = v0;
        let v8 = 0x2::tx_context::sender(arg4);
        let (v9, v10) = settle_via_kiosk<T0>(arg1, arg2, arg3, v2, v3, v4, v5, arg4);
        let v11 = BidAccepted{
            bid_id        : 0x2::object::uid_to_inner(&v7),
            item_id       : arg3,
            bidder        : v1,
            seller        : v8,
            seller_amount : v2,
            drip_fee      : v3,
        };
        0x2::event::emit<BidAccepted>(v11);
        0x2::object::delete(v7);
        (v9, v10)
    }

    public fun accept_offer<T0: store + key>(arg0: Offer<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let Offer {
            id             : v0,
            bidder         : v1,
            target_item_id : v2,
            seller_amount  : v3,
            drip_fee       : v4,
            treasury       : v5,
            payment        : v6,
            created_at_ms  : _,
        } = arg0;
        let v8 = v0;
        let v9 = 0x2::tx_context::sender(arg3);
        let (v10, v11) = settle_via_kiosk<T0>(arg1, arg2, v2, v3, v4, v5, v6, arg3);
        let v12 = OfferAccepted{
            offer_id      : 0x2::object::uid_to_inner(&v8),
            bidder        : v1,
            seller        : v9,
            seller_amount : v3,
            drip_fee      : v4,
        };
        0x2::event::emit<OfferAccepted>(v12);
        0x2::object::delete(v8);
        (v10, v11)
    }

    public fun bid_amount<T0>(arg0: &Bid<T0>) : u64 {
        arg0.seller_amount
    }

    public fun bid_bidder<T0>(arg0: &Bid<T0>) : address {
        arg0.bidder
    }

    public fun cancel_bid<T0: store + key>(arg0: Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Bid {
            id            : v0,
            bidder        : v1,
            seller_amount : _,
            drip_fee      : _,
            treasury      : _,
            payment       : v5,
            created_at_ms : _,
        } = arg0;
        let v7 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg1), 2);
        let v8 = BidCancelled{
            bid_id : 0x2::object::uid_to_inner(&v7),
            bidder : v1,
        };
        0x2::event::emit<BidCancelled>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg1), v1);
        0x2::object::delete(v7);
    }

    public fun cancel_offer<T0: store + key>(arg0: Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id             : v0,
            bidder         : v1,
            target_item_id : _,
            seller_amount  : _,
            drip_fee       : _,
            treasury       : _,
            payment        : v6,
            created_at_ms  : _,
        } = arg0;
        let v8 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg1), 2);
        let v9 = OfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v8),
            bidder   : v1,
        };
        0x2::event::emit<OfferCancelled>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg1), v1);
        0x2::object::delete(v8);
    }

    public fun create_bid<T0: store + key>(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 4);
        assert!(200 <= 1000, 3);
        let (v0, v1) = split_payment(arg1, arg0, arg3);
        let v2 = Bid<T0>{
            id            : 0x2::object::new(arg3),
            bidder        : 0x2::tx_context::sender(arg3),
            seller_amount : arg0,
            drip_fee      : v1,
            treasury      : @0x1a4c3e81ef4055af3ecf16d2f7c2ee34dd7406555716c9f32f4b75954f581490,
            payment       : v0,
            created_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        let v3 = BidCreated{
            bid_id        : 0x2::object::id<Bid<T0>>(&v2),
            bidder        : 0x2::tx_context::sender(arg3),
            seller_amount : arg0,
            drip_fee      : v1,
        };
        0x2::event::emit<BidCreated>(v3);
        0x2::transfer::share_object<Bid<T0>>(v2);
    }

    public fun create_offer<T0: store + key>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(200 <= 1000, 3);
        let (v0, v1) = split_payment(arg2, arg1, arg4);
        let v2 = Offer<T0>{
            id             : 0x2::object::new(arg4),
            bidder         : 0x2::tx_context::sender(arg4),
            target_item_id : arg0,
            seller_amount  : arg1,
            drip_fee       : v1,
            treasury       : @0x1a4c3e81ef4055af3ecf16d2f7c2ee34dd7406555716c9f32f4b75954f581490,
            payment        : v0,
            created_at_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        let v3 = OfferCreated{
            offer_id       : 0x2::object::id<Offer<T0>>(&v2),
            bidder         : 0x2::tx_context::sender(arg4),
            target_item_id : arg0,
            seller_amount  : arg1,
            drip_fee       : v1,
        };
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<Offer<T0>>(v2);
    }

    public fun offer_amount<T0>(arg0: &Offer<T0>) : u64 {
        arg0.seller_amount
    }

    public fun offer_bidder<T0>(arg0: &Offer<T0>) : address {
        arg0.bidder
    }

    public fun offer_target<T0>(arg0: &Offer<T0>) : 0x2::object::ID {
        arg0.target_item_id
    }

    fun settle_via_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg4, arg7), arg5);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        0x2::kiosk::purchase<T0>(arg0, arg2, 0x2::coin::split<0x2::sui::SUI>(&mut v0, arg3, arg7))
    }

    fun split_payment(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        let v0 = arg1 * 200 / 10000;
        let v1 = arg1 + v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v1, 1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0) - v1, arg2), 0x2::tx_context::sender(arg2));
        };
        (0x2::coin::into_balance<0x2::sui::SUI>(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

