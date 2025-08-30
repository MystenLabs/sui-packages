module 0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::privacy_pool_v3 {
    struct DepositEvent has copy, drop {
        leaf_index: u64,
        commitment: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        nullifier: vector<u8>,
        recipient: address,
        amount: u64,
        timestamp: u64,
    }

    struct PrivacyPoolV3 has store, key {
        id: 0x2::object::UID,
        merkle_tree: 0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::MerkleTreeV3,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        nullifiers: vector<vector<u8>>,
        enabled: bool,
        total_deposits: u64,
        prepared_vk: vector<u8>,
    }

    struct AdminCapV3 has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public fun is_valid_root(arg0: &PrivacyPoolV3, arg1: vector<u8>) : bool {
        0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::is_valid_root(&arg0.merkle_tree, arg1)
    }

    public fun create_pool(arg0: &mut 0x2::tx_context::TxContext) : (PrivacyPoolV3, AdminCapV3) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCapV3{
            id      : 0x2::object::new(arg0),
            pool_id : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = PrivacyPoolV3{
            id             : v0,
            merkle_tree    : 0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::initialize(26, arg0),
            balance        : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            nullifiers     : 0x1::vector::empty<vector<u8>>(),
            enabled        : true,
            total_deposits : 0,
            prepared_vk    : 0x1::vector::empty<u8>(),
        };
        (v2, v1)
    }

    public entry fun deposit(arg0: &mut PrivacyPoolV3, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 4);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let (v1, _) = 0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::append(&mut arg0.merkle_tree, arg2);
        arg0.total_deposits = arg0.total_deposits + 1;
        let v3 = DepositEvent{
            leaf_index : v1,
            commitment : arg2,
            amount     : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun get_balance(arg0: &PrivacyPoolV3) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_current_root(arg0: &PrivacyPoolV3) : vector<u8> {
        0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::get_root(&arg0.merkle_tree)
    }

    public fun get_pool_stats(arg0: &PrivacyPoolV3) : (u64, u64, bool) {
        (arg0.total_deposits, 0x2::coin::value<0x2::sui::SUI>(&arg0.balance), arg0.enabled)
    }

    public fun get_total_deposits(arg0: &PrivacyPoolV3) : u64 {
        arg0.total_deposits
    }

    public fun get_tree_stats(arg0: &PrivacyPoolV3) : (u64, u8, u64) {
        0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::get_stats(&arg0.merkle_tree)
    }

    public fun is_nullifier_used(arg0: &PrivacyPoolV3, arg1: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.nullifiers)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.nullifiers, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun set_enabled(arg0: &AdminCapV3, arg1: &mut PrivacyPoolV3, arg2: bool) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.pool_id, 5);
        arg1.enabled = arg2;
    }

    public entry fun update_verification_key_native(arg0: &AdminCapV3, arg1: &mut PrivacyPoolV3, arg2: vector<u8>, arg3: u8) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.pool_id, 5);
        arg1.prepared_vk = arg2;
    }

    public fun verify_merkle_proof(arg0: &PrivacyPoolV3, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u64) : bool {
        0xe37b0c54c07dab743a7663118315e80a26c1bd3edd3f43769a1f2ddd243b04d::merkle_tree_v3::verify_proof(arg1, arg2, arg3, arg4)
    }

    public entry fun withdraw(arg0: &mut PrivacyPoolV3, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 4);
        assert!(arg4 != @0x0, 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.nullifiers)) {
            assert!(*0x1::vector::borrow<vector<u8>>(&arg0.nullifiers, v0) != arg3, 2);
            v0 = v0 + 1;
        };
        assert!(0x1::vector::length<u8>(&arg1) > 0, 1);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 1);
        assert!(arg5 <= 0x2::coin::value<0x2::sui::SUI>(&arg0.balance), 0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.nullifiers, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, arg5, arg7), arg4);
        let v1 = WithdrawEvent{
            nullifier : arg3,
            recipient : arg4,
            amount    : arg5,
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

