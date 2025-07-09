module 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::prize {
    struct RandomnessCommitment has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        tx_digest: vector<u8>,
        total_nfts: u64,
        commitment_time: u64,
        distribution_completed: bool,
    }

    struct RandomnessCommitted has copy, drop {
        registry_id: 0x2::object::ID,
        commitment_id: 0x2::object::ID,
        total_nfts: u64,
        shuffle_type: u8,
        timestamp: u64,
    }

    struct ShuffleCompleted has copy, drop {
        registry_id: 0x2::object::ID,
        commitment_id: 0x2::object::ID,
        total_nfts: u64,
        timestamp: u64,
    }

    struct BatchDistributed has copy, drop {
        registry_id: 0x2::object::ID,
        commitment_id: 0x2::object::ID,
        start_index: u64,
        batch_size: u64,
        completed: bool,
    }

    struct PrizesAdjusted has copy, drop {
        registry_id: 0x2::object::ID,
        total_minted: u64,
        original_total_prizes: u64,
        adjusted_total_prizes: u64,
        excess_removed: u64,
    }

    fun adjust_prizes_for_minted_count(arg0: &mut 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry, arg1: u64) {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_prizes_mut(arg0);
        let v1 = 0x1::vector::length<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 + 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_remaining(0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(v0, v3));
            v3 = v3 + 1;
        };
        if (arg1 < v2) {
            let v4 = v2 - arg1;
            let v5 = v1 + 1;
            while (v4 > 0 && v5 > 0) {
                let v6 = 0;
                let v7 = v6;
                v3 = 0;
                while (v3 < v1) {
                    let v8 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_tier_level(0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(v0, v3));
                    if (v8 > v6 && v8 < v5) {
                        v7 = v8;
                    };
                    v3 = v3 + 1;
                };
                if (v7 == 0) {
                    break
                };
                v3 = 0;
                while (v3 < v1 && v4 > 0) {
                    let v9 = 0x1::vector::borrow_mut<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(v0, v3);
                    if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_tier_level(v9) == v7) {
                        let v10 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_remaining(v9);
                        if (v10 >= v4) {
                            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::set_prize_remaining(v9, v10 - v4);
                            v4 = 0;
                        } else if (v10 > 0) {
                            v4 = v4 - v10;
                            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::set_prize_remaining(v9, 0);
                        };
                    };
                    v3 = v3 + 1;
                };
                v5 = v7;
            };
            let v11 = PrizesAdjusted{
                registry_id           : 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg0),
                total_minted          : arg1,
                original_total_prizes : v2,
                adjusted_total_prizes : arg1,
                excess_removed        : v4 - v4,
            };
            0x2::event::emit<PrizesAdjusted>(v11);
        };
    }

    fun collect_prizes(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry) : vector<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize> {
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_prizes(arg0);
        let v1 = 0x1::vector::empty<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(v0)) {
            0x1::vector::push_back<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&mut v1, *0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    entry fun commit_to_randomness(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::check_admin(arg1, arg0);
        assert!(!0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_paused(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::campaign_paused());
        assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_in_claim_phase(arg1) || 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_in_shuffled_phase(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status());
        assert!(!0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_shuffled(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::already_shuffled());
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_active_commitment_id(arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 1005);
        let v1 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::minted_count(arg1);
        let v2 = 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg1);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v4 = RandomnessCommitment{
            id                     : 0x2::object::new(arg2),
            registry_id            : v2,
            tx_digest              : *0x2::tx_context::digest(arg2),
            total_nfts             : v1,
            commitment_time        : v3,
            distribution_completed : false,
        };
        let v5 = 0x2::object::id<RandomnessCommitment>(&v4);
        let v6 = RandomnessCommitted{
            registry_id   : v2,
            commitment_id : v5,
            total_nfts    : v1,
            shuffle_type  : 1,
            timestamp     : v3,
        };
        0x2::event::emit<RandomnessCommitted>(v6);
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::set_active_commitment_id(arg1, v5);
        0x2::transfer::transfer<RandomnessCommitment>(v4, 0x2::tx_context::sender(arg2));
    }

    entry fun distribute_prizes_batch(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::admin::AdminCap, arg1: &mut 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry, arg2: &RandomnessCommitment, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::check_admin(arg1, arg0);
        assert!(!0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_paused(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::campaign_paused());
        assert!(arg2.registry_id == 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg1), 1004);
        assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_active_commitment_id(arg1) == 0x1::option::some<0x2::object::ID>(0x2::object::id<RandomnessCommitment>(arg2)), 1006);
        assert!(arg2.total_nfts == 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::minted_count(arg1), 1004);
        assert!(!arg2.distribution_completed, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::already_shuffled());
        assert!(!0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_distribution_completed(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::already_shuffled());
        assert!(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_in_claim_phase(arg1) || 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_in_shuffled_phase(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::invalid_status());
        assert!(!0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_shuffled(arg1), 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::already_shuffled());
        let v0 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_distribution_start_index(arg1);
        let v1 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::minted_count(arg1);
        assert!(arg3 >= 1 && arg3 <= 1000, 1007);
        assert!(v0 < v1, 1008);
        let v2 = if (v0 + arg3 > v1) {
            v1 - v0
        } else {
            arg3
        };
        let v3 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_distribution_offset(arg1);
        if (0x1::option::is_none<u64>(&v3)) {
            let v4 = 0x2::random::new_generator(arg4, arg5);
            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::set_distribution_offset(arg1, 0x2::random::generate_u64(&mut v4));
            if (v0 == 0) {
                adjust_prizes_for_minted_count(arg1, v1);
            };
        };
        let v5 = 0x1::option::destroy_some<u64>(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_distribution_offset(arg1));
        distribute_prizes_deterministic(arg1, v0, v2, v5);
        let v6 = v0 + v2;
        0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::update_distribution_start_index(arg1, v6);
        if (v6 >= v1) {
            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::mark_distribution_completed(arg1);
            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::clear_active_commitment_id(arg1);
            0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::set_shuffled(arg1);
            if (0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::is_in_claim_phase(arg1)) {
                0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::update_campaign_status_internal(arg1, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::status_shuffled());
            };
            let v7 = ShuffleCompleted{
                registry_id   : 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg1),
                commitment_id : 0x2::object::id<RandomnessCommitment>(arg2),
                total_nfts    : v1,
                timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg5),
            };
            0x2::event::emit<ShuffleCompleted>(v7);
        };
    }

    fun distribute_prizes_deterministic(arg0: &mut 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = collect_prizes(arg0);
        let v1 = 0x1::vector::length<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&v0);
        if (v1 == 0) {
            return
        };
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = v3 + 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::prize_quantity(0x1::vector::borrow<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::Prize>(&v0, v4));
            v3 = v5;
            0x1::vector::push_back<u64>(&mut v2, v5);
            v4 = v4 + 1;
        };
        if (v3 == 0) {
            return
        };
        let v6 = arg1 + arg2;
        while (arg1 < v6) {
            let v7 = arg1 + 1;
            let v8 = 0x1::vector::empty<u8>();
            0x1::vector::append<u8>(&mut v8, 0x1::bcs::to_bytes<u64>(&v7));
            0x1::vector::append<u8>(&mut v8, 0x1::bcs::to_bytes<u64>(&arg3));
            let v9 = 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg0);
            0x1::vector::append<u8>(&mut v8, 0x1::bcs::to_bytes<0x2::object::ID>(&v9));
            let v10 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::minted_count(arg0);
            0x1::vector::append<u8>(&mut v8, 0x1::bcs::to_bytes<u64>(&v10));
            let v11 = 0x1::hash::sha3_256(v8);
            let v12 = 0;
            let v13 = 0;
            while (v13 < 8) {
                let v14 = v12 << 8;
                v12 = v14 | (*0x1::vector::borrow<u8>(&v11, v13) as u64);
                v13 = v13 + 1;
            };
            let v15 = 0;
            while (v15 < 0x1::vector::length<u64>(&v2)) {
                if (v12 % v3 < *0x1::vector::borrow<u64>(&v2, v15)) {
                    break
                };
                v15 = v15 + 1;
            };
            let v16 = false;
            if (v15 < v1) {
                v16 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::assign_prize_and_decrement(arg0, v7, v15);
            };
            if (!v16) {
                let v17 = 0;
                while (v17 < v1 && !v16) {
                    v16 = 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::assign_prize_and_decrement(arg0, v7, v17);
                    v17 = v17 + 1;
                };
            };
            assert!(v16, 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::common::error_no_prizes_remaining());
            arg1 = arg1 + 1;
        };
        let v18 = BatchDistributed{
            registry_id   : 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg0),
            commitment_id : 0x1::option::destroy_with_default<0x2::object::ID>(0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::get_active_commitment_id(arg0), 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg0)),
            start_index   : arg1,
            batch_size    : arg2,
            completed     : v6 >= 0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::minted_count(arg0),
        };
        0x2::event::emit<BatchDistributed>(v18);
    }

    public fun get_commitment_tx_digest(arg0: &RandomnessCommitment) : vector<u8> {
        arg0.tx_digest
    }

    public fun is_valid_commitment(arg0: &0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry, arg1: &RandomnessCommitment) : bool {
        arg1.registry_id == 0x2::object::id<0xd91dc698a73d9ca68a13d59b2d4897f6b33cf8d683b1fad3d32ec25ac7d5c94a::registry::Registry>(arg0) && !arg1.distribution_completed
    }

    // decompiled from Move bytecode v6
}

