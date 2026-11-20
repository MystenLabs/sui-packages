module 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::pofr_event {
    struct CoordinatorConfig has store, key {
        id: 0x2::object::UID,
        treasury: address,
        min_fee: u64,
        cancel_timeout_ms: u64,
        request_count: u64,
        gas_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        draws: 0x2::table::Table<address, 0x2::table::Table<vector<u8>, DrawState>>,
        refunds: 0x2::table::Table<address, 0x2::balance::Balance<0x2::sui::SUI>>,
    }

    struct DrawState has store {
        status: u8,
        target_round: u64,
        event_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoFREvent has store, key {
        id: 0x2::object::UID,
        requester: address,
        draw_key: vector<u8>,
        paid: 0x2::balance::Balance<0x2::sui::SUI>,
        request_ts_ms: u64,
        target_round: u64,
        status: u8,
        seed: vector<u8>,
        quicknet_value: vector<u8>,
        drand_value: vector<u8>,
        nist_value: vector<u8>,
        btc_merkle_root: vector<u8>,
        multi_chain_hash: vector<u8>,
        anu_qrng_commit: vector<u8>,
        polkadot_hash: vector<u8>,
        ethereum_hash: vector<u8>,
        cosmos_hash: vector<u8>,
        sui_checkpoint_digest: vector<u8>,
        sui_random_contrib: vector<u8>,
        signers: vector<address>,
        fulfilled_ts_ms: u64,
    }

    struct DrawRequest has copy, drop {
        event_id: 0x2::object::ID,
        requester: address,
        draw_key: vector<u8>,
        paid: u64,
        target_round: u64,
        request_ts_ms: u64,
    }

    struct RequestFulfilled has copy, drop {
        event_id: 0x2::object::ID,
        seed: vector<u8>,
        quicknet_round: u64,
        quicknet_value: vector<u8>,
        drand_value: vector<u8>,
        nist_value: vector<u8>,
        btc_merkle_root: vector<u8>,
        multi_chain_hash: vector<u8>,
        anu_qrng_commit: vector<u8>,
        polkadot_hash: vector<u8>,
        ethereum_hash: vector<u8>,
        cosmos_hash: vector<u8>,
        sui_checkpoint_digest: vector<u8>,
        sui_random_contrib: vector<u8>,
        signers: vector<address>,
    }

    struct BeaconSignatureAttested has copy, drop {
        event_id: 0x2::object::ID,
        signature: vector<u8>,
    }

    struct RequestCancelled has copy, drop {
        event_id: 0x2::object::ID,
        requester: address,
        refund: u64,
    }

    struct RefundWithdrawn has copy, drop {
        requester: address,
        amount: u64,
    }

    public fun cancel_request(arg0: &mut PoFREvent, arg1: &mut CoordinatorConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 1, 4);
        assert!(v0 == arg0.requester, 5);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.request_ts_ms + arg1.cancel_timeout_ms, 6);
        arg0.status = 3;
        0x2::table::borrow_mut<vector<u8>, DrawState>(0x2::table::borrow_mut<address, 0x2::table::Table<vector<u8>, DrawState>>(&mut arg1.draws, arg0.requester), arg0.draw_key).status = 3;
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.paid);
        if (!0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.refunds, v0)) {
            0x2::table::add<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.refunds, v0, 0x2::balance::zero<0x2::sui::SUI>());
        };
        0x2::balance::join<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.refunds, v0), v1);
        let v2 = RequestCancelled{
            event_id  : 0x2::object::id<PoFREvent>(arg0),
            requester : v0,
            refund    : 0x2::balance::value<0x2::sui::SUI>(&v1),
        };
        0x2::event::emit<RequestCancelled>(v2);
    }

    fun check_sorted_pairs(arg0: &vector<vector<u8>>) {
        let v0 = 2;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            assert!(lt_bytes(0x1::vector::borrow<vector<u8>>(arg0, v0 - 2), 0x1::vector::borrow<vector<u8>>(arg0, v0)), 9);
            v0 = v0 + 2;
        };
    }

    public fun check_sorted_pairs_public(arg0: &vector<vector<u8>>) {
        check_sorted_pairs(arg0);
    }

    public fun derive_seed(arg0: &CoordinatorConfig, arg1: &PoFREvent, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        let v0 = b"RandProof-SUI-V1-seed";
        let v1 = 0x2::object::id<CoordinatorConfig>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1.requester));
        0x1::vector::append<u8>(&mut v0, arg1.draw_key);
        0x1::vector::append<u8>(&mut v0, u64_to_be(arg1.target_round));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::hash::sha3_256(v0)
    }

    public fun drand_round_message(arg0: u64) : vector<u8> {
        0x1::hash::sha2_256(u64_to_be(arg0))
    }

    public fun draw_key_of(arg0: &PoFREvent) : vector<u8> {
        arg0.draw_key
    }

    public fun fulfill(arg0: &mut PoFREvent, arg1: &0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry::Registry, arg2: &mut CoordinatorConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<address>, arg14: vector<vector<u8>>, arg15: &0x2::clock::Clock, arg16: &0x2::random::Random, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 4);
        let v0 = 0x1::vector::length<vector<u8>>(&arg14);
        assert!(v0 >= (0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry::threshold(arg1) as u64), 7);
        assert!(v0 == 0x1::vector::length<address>(&arg13) && v0 == 0x1::vector::length<vector<u8>>(&arg12), 8);
        assert!(0x1::vector::length<vector<u8>>(&arg11) % 2 == 0, 9);
        check_sorted_pairs(&arg11);
        assert!(0x1::vector::length<u8>(&arg3) == 48, 14);
        let v1 = drand_round_message(arg0.target_round);
        let v2 = x"83cf0f2896adee7eb8b5f01fcad3912212c437e0073e911fb90022d3e760183c8c4b450b6a0a6c3ac6a5776a2d1064510d1fec758c921cc22b0e17e63aaf4bcb5ed66304de9cf809bd274ca73bab4af5a6e9c76a4bc09e76eae8991ef5ece45a";
        assert!(0x2::bls12381::bls12381_min_sig_verify(&arg3, &v2, &v1), 13);
        let v3 = 0x1::hash::sha2_256(arg3);
        let v4 = BeaconSignatureAttested{
            event_id  : 0x2::object::id<PoFREvent>(arg0),
            signature : arg3,
        };
        0x2::event::emit<BeaconSignatureAttested>(v4);
        let v5 = multi_chain_hash_of(&arg11);
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<address>(&arg13, v6);
            assert!(0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry::is_keeper(arg1, v7), 11);
            if (v6 > 0) {
                assert!(0x2::address::to_u256(v7) > 0x2::address::to_u256(*0x1::vector::borrow<address>(&arg13, v6 - 1)), 10);
            };
            let v8 = signable_of(shared_commit(arg2, arg0, v3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v5), *0x1::vector::borrow<vector<u8>>(&arg12, v6));
            let v9 = 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry::pubkey_of(arg1, v7);
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg14, v6), &v9, &v8), 12);
            v6 = v6 + 1;
        };
        let v10 = 0x2::random::new_generator(arg16, arg17);
        let v11 = 0x2::random::generate_bytes(&mut v10, 32);
        let v12 = derive_seed(arg2, arg0, v3, v11);
        settle(arg0, arg2, arg1, v3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v5, qrng_commit_of(&arg12), v11, v12, arg13, arg15, arg17);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoordinatorConfig{
            id                : 0x2::object::new(arg0),
            treasury          : 0x2::tx_context::sender(arg0),
            min_fee           : 50000000,
            cancel_timeout_ms : 86400000,
            request_count     : 0,
            gas_pool          : 0x2::balance::zero<0x2::sui::SUI>(),
            draws             : 0x2::table::new<address, 0x2::table::Table<vector<u8>, DrawState>>(arg0),
            refunds           : 0x2::table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg0),
        };
        0x2::transfer::share_object<CoordinatorConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_fulfilled(arg0: &PoFREvent) : bool {
        arg0.status == 2
    }

    fun lt_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 32 && 0x1::vector::length<u8>(arg1) == 32, 14);
        let v0 = 0;
        while (v0 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun min_fee(arg0: &CoordinatorConfig) : u64 {
        arg0.min_fee
    }

    public fun multi_chain_hash_of(arg0: &vector<vector<u8>>) : vector<u8> {
        if (0x1::vector::is_empty<vector<u8>>(arg0)) {
            return b""
        };
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        0x1::hash::sha3_256(v0)
    }

    public fun qrng_commit_of(arg0: &vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            0x1::vector::append<u8>(&mut v0, *0x1::vector::borrow<vector<u8>>(arg0, v1));
            v1 = v1 + 1;
        };
        0x1::hash::sha3_256(v0)
    }

    fun request(arg0: &mut CoordinatorConfig, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 >= arg0.min_fee, 0);
        if (!0x2::table::contains<address, 0x2::table::Table<vector<u8>, DrawState>>(&arg0.draws, v0)) {
            0x2::table::add<address, 0x2::table::Table<vector<u8>, DrawState>>(&mut arg0.draws, v0, 0x2::table::new<vector<u8>, DrawState>(arg4));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<vector<u8>, DrawState>>(&mut arg0.draws, v0);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = if (0x2::table::contains<vector<u8>, DrawState>(v2, arg1)) {
            let v5 = 0x2::table::borrow_mut<vector<u8>, DrawState>(v2, arg1);
            assert!(v5.status != 2, 3);
            assert!(v5.status != 1, 2);
            v5.status = 1;
            v5.event_id = 0x2::object::id_from_address(@0x0);
            v5.target_round
        } else {
            let v6 = (v3 / 1000 - 1692803367) / 3 + 5;
            let v7 = DrawState{
                status       : 1,
                target_round : v6,
                event_id     : 0x2::object::id_from_address(@0x0),
            };
            0x2::table::add<vector<u8>, DrawState>(v2, arg1, v7);
            v6
        };
        let v8 = PoFREvent{
            id                    : 0x2::object::new(arg4),
            requester             : v0,
            draw_key              : arg1,
            paid                  : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            request_ts_ms         : v3,
            target_round          : v4,
            status                : 1,
            seed                  : b"",
            quicknet_value        : b"",
            drand_value           : b"",
            nist_value            : b"",
            btc_merkle_root       : b"",
            multi_chain_hash      : b"",
            anu_qrng_commit       : b"",
            polkadot_hash         : b"",
            ethereum_hash         : b"",
            cosmos_hash           : b"",
            sui_checkpoint_digest : b"",
            sui_random_contrib    : b"",
            signers               : vector[],
            fulfilled_ts_ms       : 0,
        };
        let v9 = 0x2::object::id<PoFREvent>(&v8);
        0x2::table::borrow_mut<vector<u8>, DrawState>(v2, arg1).event_id = v9;
        arg0.request_count = arg0.request_count + 1;
        let v10 = DrawRequest{
            event_id      : v9,
            requester     : v0,
            draw_key      : arg1,
            paid          : v1,
            target_round  : v4,
            request_ts_ms : v3,
        };
        0x2::event::emit<DrawRequest>(v10);
        0x2::transfer::share_object<PoFREvent>(v8);
    }

    public fun request_randomness(arg0: &mut CoordinatorConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<CoordinatorConfig>(arg0);
        let v1 = 0x1::bcs::to_bytes<0x2::object::ID>(&v0);
        let v2 = 0x2::tx_context::sender(arg3);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg0.request_count));
        request(arg0, v1, arg1, arg2, arg3);
    }

    public fun request_randomness_with_key(arg0: &mut CoordinatorConfig, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1) && 0x1::vector::length<u8>(&arg1) <= 64, 1);
        request(arg0, arg1, arg2, arg3, arg4);
    }

    public fun request_ts_of(arg0: &PoFREvent) : u64 {
        arg0.request_ts_ms
    }

    public fun requester_of(arg0: &PoFREvent) : address {
        arg0.requester
    }

    public fun seed_of(arg0: &PoFREvent) : vector<u8> {
        arg0.seed
    }

    public fun set_cancel_timeout(arg0: &AdminCap, arg1: &mut CoordinatorConfig, arg2: u64) {
        arg1.cancel_timeout_ms = arg2;
    }

    public fun set_min_fee(arg0: &AdminCap, arg1: &mut CoordinatorConfig, arg2: u64) {
        arg1.min_fee = arg2;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut CoordinatorConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    fun settle(arg0: &mut PoFREvent, arg1: &mut CoordinatorConfig, arg2: &0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry::Registry, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: vector<address>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        arg0.status = 2;
        arg0.seed = arg14;
        arg0.quicknet_value = arg3;
        arg0.drand_value = arg4;
        arg0.nist_value = arg5;
        arg0.btc_merkle_root = arg6;
        arg0.multi_chain_hash = arg11;
        arg0.anu_qrng_commit = arg12;
        arg0.polkadot_hash = arg7;
        arg0.ethereum_hash = arg8;
        arg0.cosmos_hash = arg9;
        arg0.sui_checkpoint_digest = arg10;
        arg0.sui_random_contrib = arg13;
        arg0.signers = arg15;
        arg0.fulfilled_ts_ms = 0x2::clock::timestamp_ms(arg16);
        0x2::table::borrow_mut<vector<u8>, DrawState>(0x2::table::borrow_mut<address, 0x2::table::Table<vector<u8>, DrawState>>(&mut arg1.draws, arg0.requester), arg0.draw_key).status = 2;
        let (v0, v1, _) = 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::fee_vault::split_fee(0x2::balance::value<0x2::sui::SUI>(&arg0.paid));
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0x1::vector::length<address>(&arg15);
        while (v4 < v5) {
            0x1::vector::push_back<u64>(&mut v3, 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::keeper_registry::stake_of(arg2, *0x1::vector::borrow<address>(&arg15, v4)));
            v4 = v4 + 1;
        };
        let (v6, _) = 0xf5ba671552f29e452ffa46d902c853feaa8b3e30e0261550899dcf6fa8fd7bcd::fee_vault::keeper_shares(v0, &v3);
        let v8 = v6;
        v4 = 0;
        while (v4 < v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.paid, *0x1::vector::borrow<u64>(&v8, v4), arg17), *0x1::vector::borrow<address>(&arg15, v4));
            v4 = v4 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.paid, v1, arg17), arg1.treasury);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.gas_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.paid));
        let v9 = RequestFulfilled{
            event_id              : 0x2::object::id<PoFREvent>(arg0),
            seed                  : arg0.seed,
            quicknet_round        : arg0.target_round,
            quicknet_value        : arg0.quicknet_value,
            drand_value           : arg0.drand_value,
            nist_value            : arg0.nist_value,
            btc_merkle_root       : arg0.btc_merkle_root,
            multi_chain_hash      : arg0.multi_chain_hash,
            anu_qrng_commit       : arg0.anu_qrng_commit,
            polkadot_hash         : arg0.polkadot_hash,
            ethereum_hash         : arg0.ethereum_hash,
            cosmos_hash           : arg0.cosmos_hash,
            sui_checkpoint_digest : arg0.sui_checkpoint_digest,
            sui_random_contrib    : arg0.sui_random_contrib,
            signers               : arg0.signers,
        };
        0x2::event::emit<RequestFulfilled>(v9);
    }

    public fun shared_commit(arg0: &CoordinatorConfig, arg1: &PoFREvent, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>) : vector<u8> {
        let v0 = b"RandProof-SUI-V1";
        let v1 = 0x2::object::id<CoordinatorConfig>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        let v2 = 0x2::object::id<PoFREvent>(arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v2));
        0x1::vector::append<u8>(&mut v0, u64_to_be(arg1.target_round));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, u64_to_be(arg1.request_ts_ms));
        0x1::vector::append<u8>(&mut v0, arg5);
        0x1::vector::append<u8>(&mut v0, arg6);
        0x1::vector::append<u8>(&mut v0, arg7);
        0x1::vector::append<u8>(&mut v0, arg8);
        0x1::vector::append<u8>(&mut v0, arg9);
        0x1::vector::append<u8>(&mut v0, arg10);
        0x1::hash::sha3_256(v0)
    }

    public fun signable_of(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x1::hash::sha3_256(arg0)
    }

    public fun signers_of(arg0: &PoFREvent) : vector<address> {
        arg0.signers
    }

    public fun sweep_gas_pool(arg0: &AdminCap, arg1: &mut CoordinatorConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.gas_pool, arg2, arg3), arg1.treasury);
    }

    public fun target_round_of(arg0: &PoFREvent) : u64 {
        arg0.target_round
    }

    public fun treasury(arg0: &CoordinatorConfig) : address {
        arg0.treasury
    }

    public fun u64_to_be(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> (7 - v1) * 8 & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun withdraw_refund(arg0: &mut CoordinatorConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.refunds, v0), 15);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.refunds, v0));
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        assert!(v2 > 0, 15);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg1), v0);
        let v3 = RefundWithdrawn{
            requester : v0,
            amount    : v2,
        };
        0x2::event::emit<RefundWithdrawn>(v3);
    }

    // decompiled from Move bytecode v7
}

