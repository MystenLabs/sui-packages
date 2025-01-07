module 0x149f5806b4c06e9295d0bf013924b202aff2ab2ce53864938701d0d37f5d43d4::seed_nft {
    struct SeedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        nft_url: 0x2::url::Url,
        owner: address,
        referal: address,
        royalty_address: address,
    }

    struct Creators has store, key {
        id: 0x2::object::UID,
    }

    struct Creator has copy, drop, store {
        creator_address: address,
        creator_share: u64,
    }

    struct NFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
    }

    struct List<T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        nft: T0,
        price: u64,
        target_price: u64,
        auction_expire_datetime: u64,
    }

    struct NFTListedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        price: u64,
    }

    struct NFTUnlistedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    struct Bids has key {
        id: 0x2::object::UID,
    }

    struct Bid has store {
        bidder: address,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TransferCounts has store, key {
        id: 0x2::object::UID,
    }

    public entry fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: &mut TransferCounts, arg2: &mut Creators, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let List {
            id                      : v0,
            seller                  : v1,
            nft                     : v2,
            price                   : v3,
            target_price            : _,
            auction_expire_datetime : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, List<T0>>(&mut arg0.id, arg3);
        assert!(0x2::tx_context::sender(arg5) != v1, 126);
        let v6 = 0;
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg1.id, arg3)) {
            v6 = *0x2::dynamic_field::borrow<0x2::object::ID, u64>(&arg1.id, arg3);
        };
        let v7 = *0x2::dynamic_field::borrow<0x2::object::ID, vector<Creator>>(&arg2.id, arg3);
        if (v6 == 0) {
            let v8 = 0;
            while (v8 < 0x1::vector::length<Creator>(&v7)) {
                let v9 = *0x1::vector::borrow<Creator>(&v7, v8);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v3 * 980 / 1000 * v9.creator_share / 10000, arg5), v9.creator_address);
                v8 = v8 + 1;
            };
        };
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v2, 0x2::tx_context::sender(arg5));
        0x2::dynamic_field::add<0x2::object::ID, u64>(&mut arg1.id, arg3, v6 + 1);
    }

    public entry fun create_Creators(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Creators{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Creators>(v0);
    }

    public entry fun create_TransferCounts(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferCounts{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TransferCounts>(v0);
    }

    public entry fun create_bids(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bids{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Bids>(v0);
    }

    public entry fun create_marketplace(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Marketplace>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = List<T0>{
            id                      : 0x2::object::new(arg5),
            seller                  : 0x2::tx_context::sender(arg5),
            nft                     : arg1,
            price                   : arg2,
            target_price            : arg3,
            auction_expire_datetime : arg4,
        };
        0x2::dynamic_field::add<0x2::object::ID, List<T0>>(&mut arg0.id, 0x2::object::id<T0>(&arg1), v0);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: address, arg6: &mut Creators, arg7: vector<address>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8), 2001);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::vector::empty<Creator>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg7)) {
            let v3 = Creator{
                creator_address : *0x1::vector::borrow<address>(&arg7, v2),
                creator_share   : *0x1::vector::borrow<u64>(&arg8, v2),
            };
            0x1::vector::push_back<Creator>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = SeedNFT{
            id              : 0x2::object::new(arg9),
            name            : 0x1::string::utf8(arg0),
            description     : 0x1::string::utf8(arg1),
            url             : 0x2::url::new_unsafe_from_bytes(arg2),
            nft_url         : 0x2::url::new_unsafe_from_bytes(arg3),
            owner           : v0,
            referal         : arg4,
            royalty_address : arg5,
        };
        0x2::dynamic_field::add<0x2::object::ID, vector<Creator>>(&mut arg6.id, 0x2::object::id<SeedNFT>(&v4), v1);
        let v5 = NFTMintedEvent{
            object_id : 0x2::object::id<SeedNFT>(&v4),
            creator   : v0,
            name      : v4.name,
        };
        0x2::event::emit<NFTMintedEvent>(v5);
        0x2::transfer::public_transfer<SeedNFT>(v4, v0);
    }

    public entry fun unlist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let List {
            id                      : v0,
            seller                  : v1,
            nft                     : v2,
            price                   : _,
            target_price            : _,
            auction_expire_datetime : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, List<T0>>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v1, 3001);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v2, v1);
    }

    // decompiled from Move bytecode v6
}

