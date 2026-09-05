module 0xf7817cce84653d1782fa1cdbbbe8c52bf59fa7b598557b281ea6422ca72fc974::capdutch {
    struct CapAuction<phantom T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        start_price: u64,
        floor_price: u64,
        start_ms: u64,
        end_ms: u64,
        seller: address,
    }

    struct CapListed has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        start_price: u64,
        floor_price: u64,
        start_ms: u64,
        end_ms: u64,
        seller: address,
    }

    struct CapSold has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct CapDelisted has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
    }

    public fun buy<T0: store + key, T1>(arg0: CapAuction<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        let v0 = current_price<T0, T1>(&arg0, arg2);
        let CapAuction {
            id          : v1,
            cap         : v2,
            start_price : _,
            floor_price : _,
            start_ms    : _,
            end_ms      : _,
            seller      : v7,
        } = arg0;
        let v8 = v2;
        let v9 = v1;
        assert!(0x2::coin::value<T1>(&arg1) >= v0, 1);
        let v10 = 0x2::tx_context::sender(arg3);
        let v11 = 0x2::coin::split<T1>(&mut arg1, v0, arg3);
        if (0x2::coin::value<T1>(&arg1) == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, v10);
        };
        let v12 = v0 * 500 / 10000;
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v11, v12, arg3), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v11, v7);
        let v13 = CapSold{
            auction_id : 0x2::object::uid_to_inner(&v9),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v8),
            kiosk_id   : 0x2::kiosk::purchase_cap_kiosk<T0>(&v8),
            price      : v0,
            seller     : v7,
            buyer      : v10,
        };
        0x2::event::emit<CapSold>(v13);
        0x2::object::delete(v9);
        v8
    }

    public fun current_price<T0: store + key, T1>(arg0: &CapAuction<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        0xf7817cce84653d1782fa1cdbbbe8c52bf59fa7b598557b281ea6422ca72fc974::dutch::price_at(arg0.start_price, arg0.floor_price, arg0.start_ms, arg0.end_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public fun delist<T0: store + key, T1>(arg0: CapAuction<T0, T1>, arg1: &0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 2);
        let CapAuction {
            id          : v0,
            cap         : v1,
            start_price : _,
            floor_price : _,
            start_ms    : _,
            end_ms      : _,
            seller      : v6,
        } = arg0;
        let v7 = v1;
        let v8 = v0;
        let v9 = CapDelisted{
            auction_id : 0x2::object::uid_to_inner(&v8),
            item_id    : 0x2::kiosk::purchase_cap_item<T0>(&v7),
            seller     : v6,
        };
        0x2::event::emit<CapDelisted>(v9);
        0x2::object::delete(v8);
        v7
    }

    public fun list<T0: store + key, T1>(arg0: 0x2::kiosk::PurchaseCap<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg1 >= arg2, 3);
        assert!(arg3 >= 3600000 && arg3 <= 2592000000, 4);
        assert!(0x2::kiosk::purchase_cap_min_price<T0>(&arg0) == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = CapAuction<T0, T1>{
            id          : 0x2::object::new(arg5),
            cap         : arg0,
            start_price : arg1,
            floor_price : arg2,
            start_ms    : v0,
            end_ms      : v0 + arg3,
            seller      : 0x2::tx_context::sender(arg5),
        };
        let v2 = CapListed{
            auction_id  : 0x2::object::id<CapAuction<T0, T1>>(&v1),
            item_id     : 0x2::kiosk::purchase_cap_item<T0>(&v1.cap),
            kiosk_id    : 0x2::kiosk::purchase_cap_kiosk<T0>(&v1.cap),
            start_price : arg1,
            floor_price : arg2,
            start_ms    : v0,
            end_ms      : v1.end_ms,
            seller      : v1.seller,
        };
        0x2::event::emit<CapListed>(v2);
        0x2::transfer::share_object<CapAuction<T0, T1>>(v1);
    }

    // decompiled from Move bytecode v7
}

