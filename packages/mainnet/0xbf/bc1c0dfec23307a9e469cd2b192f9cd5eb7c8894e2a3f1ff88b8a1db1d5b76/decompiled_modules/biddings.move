module 0xbfbc1c0dfec23307a9e469cd2b192f9cd5eb7c8894e2a3f1ff88b8a1db1d5b76::biddings {
    struct Store has key {
        id: 0x2::object::UID,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        buyer: address,
        price: u64,
        wallet: 0x2::coin::Coin<0x2::sui::SUI>,
        commission: u64,
        beneficiary: address,
    }

    struct CreateBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CreateCollectionBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CancelCollectionBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct MatchBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct MatchCollectionBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    public fun accept_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v1) == v0.nft_type, 1);
        let v2 = 0x2::object::id<T0>(&arg2);
        let v3 = v0.nft_id;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v3) == v2, 1);
        };
        let v4 = 0x2::tx_context::sender(arg3);
        let Bid {
            id          : v5,
            nft_type    : v6,
            nft_id      : _,
            buyer       : v8,
            price       : v9,
            wallet      : v10,
            commission  : v11,
            beneficiary : v12,
        } = v0;
        let v13 = v10;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<T0>(arg2, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v11, arg3), v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v9, arg3), v4);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v13);
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v14 = MatchBidEvent{
                bid_id      : arg1,
                nft_type    : v6,
                nft_id      : v2,
                seller      : v4,
                buyer       : v8,
                price       : v9,
                commission  : v11,
                beneficiary : v12,
            };
            0x2::event::emit<MatchBidEvent>(v14);
        } else {
            let v15 = MatchCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v6,
                nft_id      : v2,
                seller      : v4,
                buyer       : v8,
                price       : v9,
                commission  : v11,
                beneficiary : v12,
            };
            0x2::event::emit<MatchCollectionBidEvent>(v15);
        };
    }

    public fun bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        bid_<T0>(arg0, 0x1::option::some<0x2::object::ID>(arg1), arg2, arg3, arg4, arg5, arg6);
    }

    fun bid_<T0: store + key>(arg0: &mut Store, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) == arg2 + arg4, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = Bid{
            id          : 0x2::object::new(arg6),
            nft_type    : v1,
            nft_id      : arg1,
            buyer       : v2,
            price       : arg2,
            wallet      : 0x2::coin::split<0x2::sui::SUI>(arg3, arg2 + arg4, arg6),
            commission  : arg4,
            beneficiary : arg5,
        };
        let v4 = 0x2::object::id<Bid>(&v3);
        0x2::dynamic_object_field::add<0x2::object::ID, Bid>(&mut arg0.id, v4, v3);
        if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            let v5 = CreateBidEvent{
                bid_id      : v4,
                nft_type    : v1,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&arg1),
                buyer       : v2,
                price       : arg2,
                commission  : arg4,
                beneficiary : arg5,
            };
            0x2::event::emit<CreateBidEvent>(v5);
        } else {
            let v6 = CreateCollectionBidEvent{
                bid_id      : v4,
                nft_type    : v1,
                buyer       : v2,
                price       : arg2,
                commission  : arg4,
                beneficiary : arg5,
            };
            0x2::event::emit<CreateCollectionBidEvent>(v6);
        };
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.buyer, 0);
        let Bid {
            id          : v1,
            nft_type    : v2,
            nft_id      : v3,
            buyer       : v4,
            price       : v5,
            wallet      : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        let v9 = v3;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v4);
        if (0x1::option::is_some<0x2::object::ID>(&v9)) {
            let v10 = CancelBidEvent{
                bid_id      : arg1,
                nft_type    : v2,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&v9),
                buyer       : v4,
                price       : v5,
                commission  : v7,
                beneficiary : v8,
            };
            0x2::event::emit<CancelBidEvent>(v10);
        } else {
            let v11 = CancelCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v2,
                buyer       : v4,
                price       : v5,
                commission  : v7,
                beneficiary : v8,
            };
            0x2::event::emit<CancelCollectionBidEvent>(v11);
        };
    }

    public fun collection_bid<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        bid_<T0>(arg0, 0x1::option::none<0x2::object::ID>(), arg1, arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
    }

    public fun ob_accept_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::collection::Collection<T0>, arg4: &mut 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::BpsRoyaltyStrategy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v1) == v0.nft_type, 1);
        let v2 = 0x2::object::id<T0>(&arg2);
        let v3 = v0.nft_id;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v3) == v2, 1);
        };
        let v4 = 0x2::tx_context::sender(arg5);
        let Bid {
            id          : v5,
            nft_type    : v6,
            nft_id      : _,
            buyer       : v8,
            price       : v9,
            wallet      : v10,
            commission  : v11,
            beneficiary : v12,
        } = v0;
        let v13 = v10;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<T0>(arg2, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v11, arg5), v12);
        let v14 = 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty_strategy_bps::calculate<T0>(arg4, 0x2::coin::value<0x2::sui::SUI>(&mut v13));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v9 - v14, arg5), v4);
        0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::royalty::collect_royalty<T0, 0x2::sui::SUI>(arg3, 0x2::coin::balance_mut<0x2::sui::SUI>(&mut v13), v14);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v13);
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            let v15 = MatchBidEvent{
                bid_id      : arg1,
                nft_type    : v6,
                nft_id      : v2,
                seller      : v4,
                buyer       : v8,
                price       : v9,
                commission  : v11,
                beneficiary : v12,
            };
            0x2::event::emit<MatchBidEvent>(v15);
        } else {
            let v16 = MatchCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v6,
                nft_id      : v2,
                seller      : v4,
                buyer       : v8,
                price       : v9,
                commission  : v11,
                beneficiary : v12,
            };
            0x2::event::emit<MatchCollectionBidEvent>(v16);
        };
    }

    // decompiled from Move bytecode v6
}

