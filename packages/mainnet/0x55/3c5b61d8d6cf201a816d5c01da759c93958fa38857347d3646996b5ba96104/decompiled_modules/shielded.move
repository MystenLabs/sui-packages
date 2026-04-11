module 0x3b1dcced3f585157f48afd14a84f42e65ee57dd38be9dd73d7d94a0a1b690782::shielded {
    struct ShieldedVault has key {
        id: 0x2::object::UID,
        sender: address,
        commitment: vector<u8>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        expires_ms: u64,
        sealed_opening: vector<u8>,
    }

    struct ShieldedDeposited has copy, drop {
        vault_id: address,
        sender: address,
        commitment: vector<u8>,
        expires_ms: u64,
    }

    struct ShieldedClaimed has copy, drop {
        vault_id: address,
        claimer: address,
        amount_mist: u64,
    }

    struct ShieldedRecalled has copy, drop {
        vault_id: address,
        sender: address,
        amount_mist: u64,
    }

    public fun challenge_domain_tag() : vector<u8> {
        b"thunder-iou-shielded::challenge::v1"
    }

    entry fun claim(arg0: ShieldedVault, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let ShieldedVault {
            id             : v0,
            sender         : _,
            commitment     : v2,
            balance        : v3,
            expires_ms     : v4,
            sealed_opening : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        let v8 = compute_commitment(arg1, arg2);
        assert!(*0x2::group_ops::bytes<0x2::bls12381::G1>(&v8) == v2, 4);
        assert!(0x2::clock::timestamp_ms(arg3) < v4, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v6) == arg2, 1);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg4), 0x2::tx_context::sender(arg4));
        let v9 = ShieldedClaimed{
            vault_id    : 0x2::object::uid_to_address(&v7),
            claimer     : 0x2::tx_context::sender(arg4),
            amount_mist : arg2,
        };
        0x2::event::emit<ShieldedClaimed>(v9);
    }

    fun compute_commitment(arg0: vector<u8>, arg1: u64) : 0x2::group_ops::Element<0x2::bls12381::G1> {
        let v0 = 0x2::bls12381::scalar_from_bytes(&arg0);
        let v1 = 0x2::bls12381::scalar_from_u64(arg1);
        let v2 = 0x2::bls12381::g1_generator();
        let v3 = h_generator();
        let v4 = 0x2::bls12381::g1_mul(&v0, &v2);
        let v5 = 0x2::bls12381::g1_mul(&v1, &v3);
        0x2::bls12381::g1_add(&v4, &v5)
    }

    entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = compute_commitment(arg1, v0);
        let v2 = 0x2::clock::timestamp_ms(arg4) + arg2;
        let v3 = ShieldedVault{
            id             : 0x2::object::new(arg5),
            sender         : 0x2::tx_context::sender(arg5),
            commitment     : *0x2::group_ops::bytes<0x2::bls12381::G1>(&v1),
            balance        : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            expires_ms     : v2,
            sealed_opening : arg3,
        };
        let v4 = ShieldedDeposited{
            vault_id   : 0x2::object::uid_to_address(&v3.id),
            sender     : v3.sender,
            commitment : v3.commitment,
            expires_ms : v2,
        };
        0x2::event::emit<ShieldedDeposited>(v4);
        0x2::transfer::share_object<ShieldedVault>(v3);
    }

    public fun h_generator() : 0x2::group_ops::Element<0x2::bls12381::G1> {
        let v0 = b"thunder-iou-shielded::H::v1";
        0x2::bls12381::hash_to_g1(&v0)
    }

    entry fun recall(arg0: ShieldedVault, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let ShieldedVault {
            id             : v0,
            sender         : v1,
            commitment     : _,
            balance        : v3,
            expires_ms     : v4,
            sealed_opening : _,
        } = arg0;
        let v6 = v3;
        let v7 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1 || 0x2::clock::timestamp_ms(arg1) >= v4, 2);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2), v1);
        let v8 = ShieldedRecalled{
            vault_id    : 0x2::object::uid_to_address(&v7),
            sender      : v1,
            amount_mist : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<ShieldedRecalled>(v8);
    }

    public fun reserved_invalid_point_code() : u64 {
        5
    }

    // decompiled from Move bytecode v7
}

