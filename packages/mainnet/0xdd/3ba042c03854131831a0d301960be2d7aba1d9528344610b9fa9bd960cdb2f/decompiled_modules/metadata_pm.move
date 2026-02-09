module 0xdd3ba042c03854131831a0d301960be2d7aba1d9528344610b9fa9bd960cdb2f::metadata_pm {
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

    struct MerkleRoot has store {
        content_id: vector<u8>,
        root_hash: vector<u8>,
        leaf_count: u64,
        threshold: u64,
    }

    struct AdRevenuePool has key {
        id: 0x2::object::UID,
        content_id: vector<u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_revenue: u64,
        distributed: bool,
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

    public fun add_funds_to_pool(arg0: &mut AdRevenuePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        arg0.total_revenue = arg0.total_revenue + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
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

    public fun create_merkle_root(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64) : MerkleRoot {
        assert!(arg3 <= arg2, 7);
        MerkleRoot{
            content_id : arg0,
            root_hash  : arg1,
            leaf_count : arg2,
            threshold  : arg3,
        }
    }

    public fun create_revenue_pool(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : AdRevenuePool {
        AdRevenuePool{
            id            : 0x2::object::new(arg2),
            content_id    : arg0,
            balance       : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            total_revenue : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            distributed   : false,
        }
    }

    public fun destroy_merkle_root(arg0: MerkleRoot) {
        let MerkleRoot {
            content_id : _,
            root_hash  : _,
            leaf_count : _,
            threshold  : _,
        } = arg0;
    }

    public fun distribute_ad_revenue(arg0: &mut AdRevenuePool, arg1: &MerkleRoot, arg2: vector<vector<u8>>, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.leaf_count >= arg1.threshold, 3);
        assert!(!arg0.distributed, 4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg2, v1);
            assert!(0x1::vector::length<u8>(&v2) > 0, 1);
            v1 = v1 + 1;
        };
        let v3 = v0 * 50 / 100;
        let v4 = v0 * 30 / 100;
        let v5 = v0 - v3 - v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg6), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v4), arg6), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5), arg6), arg5);
        let v6 = RevenueDistributed{
            content_id       : arg0.content_id,
            creator_share    : v3,
            pm_share         : v5,
            foundation_share : v4,
        };
        0x2::event::emit<RevenueDistributed>(v6);
        arg0.distributed = true;
    }

    public fun get_content_id(arg0: &AdRevenuePool) : vector<u8> {
        arg0.content_id
    }

    public fun get_pool_balance(arg0: &AdRevenuePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_total_revenue(arg0: &AdRevenuePool) : u64 {
        arg0.total_revenue
    }

    public fun is_distributed(arg0: &AdRevenuePool) : bool {
        arg0.distributed
    }

    public fun verify_ad_view(arg0: vector<u8>, arg1: vector<u8>, arg2: &MerkleRoot, arg3: vector<vector<u8>>) : bool {
        if (0x1::vector::length<u8>(&arg0) == 0) {
            return false
        };
        if (0x1::vector::length<u8>(&arg1) == 0) {
            return false
        };
        true
    }

    public fun verify_batch_ad_views(arg0: &MerkleRoot, arg1: vector<vector<u8>>, arg2: vector<vector<vector<u8>>>, arg3: vector<vector<u8>>) : bool {
        if (arg0.leaf_count < arg0.threshold) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            if (!verify_merkle_inclusion(*0x1::vector::borrow<vector<u8>>(&arg1, v0), *0x1::vector::borrow<vector<vector<u8>>>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0), arg0.root_hash)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun verify_merkle_inclusion(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        let v1 = 0x1::vector::length<u8>(&arg2);
        if (v0 == 0 || v1 == 0) {
            return false
        };
        if (v0 != v1) {
            return false
        };
        let v2 = 0x2::hash::keccak256(&arg0);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::empty<u8>();
            if (*0x1::vector::borrow<u8>(&arg2, v3) == 0) {
                0x1::vector::append<u8>(&mut v4, v2);
                0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&arg1, v3));
            } else {
                0x1::vector::append<u8>(&mut v4, *0x1::vector::borrow<vector<u8>>(&arg1, v3));
                0x1::vector::append<u8>(&mut v4, v2);
            };
            v2 = 0x2::hash::keccak256(&v4);
            v3 = v3 + 1;
        };
        if (0x1::vector::length<u8>(&v2) != 0x1::vector::length<u8>(&arg3)) {
            return false
        };
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v2)) {
            if (*0x1::vector::borrow<u8>(&v2, v5) != *0x1::vector::borrow<u8>(&arg3, v5)) {
                return false
            };
            v5 = v5 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

