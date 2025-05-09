module 0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::nft_auctionhouse {
    struct NFT_Auctionhouse_Store has key {
        id: 0x2::object::UID,
        marketplace: 0x2::object::ID,
    }

    struct DirectNftOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee: u64,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
    }

    struct DirectNftOfferCreated has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
    }

    struct DirectNftOfferCancelled has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
    }

    struct DirectNftOfferAccepted has copy, drop {
        receiver: address,
        sender: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    public fun accept_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &mut 0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: T1, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg2), 6);
        let DirectNftOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v3,
            status           : v4,
            fee              : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, arg2);
        let v6 = v0;
        assert!(v4 == 0, 2);
        assert!(0x2::object::id<T1>(&arg3) == v3, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v5, 9);
        0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::add_fee(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let NftEscrow {
            id  : v7,
            nft : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v6));
        0x2::object::delete(v6);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<T1>(arg3, v1);
        let v9 = DirectNftOfferAccepted{
            receiver        : 0x2::tx_context::sender(arg5),
            sender          : v1,
            offered_nft_id  : v2,
            received_nft_id : v3,
            fee_paid        : v5,
        };
        0x2::event::emit<DirectNftOfferAccepted>(v9);
        v8
    }

    public fun cancel_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        let DirectNftOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v3,
            status           : v4,
            fee              : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, arg1);
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 1);
        assert!(v4 == 0, 2);
        let NftEscrow {
            id  : v7,
            nft : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v6));
        0x2::object::delete(v6);
        0x2::object::delete(v7);
        let v9 = DirectNftOfferCancelled{
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v3,
        };
        0x2::event::emit<DirectNftOfferCancelled>(v9);
        v8
    }

    public entry fun create_and_share_create_nft_auctionhouse_store(arg0: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<NFT_Auctionhouse_Store>(create_nft_auctionhouse(arg0, arg1));
    }

    public fun create_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::object::new(arg4);
        let v3 = DirectNftOffer<T0, T1>{
            id               : v2,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            status           : 0,
            fee              : arg3,
        };
        let v4 = NftEscrow<T0>{
            id  : 0x2::object::new(arg4),
            nft : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, v1, v3);
        0x2::dynamic_object_field::add<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v2), v4);
        let v5 = DirectNftOfferCreated{
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            fee              : arg3,
        };
        0x2::event::emit<DirectNftOfferCreated>(v5);
    }

    public fun create_nft_auctionhouse(arg0: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg1: &mut 0x2::tx_context::TxContext) : NFT_Auctionhouse_Store {
        NFT_Auctionhouse_Store{
            id          : 0x2::object::new(arg1),
            marketplace : 0x2::object::id<0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse>(arg0),
        }
    }

    public fun direct_offer_exists<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1)
    }

    public entry fun emergency_reset_direct_offer<T0: store + key, T1: store + key>(arg0: &mut NFT_Auctionhouse_Store, arg1: &0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::AuctionHouse, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9162691368b656705d7e599f4f98e125fed56ae0ecbf0edb952097ce38b13d80::auctionhouse::is_admin(arg1, 0x2::tx_context::sender(arg3)), 11);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg2)) {
            let DirectNftOffer {
                id               : v0,
                offerer          : v1,
                offered_nft_id   : _,
                requested_nft_id : _,
                status           : _,
                fee              : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, arg2);
            let v6 = v0;
            let v7 = 0x2::object::uid_to_inner(&v6);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftEscrow<T0>>(&arg0.id, v7)) {
                let NftEscrow {
                    id  : v8,
                    nft : v9,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, v7);
                0x2::object::delete(v8);
                0x2::transfer::public_transfer<T0>(v9, v1);
            };
            0x2::object::delete(v6);
        };
    }

    public fun get_direct_offer_fee<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1).fee
    }

    public fun get_direct_offer_offerer<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1).offerer
    }

    public fun get_direct_offer_requested_nft<T0: store + key, T1: store + key>(arg0: &NFT_Auctionhouse_Store, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1).requested_nft_id
    }

    // decompiled from Move bytecode v6
}

