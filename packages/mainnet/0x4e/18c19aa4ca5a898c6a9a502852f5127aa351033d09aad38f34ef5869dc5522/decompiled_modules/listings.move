module 0x4e18c19aa4ca5a898c6a9a502852f5127aa351033d09aad38f34ef5869dc5522::listings {
    struct NftDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Listing has key {
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

    public fun list<T0: store + key>(arg0: T0, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < arg1, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Listing{
            id          : 0x2::object::new(arg4),
            seller      : v0,
            price       : arg1,
            commission  : arg2,
            beneficiary : arg3,
        };
        let v2 = NftDfKey{dummy_field: false};
        0x2::dynamic_object_field::add<NftDfKey, T0>(&mut v1.id, v2, arg0);
        let v3 = ListEvent{
            listing_id  : 0x2::object::id<Listing>(&v1),
            nft_id      : 0x2::object::id<T0>(&arg0),
            seller      : v0,
            price       : arg1,
            commission  : arg2,
            beneficiary : arg3,
        };
        0x2::event::emit<ListEvent>(v3);
        0x2::transfer::share_object<Listing>(v1);
    }

    public fun unlist<T0: store + key>(arg0: Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 0);
        let v0 = NftDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_object_field::remove<NftDfKey, T0>(&mut arg0.id, v0);
        let Listing {
            id          : v2,
            seller      : v3,
            price       : v4,
            commission  : v5,
            beneficiary : v6,
        } = arg0;
        0x2::object::delete(v2);
        let v7 = UnlistEvent{
            listing_id  : 0x2::object::id<Listing>(&arg0),
            nft_id      : 0x2::object::id<T0>(&v1),
            seller      : v3,
            price       : v4,
            commission  : v5,
            beneficiary : v6,
        };
        0x2::event::emit<UnlistEvent>(v7);
        0x2::transfer::public_transfer<T0>(v1, v3);
    }

    // decompiled from Move bytecode v6
}

