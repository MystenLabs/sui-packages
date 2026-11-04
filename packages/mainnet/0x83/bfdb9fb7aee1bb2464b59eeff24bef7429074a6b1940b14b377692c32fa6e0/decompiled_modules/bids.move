module 0x83bfdb9fb7aee1bb2464b59eeff24bef7429074a6b1940b14b377692c32fa6e0::bids {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bid<phantom T0> has key {
        id: 0x2::object::UID,
        bidder: address,
        seller_amount: u64,
        drip_fee: u64,
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at_ms: u64,
        closed: bool,
    }

    struct Offer<phantom T0> has key {
        id: 0x2::object::UID,
        bidder: address,
        target_item_id: 0x2::object::ID,
        seller_amount: u64,
        drip_fee: u64,
        payment: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at_ms: u64,
        closed: bool,
    }

    struct AcceptTicket {
        bid_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
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
        item_id: 0x2::object::ID,
        bidder: address,
        seller: address,
        seller_amount: u64,
        drip_fee: u64,
    }

    public fun accept_bid<T0: store + key>(arg0: &Config, arg1: &mut Bid<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::kiosk::Kiosk, AcceptTicket, 0x2::coin::Coin<0x2::sui::SUI>) {
        live(arg0);
        assert!(!arg1.closed, 2);
        arg1.closed = true;
        let v0 = &mut arg1.payment;
        let (v1, v2, v3, v4) = settle<T0>(v0, arg1.seller_amount, arg1.drip_fee, arg1.bidder, arg2, arg3, arg4, arg5, arg6);
        let v5 = v2;
        let v6 = BidAccepted{
            bid_id        : 0x2::object::id<Bid<T0>>(arg1),
            item_id       : v3,
            bidder        : arg1.bidder,
            seller        : 0x2::tx_context::sender(arg6),
            seller_amount : arg1.seller_amount,
            drip_fee      : arg1.drip_fee,
        };
        0x2::event::emit<BidAccepted>(v6);
        let v7 = AcceptTicket{
            bid_id   : 0x2::object::id<Bid<T0>>(arg1),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v5),
            item_id  : v3,
            bidder   : arg1.bidder,
        };
        (v1, v5, v7, v4)
    }

    public fun accept_offer<T0: store + key>(arg0: &Config, arg1: &mut Offer<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::kiosk::Kiosk, AcceptTicket, 0x2::coin::Coin<0x2::sui::SUI>) {
        live(arg0);
        assert!(!arg1.closed, 2);
        arg1.closed = true;
        let v0 = &mut arg1.payment;
        let (v1, v2, v3, v4) = settle<T0>(v0, arg1.seller_amount, arg1.drip_fee, arg1.bidder, arg2, arg3, arg1.target_item_id, arg4, arg5);
        let v5 = v2;
        let v6 = OfferAccepted{
            offer_id      : 0x2::object::id<Offer<T0>>(arg1),
            item_id       : v3,
            bidder        : arg1.bidder,
            seller        : 0x2::tx_context::sender(arg5),
            seller_amount : arg1.seller_amount,
            drip_fee      : arg1.drip_fee,
        };
        0x2::event::emit<OfferAccepted>(v6);
        let v7 = AcceptTicket{
            bid_id   : 0x2::object::id<Offer<T0>>(arg1),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v5),
            item_id  : v3,
            bidder   : arg1.bidder,
        };
        (v1, v5, v7, v4)
    }

    public fun bid_amount<T0>(arg0: &Bid<T0>) : u64 {
        arg0.seller_amount
    }

    public fun bid_bidder<T0>(arg0: &Bid<T0>) : address {
        arg0.bidder
    }

    public fun bid_closed<T0>(arg0: &Bid<T0>) : bool {
        arg0.closed
    }

    public fun bump_version(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 8);
        arg1.version = 1;
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut Bid<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.bidder, 1);
        assert!(!arg0.closed, 2);
        arg0.closed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.payment), arg1), arg0.bidder);
        let v0 = BidCancelled{
            bid_id : 0x2::object::id<Bid<T0>>(arg0),
            bidder : arg0.bidder,
        };
        0x2::event::emit<BidCancelled>(v0);
    }

    public fun cancel_offer<T0: store + key>(arg0: &mut Offer<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.bidder, 1);
        assert!(!arg0.closed, 2);
        arg0.closed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.payment), arg1), arg0.bidder);
        let v0 = OfferCancelled{
            offer_id : 0x2::object::id<Offer<T0>>(arg0),
            bidder   : arg0.bidder,
        };
        0x2::event::emit<OfferCancelled>(v0);
    }

    public fun create_bid<T0: store + key>(arg0: &Config, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        live(arg0);
        let (v0, v1) = take_escrow(arg2, arg1, arg4);
        let v2 = Bid<T0>{
            id            : 0x2::object::new(arg4),
            bidder        : 0x2::tx_context::sender(arg4),
            seller_amount : arg1,
            drip_fee      : v1,
            payment       : v0,
            created_at_ms : 0x2::clock::timestamp_ms(arg3),
            closed        : false,
        };
        let v3 = BidCreated{
            bid_id        : 0x2::object::id<Bid<T0>>(&v2),
            bidder        : v2.bidder,
            seller_amount : arg1,
            drip_fee      : v1,
        };
        0x2::event::emit<BidCreated>(v3);
        0x2::transfer::share_object<Bid<T0>>(v2);
    }

    public fun create_offer<T0: store + key>(arg0: &Config, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        live(arg0);
        let (v0, v1) = take_escrow(arg3, arg2, arg5);
        let v2 = Offer<T0>{
            id             : 0x2::object::new(arg5),
            bidder         : 0x2::tx_context::sender(arg5),
            target_item_id : arg1,
            seller_amount  : arg2,
            drip_fee       : v1,
            payment        : v0,
            created_at_ms  : 0x2::clock::timestamp_ms(arg4),
            closed         : false,
        };
        let v3 = OfferCreated{
            offer_id       : 0x2::object::id<Offer<T0>>(&v2),
            bidder         : v2.bidder,
            target_item_id : arg1,
            seller_amount  : arg2,
            drip_fee       : v1,
        };
        0x2::event::emit<OfferCreated>(v3);
        0x2::transfer::share_object<Offer<T0>>(v2);
    }

    public fun fee_for(arg0: u64) : u64 {
        (((arg0 as u128) * (200 as u128) / (10000 as u128)) as u64)
    }

    public fun finalize_accept(arg0: AcceptTicket, arg1: 0x2::kiosk::Kiosk) {
        let AcceptTicket {
            bid_id   : _,
            kiosk_id : v1,
            item_id  : v2,
            bidder   : v3,
        } = arg0;
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(&arg1) == v1, 6);
        assert!(0x2::kiosk::has_item(&arg1, v2), 7);
        assert!(0x2::kiosk::owner(&arg1) == v3, 7);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            version : 1,
            paused  : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun live(arg0: &Config) {
        assert!(arg0.version == 1, 8);
        assert!(!arg0.paused, 10);
    }

    public fun offer_amount<T0>(arg0: &Offer<T0>) : u64 {
        arg0.seller_amount
    }

    public fun offer_bidder<T0>(arg0: &Offer<T0>) : address {
        arg0.bidder
    }

    public fun offer_closed<T0>(arg0: &Offer<T0>) : bool {
        arg0.closed
    }

    public fun offer_target<T0>(arg0: &Offer<T0>) : 0x2::object::ID {
        arg0.target_item_id
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    fun settle<T0: store + key>(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::kiosk::Kiosk, 0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::kiosk::has_access(arg4, arg5), 9);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg6, arg1, arg8), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg1), arg8));
        let v2 = v0;
        assert!(0x2::object::id<T0>(&v2) == arg6, 5);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, arg2), arg8), @0x1a4c3e81ef4055af3ecf16d2f7c2ee34dd7406555716c9f32f4b75954f581490);
        };
        let (v3, v4) = 0x2::kiosk::new(arg8);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::set_owner_custom(&mut v6, &v5, arg3);
        0x2::kiosk::lock<T0>(&mut v6, &v5, arg7, v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, arg3);
        (v1, v6, arg6, 0x2::kiosk::withdraw(arg4, arg5, 0x1::option::some<u64>(arg1), arg8))
    }

    fun take_escrow(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, u64) {
        assert!(arg1 > 0, 3);
        let v0 = fee_for(arg1);
        let v1 = arg1 + v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= v1, 4);
        (0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg0, v1, arg2)), v0)
    }

    // decompiled from Move bytecode v7
}

