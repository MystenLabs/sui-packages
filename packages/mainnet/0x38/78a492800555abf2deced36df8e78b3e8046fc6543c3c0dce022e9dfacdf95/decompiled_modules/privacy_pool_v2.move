module 0x3878a492800555abf2deced36df8e78b3e8046fc6543c3c0dce022e9dfacdf95::privacy_pool_v2 {
    struct PrivacyPoolV2 has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        merkle_tree: 0x3878a492800555abf2deced36df8e78b3e8046fc6543c3c0dce022e9dfacdf95::merkle_tree::MerkleTree,
        nullifiers: vector<vector<u8>>,
        enabled: bool,
        fee_balance: 0x2::coin::Coin<0x2::sui::SUI>,
        prepared_vk: 0x2::groth16::PreparedVerifyingKey,
        total_deposits: u64,
        total_withdrawals: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        commitment: vector<u8>,
        amount: u64,
        leaf_index: u64,
        timestamp: u64,
    }

    struct WithdrawalEvent has copy, drop {
        nullifier_hash: vector<u8>,
        recipient: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    public entry fun deposit(arg0: &mut PrivacyPoolV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let (v1, _) = 0x3878a492800555abf2deced36df8e78b3e8046fc6543c3c0dce022e9dfacdf95::merkle_tree::append(&mut arg0.merkle_tree, arg2);
        arg0.total_deposits = arg0.total_deposits + v0;
        let v3 = DepositEvent{
            commitment : arg2,
            amount     : v0,
            leaf_index : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public fun get_pool_balance(arg0: &PrivacyPoolV2) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_total_deposits(arg0: &PrivacyPoolV2) : u64 {
        arg0.total_deposits
    }

    public fun get_total_withdrawals(arg0: &PrivacyPoolV2) : u64 {
        arg0.total_withdrawals
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PrivacyPoolV2{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            merkle_tree       : 0x3878a492800555abf2deced36df8e78b3e8046fc6543c3c0dce022e9dfacdf95::merkle_tree::initialize(26, arg0),
            nullifiers        : 0x1::vector::empty<vector<u8>>(),
            enabled           : true,
            fee_balance       : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            prepared_vk       : 0x2::groth16::pvk_from_bytes(0x1::vector::empty<u8>(), 0x1::vector::empty<u8>(), 0x1::vector::empty<u8>(), 0x1::vector::empty<u8>()),
            total_deposits    : 0,
            total_withdrawals : 0,
        };
        0x2::transfer::share_object<PrivacyPoolV2>(v1);
    }

    public fun is_nullifier_used(arg0: &PrivacyPoolV2, arg1: vector<u8>) : bool {
        0x1::vector::contains<vector<u8>>(&arg0.nullifiers, &arg1)
    }

    public entry fun set_pool_enabled(arg0: &AdminCap, arg1: &mut PrivacyPoolV2, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun update_verification_key_native(arg0: &AdminCap, arg1: &mut PrivacyPoolV2, arg2: vector<u8>, arg3: u8) {
        let v0 = if (arg3 == 0) {
            0x2::groth16::bls12381()
        } else {
            0x2::groth16::bn254()
        };
        let v1 = v0;
        arg1.prepared_vk = 0x2::groth16::prepare_verifying_key(&v1, &arg2);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut PrivacyPoolV2, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1.fee_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.fee_balance, v0, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun withdraw_native(arg0: &mut PrivacyPoolV2, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: vector<u8>, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(!0x1::vector::contains<vector<u8>>(&arg0.nullifiers, &arg3), 1);
        assert!(0x3878a492800555abf2deced36df8e78b3e8046fc6543c3c0dce022e9dfacdf95::merkle_tree::is_valid_root(&arg0.merkle_tree, arg6), 2);
        let v0 = if (arg7 == 0) {
            0x2::groth16::bls12381()
        } else {
            0x2::groth16::bn254()
        };
        let v1 = v0;
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg1);
        assert!(0x2::groth16::verify_groth16_proof(&v1, &arg0.prepared_vk, &v2, &v3), 0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.nullifiers, arg3);
        let v4 = arg5 / 1000;
        let v5 = arg5 - v4;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v4, arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v5, arg9), arg4);
        arg0.total_withdrawals = arg0.total_withdrawals + arg5;
        let v6 = WithdrawalEvent{
            nullifier_hash : arg3,
            recipient      : arg4,
            amount         : v5,
            fee            : v4,
            timestamp      : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<WithdrawalEvent>(v6);
    }

    public entry fun withdraw_with_proof_components(arg0: &mut PrivacyPoolV2, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: address, arg7: u64, arg8: vector<u8>, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(!0x1::vector::contains<vector<u8>>(&arg0.nullifiers, &arg5), 1);
        assert!(0x3878a492800555abf2deced36df8e78b3e8046fc6543c3c0dce022e9dfacdf95::merkle_tree::is_valid_root(&arg0.merkle_tree, arg8), 2);
        let v0 = if (arg9 == 0) {
            0x2::groth16::bls12381()
        } else {
            0x2::groth16::bn254()
        };
        let v1 = v0;
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, arg1);
        0x1::vector::append<u8>(&mut v2, arg2);
        0x1::vector::append<u8>(&mut v2, arg3);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(&arg4)) {
            0x1::vector::append<u8>(&mut v3, *0x1::vector::borrow<vector<u8>>(&arg4, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::groth16::public_proof_inputs_from_bytes(v3);
        let v6 = 0x2::groth16::proof_points_from_bytes(v2);
        assert!(0x2::groth16::verify_groth16_proof(&v1, &arg0.prepared_vk, &v5, &v6), 0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.nullifiers, arg5);
        let v7 = arg7 / 1000;
        let v8 = arg7 - v7;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v7, arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, v8, arg11), arg6);
        arg0.total_withdrawals = arg0.total_withdrawals + arg7;
        let v9 = WithdrawalEvent{
            nullifier_hash : arg5,
            recipient      : arg6,
            amount         : v8,
            fee            : v7,
            timestamp      : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<WithdrawalEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

