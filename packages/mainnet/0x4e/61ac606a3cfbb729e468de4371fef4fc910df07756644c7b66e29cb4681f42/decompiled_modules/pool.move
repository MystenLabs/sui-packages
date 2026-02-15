module 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::pool {
    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PrivacyPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        merkle_tree: 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::MerkleTree,
        nullifiers: 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::NullifierRegistry,
        vk_bytes: vector<u8>,
        transfer_vk_bytes: vector<u8>,
        swap_vk_bytes: vector<u8>,
        historical_roots: vector<vector<u8>>,
        root_head: u64,
    }

    struct ShieldEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position: u64,
        commitment: vector<u8>,
        encrypted_note: vector<u8>,
    }

    struct UnshieldEvent has copy, drop {
        pool_id: 0x2::object::ID,
        input_nullifiers: vector<vector<u8>>,
        recipient: address,
        amount: u64,
    }

    struct TransferEvent has copy, drop {
        pool_id: 0x2::object::ID,
        input_nullifiers: vector<vector<u8>>,
        output_positions: vector<u64>,
        output_commitments: vector<vector<u8>>,
        output_notes: vector<vector<u8>>,
    }

    struct SwapEvent has copy, drop {
        pool_in_id: 0x2::object::ID,
        pool_out_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        input_nullifiers: vector<vector<u8>>,
        swap_position: u64,
        swap_commitment: vector<u8>,
        encrypted_output_note: vector<u8>,
    }

    public fun swap<T0, T1>(arg0: &mut PrivacyPool<T0>, arg1: &mut PrivacyPool<T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &0x2::clock::Clock, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg4) == 256, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == 2, 5);
        let (v0, v1, v2, _, _, v5, v6, v7) = parse_swap_public_inputs(&arg4);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v2;
        let v12 = field_element_to_u64(&v9);
        let v13 = *0x1::vector::borrow<vector<u8>>(&arg5, 0);
        let v14 = *0x1::vector::borrow<vector<u8>>(&arg5, 1);
        let v15 = 0x1::vector::empty<u256>();
        let v16 = &mut v15;
        0x1::vector::push_back<u256>(v16, field_element_to_u256(&v13));
        0x1::vector::push_back<u256>(v16, field_element_to_u256(&v14));
        assert!(u256_to_field_element(0x2::poseidon::poseidon_bn254(&v15)) == v0, 5);
        assert!(is_valid_root<T0>(arg0, &v8), 3);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v13), 1);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v14), 1);
        let v17 = 0x2::groth16::bn254();
        let v18 = 0x2::groth16::prepare_verifying_key(&v17, &arg0.swap_vk_bytes);
        let v19 = 0x2::groth16::public_proof_inputs_from_bytes(arg4);
        let v20 = 0x2::groth16::proof_points_from_bytes(arg3);
        let v21 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v21, &v18, &v19, &v20), 2);
        let v22 = field_element_to_u64(&v10);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v22, 4);
        let (v23, v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg2, 0x2::coin::take<T0>(&mut arg0.balance, v22, arg10), arg6, v12, arg7, arg10);
        let v26 = v24;
        let v27 = 0x2::coin::value<T1>(&v26);
        assert!(v27 >= v12, 7);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v23));
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(v26));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v25, 0x2::tx_context::sender(arg10));
        let v28 = 0x1::vector::empty<vector<u8>>();
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v13);
        0x1::vector::push_back<vector<u8>>(&mut v28, v13);
        if (!is_zero_commitment(&v14)) {
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v14);
            0x1::vector::push_back<vector<u8>>(&mut v28, v14);
        };
        save_historical_root<T1>(arg1);
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg1.merkle_tree, v1);
        if (!is_zero_commitment(&v11)) {
            save_historical_root<T0>(arg0);
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg0.merkle_tree, v11);
            let v29 = ShieldEvent{
                pool_id        : 0x2::object::id<PrivacyPool<T0>>(arg0),
                position       : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree),
                commitment     : v11,
                encrypted_note : arg9,
            };
            0x2::event::emit<ShieldEvent>(v29);
        };
        let v30 = SwapEvent{
            pool_in_id            : 0x2::object::id<PrivacyPool<T0>>(arg0),
            pool_out_id           : 0x2::object::id<PrivacyPool<T1>>(arg1),
            amount_in             : v22,
            amount_out            : v27,
            input_nullifiers      : v28,
            swap_position         : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg1.merkle_tree),
            swap_commitment       : v1,
            encrypted_output_note : arg8,
        };
        0x2::event::emit<SwapEvent>(v30);
    }

    public fun transfer<T0>(arg0: &mut PrivacyPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 160, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 2, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 2, 5);
        let (v0, v1, v2, _, v4) = parse_transfer_public_inputs(&arg2);
        let v5 = v4;
        let v6 = v2;
        let v7 = *0x1::vector::borrow<vector<u8>>(&arg3, 0);
        let v8 = *0x1::vector::borrow<vector<u8>>(&arg3, 1);
        let v9 = 0x1::vector::empty<u256>();
        let v10 = &mut v9;
        0x1::vector::push_back<u256>(v10, field_element_to_u256(&v7));
        0x1::vector::push_back<u256>(v10, field_element_to_u256(&v8));
        assert!(u256_to_field_element(0x2::poseidon::poseidon_bn254(&v9)) == v0, 5);
        assert!(is_valid_root<T0>(arg0, &v5), 3);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v7), 1);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v8), 1);
        let v11 = 0x2::groth16::bn254();
        let v12 = 0x2::groth16::prepare_verifying_key(&v11, &arg0.transfer_vk_bytes);
        let v13 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v14 = 0x2::groth16::proof_points_from_bytes(arg1);
        let v15 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v15, &v12, &v13, &v14), 2);
        let v16 = 0x1::vector::empty<vector<u8>>();
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v7);
        0x1::vector::push_back<vector<u8>>(&mut v16, v7);
        if (!is_zero_commitment(&v8)) {
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v8);
            0x1::vector::push_back<vector<u8>>(&mut v16, v8);
        };
        save_historical_root<T0>(arg0);
        let v17 = 0x1::vector::empty<vector<u8>>();
        let v18 = 0x1::vector::empty<u64>();
        let v19 = 0x1::vector::empty<vector<u8>>();
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg0.merkle_tree, v1);
        0x1::vector::push_back<vector<u8>>(&mut v17, *0x1::vector::borrow<vector<u8>>(&arg4, 0));
        0x1::vector::push_back<u64>(&mut v18, 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree));
        0x1::vector::push_back<vector<u8>>(&mut v19, v1);
        if (!is_zero_commitment(&v6)) {
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg0.merkle_tree, v6);
            0x1::vector::push_back<vector<u8>>(&mut v17, *0x1::vector::borrow<vector<u8>>(&arg4, 1));
            0x1::vector::push_back<u64>(&mut v18, 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree));
            0x1::vector::push_back<vector<u8>>(&mut v19, v6);
        };
        let v20 = TransferEvent{
            pool_id            : 0x2::object::id<PrivacyPool<T0>>(arg0),
            input_nullifiers   : v16,
            output_positions   : v18,
            output_commitments : v19,
            output_notes       : v17,
        };
        0x2::event::emit<TransferEvent>(v20);
    }

    fun assert_admin_cap<T0>(arg0: &PrivacyPool<T0>, arg1: &PoolAdminCap) {
        assert!(arg1.pool_id == 0x2::object::id<PrivacyPool<T0>>(arg0), 2);
    }

    fun create_pool<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : PrivacyPool<T0> {
        PrivacyPool<T0>{
            id                : 0x2::object::new(arg3),
            balance           : 0x2::balance::zero<T0>(),
            merkle_tree       : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::new(arg3),
            nullifiers        : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::new(arg3),
            vk_bytes          : arg0,
            transfer_vk_bytes : arg1,
            swap_vk_bytes     : arg2,
            historical_roots  : 0x1::vector::empty<vector<u8>>(),
            root_head         : 0,
        }
    }

    public fun create_shared_pool<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pool<T0>(arg0, arg1, arg2, arg3);
        let v1 = PoolAdminCap{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::id<PrivacyPool<T0>>(&v0),
        };
        0x2::transfer::share_object<PrivacyPool<T0>>(v0);
        0x2::transfer::transfer<PoolAdminCap>(v1, 0x2::tx_context::sender(arg3));
    }

    fun extract_field(arg0: &vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg1 + 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    fun field_element_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0x2::bcs::new(*arg0);
        0x2::bcs::peel_u256(&mut v0)
    }

    fun field_element_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0x2::bcs::new(*arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    public fun get_balance<T0>(arg0: &PrivacyPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_merkle_root<T0>(arg0: &PrivacyPool<T0>) : vector<u8> {
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_root(&arg0.merkle_tree)
    }

    public fun get_note_count<T0>(arg0: &PrivacyPool<T0>) : u64 {
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree)
    }

    public fun is_nullifier_spent<T0>(arg0: &PrivacyPool<T0>, arg1: vector<u8>) : bool {
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, arg1)
    }

    fun is_valid_root<T0>(arg0: &PrivacyPool<T0>, arg1: &vector<u8>) : bool {
        if (*arg1 == 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_root(&arg0.merkle_tree)) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.historical_roots)) {
            if (*arg1 == *0x1::vector::borrow<vector<u8>>(&arg0.historical_roots, v0)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_zero_commitment(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun parse_swap_public_inputs(arg0: &vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        (extract_field(arg0, 0), extract_field(arg0, 32), extract_field(arg0, 64), extract_field(arg0, 96), extract_field(arg0, 128), extract_field(arg0, 160), extract_field(arg0, 192), extract_field(arg0, 224))
    }

    fun parse_transfer_public_inputs(arg0: &vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        (extract_field(arg0, 0), extract_field(arg0, 32), extract_field(arg0, 64), extract_field(arg0, 96), extract_field(arg0, 128))
    }

    fun parse_unshield_public_inputs(arg0: &vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        (extract_field(arg0, 0), extract_field(arg0, 32), extract_field(arg0, 64), extract_field(arg0, 96), extract_field(arg0, 128))
    }

    fun save_historical_root<T0>(arg0: &mut PrivacyPool<T0>) {
        if (0x1::vector::length<vector<u8>>(&arg0.historical_roots) < 100) {
            0x1::vector::push_back<vector<u8>>(&mut arg0.historical_roots, 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_root(&arg0.merkle_tree));
        } else {
            *0x1::vector::borrow_mut<vector<u8>>(&mut arg0.historical_roots, arg0.root_head) = 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_root(&arg0.merkle_tree);
            arg0.root_head = (arg0.root_head + 1) % 100;
        };
    }

    public fun shield<T0>(arg0: &mut PrivacyPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 6);
        save_historical_root<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg0.merkle_tree, arg2);
        let v0 = ShieldEvent{
            pool_id        : 0x2::object::id<PrivacyPool<T0>>(arg0),
            position       : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree),
            commitment     : arg2,
            encrypted_note : arg3,
        };
        0x2::event::emit<ShieldEvent>(v0);
    }

    public fun swap_bid<T0, T1>(arg0: &mut PrivacyPool<T1>, arg1: &mut PrivacyPool<T0>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: &0x2::clock::Clock, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg4) == 256, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == 2, 5);
        let (v0, v1, v2, _, _, v5, v6, v7) = parse_swap_public_inputs(&arg4);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v2;
        let v12 = field_element_to_u64(&v9);
        let v13 = *0x1::vector::borrow<vector<u8>>(&arg5, 0);
        let v14 = *0x1::vector::borrow<vector<u8>>(&arg5, 1);
        let v15 = 0x1::vector::empty<u256>();
        let v16 = &mut v15;
        0x1::vector::push_back<u256>(v16, field_element_to_u256(&v13));
        0x1::vector::push_back<u256>(v16, field_element_to_u256(&v14));
        assert!(u256_to_field_element(0x2::poseidon::poseidon_bn254(&v15)) == v0, 5);
        assert!(is_valid_root<T1>(arg0, &v8), 3);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v13), 1);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v14), 1);
        let v17 = 0x2::groth16::bn254();
        let v18 = 0x2::groth16::prepare_verifying_key(&v17, &arg0.swap_vk_bytes);
        let v19 = 0x2::groth16::public_proof_inputs_from_bytes(arg4);
        let v20 = 0x2::groth16::proof_points_from_bytes(arg3);
        let v21 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v21, &v18, &v19, &v20), 2);
        let v22 = field_element_to_u64(&v10);
        assert!(0x2::balance::value<T1>(&arg0.balance) >= v22, 4);
        let (v23, v24, v25) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg2, 0x2::coin::take<T1>(&mut arg0.balance, v22, arg10), arg6, v12, arg7, arg10);
        let v26 = v23;
        let v27 = 0x2::coin::value<T0>(&v26);
        assert!(v27 >= v12, 7);
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(v24));
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(v26));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v25, 0x2::tx_context::sender(arg10));
        let v28 = 0x1::vector::empty<vector<u8>>();
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v13);
        0x1::vector::push_back<vector<u8>>(&mut v28, v13);
        if (!is_zero_commitment(&v14)) {
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v14);
            0x1::vector::push_back<vector<u8>>(&mut v28, v14);
        };
        save_historical_root<T0>(arg1);
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg1.merkle_tree, v1);
        if (!is_zero_commitment(&v11)) {
            save_historical_root<T1>(arg0);
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg0.merkle_tree, v11);
            let v29 = ShieldEvent{
                pool_id        : 0x2::object::id<PrivacyPool<T1>>(arg0),
                position       : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree),
                commitment     : v11,
                encrypted_note : arg9,
            };
            0x2::event::emit<ShieldEvent>(v29);
        };
        let v30 = SwapEvent{
            pool_in_id            : 0x2::object::id<PrivacyPool<T1>>(arg0),
            pool_out_id           : 0x2::object::id<PrivacyPool<T0>>(arg1),
            amount_in             : v22,
            amount_out            : v27,
            input_nullifiers      : v28,
            swap_position         : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg1.merkle_tree),
            swap_commitment       : v1,
            encrypted_output_note : arg8,
        };
        0x2::event::emit<SwapEvent>(v30);
    }

    fun u256_to_field_element(arg0: u256) : vector<u8> {
        0x2::bcs::to_bytes<u256>(&arg0)
    }

    public fun unshield<T0>(arg0: &mut PrivacyPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 160, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 2, 5);
        let (v0, v1, v2, _, v4) = parse_unshield_public_inputs(&arg2);
        let v5 = v4;
        let v6 = v2;
        let v7 = v1;
        let v8 = *0x1::vector::borrow<vector<u8>>(&arg3, 0);
        let v9 = *0x1::vector::borrow<vector<u8>>(&arg3, 1);
        let v10 = 0x1::vector::empty<u256>();
        let v11 = &mut v10;
        0x1::vector::push_back<u256>(v11, field_element_to_u256(&v8));
        0x1::vector::push_back<u256>(v11, field_element_to_u256(&v9));
        assert!(u256_to_field_element(0x2::poseidon::poseidon_bn254(&v10)) == v0, 5);
        let v12 = field_element_to_u64(&v6);
        assert!(is_valid_root<T0>(arg0, &v5), 3);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v8), 1);
        assert!(!0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::is_spent(&arg0.nullifiers, v9), 1);
        let v13 = 0x2::groth16::bn254();
        let v14 = 0x2::groth16::prepare_verifying_key(&v13, &arg0.vk_bytes);
        let v15 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v16 = 0x2::groth16::proof_points_from_bytes(arg1);
        let v17 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v17, &v14, &v15, &v16), 2);
        0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v8);
        if (!is_zero_commitment(&v9)) {
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::nullifier::mark_spent(&mut arg0.nullifiers, v9);
        };
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v12, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v12, arg6), arg4);
        if (!is_zero_commitment(&v7)) {
            save_historical_root<T0>(arg0);
            0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::insert(&mut arg0.merkle_tree, v7);
            let v18 = ShieldEvent{
                pool_id        : 0x2::object::id<PrivacyPool<T0>>(arg0),
                position       : 0x4e61ac606a3cfbb729e468de4371fef4fc910df07756644c7b66e29cb4681f42::merkle_tree::get_next_index(&arg0.merkle_tree),
                commitment     : v7,
                encrypted_note : arg5,
            };
            0x2::event::emit<ShieldEvent>(v18);
        };
        let v19 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v19, v8);
        if (!is_zero_commitment(&v9)) {
            0x1::vector::push_back<vector<u8>>(&mut v19, v9);
        };
        let v20 = UnshieldEvent{
            pool_id          : 0x2::object::id<PrivacyPool<T0>>(arg0),
            input_nullifiers : v19,
            recipient        : arg4,
            amount           : v12,
        };
        0x2::event::emit<UnshieldEvent>(v20);
    }

    public fun update_swap_vk<T0>(arg0: &mut PrivacyPool<T0>, arg1: &PoolAdminCap, arg2: vector<u8>) {
        assert_admin_cap<T0>(arg0, arg1);
        arg0.swap_vk_bytes = arg2;
    }

    public fun update_transfer_vk<T0>(arg0: &mut PrivacyPool<T0>, arg1: &PoolAdminCap, arg2: vector<u8>) {
        assert_admin_cap<T0>(arg0, arg1);
        arg0.transfer_vk_bytes = arg2;
    }

    public fun update_unshield_vk<T0>(arg0: &mut PrivacyPool<T0>, arg1: &PoolAdminCap, arg2: vector<u8>) {
        assert_admin_cap<T0>(arg0, arg1);
        arg0.vk_bytes = arg2;
    }

    // decompiled from Move bytecode v6
}

