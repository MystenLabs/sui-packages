module 0x5c2af8af33eda5a490da33687dad2cbd7ac5a8059da1e6a3f43ccfb679367977::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        fee_bps: u16,
        fee_recipient: address,
    }

    struct ListingKey has copy, drop, store {
        item_id: 0x2::object::ID,
    }

    struct Listing<T0: store + key> has store, key {
        id: 0x2::object::UID,
        item: T0,
        seller: address,
        price: u64,
        created_ms: u64,
    }

    entry fun buy<T0: store + key>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingKey{item_id: arg1};
        let Listing {
            id         : v1,
            item       : v2,
            seller     : v3,
            price      : v4,
            created_ms : _,
        } = 0x2::dynamic_field::remove<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        0x2::object::delete(v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v4, 2);
        let v6 = v4 * (arg0.fee_bps as u64) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4 - v6, arg3), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v6, arg3), arg0.fee_recipient);
        let v7 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v7);
        0x2::transfer::public_transfer<T0>(v2, v7);
    }

    entry fun create_market(arg0: u16, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            id            : 0x2::object::new(arg2),
            fee_bps       : arg0,
            fee_recipient : arg1,
        };
        0x2::transfer::public_share_object<Market>(v0);
    }

    entry fun delist<T0: store + key>(arg0: &mut Market, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        let v0 = ListingKey{item_id: arg1};
        let Listing {
            id         : v1,
            item       : v2,
            seller     : v3,
            price      : _,
            created_ms : _,
        } = 0x2::dynamic_field::remove<ListingKey, Listing<T0>>(&mut arg0.id, v0);
        0x2::object::delete(v1);
        let v6 = 0x2::tx_context::sender(arg2);
        assert!(v6 == v3, 1);
        0x2::transfer::public_transfer<T0>(v2, v6);
    }

    entry fun list<T0: store + key>(arg0: &mut Market, arg1: T0, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = ListingKey{item_id: 0x2::object::id<T0>(&arg1)};
        let v1 = Listing<T0>{
            id         : 0x2::object::new(arg4),
            item       : arg1,
            seller     : 0x2::tx_context::sender(arg4),
            price      : arg2,
            created_ms : arg3,
        };
        0x2::dynamic_field::add<ListingKey, Listing<T0>>(&mut arg0.id, v0, v1);
    }

    entry fun set_fee(arg0: &mut Market, arg1: u16) {
        arg0.fee_bps = arg1;
    }

    // decompiled from Move bytecode v6
}

