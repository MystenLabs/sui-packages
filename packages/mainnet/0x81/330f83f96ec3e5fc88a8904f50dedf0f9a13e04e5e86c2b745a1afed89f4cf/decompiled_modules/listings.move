module 0x81330f83f96ec3e5fc88a8904f50dedf0f9a13e04e5e86c2b745a1afed89f4cf::listings {
    struct NftDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct ListEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct UnlistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct BuyEvent has copy, drop {
        listing_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    public fun buy<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, 0x2::object::ID) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) == v0.price, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = NftDfKey{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::remove<NftDfKey, T0>(&mut v0.id, v2);
        let v4 = 0x2::object::id<T0>(&v3);
        let Listing {
            id          : v5,
            seller      : v6,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        } = v0;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<T0>(v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v8, arg3), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v7 - v8, arg3), v6);
        let v10 = BuyEvent{
            listing_id  : arg1,
            nft_id      : v4,
            seller      : v6,
            buyer       : v1,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        };
        0x2::event::emit<BuyEvent>(v10);
        (v4, v7, arg1)
    }

    public fun buy_with_ob_request<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) == v0.price, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = NftDfKey{dummy_field: false};
        let v3 = 0x2::dynamic_object_field::remove<NftDfKey, T0>(&mut v0.id, v2);
        let v4 = 0x2::object::id<T0>(&v3);
        let Listing {
            id          : v5,
            seller      : v6,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        } = v0;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<T0>(v3, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v8, arg3), v9);
        let v10 = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::new<T0>(v4, v6, arg1, v7, arg3);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v10, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v7 - v8, arg3)), v6);
        let v11 = BuyEvent{
            listing_id  : arg1,
            nft_id      : v4,
            seller      : v6,
            buyer       : v1,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        };
        0x2::event::emit<BuyEvent>(v11);
        v10
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut Store, arg1: T0, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < arg2, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Listing{
            id          : 0x2::object::new(arg5),
            seller      : v0,
            price       : arg2,
            commission  : arg3,
            beneficiary : arg4,
        };
        let v2 = NftDfKey{dummy_field: false};
        0x2::dynamic_object_field::add<NftDfKey, T0>(&mut v1.id, v2, arg1);
        let v3 = 0x2::object::id<Listing>(&v1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v3, v1);
        let v4 = ListEvent{
            listing_id  : v3,
            nft_id      : 0x2::object::id<T0>(&arg1),
            seller      : v0,
            price       : arg2,
            commission  : arg3,
            beneficiary : arg4,
        };
        0x2::event::emit<ListEvent>(v4);
    }

    public fun unlist<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.seller, 0);
        let v1 = NftDfKey{dummy_field: false};
        let v2 = 0x2::dynamic_object_field::remove<NftDfKey, T0>(&mut v0.id, v1);
        let Listing {
            id          : v3,
            seller      : v4,
            price       : v5,
            commission  : v6,
            beneficiary : v7,
        } = v0;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<T0>(v2, v4);
        let v8 = UnlistEvent{
            listing_id  : arg1,
            nft_id      : 0x2::object::id<T0>(&v2),
            seller      : v4,
            price       : v5,
            commission  : v6,
            beneficiary : v7,
        };
        0x2::event::emit<UnlistEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

