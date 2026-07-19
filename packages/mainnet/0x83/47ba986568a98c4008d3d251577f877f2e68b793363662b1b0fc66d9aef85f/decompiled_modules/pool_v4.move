module 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool_v4 {
    struct RootEntryV4 has copy, drop, store {
        root: vector<u8>,
    }

    struct PoolV4<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        legacy_pool_id: address,
        fee_collector: address,
        balance: 0x2::balance::Balance<T0>,
        withdrawal_pvk: 0x2::groth16::PreparedVerifyingKey,
        deposit_pvk: 0x2::groth16::PreparedVerifyingKey,
        root_history: vector<RootEntryV4>,
        root_history_index: u64,
        latest_root: vector<u8>,
        nullifiers: 0x2::table::Table<vector<u8>, u64>,
        commitments: 0x2::table::Table<vector<u8>, bool>,
        next_leaf_index: u64,
        total_deposited: u64,
        total_withdrawn: u64,
        deposits_paused: bool,
    }

    struct AdminCapV4 has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct MigratedToV4 has copy, drop {
        legacy_pool_id: address,
        pool_v4_id: address,
        seed_root: vector<u8>,
        next_leaf_index: u64,
        migrated_balance: u64,
    }

    struct DepositV4 has copy, drop {
        commitment: vector<u8>,
        leaf_index: u64,
        pool_id: address,
        amount: u64,
        new_root: vector<u8>,
    }

    struct WithdrawalV4 has copy, drop {
        nullifier_hash: vector<u8>,
        note_pool_id: address,
        recipient: address,
        relayer: address,
        recipient_amount: u64,
        relayer_fee: u64,
        protocol_fee: u64,
    }

    public fun balance_value<T0>(arg0: &PoolV4<T0>) : u64 {
        assert_version<T0>(arg0);
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun fee_collector<T0>(arg0: &PoolV4<T0>) : address {
        assert_version<T0>(arg0);
        arg0.fee_collector
    }

    public fun next_leaf_index<T0>(arg0: &PoolV4<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.next_leaf_index
    }

    public fun nullifier_count<T0>(arg0: &PoolV4<T0>) : u64 {
        assert_version<T0>(arg0);
        0x2::table::length<vector<u8>, u64>(&arg0.nullifiers)
    }

    public fun pool_id<T0>(arg0: &PoolV4<T0>) : address {
        assert_version<T0>(arg0);
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun root_in_history<T0>(arg0: &PoolV4<T0>, arg1: &vector<u8>) : bool {
        assert_version<T0>(arg0);
        is_known_root<T0>(arg0, arg1)
    }

    public fun total_deposited<T0>(arg0: &PoolV4<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_deposited
    }

    public fun total_withdrawn<T0>(arg0: &PoolV4<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_withdrawn
    }

    fun add_root<T0>(arg0: &mut PoolV4<T0>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 9);
        let v0 = arg0.root_history_index;
        0x1::vector::borrow_mut<RootEntryV4>(&mut arg0.root_history, v0).root = arg1;
        arg0.root_history_index = (v0 + 1) % 50;
        arg0.latest_root = arg1;
    }

    fun assert_version<T0>(arg0: &PoolV4<T0>) {
        assert!(arg0.version == 4, 17);
    }

    fun bytes_le_to_u256(arg0: &vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 9);
        let v0 = 0x2::bcs::new(*arg0);
        0x2::bcs::peel_u256(&mut v0)
    }

    fun compute_merkle_root(arg0: u256, arg1: &vector<u256>, arg2: u64) : u256 {
        assert!(0x1::vector::length<u256>(arg1) == 20, 14);
        assert!(arg2 < 1048576, 12);
        assert!(arg0 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 8);
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 20) {
            let v2 = *0x1::vector::borrow<u256>(arg1, v1);
            assert!(v2 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 14);
            let v3 = if (arg2 & 1 == 0) {
                hash_pair(v0, v2)
            } else {
                hash_pair(v2, v0)
            };
            v0 = v3;
            arg2 = arg2 >> 1;
            v1 = v1 + 1;
        };
        v0
    }

    public fun deposit_v4<T0>(arg0: &mut PoolV4<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<u256>, arg9: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(!arg0.deposits_paused, 11);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        let v0 = bytes_le_to_u256(&arg2);
        assert!(v0 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 8);
        assert!(v0 != hash_single(0), 8);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.commitments, arg2), 18);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0 && v1 == arg3, 3);
        assert!(arg0.next_leaf_index < 1048576, 12);
        assert!(0x1::vector::length<u256>(&arg8) == 20, 14);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::u256_to_bytes_le(compute_merkle_root(hash_single(0), &arg8, arg0.next_leaf_index)) == arg0.latest_root, 14);
        let v2 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::helpers::u256_to_bytes_le(compute_merkle_root(v0, &arg8, arg0.next_leaf_index));
        let v3 = 0x2::object::uid_to_address(&arg0.id);
        0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier::validate_deposit_public_inputs(&arg7, &arg2, arg3, v3);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier::verify_deposit_proof(&arg0.deposit_pvk, arg4, arg5, arg6, arg7), 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::table::add<vector<u8>, bool>(&mut arg0.commitments, arg2, true);
        let v4 = arg0.next_leaf_index;
        arg0.next_leaf_index = v4 + 1;
        arg0.total_deposited = arg0.total_deposited + v1;
        add_root<T0>(arg0, v2);
        let v5 = DepositV4{
            commitment : arg2,
            leaf_index : v4,
            pool_id    : v3,
            amount     : arg3,
            new_root   : v2,
        };
        0x2::event::emit<DepositV4>(v5);
    }

    public fun deposits_paused<T0>(arg0: &PoolV4<T0>) : bool {
        assert_version<T0>(arg0);
        arg0.deposits_paused
    }

    fun hash_pair(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg0);
        0x1::vector::push_back<u256>(v1, arg1);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    fun hash_single(arg0: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v0, arg0);
        0x2::poseidon::poseidon_bn254(&v0)
    }

    fun is_known_root<T0>(arg0: &PoolV4<T0>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 50) {
            if (&0x1::vector::borrow<RootEntryV4>(&arg0.root_history, v0).root == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_spent<T0>(arg0: &PoolV4<T0>, arg1: &vector<u8>) : bool {
        assert_version<T0>(arg0);
        0x2::table::contains<vector<u8>, u64>(&arg0.nullifiers, *arg1)
    }

    public fun latest_root<T0>(arg0: &PoolV4<T0>) : vector<u8> {
        assert_version<T0>(arg0);
        arg0.latest_root
    }

    public fun legacy_pool_id<T0>(arg0: &PoolV4<T0>) : address {
        assert_version<T0>(arg0);
        arg0.legacy_pool_id
    }

    public fun mainnet_balance() : u64 {
        20000000
    }

    public fun mainnet_fee_collector() : address {
        @0x3a20341455dbb7ed10e414b4a054096c22b0e6c41da1571093e9d7fd36ee0a24
    }

    public fun mainnet_legacy_pool_id() : address {
        @0x982254408277ad2d3ee7b578929ac441069aac2ba37114b3d84c9a647ec55adf
    }

    public fun mainnet_migration_authority() : address {
        @0xd181e9dc710182d9472ea0ea3572f59f8a370b9e92eb83d2dda0ec003d64882f
    }

    public fun mainnet_next_leaf_index() : u64 {
        4
    }

    public fun mainnet_nullifier_count() : u64 {
        3
    }

    public fun mainnet_seed_root() : vector<u8> {
        x"baa76398c569bf67d020a9cdcd9f016d0999851efd4b92cb61f65cf00599f014"
    }

    public fun mainnet_total_deposited() : u64 {
        13172070892516
    }

    public fun mainnet_total_withdrawn() : u64 {
        13172050892516
    }

    public fun max_tree_leaves() : u64 {
        1048576
    }

    fun migrate_checked<T0>(arg0: 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::Pool<T0>, arg1: 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::AdminCap, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13);
        assert!(bytes_le_to_u256(&arg2) < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 13);
        assert!(arg3 < 1048576, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::next_leaf_index<T0>(&arg0) == arg3, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::balance_value<T0>(&arg0) == arg4, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::root_in_history<T0>(&arg0, &arg2), 13);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::consume_for_v4_migration<T0>(arg1, arg0);
        let v8 = v2;
        assert!(0x2::balance::value<T0>(&v8) == arg4, 13);
        assert!(v5 == arg3, 13);
        let v9 = 0x1::vector::empty<RootEntryV4>();
        let v10 = 0;
        while (v10 < 50) {
            let v11 = RootEntryV4{root: 0x1::vector::empty<u8>()};
            0x1::vector::push_back<RootEntryV4>(&mut v9, v11);
            v10 = v10 + 1;
        };
        0x1::vector::borrow_mut<RootEntryV4>(&mut v9, 0).root = arg2;
        let v12 = 0x2::groth16::bn254();
        let v13 = 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::deposit_verifying_key::bytes();
        let v14 = 0x2::object::new(arg5);
        let v15 = PoolV4<T0>{
            id                 : v14,
            version            : 4,
            legacy_pool_id     : v0,
            fee_collector      : v1,
            balance            : v8,
            withdrawal_pvk     : v3,
            deposit_pvk        : 0x2::groth16::prepare_verifying_key(&v12, &v13),
            root_history       : v9,
            root_history_index : 1,
            latest_root        : arg2,
            nullifiers         : v4,
            commitments        : 0x2::table::new<vector<u8>, bool>(arg5),
            next_leaf_index    : arg3,
            total_deposited    : v6,
            total_withdrawn    : v7,
            deposits_paused    : true,
        };
        let v16 = AdminCapV4{
            id      : 0x2::object::new(arg5),
            pool_id : 0x2::object::uid_to_inner(&v14),
        };
        let v17 = MigratedToV4{
            legacy_pool_id   : v0,
            pool_v4_id       : 0x2::object::uid_to_address(&v14),
            seed_root        : arg2,
            next_leaf_index  : arg3,
            migrated_balance : arg4,
        };
        0x2::event::emit<MigratedToV4>(v17);
        0x2::transfer::share_object<PoolV4<T0>>(v15);
        0x2::transfer::transfer<AdminCapV4>(v16, 0x2::tx_context::sender(arg5));
    }

    public fun migrate_mainnet<T0>(arg0: 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::Pool<T0>, arg1: 0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd181e9dc710182d9472ea0ea3572f59f8a370b9e92eb83d2dda0ec003d64882f, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::pool_id<T0>(&arg0) == @0x982254408277ad2d3ee7b578929ac441069aac2ba37114b3d84c9a647ec55adf, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::authority<T0>(&arg0) == @0xd181e9dc710182d9472ea0ea3572f59f8a370b9e92eb83d2dda0ec003d64882f, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::relayer<T0>(&arg0) == @0xd181e9dc710182d9472ea0ea3572f59f8a370b9e92eb83d2dda0ec003d64882f, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::fee_collector<T0>(&arg0) == @0x3a20341455dbb7ed10e414b4a054096c22b0e6c41da1571093e9d7fd36ee0a24, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::nullifier_count<T0>(&arg0) == 3, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::total_deposited<T0>(&arg0) == 13172070892516, 13);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::pool::total_withdrawn<T0>(&arg0) == 13172050892516, 13);
        migrate_checked<T0>(arg0, arg1, x"baa76398c569bf67d020a9cdcd9f016d0999851efd4b92cb61f65cf00599f014", 4, 20000000, arg2);
    }

    public fun pause_deposits<T0>(arg0: &AdminCapV4, arg1: &mut PoolV4<T0>) {
        assert_version<T0>(arg1);
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        arg1.deposits_paused = true;
    }

    public fun transfer_v4<T0>(arg0: &mut PoolV4<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: address, arg7: u64, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 10);
        assert!(arg6 == arg0.legacy_pool_id || arg6 == 0x2::object::uid_to_address(&arg0.id), 16);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.nullifiers, arg5), 6);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 7, 15);
        let v0 = *0x1::vector::borrow<vector<u8>>(&arg4, 0);
        assert!(0x1::vector::length<u8>(&v0) == 32, 9);
        assert!(is_known_root<T0>(arg0, &v0), 2);
        0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier::validate_public_inputs(&arg4, &v0, &arg5, arg9, 0x2::tx_context::sender(arg11), arg7, arg8, arg6);
        assert!(0x9e935de41f29d842ced69c9e7c751cc565f7080274ffaa1223d98886bb9b9a07::verifier::verify_groth16_proof(&arg0.withdrawal_pvk, arg1, arg2, arg3, arg4), 1);
        let v1 = (arg8 as u128) + (arg7 as u128);
        assert!(v1 > 0, 3);
        assert!(v1 <= 18446744073709551615, 5);
        let v2 = (v1 as u64);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v2, 4);
        let v3 = (((arg8 as u128) * (15 as u128) / 10000) as u64);
        let v4 = arg8 - v3;
        0x2::table::add<vector<u8>, u64>(&mut arg0.nullifiers, arg5, 0x2::clock::timestamp_ms(arg10));
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg11), arg9);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg11), arg0.fee_collector);
        };
        if (arg7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg7), arg11), 0x2::tx_context::sender(arg11));
        };
        arg0.total_withdrawn = arg0.total_withdrawn + v2;
        let v5 = WithdrawalV4{
            nullifier_hash   : arg5,
            note_pool_id     : arg6,
            recipient        : arg9,
            relayer          : 0x2::tx_context::sender(arg11),
            recipient_amount : arg8,
            relayer_fee      : arg7,
            protocol_fee     : v3,
        };
        0x2::event::emit<WithdrawalV4>(v5);
    }

    public fun unpause_deposits<T0>(arg0: &AdminCapV4, arg1: &mut PoolV4<T0>) {
        assert_version<T0>(arg1);
        assert!(arg0.pool_id == 0x2::object::uid_to_inner(&arg1.id), 7);
        abort 19
    }

    public fun version<T0>(arg0: &PoolV4<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

