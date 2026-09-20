module 0x56249f0318d6f9e2435e7e86fb5eb457cf86f03075809f438371ba39f37be347::market {
    struct Listing<T0: store + key> has key {
        id: 0x2::object::UID,
        seller: address,
        price: u64,
        nft: T0,
    }

    struct Listed has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
    }

    struct Sold has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
    }

    struct Delisted has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
    }

    public entry fun buy<T0: store + key>(arg0: Listing<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            seller : v1,
            price  : v2,
            nft    : v3,
        } = arg0;
        let v4 = v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v2, 0);
        let v5 = 0x2::tx_context::sender(arg2);
        let v6 = v2 * 300 / 10000;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v6, arg2), @0x9a04278869e706fc3ade67acd74c59f9413d3ba505a456ca60ea23ec92ca6692);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        0x2::transfer::public_transfer<T0>(v3, v5);
        let v7 = Sold{
            listing_id : 0x2::object::uid_to_inner(&v4),
            seller     : v1,
            buyer      : v5,
            price      : v2,
        };
        0x2::event::emit<Sold>(v7);
        0x2::object::delete(v4);
    }

    public entry fun cancel<T0: store + key>(arg0: Listing<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            seller : v1,
            price  : _,
            nft    : v3,
        } = arg0;
        let v4 = v0;
        assert!(0x2::tx_context::sender(arg1) == v1, 1);
        0x2::transfer::public_transfer<T0>(v3, v1);
        let v5 = Delisted{
            listing_id : 0x2::object::uid_to_inner(&v4),
            seller     : v1,
        };
        0x2::event::emit<Delisted>(v5);
        0x2::object::delete(v4);
    }

    public entry fun list<T0: store + key>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::new(arg2);
        let v2 = Listed{
            listing_id : 0x2::object::uid_to_inner(&v1),
            seller     : v0,
            price      : arg1,
            nft_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            nft_id     : 0x2::object::id<T0>(&arg0),
        };
        0x2::event::emit<Listed>(v2);
        let v3 = Listing<T0>{
            id     : v1,
            seller : v0,
            price  : arg1,
            nft    : arg0,
        };
        0x2::transfer::share_object<Listing<T0>>(v3);
    }

    public fun price<T0: store + key>(arg0: &Listing<T0>) : u64 {
        arg0.price
    }

    public fun seller<T0: store + key>(arg0: &Listing<T0>) : address {
        arg0.seller
    }

    // decompiled from Move bytecode v6
}

