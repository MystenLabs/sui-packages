module 0x7dafdc4f52dd75cbac15aa2de86c56be280f72b4e51786e15368a08bfd85b50c::health_data_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Participant<phantom T0> has store {
        stake: 0x2::balance::Balance<T0>,
        joined_at_ms: u64,
        contract_ends_ms: u64,
        claimed: bool,
        flagged: bool,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        buyer: address,
        reward_balance: 0x2::balance::Balance<T0>,
        stake_per_user: u64,
        reward_per_user: u64,
        required_participants: u64,
        current_participants: u64,
        commencement_deadline_ms: u64,
        contract_length_ms: u64,
        is_rolling: bool,
        pool_ends_ms: u64,
        status: u8,
        participants: 0x2::table::Table<address, Participant<T0>>,
        oracle_signers: vector<vector<u8>>,
        oracle_threshold: u8,
        used_nonces: 0x2::table::Table<vector<u8>, bool>,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        buyer: address,
        stake_per_user: u64,
        reward_per_user: u64,
        required_participants: u64,
        commencement_deadline_ms: u64,
        contract_length_ms: u64,
        is_rolling: bool,
    }

    struct PoolFunded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    struct PoolLive has copy, drop {
        pool_id: 0x2::object::ID,
        at_ms: u64,
    }

    struct PoolAborted has copy, drop {
        pool_id: 0x2::object::ID,
        refunded_participants: u64,
    }

    struct PoolSettled has copy, drop {
        pool_id: 0x2::object::ID,
        buyer_sweep: u64,
    }

    struct ParticipantJoined has copy, drop {
        pool_id: 0x2::object::ID,
        participant: address,
        contract_ends_ms: u64,
        current_participants: u64,
    }

    struct RewardClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        participant: address,
        reward_amount: u64,
        multiplier_bps: u64,
        attestation_hash: vector<u8>,
    }

    struct StakeBurned has copy, drop {
        pool_id: 0x2::object::ID,
        participant: address,
        amount: u64,
        evidence_hash: vector<u8>,
    }

    public entry fun abort_pool<T0>(arg0: &mut Pool<T0>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.commencement_deadline_ms, 5);
        assert!(arg0.current_participants < arg0.required_participants, 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, Participant<T0>>(&arg0.participants, v1)) {
                let Participant {
                    stake            : v2,
                    joined_at_ms     : _,
                    contract_ends_ms : _,
                    claimed          : _,
                    flagged          : _,
                } = 0x2::table::remove<address, Participant<T0>>(&mut arg0.participants, v1);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), v1);
            };
            v0 = v0 + 1;
        };
        if (0x2::table::is_empty<address, Participant<T0>>(&arg0.participants)) {
            arg0.current_participants = 0;
            arg0.status = 2;
            let v7 = 0x2::balance::withdraw_all<T0>(&mut arg0.reward_balance);
            if (0x2::balance::value<T0>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg3), arg0.buyer);
            } else {
                0x2::balance::destroy_zero<T0>(v7);
            };
            let v8 = PoolAborted{
                pool_id               : 0x2::object::id<Pool<T0>>(arg0),
                refunded_participants : arg0.current_participants,
            };
            0x2::event::emit<PoolAborted>(v8);
        };
    }

    fun build_attest_message(arg0: 0x2::object::ID, arg1: address, arg2: &vector<u8>, arg3: u64, arg4: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"heartbeats::hdp::attest::v1");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, *arg4);
        0x2::hash::blake2b256(&v0)
    }

    fun build_flag_message(arg0: 0x2::object::ID, arg1: address, arg2: &vector<u8>, arg3: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"heartbeats::hdp::flag::v1");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::append<u8>(&mut v0, *arg3);
        0x2::hash::blake2b256(&v0)
    }

    public entry fun claim_reward<T0>(arg0: &mut Pool<T0>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1 || arg0.status == 3, 3);
        assert!(arg2 <= 50000, 20);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, Participant<T0>>(&arg0.participants, v0), 8);
        let v1 = 0x2::table::borrow<address, Participant<T0>>(&arg0.participants, v0);
        assert!(!v1.claimed, 9);
        assert!(!v1.flagged, 10);
        assert!(0x2::clock::timestamp_ms(arg5) >= v1.contract_ends_ms, 11);
        let v2 = build_attest_message(0x2::object::id<Pool<T0>>(arg0), v0, &arg1, arg2, &arg3);
        verify_oracle_sigs(&arg0.oracle_signers, arg0.oracle_threshold, &v2, &arg4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg3), 16);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_nonces, arg3, true);
        let v3 = arg0.reward_per_user * arg2 / 10000;
        assert!(0x2::balance::value<T0>(&arg0.reward_balance) >= v3, 13);
        let v4 = 0x2::table::borrow_mut<address, Participant<T0>>(&mut arg0.participants, v0);
        v4.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v4.stake), arg6), v0);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_balance, v3), arg6), v0);
        };
        let v5 = RewardClaimed{
            pool_id          : 0x2::object::id<Pool<T0>>(arg0),
            participant      : v0,
            reward_amount    : v3,
            multiplier_bps   : arg2,
            attestation_hash : arg1,
        };
        0x2::event::emit<RewardClaimed>(v5);
    }

    public entry fun create_pool<T0>(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: vector<vector<u8>>, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        abort 21
    }

    public entry fun flag_participant<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Participant<T0>>(&arg0.participants, arg1), 8);
        let v0 = build_flag_message(0x2::object::id<Pool<T0>>(arg0), arg1, &arg2, &arg3);
        verify_oracle_sigs(&arg0.oracle_signers, arg0.oracle_threshold, &v0, &arg4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_nonces, arg3), 16);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_nonces, arg3, true);
        let v1 = 0x2::table::borrow_mut<address, Participant<T0>>(&mut arg0.participants, arg1);
        assert!(!v1.flagged, 10);
        assert!(!v1.claimed, 9);
        v1.flagged = true;
        let v2 = 0x2::balance::withdraw_all<T0>(&mut v1.stake);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg5), @0x0);
        let v3 = StakeBurned{
            pool_id       : 0x2::object::id<Pool<T0>>(arg0),
            participant   : arg1,
            amount        : 0x2::balance::value<T0>(&v2),
            evidence_hash : arg2,
        };
        0x2::event::emit<StakeBurned>(v3);
    }

    public entry fun fund_pool<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0 || arg0.status == 1, 4);
        0x2::balance::join<T0>(&mut arg0.reward_balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = PoolFunded{
            pool_id     : 0x2::object::id<Pool<T0>>(arg0),
            amount      : 0x2::coin::value<T0>(&arg1),
            new_balance : 0x2::balance::value<T0>(&arg0.reward_balance),
        };
        0x2::event::emit<PoolFunded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun join_pool<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        abort 21
    }

    public entry fun rotate_oracle_signers<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: vector<vector<u8>>, arg3: u8) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 > 0, 19);
        assert!((arg3 as u64) > 0 && (arg3 as u64) <= v0, 18);
        arg1.oracle_signers = arg2;
        arg1.oracle_threshold = arg3;
    }

    public entry fun sweep_unclaimed<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_rolling, 3);
        assert!(arg0.status == 1, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pool_ends_ms, 11);
        assert!(0x2::tx_context::sender(arg2) == arg0.buyer, 1);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.reward_balance);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg0.buyer);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        arg0.status = 3;
        let v2 = PoolSettled{
            pool_id     : 0x2::object::id<Pool<T0>>(arg0),
            buyer_sweep : v1,
        };
        0x2::event::emit<PoolSettled>(v2);
    }

    fun verify_oracle_sigs(arg0: &vector<vector<u8>>, arg1: u8, arg2: &vector<u8>, arg3: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(0x1::vector::length<vector<u8>>(arg3) == v0, 14);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg3, v2);
            if (0x1::vector::length<u8>(v3) == 64) {
                if (0x2::ed25519::ed25519_verify(v3, 0x1::vector::borrow<vector<u8>>(arg0, v2), arg2)) {
                    v1 = v1 + 1;
                };
            };
            v2 = v2 + 1;
        };
        assert!(v1 >= (arg1 as u64), 15);
    }

    // decompiled from Move bytecode v7
}

