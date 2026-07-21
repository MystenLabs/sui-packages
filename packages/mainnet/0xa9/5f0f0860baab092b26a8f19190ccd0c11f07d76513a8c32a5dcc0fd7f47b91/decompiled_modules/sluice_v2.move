module 0x7c7ca3da6bad849a02d9f888b2f8cab40d507b2c01bbcab3f2d816334c17aa07::sluice_v2 {
    struct VestingScheduleV2<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: u8,
        creator: address,
        beneficiary: address,
        balance: 0x2::balance::Balance<T0>,
        total_amount: u64,
        released_amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        vesting_duration_ms: u64,
        interval_ms: u64,
        not_before_ms: u64,
        status: u8,
        revocable: bool,
        trigger_kind: u8,
        comparison: u8,
        target_value: u64,
        trigger_config_hash: vector<u8>,
        min_liquidity_usd: u64,
        validation_window_ms: u64,
        max_sample_gap_ms: u64,
        max_observation_age_ms: u64,
        above_since_ms: 0x1::option::Option<u64>,
        last_observed_at_ms: 0x1::option::Option<u64>,
        last_observed_value: 0x1::option::Option<u64>,
        oracle_pubkeys: vector<vector<u8>>,
        oracle_threshold: u8,
        trigger_deadline_ms: u64,
        fallback_policy: u8,
        client_reference: vector<u8>,
    }

    struct ObservationMessage has copy, drop, store {
        domain: vector<u8>,
        schedule_id: address,
        trigger_config_hash: vector<u8>,
        trigger_kind: u8,
        comparison: u8,
        observed_value: u64,
        observed_at_ms: u64,
        valid_until_ms: u64,
    }

    struct ClaimMessage has copy, drop, store {
        domain: vector<u8>,
        schedule_id: address,
        current_beneficiary: address,
        new_beneficiary: address,
        valid_until_ms: u64,
    }

    struct ScheduleCreatedV2 has copy, drop {
        schedule_id: address,
        creator: address,
        beneficiary: address,
        total_amount: u64,
        trigger_kind: u8,
        target_value: u64,
        client_reference: vector<u8>,
    }

    struct ObservationSubmitted has copy, drop {
        schedule_id: address,
        observed_value: u64,
        observed_at_ms: u64,
        condition_met: bool,
        above_since_ms: 0x1::option::Option<u64>,
    }

    struct VestingActivatedV2 has copy, drop {
        schedule_id: address,
        activated_at_ms: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct TokensClaimedV2 has copy, drop {
        schedule_id: address,
        beneficiary: address,
        amount: u64,
    }

    struct ScheduleCancelledV2 has copy, drop {
        schedule_id: address,
        vested_paid_to_beneficiary: u64,
        returned_to_creator: u64,
    }

    struct TriggerExpiredV2 has copy, drop {
        schedule_id: address,
        fallback_policy: u8,
    }

    struct BeneficiaryReassignedV2 has copy, drop {
        schedule_id: address,
        old_beneficiary: address,
        new_beneficiary: address,
    }

    struct OraclePolicyRotatedV2 has copy, drop {
        schedule_id: address,
        oracle_threshold: u8,
        oracle_count: u64,
    }

    fun activate<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: u64) {
        let v0 = if (arg1 > arg0.not_before_ms) {
            arg1
        } else {
            arg0.not_before_ms
        };
        arg0.start_time_ms = v0;
        arg0.end_time_ms = v0 + arg0.vesting_duration_ms;
        arg0.status = 1;
        let v1 = VestingActivatedV2{
            schedule_id     : 0x2::object::uid_to_address(&arg0.id),
            activated_at_ms : arg1,
            start_time_ms   : arg0.start_time_ms,
            end_time_ms     : arg0.end_time_ms,
        };
        0x2::event::emit<VestingActivatedV2>(v1);
    }

    fun apply_observation<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = condition_is_met(arg0.comparison, arg1, arg0.target_value);
        let v1 = 0x1::option::is_some<u64>(&arg0.last_observed_at_ms) && arg2 - *0x1::option::borrow<u64>(&arg0.last_observed_at_ms) > arg0.max_sample_gap_ms;
        arg0.last_observed_at_ms = 0x1::option::some<u64>(arg2);
        arg0.last_observed_value = 0x1::option::some<u64>(arg1);
        if (!v0) {
            arg0.above_since_ms = 0x1::option::none<u64>();
        } else {
            if (v1 || !0x1::option::is_some<u64>(&arg0.above_since_ms)) {
                arg0.above_since_ms = 0x1::option::some<u64>(arg2);
            };
            if (arg2 - *0x1::option::borrow<u64>(&arg0.above_since_ms) >= arg0.validation_window_ms) {
                activate<T0>(arg0, arg3);
            };
        };
        let v2 = ObservationSubmitted{
            schedule_id    : 0x2::object::uid_to_address(&arg0.id),
            observed_value : arg1,
            observed_at_ms : arg2,
            condition_met  : v0,
            above_since_ms : arg0.above_since_ms,
        };
        0x2::event::emit<ObservationSubmitted>(v2);
    }

    public fun balance_value<T0>(arg0: &VestingScheduleV2<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun beneficiary<T0>(arg0: &VestingScheduleV2<T0>) : address {
        arg0.beneficiary
    }

    public fun calculate_vested_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 < arg1) {
            return 0
        };
        if (arg4 >= arg2) {
            return arg0
        };
        (((arg0 as u128) * (((arg4 - arg1) / arg3 * arg3) as u128) / ((arg2 - arg1) as u128)) as u64)
    }

    public entry fun cancel_schedule<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        assert!(arg0.revocable, 0);
        assert!(arg0.status == 0 || arg0.status == 1, 3);
        let v0 = 0;
        if (arg0.status == 1) {
            let v1 = calculate_vested_amount(arg0.total_amount, arg0.start_time_ms, arg0.end_time_ms, arg0.interval_ms, 0x2::clock::timestamp_ms(arg1)) - arg0.released_amount;
            v0 = v1;
            if (v1 > 0) {
                let v2 = &mut arg0.balance;
                transfer_amount<T0>(v2, v1, arg0.beneficiary, arg2);
                arg0.released_amount = arg0.released_amount + v1;
            };
        };
        let v3 = &mut arg0.balance;
        transfer_all<T0>(v3, arg0.creator, arg2);
        arg0.status = 2;
        let v4 = ScheduleCancelledV2{
            schedule_id                : 0x2::object::uid_to_address(&arg0.id),
            vested_paid_to_beneficiary : v0,
            returned_to_creator        : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<ScheduleCancelledV2>(v4);
    }

    public fun claim_message_bytes<T0>(arg0: &VestingScheduleV2<T0>, arg1: address, arg2: u64) : vector<u8> {
        let v0 = ClaimMessage{
            domain              : b"alphacity.sluice.v2.claim",
            schedule_id         : 0x2::object::uid_to_address(&arg0.id),
            current_beneficiary : arg0.beneficiary,
            new_beneficiary     : arg1,
            valid_until_ms      : arg2,
        };
        0x2::bcs::to_bytes<ClaimMessage>(&v0)
    }

    public entry fun claim_vested<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 3);
        let v0 = calculate_vested_amount(arg0.total_amount, arg0.start_time_ms, arg0.end_time_ms, arg0.interval_ms, 0x2::clock::timestamp_ms(arg1)) - arg0.released_amount;
        assert!(v0 > 0, 2);
        arg0.released_amount = arg0.released_amount + v0;
        let v1 = &mut arg0.balance;
        transfer_amount<T0>(v1, v0, arg0.beneficiary, arg2);
        if (0x2::balance::value<T0>(&arg0.balance) == 0) {
            arg0.status = 3;
        };
        let v2 = TokensClaimedV2{
            schedule_id : 0x2::object::uid_to_address(&arg0.id),
            beneficiary : arg0.beneficiary,
            amount      : v0,
        };
        0x2::event::emit<TokensClaimedV2>(v2);
    }

    fun condition_is_met(arg0: u8, arg1: u64, arg2: u64) : bool {
        arg0 == 0 && arg1 >= arg2 || arg1 <= arg2
    }

    public entry fun create_time_schedule<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 - arg2;
        validate_common<T0>(&arg0, arg1, v0, arg4, &arg6);
        let v1 = VestingScheduleV2<T0>{
            id                     : 0x2::object::new(arg7),
            version                : 2,
            creator                : 0x2::tx_context::sender(arg7),
            beneficiary            : arg1,
            balance                : 0x2::coin::into_balance<T0>(arg0),
            total_amount           : 0x2::coin::value<T0>(&arg0),
            released_amount        : 0,
            start_time_ms          : arg2,
            end_time_ms            : arg3,
            vesting_duration_ms    : v0,
            interval_ms            : arg4,
            not_before_ms          : arg2,
            status                 : 1,
            revocable              : arg5,
            trigger_kind           : 0,
            comparison             : 0,
            target_value           : 0,
            trigger_config_hash    : b"",
            min_liquidity_usd      : 0,
            validation_window_ms   : 0,
            max_sample_gap_ms      : 0,
            max_observation_age_ms : 0,
            above_since_ms         : 0x1::option::none<u64>(),
            last_observed_at_ms    : 0x1::option::none<u64>(),
            last_observed_value    : 0x1::option::none<u64>(),
            oracle_pubkeys         : vector[],
            oracle_threshold       : 0,
            trigger_deadline_ms    : 0,
            fallback_policy        : 0,
            client_reference       : arg6,
        };
        emit_created<T0>(&v1);
        0x2::transfer::share_object<VestingScheduleV2<T0>>(v1);
    }

    public entry fun create_triggered_schedule<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: vector<vector<u8>>, arg14: u8, arg15: u64, arg16: u8, arg17: bool, arg18: vector<u8>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        validate_common<T0>(&arg0, arg1, arg3, arg4, &arg18);
        validate_trigger(arg5, arg6, arg7, &arg8, arg10, arg11, arg12, &arg13, arg14, arg15, arg16, 0x2::clock::timestamp_ms(arg19));
        let v0 = VestingScheduleV2<T0>{
            id                     : 0x2::object::new(arg20),
            version                : 2,
            creator                : 0x2::tx_context::sender(arg20),
            beneficiary            : arg1,
            balance                : 0x2::coin::into_balance<T0>(arg0),
            total_amount           : 0x2::coin::value<T0>(&arg0),
            released_amount        : 0,
            start_time_ms          : arg2,
            end_time_ms            : arg2 + arg3,
            vesting_duration_ms    : arg3,
            interval_ms            : arg4,
            not_before_ms          : arg2,
            status                 : 0,
            revocable              : arg17,
            trigger_kind           : arg5,
            comparison             : arg6,
            target_value           : arg7,
            trigger_config_hash    : arg8,
            min_liquidity_usd      : arg9,
            validation_window_ms   : arg10,
            max_sample_gap_ms      : arg11,
            max_observation_age_ms : arg12,
            above_since_ms         : 0x1::option::none<u64>(),
            last_observed_at_ms    : 0x1::option::none<u64>(),
            last_observed_value    : 0x1::option::none<u64>(),
            oracle_pubkeys         : arg13,
            oracle_threshold       : arg14,
            trigger_deadline_ms    : arg15,
            fallback_policy        : arg16,
            client_reference       : arg18,
        };
        emit_created<T0>(&v0);
        0x2::transfer::share_object<VestingScheduleV2<T0>>(v0);
    }

    fun emit_created<T0>(arg0: &VestingScheduleV2<T0>) {
        let v0 = ScheduleCreatedV2{
            schedule_id      : 0x2::object::uid_to_address(&arg0.id),
            creator          : arg0.creator,
            beneficiary      : arg0.beneficiary,
            total_amount     : arg0.total_amount,
            trigger_kind     : arg0.trigger_kind,
            target_value     : arg0.target_value,
            client_reference : arg0.client_reference,
        };
        0x2::event::emit<ScheduleCreatedV2>(v0);
    }

    public fun end_time_ms<T0>(arg0: &VestingScheduleV2<T0>) : u64 {
        arg0.end_time_ms
    }

    public fun observation_message_bytes<T0>(arg0: &VestingScheduleV2<T0>, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = ObservationMessage{
            domain              : b"alphacity.sluice.v2.observation",
            schedule_id         : 0x2::object::uid_to_address(&arg0.id),
            trigger_config_hash : arg0.trigger_config_hash,
            trigger_kind        : arg0.trigger_kind,
            comparison          : arg0.comparison,
            observed_value      : arg1,
            observed_at_ms      : arg2,
            valid_until_ms      : arg3,
        };
        0x2::bcs::to_bytes<ObservationMessage>(&v0)
    }

    fun reassign<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: address) {
        assert!(arg1 != @0x0, 10);
        assert!(arg0.status == 0 || arg0.status == 1, 3);
        arg0.beneficiary = arg1;
        let v0 = BeneficiaryReassignedV2{
            schedule_id     : 0x2::object::uid_to_address(&arg0.id),
            old_beneficiary : arg0.beneficiary,
            new_beneficiary : arg1,
        };
        0x2::event::emit<BeneficiaryReassignedV2>(v0);
    }

    public entry fun reassign_beneficiary<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 0);
        reassign<T0>(arg0, arg1);
    }

    public entry fun reassign_beneficiary_by_signature<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(0x1::vector::length<u8>(&arg2) == 64, 4);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg5), 4);
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, arg1);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&v0)) == arg0.beneficiary, 0);
        let v1 = claim_message_bytes<T0>(arg0, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg1, &v1), 4);
        reassign<T0>(arg0, arg3);
    }

    public fun released_amount<T0>(arg0: &VestingScheduleV2<T0>) : u64 {
        arg0.released_amount
    }

    public entry fun resolve_expired_trigger<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 3);
        assert!(arg0.trigger_deadline_ms > 0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.trigger_deadline_ms, 8);
        let v1 = arg0.fallback_policy;
        if (v1 == 1) {
            activate<T0>(arg0, v0);
        } else {
            let v2 = &mut arg0.balance;
            transfer_all<T0>(v2, arg0.creator, arg2);
            arg0.status = 2;
            let v3 = ScheduleCancelledV2{
                schedule_id                : 0x2::object::uid_to_address(&arg0.id),
                vested_paid_to_beneficiary : 0,
                returned_to_creator        : 0x2::balance::value<T0>(&arg0.balance),
            };
            0x2::event::emit<ScheduleCancelledV2>(v3);
        };
        let v4 = TriggerExpiredV2{
            schedule_id     : 0x2::object::uid_to_address(&arg0.id),
            fallback_policy : v1,
        };
        0x2::event::emit<TriggerExpiredV2>(v4);
    }

    public entry fun rotate_oracle_policy<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: vector<vector<u8>>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 0);
        assert!(arg0.revocable, 0);
        assert!(arg0.status == 0, 3);
        validate_oracle_policy(&arg1, arg2);
        arg0.oracle_pubkeys = arg1;
        arg0.oracle_threshold = arg2;
        arg0.above_since_ms = 0x1::option::none<u64>();
        arg0.last_observed_at_ms = 0x1::option::none<u64>();
        arg0.last_observed_value = 0x1::option::none<u64>();
        let v0 = OraclePolicyRotatedV2{
            schedule_id      : 0x2::object::uid_to_address(&arg0.id),
            oracle_threshold : arg2,
            oracle_count     : 0x1::vector::length<vector<u8>>(&arg0.oracle_pubkeys),
        };
        0x2::event::emit<OraclePolicyRotatedV2>(v0);
    }

    public fun start_time_ms<T0>(arg0: &VestingScheduleV2<T0>) : u64 {
        arg0.start_time_ms
    }

    public fun status<T0>(arg0: &VestingScheduleV2<T0>) : u8 {
        arg0.status
    }

    public entry fun submit_observation<T0>(arg0: &mut VestingScheduleV2<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg2 <= v0, 6);
        assert!(v0 - arg2 <= arg0.max_observation_age_ms, 6);
        assert!(arg3 >= v0, 6);
        if (0x1::option::is_some<u64>(&arg0.last_observed_at_ms)) {
            assert!(arg2 > *0x1::option::borrow<u64>(&arg0.last_observed_at_ms), 7);
        };
        let v1 = observation_message_bytes<T0>(arg0, arg1, arg2, arg3);
        verify_oracle_threshold(&arg0.oracle_pubkeys, arg0.oracle_threshold, &arg4, &arg5, &v1);
        apply_observation<T0>(arg0, arg1, arg2, v0);
    }

    fun transfer_all<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > 0) {
            transfer_amount<T0>(arg0, v0, arg1, arg2);
        };
    }

    fun transfer_amount<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg3), arg2);
    }

    fun valid_trigger_kind(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else {
            arg0 == 255
        }
    }

    fun validate_common<T0>(arg0: &0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: &vector<u8>) {
        assert!(0x2::coin::value<T0>(arg0) > 0, 9);
        assert!(arg1 != @0x0, 10);
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0 && arg3 <= arg2, 1);
        assert!(0x1::vector::length<u8>(arg4) > 0 && 0x1::vector::length<u8>(arg4) <= 64, 11);
    }

    fun validate_oracle_policy(arg0: &vector<vector<u8>>, arg1: u8) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 > 0 && v0 <= 10, 5);
        assert!((arg1 as u64) > 0 && (arg1 as u64) <= v0, 5);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg0, v1)) == 32, 5);
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(0x1::vector::borrow<vector<u8>>(arg0, v1) != 0x1::vector::borrow<vector<u8>>(arg0, v2), 5);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun validate_trigger(arg0: u8, arg1: u8, arg2: u64, arg3: &vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &vector<vector<u8>>, arg8: u8, arg9: u64, arg10: u8, arg11: u64) {
        assert!(arg0 != 0 && valid_trigger_kind(arg0), 11);
        assert!(arg1 == 0 || arg1 == 1, 11);
        assert!(arg2 > 0, 11);
        assert!(0x1::vector::length<u8>(arg3) == 32, 11);
        assert!(arg5 > 0, 11);
        assert!(arg6 > 0, 11);
        assert!(arg4 == 0 || arg5 <= arg4, 11);
        assert!(arg10 == 0 || arg10 == 1, 11);
        assert!(arg9 == 0 || arg9 > arg11, 11);
        validate_oracle_policy(arg7, arg8);
    }

    fun verify_oracle_threshold(arg0: &vector<vector<u8>>, arg1: u8, arg2: &vector<u8>, arg3: &vector<vector<u8>>, arg4: &vector<u8>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg3);
        assert!(v0 == 0x1::vector::length<u8>(arg2), 4);
        assert!(v0 >= (arg1 as u64), 4);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = (*0x1::vector::borrow<u8>(arg2, v1) as u64);
            assert!(v2 < 0x1::vector::length<vector<u8>>(arg0), 4);
            if (v1 > 0) {
                assert!(v2 > 0, 4);
            };
            let v3 = 0x1::vector::borrow<vector<u8>>(arg3, v1);
            let v4 = 0x1::vector::borrow<vector<u8>>(arg0, v2);
            assert!(0x1::vector::length<u8>(v3) == 64, 4);
            assert!(0x2::ed25519::ed25519_verify(v3, v4, arg4), 4);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

