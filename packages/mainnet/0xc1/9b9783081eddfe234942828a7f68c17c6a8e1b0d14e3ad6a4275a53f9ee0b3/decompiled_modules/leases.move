module 0xc19b9783081eddfe234942828a7f68c17c6a8e1b0d14e3ad6a4275a53f9ee0b3::leases {
    struct Lease<phantom T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        owner: address,
        price: u64,
        lessee: 0x1::option::Option<address>,
        started_ms: u64,
        expires_ms: u64,
    }

    struct LeaseBid<phantom T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        bidder: address,
        item_id: 0x2::object::ID,
        escrow: 0x2::coin::Coin<T1>,
        expires_ms: u64,
    }

    struct LeaseListed has copy, drop {
        lease_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        owner: address,
        term_ms: u64,
    }

    struct LeaseRented has copy, drop {
        lease_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        owner: address,
        lessee: address,
        started_ms: u64,
        expires_ms: u64,
    }

    struct LeaseCancelled has copy, drop {
        lease_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        owner: address,
    }

    struct LeaseClosed has copy, drop {
        lease_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        owner: address,
        lessee: address,
        expires_ms: u64,
    }

    struct LeaseBidPlaced has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        expires_ms: u64,
    }

    struct LeaseBidCancelled has copy, drop {
        bid_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    public fun accept_bid<T0: store + key, T1>(arg0: LeaseBid<T0, T1>, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg0.expires_ms, 9);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg1) == 0, 2);
        assert!(0x2::kiosk::purchase_cap_item<T0>(&arg1) == arg0.item_id, 11);
        let LeaseBid {
            id         : v1,
            bidder     : v2,
            item_id    : _,
            escrow     : v4,
            expires_ms : _,
        } = arg0;
        0x2::object::delete(v1);
        let v6 = v4;
        let v7 = 0x2::coin::value<T1>(&v6);
        let v8 = v7 * 500 / 10000;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v6, v8, arg3), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg3));
        let v9 = Lease<T0, T1>{
            id         : 0x2::object::new(arg3),
            cap        : arg1,
            owner      : 0x2::tx_context::sender(arg3),
            price      : v7,
            lessee     : 0x1::option::some<address>(v2),
            started_ms : v0,
            expires_ms : v0 + 2592000000,
        };
        let v10 = LeaseRented{
            lease_id   : 0x2::object::id<Lease<T0, T1>>(&v9),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v9.cap),
            kiosk_id   : 0x2::kiosk::purchase_cap_kiosk<T0>(&v9.cap),
            price      : v7,
            owner      : v9.owner,
            lessee     : v2,
            started_ms : v0,
            expires_ms : v9.expires_ms,
        };
        0x2::event::emit<LeaseRented>(v10);
        0x2::transfer::share_object<Lease<T0, T1>>(v9);
    }

    public fun cancel<T0: store + key, T1>(arg0: Lease<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        assert!(0x1::option::is_none<address>(&arg0.lessee), 5);
        let Lease {
            id         : v0,
            cap        : v1,
            owner      : v2,
            price      : _,
            lessee     : _,
            started_ms : _,
            expires_ms : _,
        } = arg0;
        let v7 = v1;
        let v8 = v0;
        let v9 = LeaseCancelled{
            lease_id : 0x2::object::uid_to_inner(&v8),
            item_id  : 0x2::kiosk::purchase_cap_item<T0>(&v7),
            owner    : v2,
        };
        0x2::event::emit<LeaseCancelled>(v9);
        0x2::object::delete(v8);
        v7
    }

    public fun cancel_bid<T0: store + key, T1>(arg0: LeaseBid<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.expires_ms || 0x2::tx_context::sender(arg2) == arg0.bidder, 8);
        let LeaseBid {
            id         : v0,
            bidder     : v1,
            item_id    : v2,
            escrow     : v3,
            expires_ms : _,
        } = arg0;
        let v5 = v3;
        let v6 = v0;
        let v7 = LeaseBidCancelled{
            bid_id  : 0x2::object::uid_to_inner(&v6),
            item_id : v2,
            bidder  : v1,
            amount  : 0x2::coin::value<T1>(&v5),
        };
        0x2::event::emit<LeaseBidCancelled>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v1);
        0x2::object::delete(v6);
    }

    public fun close<T0: store + key, T1>(arg0: Lease<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x1::option::is_some<address>(&arg0.lessee), 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 7);
        let Lease {
            id         : v0,
            cap        : v1,
            owner      : v2,
            price      : _,
            lessee     : v4,
            started_ms : _,
            expires_ms : v6,
        } = arg0;
        let v7 = v4;
        let v8 = v1;
        let v9 = v0;
        let v10 = LeaseClosed{
            lease_id   : 0x2::object::uid_to_inner(&v9),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v8),
            owner      : v2,
            lessee     : *0x1::option::borrow<address>(&v7),
            expires_ms : v6,
        };
        0x2::event::emit<LeaseClosed>(v10);
        0x2::object::delete(v9);
        v8
    }

    public fun controller<T0: store + key, T1>(arg0: &Lease<T0, T1>, arg1: &0x2::clock::Clock) : 0x1::option::Option<address> {
        if (0x1::option::is_some<address>(&arg0.lessee) && 0x2::clock::timestamp_ms(arg1) < arg0.expires_ms) {
            arg0.lessee
        } else {
            0x1::option::none<address>()
        }
    }

    public fun expires_ms<T0: store + key, T1>(arg0: &Lease<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun is_running<T0: store + key, T1>(arg0: &Lease<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<address>(&arg0.lessee) && 0x2::clock::timestamp_ms(arg1) < arg0.expires_ms
    }

    public fun item_id<T0: store + key, T1>(arg0: &Lease<T0, T1>) : 0x2::object::ID {
        0x2::kiosk::purchase_cap_item<T0>(&arg0.cap)
    }

    public fun kiosk_id<T0: store + key, T1>(arg0: &Lease<T0, T1>) : 0x2::object::ID {
        0x2::kiosk::purchase_cap_kiosk<T0>(&arg0.cap)
    }

    public fun list<T0: store + key, T1>(arg0: 0x2::kiosk::PurchaseCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 3);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg0) == 0, 2);
        let v0 = Lease<T0, T1>{
            id         : 0x2::object::new(arg2),
            cap        : arg0,
            owner      : 0x2::tx_context::sender(arg2),
            price      : arg1,
            lessee     : 0x1::option::none<address>(),
            started_ms : 0,
            expires_ms : 0,
        };
        let v1 = LeaseListed{
            lease_id : 0x2::object::id<Lease<T0, T1>>(&v0),
            item_id  : 0x2::kiosk::purchase_cap_item<T0>(&v0.cap),
            kiosk_id : 0x2::kiosk::purchase_cap_kiosk<T0>(&v0.cap),
            price    : arg1,
            owner    : v0.owner,
            term_ms  : 2592000000,
        };
        0x2::event::emit<LeaseListed>(v1);
        0x2::transfer::share_object<Lease<T0, T1>>(v0);
    }

    public fun owner<T0: store + key, T1>(arg0: &Lease<T0, T1>) : address {
        arg0.owner
    }

    public fun place_bid<T0: store + key, T1>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 3);
        assert!(arg2 > 0 && arg2 <= 2592000000, 10);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg2;
        let v1 = LeaseBid<T0, T1>{
            id         : 0x2::object::new(arg4),
            bidder     : 0x2::tx_context::sender(arg4),
            item_id    : arg0,
            escrow     : arg1,
            expires_ms : v0,
        };
        let v2 = LeaseBidPlaced{
            bid_id     : 0x2::object::id<LeaseBid<T0, T1>>(&v1),
            item_id    : arg0,
            bidder     : v1.bidder,
            amount     : 0x2::coin::value<T1>(&arg1),
            expires_ms : v0,
        };
        0x2::event::emit<LeaseBidPlaced>(v2);
        0x2::transfer::share_object<LeaseBid<T0, T1>>(v1);
    }

    public fun price<T0: store + key, T1>(arg0: &Lease<T0, T1>) : u64 {
        arg0.price
    }

    public fun rent<T0: store + key, T1>(arg0: &mut Lease<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.lessee), 5);
        assert!(0x2::coin::value<T1>(&arg1) == arg0.price, 4);
        let v0 = arg0.price * 500 / 10000;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v0, arg3), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, arg0.owner);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.lessee = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        arg0.started_ms = v1;
        arg0.expires_ms = v1 + 2592000000;
        let v2 = LeaseRented{
            lease_id   : 0x2::object::id<Lease<T0, T1>>(arg0),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&arg0.cap),
            kiosk_id   : 0x2::kiosk::purchase_cap_kiosk<T0>(&arg0.cap),
            price      : arg0.price,
            owner      : arg0.owner,
            lessee     : 0x2::tx_context::sender(arg3),
            started_ms : v1,
            expires_ms : arg0.expires_ms,
        };
        0x2::event::emit<LeaseRented>(v2);
    }

    public fun started_ms<T0: store + key, T1>(arg0: &Lease<T0, T1>) : u64 {
        arg0.started_ms
    }

    public fun term_ms() : u64 {
        2592000000
    }

    // decompiled from Move bytecode v7
}

