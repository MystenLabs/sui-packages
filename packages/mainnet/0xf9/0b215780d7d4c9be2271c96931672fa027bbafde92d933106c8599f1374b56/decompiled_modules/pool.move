module 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::pool {
    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PrivacyPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        merkle_tree: 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::MerkleTree,
        nullifiers: 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::NullifierRegistry,
        vk_bytes: vector<u8>,
        transfer_vk_bytes: vector<u8>,
        swap_vk_bytes: vector<u8>,
        historical_roots: vector<vector<u8>>,
    }

    struct ShieldEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position: u64,
        commitment: vector<u8>,
        encrypted_note: vector<u8>,
    }

    struct UnshieldEvent has copy, drop {
        pool_id: 0x2::object::ID,
        nullifier: vector<u8>,
        recipient: address,
        amount: u64,
        change_commitment: vector<u8>,
        change_position: u64,
    }

    struct TransferEvent has copy, drop {
        pool_id: 0x2::object::ID,
        input_nullifiers: vector<vector<u8>>,
        output_commitments: vector<vector<u8>>,
        output_positions: vector<u64>,
        output_notes: vector<vector<u8>>,
    }

    struct SwapEvent has copy, drop {
        pool_in_id: 0x2::object::ID,
        pool_out_id: 0x2::object::ID,
        input_nullifiers: vector<vector<u8>>,
        output_commitment: vector<u8>,
        change_commitment: vector<u8>,
        output_position: u64,
        change_position: u64,
        amount_in: u64,
        amount_out: u64,
        encrypted_output_note: vector<u8>,
        encrypted_change_note: vector<u8>,
    }

    public fun swap<T0, T1>(arg0: &mut PrivacyPool<T0>, arg1: &mut PrivacyPool<T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg4) == 256, 5);
        assert!(arg5 > 0, 6);
        let (_, _, v2, v3, v4, _, v6, v7) = parse_swap_public_inputs(&arg4);
        let v8 = v2;
        assert!(is_valid_root<T0>(arg0, &v8), 3);
        assert!(!0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::is_spent(&arg0.nullifiers, v3), 1);
        assert!(!0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::is_spent(&arg0.nullifiers, v4), 1);
        let v9 = 0x2::groth16::bn254();
        let v10 = 0x2::groth16::prepare_verifying_key(&v9, &arg0.swap_vk_bytes);
        let v11 = 0x2::groth16::public_proof_inputs_from_bytes(arg4);
        let v12 = 0x2::groth16::proof_points_from_bytes(arg3);
        let v13 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v13, &v10, &v11, &v12), 2);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg5, 4);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg0.balance, arg5, arg9)));
        assert!(0x2::balance::value<T1>(&arg1.balance) >= arg5, 4);
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg1.balance, arg5, arg9)));
        assert!(arg5 >= arg6, 7);
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::mark_spent(&mut arg0.nullifiers, v3);
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::mark_spent(&mut arg0.nullifiers, v4);
        save_historical_root<T0>(arg0);
        save_historical_root<T1>(arg1);
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::insert(&mut arg1.merkle_tree, v6);
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::insert(&mut arg0.merkle_tree, v7);
        let v14 = 0x1::vector::empty<vector<u8>>();
        let v15 = &mut v14;
        0x1::vector::push_back<vector<u8>>(v15, v3);
        0x1::vector::push_back<vector<u8>>(v15, v4);
        let v16 = SwapEvent{
            pool_in_id            : 0x2::object::id<PrivacyPool<T0>>(arg0),
            pool_out_id           : 0x2::object::id<PrivacyPool<T1>>(arg1),
            input_nullifiers      : v14,
            output_commitment     : v6,
            change_commitment     : v7,
            output_position       : 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg1.merkle_tree),
            change_position       : 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg0.merkle_tree),
            amount_in             : arg5,
            amount_out            : arg5,
            encrypted_output_note : arg7,
            encrypted_change_note : arg8,
        };
        0x2::event::emit<SwapEvent>(v16);
    }

    public fun transfer<T0>(arg0: &mut PrivacyPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 192, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == 2, 5);
        let (v0, v1, v2, v3, _, v5) = parse_transfer_public_inputs(&arg2);
        let v6 = v5;
        let v7 = v3;
        let v8 = v1;
        assert!(is_valid_root<T0>(arg0, &v6), 3);
        assert!(!0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::is_spent(&arg0.nullifiers, v0), 1);
        assert!(!0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::is_spent(&arg0.nullifiers, v8), 1);
        let v9 = 0x2::groth16::bn254();
        let v10 = 0x2::groth16::prepare_verifying_key(&v9, &arg0.transfer_vk_bytes);
        let v11 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v12 = 0x2::groth16::proof_points_from_bytes(arg1);
        let v13 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v13, &v10, &v11, &v12), 2);
        let v14 = 0x1::vector::empty<vector<u8>>();
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::mark_spent(&mut arg0.nullifiers, v0);
        0x1::vector::push_back<vector<u8>>(&mut v14, v0);
        if (!is_zero_commitment(&v8)) {
            0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::mark_spent(&mut arg0.nullifiers, v8);
            0x1::vector::push_back<vector<u8>>(&mut v14, v8);
        };
        save_historical_root<T0>(arg0);
        let v15 = 0x1::vector::empty<vector<u8>>();
        let v16 = 0x1::vector::empty<vector<u8>>();
        let v17 = 0x1::vector::empty<u64>();
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::insert(&mut arg0.merkle_tree, v2);
        0x1::vector::push_back<vector<u8>>(&mut v15, *0x1::vector::borrow<vector<u8>>(&arg3, 0));
        0x1::vector::push_back<vector<u8>>(&mut v16, v2);
        0x1::vector::push_back<u64>(&mut v17, 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg0.merkle_tree));
        if (!is_zero_commitment(&v7)) {
            0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::insert(&mut arg0.merkle_tree, v7);
            0x1::vector::push_back<vector<u8>>(&mut v15, *0x1::vector::borrow<vector<u8>>(&arg3, 1));
            0x1::vector::push_back<vector<u8>>(&mut v16, v7);
            0x1::vector::push_back<u64>(&mut v17, 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg0.merkle_tree));
        };
        let v18 = TransferEvent{
            pool_id            : 0x2::object::id<PrivacyPool<T0>>(arg0),
            input_nullifiers   : v14,
            output_commitments : v16,
            output_positions   : v17,
            output_notes       : v15,
        };
        0x2::event::emit<TransferEvent>(v18);
    }

    fun create_pool<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : PrivacyPool<T0> {
        PrivacyPool<T0>{
            id                : 0x2::object::new(arg3),
            balance           : 0x2::balance::zero<T0>(),
            merkle_tree       : 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::new(arg3),
            nullifiers        : 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::new(arg3),
            vk_bytes          : arg0,
            transfer_vk_bytes : arg1,
            swap_vk_bytes     : arg2,
            historical_roots  : 0x1::vector::empty<vector<u8>>(),
        }
    }

    public fun create_shared_pool<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : PoolAdminCap {
        let v0 = create_pool<T0>(arg0, arg1, arg2, arg3);
        let v1 = PoolAdminCap{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::id<PrivacyPool<T0>>(&v0),
        };
        0x2::transfer::share_object<PrivacyPool<T0>>(v0);
        v1
    }

    fun field_element_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 1;
        let v2 = 0;
        while (v2 < 8) {
            v0 = v0 + (*0x1::vector::borrow<u8>(arg0, v2) as u64) * v1;
            if (v2 < 7) {
                v1 = v1 * 256;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_balance<T0>(arg0: &PrivacyPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_merkle_root<T0>(arg0: &PrivacyPool<T0>) : vector<u8> {
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_root(&arg0.merkle_tree)
    }

    public fun get_note_count<T0>(arg0: &PrivacyPool<T0>) : u64 {
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg0.merkle_tree)
    }

    public fun is_nullifier_spent<T0>(arg0: &PrivacyPool<T0>, arg1: vector<u8>) : bool {
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::is_spent(&arg0.nullifiers, arg1)
    }

    fun is_valid_root<T0>(arg0: &PrivacyPool<T0>, arg1: &vector<u8>) : bool {
        if (*arg1 == 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_root(&arg0.merkle_tree)) {
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
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 0x1::vector::empty<u8>();
        let v8 = 0;
        while (v8 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 96) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 128) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 160) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 192) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 224) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        while (v8 < 256) {
            0x1::vector::push_back<u8>(&mut v7, *0x1::vector::borrow<u8>(arg0, v8));
            v8 = v8 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    fun parse_transfer_public_inputs(arg0: &vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0;
        while (v6 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v6));
            v6 = v6 + 1;
        };
        while (v6 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v6));
            v6 = v6 + 1;
        };
        while (v6 < 96) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v6));
            v6 = v6 + 1;
        };
        while (v6 < 128) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg0, v6));
            v6 = v6 + 1;
        };
        while (v6 < 160) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg0, v6));
            v6 = v6 + 1;
        };
        while (v6 < 192) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(arg0, v6));
            v6 = v6 + 1;
        };
        (v0, v1, v2, v3, v4, v5)
    }

    fun parse_unshield_public_inputs(arg0: &vector<u8>) : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v4));
            v4 = v4 + 1;
        };
        while (v4 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v4));
            v4 = v4 + 1;
        };
        while (v4 < 96) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v4));
            v4 = v4 + 1;
        };
        while (v4 < 128) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg0, v4));
            v4 = v4 + 1;
        };
        (v1, v0, v3, v2)
    }

    fun save_historical_root<T0>(arg0: &mut PrivacyPool<T0>) {
        0x1::vector::push_back<vector<u8>>(&mut arg0.historical_roots, 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_root(&arg0.merkle_tree));
        while (0x1::vector::length<vector<u8>>(&arg0.historical_roots) > 100) {
            0x1::vector::remove<vector<u8>>(&mut arg0.historical_roots, 0);
        };
    }

    public fun shield<T0>(arg0: &mut PrivacyPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 6);
        save_historical_root<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::insert(&mut arg0.merkle_tree, arg2);
        let v0 = ShieldEvent{
            pool_id        : 0x2::object::id<PrivacyPool<T0>>(arg0),
            position       : 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg0.merkle_tree),
            commitment     : arg2,
            encrypted_note : arg3,
        };
        0x2::event::emit<ShieldEvent>(v0);
    }

    public fun unshield<T0>(arg0: &mut PrivacyPool<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 128, 5);
        let (v0, v1, v2, v3) = parse_unshield_public_inputs(&arg2);
        let v4 = v3;
        let v5 = v2;
        let v6 = v0;
        let v7 = field_element_to_u64(&v5);
        assert!(is_valid_root<T0>(arg0, &v6), 3);
        assert!(!0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::is_spent(&arg0.nullifiers, v1), 1);
        let v8 = 0x2::groth16::bn254();
        let v9 = 0x2::groth16::prepare_verifying_key(&v8, &arg0.vk_bytes);
        let v10 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v11 = 0x2::groth16::proof_points_from_bytes(arg1);
        let v12 = 0x2::groth16::bn254();
        assert!(0x2::groth16::verify_groth16_proof(&v12, &v9, &v10, &v11), 2);
        0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::nullifier::mark_spent(&mut arg0.nullifiers, v1);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v7, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v7, arg5), arg3);
        let v13 = 0;
        if (!is_zero_commitment(&v4)) {
            save_historical_root<T0>(arg0);
            let v14 = 0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::get_next_index(&arg0.merkle_tree);
            v13 = v14;
            0xf90b215780d7d4c9be2271c96931672fa027bbafde92d933106c8599f1374b56::merkle_tree::insert(&mut arg0.merkle_tree, v4);
            let v15 = ShieldEvent{
                pool_id        : 0x2::object::id<PrivacyPool<T0>>(arg0),
                position       : v14,
                commitment     : v4,
                encrypted_note : arg4,
            };
            0x2::event::emit<ShieldEvent>(v15);
        };
        let v16 = UnshieldEvent{
            pool_id           : 0x2::object::id<PrivacyPool<T0>>(arg0),
            nullifier         : v1,
            recipient         : arg3,
            amount            : v7,
            change_commitment : v4,
            change_position   : v13,
        };
        0x2::event::emit<UnshieldEvent>(v16);
    }

    public fun update_swap_vk<T0>(arg0: &mut PrivacyPool<T0>, arg1: &PoolAdminCap, arg2: vector<u8>) {
        assert!(arg1.pool_id == 0x2::object::id<PrivacyPool<T0>>(arg0), 2);
        arg0.swap_vk_bytes = arg2;
    }

    public fun update_transfer_vk<T0>(arg0: &mut PrivacyPool<T0>, arg1: &PoolAdminCap, arg2: vector<u8>) {
        assert!(arg1.pool_id == 0x2::object::id<PrivacyPool<T0>>(arg0), 2);
        arg0.transfer_vk_bytes = arg2;
    }

    public fun update_unshield_vk<T0>(arg0: &mut PrivacyPool<T0>, arg1: &PoolAdminCap, arg2: vector<u8>) {
        assert!(arg1.pool_id == 0x2::object::id<PrivacyPool<T0>>(arg0), 2);
        arg0.vk_bytes = arg2;
    }

    // decompiled from Move bytecode v6
}

