module 0x73613282c21c69ed56f9a61cce389f41e947c6ac2e4365474af6b6f8690b8eae::listings {
    struct NftDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct ListEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct UnlistEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct BuyEvent has copy, drop {
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    public fun list<T0: store + key>(arg0: T0, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < arg1, 0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = Listing{
            id          : 0x2::object::new(arg4),
            nft_type    : v1,
            seller      : v2,
            price       : arg1,
            commission  : arg2,
            beneficiary : arg3,
        };
        let v4 = NftDfKey{dummy_field: false};
        0x2::dynamic_object_field::add<NftDfKey, T0>(&mut v3.id, v4, arg0);
        let v5 = ListEvent{
            nft_type    : v1,
            nft_id      : 0x2::object::id<T0>(&arg0),
            seller      : v2,
            price       : arg1,
            commission  : arg2,
            beneficiary : arg3,
        };
        0x2::event::emit<ListEvent>(v5);
        0x2::transfer::share_object<Listing>(v3);
    }

    // decompiled from Move bytecode v6
}

