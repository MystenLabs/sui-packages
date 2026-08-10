module 0x1cfe7205c3a1f85a08e4eda32a6a125a4055e9556e505dda6490d5172af97d87::withdrawal {
    struct GovernanceCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct GuardianCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct TreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct WithdrawalPool<phantom T0> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        domain_hash: vector<u8>,
        signer_public_keys: vector<vector<u8>>,
        signature_threshold: u8,
        signer_set_version: u64,
        paused: bool,
        paused_at_ms: u64,
        max_claim_amount: u64,
        window_ms: u64,
        max_window_amount: u64,
        window_started_at_ms: u64,
        window_withdrawn: u64,
        total_deposited: u128,
        total_withdrawn: u128,
        vault: 0x2::balance::Balance<T0>,
        next_nonces: 0x2::table::Table<address, u64>,
        used_request_hashes: 0x2::table::Table<vector<u8>, bool>,
    }

    struct WithdrawalVoucher has drop {
        schema_version: u64,
        action: u8,
        domain_hash: vector<u8>,
        pool_id: 0x2::object::ID,
        coin_type_hash: vector<u8>,
        recipient: address,
        amount: u64,
        nonce: u64,
        request_hash: vector<u8>,
        valid_after_ms: u64,
        expires_at_ms: u64,
        signer_set_version: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        governance: address,
        guardian: address,
        treasury: address,
        domain_hash: vector<u8>,
        signer_count: u64,
        signature_threshold: u8,
        max_claim_amount: u64,
        window_ms: u64,
        max_window_amount: u64,
        timestamp_ms: u64,
    }

    struct VaultFunded has copy, drop {
        pool_id: 0x2::object::ID,
        contributor: address,
        amount: u64,
        balance_after: u64,
        timestamp_ms: u64,
    }

    struct WithdrawalExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        nonce: u64,
        request_hash: vector<u8>,
        signer_set_version: u64,
        voucher_digest: vector<u8>,
        balance_after: u64,
        timestamp_ms: u64,
    }

    struct PoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        guardian: address,
        signer_set_version: u64,
        timestamp_ms: u64,
    }

    struct PoolResumed has copy, drop {
        pool_id: 0x2::object::ID,
        governance: address,
        timestamp_ms: u64,
    }

    struct SignerSetRotated has copy, drop {
        pool_id: 0x2::object::ID,
        signer_set_version: u64,
        signer_count: u64,
        signature_threshold: u8,
        timestamp_ms: u64,
    }

    struct LimitsReduced has copy, drop {
        pool_id: 0x2::object::ID,
        max_claim_amount: u64,
        max_window_amount: u64,
        timestamp_ms: u64,
    }

    struct EmergencyWithdrawalExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        balance_after: u64,
        timestamp_ms: u64,
    }

    fun assert_cap<T0>(arg0: &WithdrawalPool<T0>, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<WithdrawalPool<T0>>(arg0) == arg1, 2);
    }

    fun assert_request<T0>(arg0: &WithdrawalPool<T0>, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(!arg0.paused, 3);
        assert!(arg1 != @0x0, 16);
        assert!(arg2 > 0 && arg2 <= arg0.max_claim_amount, 4);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 19);
        assert!(arg7 == arg0.signer_set_version, 5);
        assert!(arg6 >= arg5, 7);
        assert!(arg6 - arg5 <= 600000, 8);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 >= arg5, 6);
        assert!(v0 <= arg6, 7);
        assert!(arg3 == next_nonce<T0>(arg0, arg1), 9);
        assert!(arg3 < 18446744073709551615, 18);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_request_hashes, arg4), 20);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg2, 12);
    }

    fun consume_nonce<T0>(arg0: &mut WithdrawalPool<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.next_nonces, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.next_nonces, arg1) = arg2 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.next_nonces, arg1, arg2 + 1);
        };
    }

    entry fun create_pool<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) >= 8 && 0x1::vector::length<u8>(&arg0) <= 96, 1);
        let v0 = if (arg6 != @0x0) {
            if (arg7 != @0x0) {
                arg8 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
        let v1 = if (arg6 != arg7) {
            if (arg6 != arg8) {
                arg7 != arg8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        validate_signer_set(&arg1, arg2);
        validate_limits(arg3, arg4, arg5);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        let v3 = WithdrawalPool<T0>{
            id                   : 0x2::object::new(arg10),
            schema_version       : 1,
            domain_hash          : 0x1::hash::sha3_256(arg0),
            signer_public_keys   : arg1,
            signature_threshold  : arg2,
            signer_set_version   : 1,
            paused               : false,
            paused_at_ms         : 0,
            max_claim_amount     : arg3,
            window_ms            : arg4,
            max_window_amount    : arg5,
            window_started_at_ms : v2,
            window_withdrawn     : 0,
            total_deposited      : 0,
            total_withdrawn      : 0,
            vault                : 0x2::balance::zero<T0>(),
            next_nonces          : 0x2::table::new<address, u64>(arg10),
            used_request_hashes  : 0x2::table::new<vector<u8>, bool>(arg10),
        };
        let v4 = 0x2::object::id<WithdrawalPool<T0>>(&v3);
        let v5 = GovernanceCap<T0>{
            id      : 0x2::object::new(arg10),
            pool_id : v4,
        };
        let v6 = GuardianCap<T0>{
            id      : 0x2::object::new(arg10),
            pool_id : v4,
        };
        let v7 = TreasuryCap<T0>{
            id      : 0x2::object::new(arg10),
            pool_id : v4,
        };
        let v8 = PoolCreated{
            pool_id             : v4,
            creator             : 0x2::tx_context::sender(arg10),
            governance          : arg6,
            guardian            : arg7,
            treasury            : arg8,
            domain_hash         : v3.domain_hash,
            signer_count        : 0x1::vector::length<vector<u8>>(&v3.signer_public_keys),
            signature_threshold : arg2,
            max_claim_amount    : arg3,
            window_ms           : arg4,
            max_window_amount   : arg5,
            timestamp_ms        : v2,
        };
        0x2::event::emit<PoolCreated>(v8);
        0x2::transfer::share_object<WithdrawalPool<T0>>(v3);
        0x2::transfer::transfer<GovernanceCap<T0>>(v5, arg6);
        0x2::transfer::transfer<GuardianCap<T0>>(v6, arg7);
        0x2::transfer::transfer<TreasuryCap<T0>>(v7, arg8);
    }

    entry fun emergency_withdraw<T0>(arg0: &mut WithdrawalPool<T0>, arg1: &TreasuryCap<T0>, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_cap<T0>(arg0, arg1.pool_id);
        assert!(arg0.paused, 14);
        assert!(arg3 != @0x0, 16);
        assert!(arg2 > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.paused_at_ms && v0 - arg0.paused_at_ms >= 172800000, 15);
        assert!(0x2::balance::value<T0>(&arg0.vault) >= arg2, 12);
        arg0.total_withdrawn = arg0.total_withdrawn + (arg2 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg5), arg3);
        let v1 = EmergencyWithdrawalExecuted{
            pool_id       : 0x2::object::id<WithdrawalPool<T0>>(arg0),
            recipient     : arg3,
            amount        : arg2,
            balance_after : 0x2::balance::value<T0>(&arg0.vault),
            timestamp_ms  : v0,
        };
        0x2::event::emit<EmergencyWithdrawalExecuted>(v1);
    }

    fun execute_withdrawal<T0>(arg0: &mut WithdrawalPool<T0>, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        refresh_window<T0>(arg0, v0);
        assert!(arg0.window_withdrawn <= arg0.max_window_amount, 13);
        assert!(arg2 <= arg0.max_window_amount - arg0.window_withdrawn, 13);
        consume_nonce<T0>(arg0, arg1, arg3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_request_hashes, arg4, true);
        arg0.window_withdrawn = arg0.window_withdrawn + arg2;
        arg0.total_withdrawn = arg0.total_withdrawn + (arg2 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg8), arg1);
        let v1 = WithdrawalExecuted{
            pool_id            : 0x2::object::id<WithdrawalPool<T0>>(arg0),
            recipient          : arg1,
            amount             : arg2,
            nonce              : arg3,
            request_hash       : arg4,
            signer_set_version : arg5,
            voucher_digest     : arg6,
            balance_after      : 0x2::balance::value<T0>(&arg0.vault),
            timestamp_ms       : v0,
        };
        0x2::event::emit<WithdrawalExecuted>(v1);
    }

    entry fun fund<T0>(arg0: &mut WithdrawalPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + (v0 as u128);
        let v1 = VaultFunded{
            pool_id       : 0x2::object::id<WithdrawalPool<T0>>(arg0),
            contributor   : 0x2::tx_context::sender(arg3),
            amount        : v0,
            balance_after : 0x2::balance::value<T0>(&arg0.vault),
            timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<VaultFunded>(v1);
    }

    public fun get_domain_hash<T0>(arg0: &WithdrawalPool<T0>) : vector<u8> {
        arg0.domain_hash
    }

    public fun get_next_nonce<T0>(arg0: &WithdrawalPool<T0>, arg1: address) : u64 {
        next_nonce<T0>(arg0, arg1)
    }

    public fun get_pool_info<T0>(arg0: &WithdrawalPool<T0>) : (u64, bool, u64, u8, u64, u64, u64, u64, u128, u128) {
        (arg0.schema_version, arg0.paused, arg0.signer_set_version, arg0.signature_threshold, arg0.max_claim_amount, arg0.window_ms, arg0.max_window_amount, 0x2::balance::value<T0>(&arg0.vault), arg0.total_deposited, arg0.total_withdrawn)
    }

    public fun get_signer_public_keys<T0>(arg0: &WithdrawalPool<T0>) : vector<vector<u8>> {
        arg0.signer_public_keys
    }

    public fun get_vault_balance<T0>(arg0: &WithdrawalPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun get_voucher_message<T0>(arg0: &WithdrawalPool<T0>, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64) : vector<u8> {
        voucher_message<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun is_request_used<T0>(arg0: &WithdrawalPool<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_request_hashes, arg1)
    }

    fun next_nonce<T0>(arg0: &WithdrawalPool<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.next_nonces, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.next_nonces, arg1)
        } else {
            0
        }
    }

    entry fun pause<T0>(arg0: &mut WithdrawalPool<T0>, arg1: &GuardianCap<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_cap<T0>(arg0, arg1.pool_id);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (!arg0.paused) {
            arg0.paused = true;
            arg0.paused_at_ms = v0;
            arg0.signer_set_version = arg0.signer_set_version + 1;
            let v1 = PoolPaused{
                pool_id            : 0x2::object::id<WithdrawalPool<T0>>(arg0),
                guardian           : 0x2::tx_context::sender(arg3),
                signer_set_version : arg0.signer_set_version,
                timestamp_ms       : v0,
            };
            0x2::event::emit<PoolPaused>(v1);
        };
    }

    entry fun reduce_limits<T0>(arg0: &mut WithdrawalPool<T0>, arg1: &GovernanceCap<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_cap<T0>(arg0, arg1.pool_id);
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg0.max_claim_amount) {
                if (arg3 >= arg2) {
                    arg3 <= arg0.max_window_amount
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 17);
        arg0.max_claim_amount = arg2;
        arg0.max_window_amount = arg3;
        let v1 = LimitsReduced{
            pool_id           : 0x2::object::id<WithdrawalPool<T0>>(arg0),
            max_claim_amount  : arg2,
            max_window_amount : arg3,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LimitsReduced>(v1);
    }

    fun refresh_window<T0>(arg0: &mut WithdrawalPool<T0>, arg1: u64) {
        if (arg1 >= arg0.window_started_at_ms && arg1 - arg0.window_started_at_ms >= arg0.window_ms) {
            arg0.window_started_at_ms = arg1;
            arg0.window_withdrawn = 0;
        };
    }

    entry fun resume<T0>(arg0: &mut WithdrawalPool<T0>, arg1: &GovernanceCap<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_cap<T0>(arg0, arg1.pool_id);
        if (arg0.paused) {
            arg0.paused = false;
            arg0.paused_at_ms = 0;
            let v0 = PoolResumed{
                pool_id      : 0x2::object::id<WithdrawalPool<T0>>(arg0),
                governance   : 0x2::tx_context::sender(arg3),
                timestamp_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<PoolResumed>(v0);
        };
    }

    entry fun rotate_signer_set<T0>(arg0: &mut WithdrawalPool<T0>, arg1: &GovernanceCap<T0>, arg2: vector<vector<u8>>, arg3: u8, arg4: &0x2::clock::Clock) {
        assert_cap<T0>(arg0, arg1.pool_id);
        validate_signer_set(&arg2, arg3);
        arg0.signer_public_keys = arg2;
        arg0.signature_threshold = arg3;
        arg0.signer_set_version = arg0.signer_set_version + 1;
        let v0 = SignerSetRotated{
            pool_id             : 0x2::object::id<WithdrawalPool<T0>>(arg0),
            signer_set_version  : arg0.signer_set_version,
            signer_count        : 0x1::vector::length<vector<u8>>(&arg0.signer_public_keys),
            signature_threshold : arg3,
            timestamp_ms        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SignerSetRotated>(v0);
    }

    fun validate_limits(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 1);
        assert!(arg2 >= arg0, 1);
        assert!(arg1 >= 60000 && arg1 <= 604800000, 1);
    }

    fun validate_signer_set(arg0: &vector<vector<u8>>, arg1: u8) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 >= 3 && v0 <= 7, 1);
        let v1 = if (arg1 >= 2) {
            if ((arg1 as u64) <= v0) {
                (arg1 as u64) * 2 > v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg0, v2);
            assert!(0x1::vector::length<u8>(v3) == 32, 1);
            let v4 = v2 + 1;
            while (v4 < v0) {
                assert!(v3 != 0x1::vector::borrow<vector<u8>>(arg0, v4), 1);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
    }

    fun verify_threshold_signatures(arg0: &vector<vector<u8>>, arg1: u8, arg2: &vector<u8>, arg3: &vector<vector<u8>>, arg4: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg2);
        assert!(v0 == (arg1 as u64) && 0x1::vector::length<vector<u8>>(arg3) == v0, 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg2, v1);
            assert!((v2 as u64) < 0x1::vector::length<vector<u8>>(arg0), 10);
            if (v1 > 0) {
                assert!(v2 > 0, 10);
            };
            let v3 = 0x1::vector::borrow<vector<u8>>(arg3, v1);
            let v4 = 0x1::vector::borrow<vector<u8>>(arg0, (v2 as u64));
            assert!(0x1::vector::length<u8>(v3) == 64, 10);
            assert!(0x2::ed25519::ed25519_verify(v3, v4, arg4), 11);
            v1 = v1 + 1;
        };
    }

    fun voucher_message<T0>(arg0: &WithdrawalPool<T0>, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64) : vector<u8> {
        let v0 = WithdrawalVoucher{
            schema_version     : 1,
            action             : 1,
            domain_hash        : arg0.domain_hash,
            pool_id            : 0x2::object::id<WithdrawalPool<T0>>(arg0),
            coin_type_hash     : 0x1::hash::sha3_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))),
            recipient          : arg1,
            amount             : arg2,
            nonce              : arg3,
            request_hash       : arg4,
            valid_after_ms     : arg5,
            expires_at_ms      : arg6,
            signer_set_version : arg7,
        };
        0x1::bcs::to_bytes<WithdrawalVoucher>(&v0)
    }

    entry fun withdraw<T0>(arg0: &mut WithdrawalPool<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert_request<T0>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        let v1 = voucher_message<T0>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6);
        verify_threshold_signatures(&arg0.signer_public_keys, arg0.signature_threshold, &arg7, &arg8, &v1);
        execute_withdrawal<T0>(arg0, v0, arg1, arg2, arg3, arg6, 0x1::hash::sha3_256(v1), arg9, arg10);
    }

    // decompiled from Move bytecode v7
}

