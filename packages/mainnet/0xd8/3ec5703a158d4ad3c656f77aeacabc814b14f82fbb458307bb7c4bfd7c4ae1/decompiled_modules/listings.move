module 0xd83ec5703a158d4ad3c656f77aeacabc814b14f82fbb458307bb7c4bfd7c4ae1::listings {
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

