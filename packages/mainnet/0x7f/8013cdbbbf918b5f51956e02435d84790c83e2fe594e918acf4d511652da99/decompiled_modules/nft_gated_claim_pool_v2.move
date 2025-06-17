module 0x7f8013cdbbbf918b5f51956e02435d84790c83e2fe594e918acf4d511652da99::nft_gated_claim_pool_v2 {
    struct NFTGatedClaimPoolV2 has key {
        id: 0x2::object::UID,
        admin: address,
        nft_ids: vector<0x2::object::ID>,
        claims: 0x2::table::Table<address, bool>,
        authorized_depositors: 0x2::table::Table<address, bool>,
        claiming_enabled: bool,
        total_claimed: u64,
        eligible_collections: 0x2::vec_set::VecSet<vector<u8>>,
    }

    struct OwnershipProof has drop {
        collection_type: vector<u8>,
        nft_id: 0x2::object::ID,
        owner: address,
    }

    struct NFTClaimed has copy, drop {
        claimer: address,
        nft_id: 0x2::object::ID,
        pool_remaining: u64,
        collection_used: vector<u8>,
    }

    struct NFTAddedToPool has copy, drop {
        nft_id: 0x2::object::ID,
        pool_size: u64,
    }

    struct PoolStatusChanged has copy, drop {
        claiming_enabled: bool,
    }

    struct EligibleCollectionAdded has copy, drop {
        collection_type: vector<u8>,
    }

    struct EligibleCollectionRemoved has copy, drop {
        collection_type: vector<u8>,
    }

    struct NFT_GATED_CLAIM_POOL_V2 has drop {
        dummy_field: bool,
    }

    public entry fun add_authorized_depositor(arg0: &mut NFTGatedClaimPoolV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (!0x2::table::contains<address, bool>(&arg0.authorized_depositors, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.authorized_depositors, arg1, true);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.authorized_depositors, arg1) = true;
        };
    }

    public entry fun add_eligible_collection(arg0: &mut NFTGatedClaimPoolV2, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (!0x2::vec_set::contains<vector<u8>>(&arg0.eligible_collections, &arg1)) {
            0x2::vec_set::insert<vector<u8>>(&mut arg0.eligible_collections, arg1);
            let v0 = EligibleCollectionAdded{collection_type: arg1};
            0x2::event::emit<EligibleCollectionAdded>(v0);
        };
    }

    public entry fun add_nft_to_pool<T0: store + key>(arg0: &mut NFTGatedClaimPoolV2, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || 0x2::table::contains<address, bool>(&arg0.authorized_depositors, v0) && *0x2::table::borrow<address, bool>(&arg0.authorized_depositors, v0), 1);
        let v1 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v1, arg1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.nft_ids, v1);
        let v2 = NFTAddedToPool{
            nft_id    : v1,
            pool_size : 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids),
        };
        0x2::event::emit<NFTAddedToPool>(v2);
    }

    public entry fun batch_add_nfts_to_pool<T0: store + key>(arg0: &mut NFTGatedClaimPoolV2, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || 0x2::table::contains<address, bool>(&arg0.authorized_depositors, v0) && *0x2::table::borrow<address, bool>(&arg0.authorized_depositors, v0), 1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(&arg1)) {
            let v2 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v3 = 0x2::object::id<T0>(&v2);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v3, v2);
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.nft_ids, v3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
        let v4 = NFTAddedToPool{
            nft_id    : 0x2::object::id_from_address(@0x0),
            pool_size : 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids),
        };
        0x2::event::emit<NFTAddedToPool>(v4);
    }

    public fun can_claim(arg0: &NFTGatedClaimPoolV2, arg1: address) : bool {
        if (arg0.claiming_enabled) {
            if (!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids)) {
                !0x2::table::contains<address, bool>(&arg0.claims, arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun claim_nft_with_proof<T0: store + key>(arg0: &mut NFTGatedClaimPoolV2, arg1: OwnershipProof, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claiming_enabled, 4);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids), 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.owner == v0, 6);
        assert!(!0x2::table::contains<address, bool>(&arg0.claims, v0), 3);
        assert!(is_collection_eligible(arg0, &arg1.collection_type), 5);
        let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids);
        0x2::table::add<address, bool>(&mut arg0.claims, v0, true);
        arg0.total_claimed = arg0.total_claimed + 1;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v1), v0);
        let OwnershipProof {
            collection_type : v2,
            nft_id          : _,
            owner           : _,
        } = arg1;
        let v5 = NFTClaimed{
            claimer         : v0,
            nft_id          : v1,
            pool_remaining  : 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids),
            collection_used : v2,
        };
        0x2::event::emit<NFTClaimed>(v5);
    }

    public entry fun claim_with_nft<T0: store + key, T1: key>(arg0: &mut NFTGatedClaimPoolV2, arg1: &T1, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_ownership_proof<T1>(arg1, arg2, arg3);
        claim_nft_with_proof<T0>(arg0, v0, arg3);
    }

    public fun create_ownership_proof<T0: key>(arg0: &T0, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) : OwnershipProof {
        OwnershipProof{
            collection_type : arg1,
            nft_id          : 0x2::object::id<T0>(arg0),
            owner           : 0x2::tx_context::sender(arg2),
        }
    }

    public fun get_eligible_collections_count(arg0: &NFTGatedClaimPoolV2) : u64 {
        0x2::vec_set::size<vector<u8>>(&arg0.eligible_collections)
    }

    public fun get_pool_info(arg0: &NFTGatedClaimPoolV2) : (u64, u64, bool, address) {
        (0x1::vector::length<0x2::object::ID>(&arg0.nft_ids), arg0.total_claimed, arg0.claiming_enabled, arg0.admin)
    }

    public fun has_claimed(arg0: &NFTGatedClaimPoolV2, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claims, arg1)
    }

    fun init(arg0: NFT_GATED_CLAIM_POOL_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTGatedClaimPoolV2{
            id                    : 0x2::object::new(arg1),
            admin                 : 0x2::tx_context::sender(arg1),
            nft_ids               : 0x1::vector::empty<0x2::object::ID>(),
            claims                : 0x2::table::new<address, bool>(arg1),
            authorized_depositors : 0x2::table::new<address, bool>(arg1),
            claiming_enabled      : false,
            total_claimed         : 0,
            eligible_collections  : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::vec_set::insert<vector<u8>>(&mut v0.eligible_collections, b"0x034c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::factory::PrimeMachin");
        0x2::vec_set::insert<vector<u8>>(&mut v0.eligible_collections, b"0x8f74a7d632191e29956df3843404f22d27bd84d92cca1b1abde621d033098769::rootlet::Rootlet");
        0x2::transfer::share_object<NFTGatedClaimPoolV2>(v0);
    }

    public fun is_collection_eligible(arg0: &NFTGatedClaimPoolV2, arg1: &vector<u8>) : bool {
        0x2::vec_set::contains<vector<u8>>(&arg0.eligible_collections, arg1)
    }

    public entry fun remove_all_nfts_from_pool<T0: store + key>(arg0: &mut NFTGatedClaimPoolV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.nft_ids)) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids)), arg1);
        };
    }

    public entry fun remove_authorized_depositor(arg0: &mut NFTGatedClaimPoolV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::table::contains<address, bool>(&arg0.authorized_depositors, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.authorized_depositors, arg1);
        };
    }

    public entry fun remove_eligible_collection(arg0: &mut NFTGatedClaimPoolV2, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::vec_set::contains<vector<u8>>(&arg0.eligible_collections, &arg1)) {
            0x2::vec_set::remove<vector<u8>>(&mut arg0.eligible_collections, &arg1);
            let v0 = EligibleCollectionRemoved{collection_type: arg1};
            0x2::event::emit<EligibleCollectionRemoved>(v0);
        };
    }

    public entry fun remove_nfts_from_pool<T0: store + key>(arg0: &mut NFTGatedClaimPoolV2, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = arg1;
        if (arg1 > 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids)) {
            v0 = 0x1::vector::length<0x2::object::ID>(&arg0.nft_ids);
        };
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.nft_ids)), arg2);
            v1 = v1 + 1;
        };
    }

    public entry fun set_claiming_enabled(arg0: &mut NFTGatedClaimPoolV2, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.claiming_enabled = arg1;
        let v0 = PoolStatusChanged{claiming_enabled: arg1};
        0x2::event::emit<PoolStatusChanged>(v0);
    }

    public entry fun transfer_admin(arg0: &mut NFTGatedClaimPoolV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

