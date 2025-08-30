module 0xe9c2e055948504bd88eef9a21a14bc70cc439dd84d0b43ed2ad140b178d6c97::privacy_pool_v4 {
    struct DepositEvent has copy, drop {
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

    struct PrivacyPoolV4 has store, key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        commitments: vector<vector<u8>>,
        nullifiers: vector<vector<u8>>,
        enabled: bool,
        total_deposits: u64,
        deposit_pvk: 0x1::option::Option<0x2::groth16::PreparedVerifyingKey>,
        withdraw_pvk: 0x1::option::Option<0x2::groth16::PreparedVerifyingKey>,
        curve: 0x2::groth16::Curve,
    }

    struct AdminCapV4 has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCapV4{
            id      : 0x2::object::new(arg0),
            pool_id : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = PrivacyPoolV4{
            id             : v0,
            balance        : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            commitments    : 0x1::vector::empty<vector<u8>>(),
            nullifiers     : 0x1::vector::empty<vector<u8>>(),
            enabled        : true,
            total_deposits : 0,
            deposit_pvk    : 0x1::option::none<0x2::groth16::PreparedVerifyingKey>(),
            withdraw_pvk   : 0x1::option::none<0x2::groth16::PreparedVerifyingKey>(),
            curve          : 0x2::groth16::bn254(),
        };
        0x2::transfer::transfer<AdminCapV4>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PrivacyPoolV4>(v2);
    }

    public entry fun deposit_v4(arg0: &mut PrivacyPoolV4, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(0x1::option::is_some<0x2::groth16::PreparedVerifyingKey>(&arg0.deposit_pvk), 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0.commitments)) {
            assert!(*0x1::vector::borrow<vector<u8>>(&arg0.commitments, v1) != arg2, 6);
            v1 = v1 + 1;
        };
        let v2 = 0x2::groth16::proof_points_from_bytes(arg3);
        let v3 = 0x2::groth16::public_proof_inputs_from_bytes(arg4);
        assert!(0x2::groth16::verify_groth16_proof(&arg0.curve, 0x1::option::borrow<0x2::groth16::PreparedVerifyingKey>(&arg0.deposit_pvk), &v3, &v2), 1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.commitments, arg2);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        arg0.total_deposits = arg0.total_deposits + 1;
        let v4 = DepositEvent{
            commitment : arg2,
            amount     : v0,
            timestamp  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun get_balance_v4(arg0: &PrivacyPoolV4) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_commitment_count_v4(arg0: &PrivacyPoolV4) : u64 {
        0x1::vector::length<vector<u8>>(&arg0.commitments)
    }

    public fun get_commitments_v4(arg0: &PrivacyPoolV4) : vector<vector<u8>> {
        arg0.commitments
    }

    public fun get_pool_stats_v4(arg0: &PrivacyPoolV4) : (u64, u64, bool, u64, bool) {
        let v0 = 0x1::option::is_some<0x2::groth16::PreparedVerifyingKey>(&arg0.deposit_pvk) && 0x1::option::is_some<0x2::groth16::PreparedVerifyingKey>(&arg0.withdraw_pvk);
        (arg0.total_deposits, 0x2::coin::value<0x2::sui::SUI>(&arg0.balance), arg0.enabled, 0x1::vector::length<vector<u8>>(&arg0.commitments), v0)
    }

    public fun get_total_deposits_v4(arg0: &PrivacyPoolV4) : u64 {
        arg0.total_deposits
    }

    public fun has_commitment_v4(arg0: &PrivacyPoolV4, arg1: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.commitments)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.commitments, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_nullifier_used_v4(arg0: &PrivacyPoolV4, arg1: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.nullifiers)) {
            if (*0x1::vector::borrow<vector<u8>>(&arg0.nullifiers, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun set_enabled_v4(arg0: &AdminCapV4, arg1: &mut PrivacyPoolV4, arg2: bool) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.pool_id, 4);
        arg1.enabled = arg2;
    }

    public entry fun update_verification_keys_v4(arg0: &AdminCapV4, arg1: &mut PrivacyPoolV4, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.pool_id, 4);
        arg1.deposit_pvk = 0x1::option::some<0x2::groth16::PreparedVerifyingKey>(0x2::groth16::prepare_verifying_key(&arg1.curve, &arg2));
        arg1.withdraw_pvk = 0x1::option::some<0x2::groth16::PreparedVerifyingKey>(0x2::groth16::prepare_verifying_key(&arg1.curve, &arg3));
    }

    public entry fun withdraw_v4(arg0: &mut PrivacyPoolV4, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(0x1::option::is_some<0x2::groth16::PreparedVerifyingKey>(&arg0.withdraw_pvk), 7);
        assert!(arg4 != @0x0, 5);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.nullifiers)) {
            assert!(*0x1::vector::borrow<vector<u8>>(&arg0.nullifiers, v0) != arg3, 2);
            v0 = v0 + 1;
        };
        assert!(arg5 <= 0x2::coin::value<0x2::sui::SUI>(&arg0.balance), 0);
        let v1 = 0x2::groth16::proof_points_from_bytes(arg1);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        assert!(0x2::groth16::verify_groth16_proof(&arg0.curve, 0x1::option::borrow<0x2::groth16::PreparedVerifyingKey>(&arg0.withdraw_pvk), &v2, &v1), 1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.nullifiers, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.balance, arg5, arg7), arg4);
        let v3 = WithdrawEvent{
            nullifier : arg3,
            recipient : arg4,
            amount    : arg5,
            timestamp : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<WithdrawEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

