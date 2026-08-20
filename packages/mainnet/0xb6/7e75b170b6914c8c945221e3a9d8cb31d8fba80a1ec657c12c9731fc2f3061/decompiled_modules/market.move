module 0x2181ed994caf30b30878d16a7309c79fa36b3a25e35b3a973cd2c9a6bc615d9a::market {
    struct Listing<T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        item: T0,
        price: u64,
        seller: address,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct Sold has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct Delisted has copy, drop {
        listing_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
    }

    public fun buy<T0: store + key, T1>(arg0: Listing<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            item   : v1,
            price  : v2,
            seller : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::coin::value<T1>(&arg1) >= v2, 1);
        let v6 = 0x2::tx_context::sender(arg2);
        let v7 = 0x2::coin::split<T1>(&mut arg1, v2, arg2);
        if (0x2::coin::value<T1>(&arg1) == 0) {
            0x2::coin::destroy_zero<T1>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, v6);
        };
        let v8 = v2 * 250 / 10000;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v7, v8, arg2), @0x5077e43c411dec5ef5464ae9b337c2644d0300140b9caecad860a14fd7a22711);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v3);
        let v9 = Sold{
            listing_id : 0x2::object::uid_to_inner(&v5),
            item_id    : 0x2::object::id<T0>(&v4),
            price      : v2,
            seller     : v3,
            buyer      : v6,
        };
        0x2::event::emit<Sold>(v9);
        0x2::transfer::public_transfer<T0>(v4, v6);
        0x2::object::delete(v5);
    }

    public fun delist<T0: store + key, T1>(arg0: Listing<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            item   : v1,
            price  : _,
            seller : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::tx_context::sender(arg1) == v3, 2);
        let v6 = Delisted{
            listing_id : 0x2::object::uid_to_inner(&v5),
            item_id    : 0x2::object::id<T0>(&v4),
            seller     : v3,
        };
        0x2::event::emit<Delisted>(v6);
        0x2::transfer::public_transfer<T0>(v4, v3);
        0x2::object::delete(v5);
    }

    public fun list<T0: store + key, T1>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing<T0, T1>{
            id     : 0x2::object::new(arg2),
            item   : arg0,
            price  : arg1,
            seller : 0x2::tx_context::sender(arg2),
        };
        let v1 = Listed{
            listing_id : 0x2::object::id<Listing<T0, T1>>(&v0),
            item_id    : 0x2::object::id<T0>(&v0.item),
            price      : arg1,
            seller     : v0.seller,
        };
        0x2::event::emit<Listed>(v1);
        0x2::transfer::share_object<Listing<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

