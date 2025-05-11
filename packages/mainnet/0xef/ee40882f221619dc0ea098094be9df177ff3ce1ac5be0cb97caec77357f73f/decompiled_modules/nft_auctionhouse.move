module 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::nft_auctionhouse {
    struct NFT_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        marketplace: 0x2::object::ID,
        direct_offers: 0x2::object::UID,
        nft_escrows: 0x2::object::UID,
    }

    struct DirectOfferKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct EscrowKey has copy, drop, store {
        offer_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct DirectNftOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee: u64,
        created_at: u64,
        expires_at: u64,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
        created_at: u64,
    }

    struct NFTAuctionhouseStoreCreated has copy, drop {
        creator: address,
        marketplace_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct DirectNftOfferCreated has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct DirectNftOfferCancelled has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct DirectNftOfferAccepted has copy, drop {
        receiver: address,
        sender: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
        timestamp: u64,
    }

    struct EmergencyReset has copy, drop {
        nft_id: 0x2::object::ID,
        admin: address,
        timestamp: u64,
    }

    public fun accept_native_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = create_direct_offer_key<T0, T1>(arg2);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v1), 5);
        let DirectNftOffer {
            id               : v2,
            offerer          : v3,
            offered_nft_id   : v4,
            requested_nft_id : v5,
            status           : v6,
            fee              : v7,
            created_at       : _,
            expires_at       : v9,
        } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v1);
        let v10 = v2;
        assert!(v0 <= v9, 11);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<T1>(&arg3) == v5, 3);
        let v11 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v11 >= v7, 6);
        let v12 = if (v11 > v7 && v7 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg4, v11 - v7, arg5)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg5)
        };
        0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v13 = create_escrow_key<T0>(0x2::object::uid_to_inner(&v10));
        assert!(0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v13), 9);
        let NftEscrow {
            id         : v14,
            nft        : v15,
            created_at : _,
        } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v13);
        0x2::object::delete(v10);
        0x2::object::delete(v14);
        0x2::transfer::public_transfer<T1>(arg3, v3);
        let v17 = DirectNftOfferAccepted{
            receiver        : 0x2::tx_context::sender(arg5),
            sender          : v3,
            offered_nft_id  : v4,
            received_nft_id : v5,
            fee_paid        : v7,
            timestamp       : v0,
        };
        0x2::event::emit<DirectNftOfferAccepted>(v17);
        (v15, v12)
    }

    public entry fun accept_native_nft_offer_entry<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = accept_native_nft_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun cancel_native_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0), 5);
        let DirectNftOffer {
            id               : v1,
            offerer          : v2,
            offered_nft_id   : v3,
            requested_nft_id : v4,
            status           : v5,
            fee              : _,
            created_at       : _,
            expires_at       : _,
        } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v0);
        let v9 = v1;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        assert!(v5 == 0, 2);
        let v10 = create_escrow_key<T0>(0x2::object::uid_to_inner(&v9));
        assert!(0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v10), 9);
        let NftEscrow {
            id         : v11,
            nft        : v12,
            created_at : _,
        } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v10);
        0x2::object::delete(v9);
        0x2::object::delete(v11);
        let v14 = DirectNftOfferCancelled{
            offerer          : v2,
            offered_nft_id   : v3,
            requested_nft_id : v4,
            timestamp        : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<DirectNftOfferCancelled>(v14);
        v12
    }

    public entry fun create_and_share_nft_auctionhouse_store(arg0: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<NFT_Auctionhouse_Store>(create_nft_auctionhouse(arg0, arg1));
    }

    fun create_direct_offer_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID) : DirectOfferKey {
        DirectOfferKey{
            nft_id      : arg0,
            type_marker : b"DirectNftOffer_T1_T2",
        }
    }

    fun create_escrow_key<T0: store + key>(arg0: 0x2::object::ID) : EscrowKey {
        EscrowKey{
            offer_id    : arg0,
            type_marker : b"NftEscrow_T",
        }
    }

    public fun create_native_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::tx_context::epoch(arg5);
        let v3 = if (arg4 == 0) {
            v2 + 604800
        } else {
            v2 + arg4
        };
        let v4 = create_direct_offer_key<T0, T1>(v1);
        assert!(!0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v4), 10);
        assert!(arg3 <= 100000000000000, 8);
        let v5 = 0x2::object::new(arg5);
        let v6 = DirectNftOffer<T0, T1>{
            id               : v5,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            status           : 0,
            fee              : arg3,
            created_at       : v2,
            expires_at       : v3,
        };
        let v7 = NftEscrow<T0>{
            id         : 0x2::object::new(arg5),
            nft        : arg1,
            created_at : v2,
        };
        0x2::dynamic_object_field::add<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v4, v6);
        0x2::dynamic_object_field::add<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, create_escrow_key<T0>(0x2::object::uid_to_inner(&v5)), v7);
        let v8 = DirectNftOfferCreated{
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            fee              : arg3,
            expires_at       : v3,
            timestamp        : v2,
        };
        0x2::event::emit<DirectNftOfferCreated>(v8);
    }

    public fun create_nft_auctionhouse(arg0: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : NFT_Auctionhouse_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg0, v0), 7);
        let v1 = NFT_Auctionhouse_Store{
            id            : 0x2::object::new(arg1),
            marketplace   : 0x2::object::id<0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse>(arg0),
            direct_offers : 0x2::object::new(arg1),
            nft_escrows   : 0x2::object::new(arg1),
        };
        let v2 = NFTAuctionhouseStoreCreated{
            creator        : v0,
            marketplace_id : 0x2::object::id<0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse>(arg0),
            timestamp      : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<NFTAuctionhouseStoreCreated>(v2);
        v1
    }

    public fun direct_offer_exists<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, create_direct_offer_key<T0, T1>(arg1))
    }

    public entry fun emergency_reset_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xefee40882f221619dc0ea098094be9df177ff3ce1ac5be0cb97caec77357f73f::auctionhouse::is_admin(arg1, v0), 7);
        let v1 = create_direct_offer_key<T0, T1>(arg2);
        if (0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v1)) {
            let DirectNftOffer {
                id               : v2,
                offerer          : v3,
                offered_nft_id   : _,
                requested_nft_id : _,
                status           : _,
                fee              : _,
                created_at       : _,
                expires_at       : _,
            } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v1);
            let v10 = v2;
            let v11 = create_escrow_key<T0>(0x2::object::uid_to_inner(&v10));
            if (0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v11)) {
                let NftEscrow {
                    id         : v12,
                    nft        : v13,
                    created_at : _,
                } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v11);
                0x2::object::delete(v12);
                0x2::transfer::public_transfer<T0>(v13, v3);
            };
            0x2::object::delete(v10);
            let v15 = EmergencyReset{
                nft_id    : arg2,
                admin     : v0,
                timestamp : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<EmergencyReset>(v15);
        };
    }

    public fun get_direct_offer_expiration<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0), 5);
        0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v0).expires_at
    }

    public fun get_direct_offer_fee<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0), 5);
        0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v0).fee
    }

    public fun get_direct_offer_offerer<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : address {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0), 5);
        0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v0).offerer
    }

    public fun get_direct_offer_requested_nft<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : 0x2::object::ID {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0), 5);
        0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v0).requested_nft_id
    }

    public fun get_marketplace_id(arg0: &NFT_Auctionhouse_Store) : 0x2::object::ID {
        arg0.marketplace
    }

    public fun is_direct_offer_expired<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        if (!0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0)) {
            return false
        };
        arg2 > 0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v0).expires_at
    }

    // decompiled from Move bytecode v6
}

