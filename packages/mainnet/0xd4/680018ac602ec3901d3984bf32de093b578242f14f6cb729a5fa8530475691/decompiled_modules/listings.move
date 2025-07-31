module 0xd4680018ac602ec3901d3984bf32de093b578242f14f6cb729a5fa8530475691::listings {
    struct BuyEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct ListEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct NftDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RelistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct Store has key {
        id: 0x2::object::UID,
    }

    struct UnlistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    public fun buy<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        buy_<T0>(arg0, arg1, arg2, 0, arg3);
    }

    fun buy_<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) == v1.price, 1);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = NftDfKey{dummy_field: false};
        let v4 = 0x2::dynamic_object_field::remove<NftDfKey, T0>(&mut v1.id, v3);
        let Listing {
            id          : v5,
            seller      : v6,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        } = v1;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<T0>(v4, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v8, arg4), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v7 - arg3 - v8, arg4), v6);
        let v10 = BuyEvent{
            listing_id  : arg1,
            nft_id      : 0x2::object::id<T0>(&v4),
            nft_type    : *0x1::type_name::borrow_string(&v0),
            seller      : v6,
            buyer       : v2,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        };
        0x2::event::emit<BuyEvent>(v10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut Store, arg1: T0, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < arg2, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = Listing{
            id          : 0x2::object::new(arg5),
            seller      : v0,
            price       : arg2,
            commission  : arg3,
            beneficiary : arg4,
        };
        let v3 = NftDfKey{dummy_field: false};
        0x2::dynamic_object_field::add<NftDfKey, T0>(&mut v2.id, v3, arg1);
        let v4 = 0x2::object::id<Listing>(&v2);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v4, v2);
        let v5 = ListEvent{
            listing_id  : v4,
            nft_id      : 0x2::object::id<T0>(&arg1),
            nft_type    : *0x1::type_name::borrow_string(&v1),
            seller      : v0,
            price       : arg2,
            commission  : arg3,
            beneficiary : arg4,
        };
        0x2::event::emit<ListEvent>(v5);
    }

    public fun relist<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < arg2, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg5) == v0.seller, 0);
        let v1 = 0x1::type_name::get<T0>();
        v0.price = arg2;
        v0.commission = arg3;
        v0.beneficiary = arg4;
        let v2 = NftDfKey{dummy_field: false};
        let v3 = RelistEvent{
            listing_id  : 0x2::object::id<Listing>(v0),
            nft_id      : 0x2::object::id<T0>(0x2::dynamic_object_field::borrow<NftDfKey, T0>(&mut v0.id, v2)),
            nft_type    : *0x1::type_name::borrow_string(&v1),
            seller      : v0.seller,
            price       : arg2,
            commission  : arg3,
            beneficiary : arg4,
        };
        0x2::event::emit<RelistEvent>(v3);
    }

    public fun unlist<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.seller, 0);
        let v1 = NftDfKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<NftDfKey, T0>(&mut v0.id, v1);
        let v3 = 0x1::type_name::get<T0>();
        let Listing {
            id          : v4,
            seller      : v5,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<T0>(v2, v5);
        let v9 = UnlistEvent{
            listing_id  : arg1,
            nft_id      : 0x2::object::id<T0>(&v2),
            nft_type    : *0x1::type_name::borrow_string(&v3),
            seller      : v5,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        };
        0x2::event::emit<UnlistEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

