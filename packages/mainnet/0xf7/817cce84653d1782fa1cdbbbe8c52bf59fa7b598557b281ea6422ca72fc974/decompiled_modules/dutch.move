module 0xf7817cce84653d1782fa1cdbbbe8c52bf59fa7b598557b281ea6422ca72fc974::dutch {
    struct Auction<T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        item: T0,
        start_price: u64,
        floor_price: u64,
        start_ms: u64,
        end_ms: u64,
        seller: address,
    }

    struct Listed has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        start_price: u64,
        floor_price: u64,
        start_ms: u64,
        end_ms: u64,
        seller: address,
    }

    struct Sold has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct Delisted has copy, drop {
        auction_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
    }

    public fun buy<T0: store + key, T1>(arg0: Auction<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = current_price<T0, T1>(&arg0, arg2);
        let Auction {
            id          : v1,
            item        : v2,
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
        let v13 = Sold{
            auction_id : 0x2::object::uid_to_inner(&v9),
            item_id    : 0x2::object::id<T0>(&v8),
            price      : v0,
            seller     : v7,
            buyer      : v10,
        };
        0x2::event::emit<Sold>(v13);
        0x2::transfer::public_transfer<T0>(v8, v10);
        0x2::object::delete(v9);
    }

    public fun current_price<T0: store + key, T1>(arg0: &Auction<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        price_at(arg0.start_price, arg0.floor_price, arg0.start_ms, arg0.end_ms, 0x2::clock::timestamp_ms(arg1))
    }

    public fun delist<T0: store + key, T1>(arg0: Auction<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let Auction {
            id          : v0,
            item        : v1,
            start_price : _,
            floor_price : _,
            start_ms    : _,
            end_ms      : _,
            seller      : v6,
        } = arg0;
        let v7 = v1;
        let v8 = v0;
        assert!(0x2::tx_context::sender(arg1) == v6, 2);
        let v9 = Delisted{
            auction_id : 0x2::object::uid_to_inner(&v8),
            item_id    : 0x2::object::id<T0>(&v7),
            seller     : v6,
        };
        0x2::event::emit<Delisted>(v9);
        0x2::transfer::public_transfer<T0>(v7, v6);
        0x2::object::delete(v8);
    }

    public fun list<T0: store + key, T1>(arg0: T0, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg1 >= arg2, 3);
        assert!(arg3 >= 3600000 && arg3 <= 2592000000, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Auction<T0, T1>{
            id          : 0x2::object::new(arg5),
            item        : arg0,
            start_price : arg1,
            floor_price : arg2,
            start_ms    : v0,
            end_ms      : v0 + arg3,
            seller      : 0x2::tx_context::sender(arg5),
        };
        let v2 = Listed{
            auction_id  : 0x2::object::id<Auction<T0, T1>>(&v1),
            item_id     : 0x2::object::id<T0>(&v1.item),
            start_price : arg1,
            floor_price : arg2,
            start_ms    : v0,
            end_ms      : v1.end_ms,
            seller      : v1.seller,
        };
        0x2::event::emit<Listed>(v2);
        0x2::transfer::share_object<Auction<T0, T1>>(v1);
    }

    public fun price_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 >= arg3) {
            return arg1
        };
        if (arg4 <= arg2) {
            return arg0
        };
        arg0 - ((((arg0 - arg1) as u128) * ((arg4 - arg2) as u128) / ((arg3 - arg2) as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

