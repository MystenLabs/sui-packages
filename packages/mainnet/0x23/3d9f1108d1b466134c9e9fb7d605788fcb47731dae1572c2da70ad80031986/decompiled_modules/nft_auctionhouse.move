module 0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::nft_auctionhouse {
    struct NFT_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        marketplace: 0x2::object::ID,
        deployer: address,
        nft_to_offer_index: 0x2::table::Table<0x2::object::ID, OfferInfo>,
        offer_to_nft_index: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct OfferInfo has copy, drop, store {
        offer_id: 0x2::object::ID,
        offerer: address,
        type_hash: vector<u8>,
    }

    struct DirectNftOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee_sui: u64,
        created_at_ms: u64,
        expires_at_ms: u64,
        is_processing: bool,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
        created_at_ms: u64,
        offerer: address,
        offer_id: 0x2::object::ID,
    }

    struct NFTAuctionhouseStoreCreated has copy, drop {
        store_id: 0x2::object::ID,
        marketplace_id: 0x2::object::ID,
        deployer: address,
    }

    struct DirectNftOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee_sui: u64,
        expires_at_ms: u64,
        created_at_ms: u64,
        type_hash: vector<u8>,
    }

    struct DirectNftOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        created_at_ms: u64,
    }

    struct DirectNftOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        receiver: address,
        sender: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
        timestamp_ms: u64,
    }

    struct OfferExpired has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cleaner: address,
        cleanup_timestamp_ms: u64,
    }

    public fun accept_direct_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::object::id<0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse>(arg1) == arg0.marketplace, 15);
        assert!(0x2::object::id<T1>(&arg3) != arg2, 16);
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg2), 5);
        let v2 = 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg2);
        assert!(v2.type_hash == create_type_hash<T0, T1>(), 3);
        let v3 = create_direct_offer_key<T0, T1>(arg2, v2.offerer);
        assert!(0x2::dynamic_object_field::exists_with_type<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v3), 5);
        let v4 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, DirectNftOffer<T0, T1>>(&mut arg0.id, v3);
        assert!(v4.status == 0, 2);
        assert!(!v4.is_processing, 19);
        assert!(!is_offer_expired(v4.expires_at_ms, v1), 12);
        assert!(0x2::object::id<T1>(&arg3) == v4.requested_nft_id, 3);
        assert!(v4.offerer != v0, 16);
        v4.is_processing = true;
        v4.status = 3;
        let v5 = 0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v3);
        let v6 = v5.offerer;
        let v7 = 0x2::object::uid_to_inner(&v5.id);
        let v8 = v5.requested_nft_id;
        let v9 = v5.fee_sui;
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v10 >= v9, 6);
        let v11 = if (v10 > v9 && v9 > 0) {
            0x2::coin::split<0x2::sui::SUI>(&mut arg4, v10 - v9, arg6)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg6)
        };
        0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let DirectNftOffer {
            id               : v12,
            offerer          : _,
            offered_nft_id   : _,
            requested_nft_id : _,
            status           : _,
            fee_sui          : _,
            created_at_ms    : _,
            expires_at_ms    : _,
            is_processing    : _,
        } = 0x2::dynamic_object_field::remove<vector<u8>, DirectNftOffer<T0, T1>>(&mut arg0.id, v3);
        let v21 = create_escrow_key<T0>(v7);
        assert!(0x2::dynamic_object_field::exists_with_type<vector<u8>, NftEscrow<T0>>(&arg0.id, v21), 10);
        let NftEscrow {
            id            : v22,
            nft           : v23,
            created_at_ms : _,
            offerer       : _,
            offer_id      : _,
        } = 0x2::dynamic_object_field::remove<vector<u8>, NftEscrow<T0>>(&mut arg0.id, v21);
        0x2::table::remove<0x2::object::ID, OfferInfo>(&mut arg0.nft_to_offer_index, arg2);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.offer_to_nft_index, v7);
        0x2::object::delete(v12);
        0x2::object::delete(v22);
        0x2::transfer::public_transfer<T1>(arg3, v6);
        let v27 = DirectNftOfferAccepted{
            offer_id        : v7,
            receiver        : v0,
            sender          : v6,
            offered_nft_id  : v5.offered_nft_id,
            received_nft_id : v8,
            fee_paid        : v9,
            timestamp_ms    : v1,
        };
        0x2::event::emit<DirectNftOfferAccepted>(v27);
        (v23, v11)
    }

    public entry fun accept_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = accept_direct_nft_offer<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun cancel_direct_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::clock::timestamp_ms(arg2);
        let v1 = create_direct_offer_key<T0, T1>(arg1, v0);
        assert!(0x2::dynamic_object_field::exists_with_type<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v1), 5);
        let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, DirectNftOffer<T0, T1>>(&mut arg0.id, v1);
        assert!(v0 == v2.offerer, 1);
        assert!(v2.status == 0, 2);
        assert!(!v2.is_processing, 19);
        v2.is_processing = true;
        v2.status = 3;
        let v3 = 0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v1);
        let v4 = 0x2::object::uid_to_inner(&v3.id);
        let v5 = v3.created_at_ms;
        let DirectNftOffer {
            id               : v6,
            offerer          : _,
            offered_nft_id   : _,
            requested_nft_id : _,
            status           : _,
            fee_sui          : _,
            created_at_ms    : _,
            expires_at_ms    : _,
            is_processing    : _,
        } = 0x2::dynamic_object_field::remove<vector<u8>, DirectNftOffer<T0, T1>>(&mut arg0.id, v1);
        let v15 = create_escrow_key<T0>(v4);
        assert!(0x2::dynamic_object_field::exists_with_type<vector<u8>, NftEscrow<T0>>(&arg0.id, v15), 10);
        let NftEscrow {
            id            : v16,
            nft           : v17,
            created_at_ms : _,
            offerer       : _,
            offer_id      : _,
        } = 0x2::dynamic_object_field::remove<vector<u8>, NftEscrow<T0>>(&mut arg0.id, v15);
        0x2::table::remove<0x2::object::ID, OfferInfo>(&mut arg0.nft_to_offer_index, arg1);
        0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.offer_to_nft_index, v4);
        0x2::object::delete(v6);
        0x2::object::delete(v16);
        let v21 = DirectNftOfferCancelled{
            offer_id         : v4,
            offerer          : v0,
            offered_nft_id   : v3.offered_nft_id,
            requested_nft_id : v3.requested_nft_id,
            created_at_ms    : v5,
        };
        0x2::event::emit<DirectNftOfferCancelled>(v21);
        v17
    }

    public entry fun cancel_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = cancel_direct_nft_offer<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun cleanup_expired_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1), 5);
        let v1 = create_direct_offer_key<T0, T1>(arg1, 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1).offerer);
        if (0x2::dynamic_object_field::exists_with_type<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v1);
            let v3 = 0x2::object::uid_to_inner(&v2.id);
            let v4 = v2.offered_nft_id;
            let v5 = v2.offerer;
            assert!(is_offer_expired(v2.expires_at_ms, v0), 17);
            assert!(!v2.is_processing, 19);
            let DirectNftOffer {
                id               : v6,
                offerer          : _,
                offered_nft_id   : _,
                requested_nft_id : _,
                status           : _,
                fee_sui          : _,
                created_at_ms    : _,
                expires_at_ms    : _,
                is_processing    : _,
            } = 0x2::dynamic_object_field::remove<vector<u8>, DirectNftOffer<T0, T1>>(&mut arg0.id, v1);
            let v15 = create_escrow_key<T0>(v3);
            if (0x2::dynamic_object_field::exists_with_type<vector<u8>, NftEscrow<T0>>(&arg0.id, v15)) {
                let NftEscrow {
                    id            : v16,
                    nft           : v17,
                    created_at_ms : _,
                    offerer       : _,
                    offer_id      : _,
                } = 0x2::dynamic_object_field::remove<vector<u8>, NftEscrow<T0>>(&mut arg0.id, v15);
                0x2::object::delete(v16);
                0x2::transfer::public_transfer<T0>(v17, v5);
            };
            0x2::table::remove<0x2::object::ID, OfferInfo>(&mut arg0.nft_to_offer_index, arg1);
            0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut arg0.offer_to_nft_index, v3);
            0x2::object::delete(v6);
            let v21 = OfferExpired{
                offer_id             : v3,
                nft_id               : v4,
                cleaner              : 0x2::tx_context::sender(arg3),
                cleanup_timestamp_ms : v0,
            };
            0x2::event::emit<OfferExpired>(v21);
        };
    }

    public entry fun cleanup_expired_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        cleanup_expired_direct_offer<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_and_share_nft_auctionhouse_store(arg0: &0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<NFT_Auctionhouse_Store>(create_nft_auctionhouse(arg0, arg1));
    }

    public fun create_direct_nft_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 != arg2, 16);
        validate_fee_sui(arg3);
        validate_duration(arg4);
        let v3 = safe_add_u64(v2, arg4);
        assert!(!0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, v1), 11);
        let v4 = create_direct_offer_key<T0, T1>(v1, v0);
        assert!(!0x2::dynamic_object_field::exists_with_type<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, v4), 11);
        let v5 = 0x2::object::new(arg6);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = DirectNftOffer<T0, T1>{
            id               : v5,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            status           : 0,
            fee_sui          : arg3,
            created_at_ms    : v2,
            expires_at_ms    : v3,
            is_processing    : false,
        };
        let v8 = NftEscrow<T0>{
            id            : 0x2::object::new(arg6),
            nft           : arg1,
            created_at_ms : v2,
            offerer       : v0,
            offer_id      : v6,
        };
        let v9 = create_type_hash<T0, T1>();
        0x2::dynamic_object_field::add<vector<u8>, DirectNftOffer<T0, T1>>(&mut arg0.id, v4, v7);
        0x2::dynamic_object_field::add<vector<u8>, NftEscrow<T0>>(&mut arg0.id, create_escrow_key<T0>(v6), v8);
        let v10 = OfferInfo{
            offer_id  : v6,
            offerer   : v0,
            type_hash : v9,
        };
        0x2::table::add<0x2::object::ID, OfferInfo>(&mut arg0.nft_to_offer_index, v1, v10);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.offer_to_nft_index, v6, v1);
        let v11 = DirectNftOfferCreated{
            offer_id         : v6,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            fee_sui          : arg3,
            expires_at_ms    : v3,
            created_at_ms    : v2,
            type_hash        : v9,
        };
        0x2::event::emit<DirectNftOfferCreated>(v11);
        v6
    }

    public entry fun create_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        create_direct_nft_offer<T0, T1>(arg0, arg1, arg2, arg3, hours_to_ms(arg4), arg5, arg6);
    }

    fun create_direct_offer_key<T0: store + key, T1: store + key>(arg0: 0x2::object::ID, arg1: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"DirectOffer_");
        0x1::vector::append<u8>(&mut v0, create_type_hash<T0, T1>());
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        v0
    }

    fun create_escrow_key<T0: store + key>(arg0: 0x2::object::ID) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"Escrow_");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, b"_");
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        v0
    }

    public fun create_nft_auctionhouse(arg0: &0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : NFT_Auctionhouse_Store {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::is_admin(arg0, v0), 21);
        let v1 = 0x2::object::new(arg1);
        let v2 = NFT_Auctionhouse_Store{
            id                 : v1,
            marketplace        : 0x2::object::id<0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse>(arg0),
            deployer           : v0,
            nft_to_offer_index : 0x2::table::new<0x2::object::ID, OfferInfo>(arg1),
            offer_to_nft_index : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        let v3 = NFTAuctionhouseStoreCreated{
            store_id       : 0x2::object::uid_to_inner(&v1),
            marketplace_id : 0x2::object::id<0x233d9f1108d1b466134c9e9fb7d605788fcb47731dae1572c2da70ad80031986::auctionhouse::AuctionHouse>(arg0),
            deployer       : v0,
        };
        0x2::event::emit<NFTAuctionhouseStoreCreated>(v3);
        v2
    }

    fun create_type_hash<T0: store + key, T1: store + key>() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v0, b"_TO_");
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        v0
    }

    public fun days_to_ms(arg0: u64) : u64 {
        assert!(arg0 > 0, 13);
        let v0 = safe_mul_u64(arg0, 86400000);
        validate_duration(v0);
        v0
    }

    public fun direct_offer_exists(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1)
    }

    public fun get_deployer(arg0: &NFT_Auctionhouse_Store) : address {
        arg0.deployer
    }

    public fun get_direct_offer_expiration<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1), 5);
        0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, create_direct_offer_key<T0, T1>(arg1, 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1).offerer)).expires_at_ms
    }

    public fun get_direct_offer_fee<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1), 5);
        0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, create_direct_offer_key<T0, T1>(arg1, 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1).offerer)).fee_sui
    }

    public fun get_direct_offer_requested_nft<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1), 5);
        0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, create_direct_offer_key<T0, T1>(arg1, 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1).offerer)).requested_nft_id
    }

    public fun get_marketplace_id(arg0: &NFT_Auctionhouse_Store) : 0x2::object::ID {
        arg0.marketplace
    }

    public fun get_offer_info(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : (0x2::object::ID, address, vector<u8>) {
        assert!(0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1), 5);
        let v0 = 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1);
        (v0.offer_id, v0.offerer, v0.type_hash)
    }

    public fun get_system_limits() : (u64, u64, u64, u64) {
        (31536000000, 0, 100000000000, 100000000000000000)
    }

    public fun hours_to_ms(arg0: u64) : u64 {
        assert!(arg0 > 0, 13);
        let v0 = safe_mul_u64(arg0, 3600000);
        validate_duration(v0);
        v0
    }

    public fun is_direct_offer_expired<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1)) {
            return false
        };
        is_offer_expired(0x2::dynamic_object_field::borrow<vector<u8>, DirectNftOffer<T0, T1>>(&arg0.id, create_direct_offer_key<T0, T1>(arg1, 0x2::table::borrow<0x2::object::ID, OfferInfo>(&arg0.nft_to_offer_index, arg1).offerer)).expires_at_ms, 0x2::clock::timestamp_ms(arg2))
    }

    public fun is_offer_expired(arg0: u64, arg1: u64) : bool {
        arg1 > arg0
    }

    public fun readable_to_sui(arg0: u64, arg1: u64) : u64 {
        arg0 * 1000000000 + arg1
    }

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 100000000000000000 && arg1 <= 100000000000000000, 18);
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0 && v0 >= arg1, 18);
        v0
    }

    fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 100000000000000000 / arg1, 18);
        arg0 * arg1
    }

    public fun sui_to_readable(arg0: u64) : (u64, u64) {
        (arg0 / 1000000000, arg0 % 1000000000)
    }

    public fun validate_current_time(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 300000;
        assert!(arg0 >= v0 - v1 && arg0 <= v0 + v1, 20);
    }

    public fun validate_duration(arg0: u64) {
        assert!(arg0 >= 3600000, 13);
        assert!(arg0 <= 31536000000, 14);
    }

    public fun validate_fee_sui(arg0: u64) {
        assert!(arg0 >= 0, 9);
        assert!(arg0 <= 100000000000, 8);
    }

    // decompiled from Move bytecode v6
}

