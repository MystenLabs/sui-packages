module 0x9eb3dc5fe9b81ba2bcfb07f66db7afb49677667940c43828336d9b8eab1c2a59::capmarket {
    struct CapListing<phantom T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        seller: address,
    }

    struct CapListed has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct CapSold has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct CapDelisted has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
    }

    public fun buy<T0: store + key, T1>(arg0: CapListing<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        let CapListing {
            id     : v0,
            cap    : v1,
            price  : v2,
            seller : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::coin::value<T1>(&arg1) == v2, 1);
        let v6 = v2 * 500 / 10000;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v6, arg2), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, v3);
        let v7 = CapSold{
            listing_id : 0x2::object::uid_to_inner(&v5),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v4),
            kiosk_id   : 0x2::kiosk::purchase_cap_kiosk<T0>(&v4),
            price      : v2,
            seller     : v3,
            buyer      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CapSold>(v7);
        0x2::object::delete(v5);
        v4
    }

    public fun delist<T0: store + key, T1>(arg0: CapListing<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 2);
        let CapListing {
            id     : v0,
            cap    : v1,
            price  : _,
            seller : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        let v6 = CapDelisted{
            listing_id : 0x2::object::uid_to_inner(&v5),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v4),
            seller     : v3,
        };
        0x2::event::emit<CapDelisted>(v6);
        0x2::object::delete(v5);
        v4
    }

    public fun list<T0: store + key, T1>(arg0: 0x2::kiosk::PurchaseCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg0) == 0, 3);
        let v0 = CapListing<T0, T1>{
            id     : 0x2::object::new(arg2),
            cap    : arg0,
            price  : arg1,
            seller : 0x2::tx_context::sender(arg2),
        };
        let v1 = CapListed{
            listing_id : 0x2::object::id<CapListing<T0, T1>>(&v0),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v0.cap),
            kiosk_id   : 0x2::kiosk::purchase_cap_kiosk<T0>(&v0.cap),
            price      : arg1,
            seller     : v0.seller,
        };
        0x2::event::emit<CapListed>(v1);
        0x2::transfer::share_object<CapListing<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

