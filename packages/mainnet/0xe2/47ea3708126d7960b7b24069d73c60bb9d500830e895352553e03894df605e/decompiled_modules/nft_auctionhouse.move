module 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::nft_auctionhouse {
    struct NFT_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        marketplace: 0x2::object::ID,
        direct_offers: 0x2::object::UID,
        nft_escrows: 0x2::object::UID,
        expired_offers: 0x2::object::UID,
    }

    struct DirectOfferKey has copy, drop, store {
        nft_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct EscrowKey has copy, drop, store {
        offer_id: 0x2::object::ID,
        type_marker: vector<u8>,
    }

    struct ExpiredOfferKey has copy, drop, store {
        offer_id: 0x2::object::ID,
        expiration: u64,
    }

    struct ExpiredOfferMarker has store, key {
        id: 0x2::object::UID,
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
        offerer: address,
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
        reason: vector<u8>,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun accept_native_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::coin::Coin<0x2::sui::SUI>) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::epoch(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = create_direct_offer_key<T0, T1>(arg2);
        assert!(0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v2), 5);
        let DirectNftOffer {
            id               : v3,
            offerer          : v4,
            offered_nft_id   : v5,
            requested_nft_id : v6,
            status           : v7,
            fee              : v8,
            created_at       : _,
            expires_at       : v10,
        } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v2);
        let v11 = v3;
        assert!(v0 <= v10, 12);
        assert!(v7 == 0, 2);
        assert!(0x2::object::id<T1>(&arg3) == v6, 3);
        validate_not_self_trade(v4, v1);
        let v12 = 0x2::object::uid_to_inner(&v11);
        let v13 = create_expired_offer_key(v12, v10);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v13)) {
            let ExpiredOfferMarker { id: v14 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v13);
            0x2::object::delete(v14);
        };
        let v15 = &mut arg4;
        0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v16 = create_escrow_key<T0>(v12);
        assert!(0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v16), 10);
        let NftEscrow {
            id         : v17,
            nft        : v18,
            created_at : _,
            offerer    : _,
        } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v16);
        0x2::object::delete(v11);
        0x2::object::delete(v17);
        0x2::transfer::public_transfer<T1>(arg3, v4);
        let v21 = DirectNftOfferAccepted{
            receiver        : v1,
            sender          : v4,
            offered_nft_id  : v5,
            received_nft_id : v6,
            fee_paid        : v8,
            timestamp       : v0,
        };
        0x2::event::emit<DirectNftOfferAccepted>(v21);
        (v18, handle_fee_payment(v15, v8, arg5))
    }

    public entry fun accept_native_nft_offer_entry<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
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
            expires_at       : v8,
        } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v0);
        let v9 = v1;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        assert!(v5 == 0, 2);
        let v10 = 0x2::object::uid_to_inner(&v9);
        let v11 = create_expired_offer_key(v10, v8);
        if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v11)) {
            let ExpiredOfferMarker { id: v12 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v11);
            0x2::object::delete(v12);
        };
        let v13 = create_escrow_key<T0>(v10);
        assert!(0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v13), 10);
        let NftEscrow {
            id         : v14,
            nft        : v15,
            created_at : _,
            offerer    : _,
        } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v13);
        0x2::object::delete(v9);
        0x2::object::delete(v14);
        let v18 = DirectNftOfferCancelled{
            offerer          : v2,
            offered_nft_id   : v3,
            requested_nft_id : v4,
            timestamp        : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<DirectNftOfferCancelled>(v18);
        v15
    }

    public entry fun cleanup_direct_offer_entry<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        cleanup_expired_direct_offer<T0, T1>(arg0, arg2, arg3);
    }

    public fun cleanup_expired_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = create_direct_offer_key<T0, T1>(arg1);
        if (0x2::dynamic_object_field::exists_with_type<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v1)) {
            if (0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v1).expires_at <= v0) {
                let DirectNftOffer {
                    id               : v2,
                    offerer          : v3,
                    offered_nft_id   : v4,
                    requested_nft_id : _,
                    status           : _,
                    fee              : _,
                    created_at       : _,
                    expires_at       : v9,
                } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v1);
                let v10 = v2;
                let v11 = 0x2::object::uid_to_inner(&v10);
                let v12 = create_expired_offer_key(v11, v9);
                if (0x2::dynamic_object_field::exists_with_type<ExpiredOfferKey, ExpiredOfferMarker>(&arg0.expired_offers, v12)) {
                    let ExpiredOfferMarker { id: v13 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v12);
                    0x2::object::delete(v13);
                };
                let v14 = create_escrow_key<T0>(v11);
                if (0x2::dynamic_object_field::exists_with_type<EscrowKey, NftEscrow<T0>>(&arg0.nft_escrows, v14)) {
                    let NftEscrow {
                        id         : v15,
                        nft        : v16,
                        created_at : _,
                        offerer    : _,
                    } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v14);
                    0x2::object::delete(v15);
                    0x2::transfer::public_transfer<T0>(v16, v3);
                };
                0x2::object::delete(v10);
                let v19 = OfferExpired{
                    offer_id  : v11,
                    nft_id    : v4,
                    timestamp : v0,
                };
                0x2::event::emit<OfferExpired>(v19);
            };
        };
    }

    public entry fun create_and_share_nft_auctionhouse_store(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<NFT_Auctionhouse_Store>(create_nft_auctionhouse(arg0, arg1));
    }

    fun create_direct_offer_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID) : DirectOfferKey {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"DirectNftOffer_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T0>());
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T1>());
        DirectOfferKey{
            nft_id      : arg0,
            type_marker : v0,
        }
    }

    fun create_escrow_key<T0: store + key>(arg0: 0x2::object::ID) : EscrowKey {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"NftEscrow_");
        0x1::vector::append<u8>(&mut v0, type_name_bytes<T0>());
        EscrowKey{
            offer_id    : arg0,
            type_marker : v0,
        }
    }

    fun create_expired_offer_key(arg0: 0x2::object::ID, arg1: u64) : ExpiredOfferKey {
        ExpiredOfferKey{
            offer_id   : arg0,
            expiration : arg1,
        }
    }

    public fun create_native_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::tx_context::epoch(arg5);
        validate_fee(arg3);
        let v3 = v2 + validate_duration(arg4);
        let v4 = create_direct_offer_key<T0, T1>(v1);
        assert!(!0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v4), 11);
        let v5 = 0x2::object::new(arg5);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = DirectNftOffer<T0, T1>{
            id               : v5,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            status           : 0,
            fee              : arg3,
            created_at       : v2,
            expires_at       : v3,
        };
        let v8 = NftEscrow<T0>{
            id         : 0x2::object::new(arg5),
            nft        : arg1,
            created_at : v2,
            offerer    : v0,
        };
        0x2::dynamic_object_field::add<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v4, v7);
        0x2::dynamic_object_field::add<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, create_escrow_key<T0>(v6), v8);
        track_offer_expiration(arg0, v6, v3, arg5);
        let v9 = DirectNftOfferCreated{
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            fee              : arg3,
            expires_at       : v3,
            timestamp        : v2,
        };
        0x2::event::emit<DirectNftOfferCreated>(v9);
    }

    public fun create_nft_auctionhouse(arg0: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : NFT_Auctionhouse_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg0, v0), 7);
        let v1 = NFT_Auctionhouse_Store{
            id             : 0x2::object::new(arg1),
            marketplace    : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            direct_offers  : 0x2::object::new(arg1),
            nft_escrows    : 0x2::object::new(arg1),
            expired_offers : 0x2::object::new(arg1),
        };
        let v2 = NFTAuctionhouseStoreCreated{
            creator        : v0,
            marketplace_id : 0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg0),
            timestamp      : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<NFTAuctionhouseStoreCreated>(v2);
        v1
    }

    public fun direct_offer_exists<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, create_direct_offer_key<T0, T1>(arg1))
    }

    public entry fun emergency_reset_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        validate_auction_house(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::is_admin(arg1, v0), 7);
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
                expires_at       : v9,
            } = 0x2::dynamic_object_field::remove<DirectOfferKey, DirectNftOffer<T0, T1>>(&mut arg0.direct_offers, v1);
            let v10 = v2;
            let v11 = 0x2::object::uid_to_inner(&v10);
            let v12 = create_expired_offer_key(v11, v9);
            if (0x2::dynamic_object_field::exists_<ExpiredOfferKey>(&arg0.expired_offers, v12)) {
                let ExpiredOfferMarker { id: v13 } = 0x2::dynamic_object_field::remove<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, v12);
                0x2::object::delete(v13);
            };
            let v14 = create_escrow_key<T0>(v11);
            if (0x2::dynamic_object_field::exists_<EscrowKey>(&arg0.nft_escrows, v14)) {
                let NftEscrow {
                    id         : v15,
                    nft        : v16,
                    created_at : _,
                    offerer    : _,
                } = 0x2::dynamic_object_field::remove<EscrowKey, NftEscrow<T0>>(&mut arg0.nft_escrows, v14);
                0x2::object::delete(v15);
                0x2::transfer::public_transfer<T0>(v16, v3);
            };
            0x2::object::delete(v10);
            let v19 = EmergencyReset{
                nft_id    : arg2,
                admin     : v0,
                timestamp : 0x2::tx_context::epoch(arg4),
                reason    : arg3,
            };
            0x2::event::emit<EmergencyReset>(v19);
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

    fun handle_fee_payment(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        assert!(v0 >= arg1, 6);
        if (v0 > arg1 && arg1 > 0) {
            0x2::coin::split<0x2::sui::SUI>(arg0, v0 - arg1, arg2)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg2)
        }
    }

    public fun is_direct_offer_expired<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u64) : bool {
        let v0 = create_direct_offer_key<T0, T1>(arg1);
        if (!0x2::dynamic_object_field::exists_<DirectOfferKey>(&arg0.direct_offers, v0)) {
            return false
        };
        arg2 > 0x2::dynamic_object_field::borrow<DirectOfferKey, DirectNftOffer<T0, T1>>(&arg0.direct_offers, v0).expires_at
    }

    fun track_offer_expiration(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ExpiredOfferMarker{id: 0x2::object::new(arg3)};
        0x2::dynamic_object_field::add<ExpiredOfferKey, ExpiredOfferMarker>(&mut arg0.expired_offers, create_expired_offer_key(arg1, arg2), v0);
    }

    fun type_name_bytes<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun validate_auction_house(arg0: &NFT_Auctionhouse_Store, arg1: &0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse) {
        assert!(0x2::object::id<0xe247ea3708126d7960b7b24069d73c60bb9d500830e895352553e03894df605e::auctionhouse::AuctionHouse>(arg1) == arg0.marketplace, 14);
    }

    fun validate_duration(arg0: u64) : u64 {
        if (arg0 == 0) {
            31536000
        } else {
            assert!(arg0 >= 3600, 13);
            assert!(arg0 <= 62208000, 13);
            arg0
        }
    }

    fun validate_fee(arg0: u64) {
        assert!(arg0 >= 0, 9);
        assert!(arg0 <= 100000000000000, 8);
    }

    fun validate_not_self_trade(arg0: address, arg1: address) {
        assert!(arg0 != arg1, 15);
    }

    // decompiled from Move bytecode v6
}

