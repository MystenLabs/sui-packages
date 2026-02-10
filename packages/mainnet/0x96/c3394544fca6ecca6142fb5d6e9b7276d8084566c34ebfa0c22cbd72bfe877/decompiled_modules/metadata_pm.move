module 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::metadata_pm {
    struct LocationMetadata has store {
        latitude: u64,
        longitude: u64,
        elevation: u64,
        planet: u8,
    }

    struct DigitalTwinOrigin has store {
        gltf_index: vector<u8>,
        position_x: u64,
        position_y: u64,
        position_z: u64,
        rotation_x: u64,
        rotation_y: u64,
        rotation_z: u64,
        rotation_w: u64,
    }

    struct AdRevenuePool has key {
        id: 0x2::object::UID,
        content_id: vector<u8>,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_revenue: u64,
        distributed: bool,
        merkle_root: 0x1::option::Option<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>,
        paused: bool,
        governance_config_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ZKProofVerified has copy, drop {
        content_id: vector<u8>,
        merkle_root: vector<u8>,
        verified_count: u64,
    }

    struct RevenueDistributed has copy, drop {
        content_id: vector<u8>,
        creator_share: u64,
        pm_share: u64,
        foundation_share: u64,
    }

    struct PoolCreated has copy, drop {
        content_id: vector<u8>,
        creator: address,
        initial_amount: u64,
    }

    struct FundsAdded has copy, drop {
        content_id: vector<u8>,
        amount: u64,
    }

    struct PoolPaused has copy, drop {
        content_id: vector<u8>,
        creator: address,
    }

    struct PoolUnpaused has copy, drop {
        content_id: vector<u8>,
        creator: address,
    }

    public fun get_content_id(arg0: &AdRevenuePool) : vector<u8> {
        arg0.content_id
    }

    public fun add_funds_to_pool(arg0: &mut AdRevenuePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(!arg0.paused, 10);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        arg0.total_revenue = arg0.total_revenue + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = FundsAdded{
            content_id : arg0.content_id,
            amount     : v0,
        };
        0x2::event::emit<FundsAdded>(v1);
    }

    public fun create_digital_twin_origin(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : DigitalTwinOrigin {
        DigitalTwinOrigin{
            gltf_index : arg0,
            position_x : arg1,
            position_y : arg2,
            position_z : arg3,
            rotation_x : arg4,
            rotation_y : arg5,
            rotation_z : arg6,
            rotation_w : arg7,
        }
    }

    public fun create_location_metadata(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : LocationMetadata {
        assert!(arg3 <= 2, 8);
        LocationMetadata{
            latitude  : arg0,
            longitude : arg1,
            elevation : arg2,
            planet    : arg3,
        }
    }

    public fun create_revenue_pool(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : AdRevenuePool {
        assert!(0x1::vector::length<u8>(&arg0) <= 64, 17);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = AdRevenuePool{
            id                   : 0x2::object::new(arg2),
            content_id           : arg0,
            creator              : v0,
            balance              : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            total_revenue        : v1,
            distributed          : false,
            merkle_root          : 0x1::option::none<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(),
            paused               : false,
            governance_config_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = PoolCreated{
            content_id     : arg0,
            creator        : v0,
            initial_amount : v1,
        };
        0x2::event::emit<PoolCreated>(v3);
        v2
    }

    public fun distribute_ad_revenue(arg0: &mut AdRevenuePool, arg1: vector<vector<u8>>, arg2: vector<vector<vector<u8>>>, arg3: vector<vector<u8>>, arg4: address, arg5: address, arg6: &0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::ad_payments::AdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.distributed, 4);
        assert!(!arg0.paused, 10);
        assert!(0x1::option::is_some<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(&arg0.merkle_root), 9);
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 <= 100, 12);
        assert!(v0 > 0, 6);
        let v1 = 0x1::option::borrow<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(&arg0.merkle_root);
        assert!(0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_leaf_count(v1) >= 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_threshold(v1), 3);
        assert!(v0 >= 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_threshold(v1) / 10, 16);
        let v2 = 0;
        while (v2 < v0) {
            assert!(0x1::vector::length<vector<u8>>(0x1::vector::borrow<vector<vector<u8>>>(&arg2, v2)) <= 40, 15);
            v2 = v2 + 1;
        };
        assert!(0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::verify_batch_ad_views(v1, arg1, arg2, arg3), 6);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v3 > 0, 5);
        let v4 = v3 * 50 / 100;
        let v5 = v3 * 30 / 100;
        let v6 = v3 - v4 - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v4), arg7), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5), arg7), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v6), arg7), arg5);
        let v7 = RevenueDistributed{
            content_id       : arg0.content_id,
            creator_share    : v4,
            pm_share         : v6,
            foundation_share : v5,
        };
        0x2::event::emit<RevenueDistributed>(v7);
        arg0.distributed = true;
    }

    public fun get_creator(arg0: &AdRevenuePool) : address {
        arg0.creator
    }

    public fun get_merkle_root_hash(arg0: &AdRevenuePool) : 0x1::option::Option<vector<u8>> {
        if (0x1::option::is_some<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(&arg0.merkle_root)) {
            let v1 = 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_root_hash(0x1::option::borrow<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(&arg0.merkle_root));
            let v2 = 0;
            let v3 = 0x1::vector::empty<u8>();
            while (v2 < 0x1::vector::length<u8>(v1)) {
                0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(v1, v2));
                v2 = v2 + 1;
            };
            0x1::option::some<vector<u8>>(v3)
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun get_pool_balance(arg0: &AdRevenuePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_total_revenue(arg0: &AdRevenuePool) : u64 {
        arg0.total_revenue
    }

    public fun has_merkle_root(arg0: &AdRevenuePool) : bool {
        0x1::option::is_some<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(&arg0.merkle_root)
    }

    public fun is_distributed(arg0: &AdRevenuePool) : bool {
        arg0.distributed
    }

    public fun is_paused(arg0: &AdRevenuePool) : bool {
        arg0.paused
    }

    public fun pause_pool(arg0: &mut AdRevenuePool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 11);
        arg0.paused = true;
        let v0 = PoolPaused{
            content_id : arg0.content_id,
            creator    : arg0.creator,
        };
        0x2::event::emit<PoolPaused>(v0);
    }

    public fun set_merkle_root(arg0: &mut AdRevenuePool, arg1: 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot, arg2: &0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::ad_payments::AdminCap) {
        assert!(!arg0.distributed, 4);
        assert!(0x1::option::is_none<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(&arg0.merkle_root), 13);
        let v0 = arg0.content_id;
        assert!(0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_content_id(&arg1) == &v0, 6);
        assert!(0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_leaf_count(&arg1) >= 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::get_threshold(&arg1), 3);
        arg0.merkle_root = 0x1::option::some<0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::merkle_verifier::MerkleRoot>(arg1);
    }

    public fun unpause_pool(arg0: &mut AdRevenuePool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 11);
        assert!(arg0.paused, 14);
        arg0.paused = false;
        let v0 = PoolUnpaused{
            content_id : arg0.content_id,
            creator    : arg0.creator,
        };
        0x2::event::emit<PoolUnpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

