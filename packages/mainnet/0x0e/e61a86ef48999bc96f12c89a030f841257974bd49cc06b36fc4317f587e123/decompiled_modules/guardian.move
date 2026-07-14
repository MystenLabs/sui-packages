module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian {
    struct GuardianSet has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        guardians: vector<address>,
        threshold: u64,
        heir: address,
        timelock_ms: u64,
        dispute_window_ms: u64,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct RecoveryRequest has key {
        id: 0x2::object::UID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        proposed_owner: address,
        proposed_heir: address,
        reason_hash: vector<u8>,
        approvals: vector<address>,
        guardian_set_nonce: u64,
        requested_at_ms: u64,
        executable_after_ms: u64,
        dispute_until_ms: u64,
        disputed: bool,
        finalized: bool,
    }

    struct GuardianSetCreated has copy, drop {
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        threshold: u64,
        heir: address,
        timelock_ms: u64,
        dispute_window_ms: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct GuardianSetUpdated has copy, drop {
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        threshold: u64,
        heir: address,
        timelock_ms: u64,
        dispute_window_ms: u64,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct RecoveryRequested has copy, drop {
        recovery_request_id: 0x2::object::ID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        proposed_owner: address,
        proposed_heir: address,
        guardian_set_nonce: u64,
        requested_at_ms: u64,
        executable_after_ms: u64,
        dispute_until_ms: u64,
    }

    struct RecoveryDisputed has copy, drop {
        recovery_request_id: 0x2::object::ID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct RecoveryApproved has copy, drop {
        recovery_request_id: 0x2::object::ID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        guardian: address,
        approval_count: u64,
    }

    struct SuccessionFinalized has copy, drop {
        recovery_request_id: 0x2::object::ID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        previous_owner: address,
        proposed_owner: address,
        proposed_heir: address,
        guardian_set_nonce: u64,
        timestamp_ms: u64,
    }

    struct KeyRotationRequired has copy, drop {
        recovery_request_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        previous_owner: address,
        proposed_owner: address,
        timestamp_ms: u64,
    }

    entry fun approve_recovery(arg0: &mut RecoveryRequest, arg1: &GuardianSet, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.guardian_set_id == 0x2::object::uid_to_inner(&arg1.id), 508);
        assert!(arg0.character_id == arg1.character_id, 501);
        assert!(arg0.guardian_set_nonce == arg1.nonce, 509);
        assert!(!arg0.finalized, 511);
        assert!(!arg0.disputed, 512);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.dispute_until_ms, 510);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_guardian(arg1, v0), 517);
        assert!(!0x1::vector::contains<address>(&arg0.approvals, &v0), 518);
        0x1::vector::push_back<address>(&mut arg0.approvals, v0);
        let v1 = RecoveryApproved{
            recovery_request_id : 0x2::object::uid_to_inner(&arg0.id),
            guardian_set_id     : arg0.guardian_set_id,
            character_id        : arg0.character_id,
            guardian            : v0,
            approval_count      : 0x1::vector::length<address>(&arg0.approvals),
        };
        0x2::event::emit<RecoveryApproved>(v1);
    }

    fun assert_distinct_addresses(arg0: &vector<address>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(arg0);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow<address>(arg0, v0);
            let v3 = v0 + 1;
            while (v3 < v1) {
                assert!(*v2 != *0x1::vector::borrow<address>(arg0, v3), 504);
                v3 = v3 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_finalizable_state(arg0: u64, arg1: u64, arg2: bool, arg3: bool) {
        assert!(!arg3, 511);
        assert!(!arg2, 512);
        assert!(arg0 >= arg1, 513);
    }

    fun assert_guardian_args(arg0: &vector<address>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::vector::length<address>(arg0);
        assert!(v0 > 0, 502);
        assert!(arg1 > 0 && arg1 <= v0, 503);
        assert_distinct_addresses(arg0);
        assert!(arg2 > 0, 514);
        assert!(arg3 > 0 && arg3 <= arg2, 515);
    }

    fun assert_guardian_owner(arg0: &GuardianSet, arg1: address) {
        assert!(arg0.owner == arg1, 500);
    }

    fun assert_reason_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 505);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 506);
    }

    fun assert_recovery_owner(arg0: &RecoveryRequest, arg1: address) {
        assert!(arg0.owner == arg1, 500);
    }

    fun assert_threshold(arg0: &vector<address>, arg1: u64, arg2: &vector<address>) {
        assert!(count_distinct_guardian_approvals(arg0, arg2) >= arg1, 507);
    }

    entry fun begin_recovery(arg0: &GuardianSet, arg1: address, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_reason_hash(&arg3);
        assert!(arg2 == arg0.heir, 516);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + arg0.timelock_ms;
        let v2 = v0 + arg0.dispute_window_ms;
        let v3 = RecoveryRequest{
            id                  : 0x2::object::new(arg5),
            guardian_set_id     : 0x2::object::uid_to_inner(&arg0.id),
            character_id        : arg0.character_id,
            owner               : arg0.owner,
            proposed_owner      : arg1,
            proposed_heir       : arg2,
            reason_hash         : arg3,
            approvals           : vector[],
            guardian_set_nonce  : arg0.nonce,
            requested_at_ms     : v0,
            executable_after_ms : v1,
            dispute_until_ms    : v2,
            disputed            : false,
            finalized           : false,
        };
        let v4 = RecoveryRequested{
            recovery_request_id : 0x2::object::uid_to_inner(&v3.id),
            guardian_set_id     : v3.guardian_set_id,
            character_id        : v3.character_id,
            owner               : v3.owner,
            proposed_owner      : arg1,
            proposed_heir       : arg2,
            guardian_set_nonce  : v3.guardian_set_nonce,
            requested_at_ms     : v0,
            executable_after_ms : v1,
            dispute_until_ms    : v2,
        };
        0x2::event::emit<RecoveryRequested>(v4);
        0x2::transfer::share_object<RecoveryRequest>(v3);
    }

    fun count_distinct_guardian_approvals(arg0: &vector<address>, arg1: &vector<address>) : u64 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = *0x1::vector::borrow<address>(arg1, v1);
            if (0x1::vector::contains<address>(arg0, &v2) && !0x1::vector::contains<address>(&v0, &v2)) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::length<address>(&v0)
    }

    entry fun create_guardian_set(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<address>, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, v0);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_guardian_args(&arg1, arg2, arg4, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = GuardianSet{
            id                : 0x2::object::new(arg7),
            character_id      : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner             : v0,
            guardians         : arg1,
            threshold         : arg2,
            heir              : arg3,
            timelock_ms       : arg4,
            dispute_window_ms : arg5,
            nonce             : 0,
            created_at_ms     : v1,
            updated_at_ms     : v1,
        };
        let v3 = GuardianSetCreated{
            guardian_set_id   : 0x2::object::uid_to_inner(&v2.id),
            character_id      : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner             : v0,
            threshold         : arg2,
            heir              : arg3,
            timelock_ms       : arg4,
            dispute_window_ms : arg5,
            nonce             : 0,
            timestamp_ms      : v1,
        };
        0x2::event::emit<GuardianSetCreated>(v3);
        0x2::transfer::share_object<GuardianSet>(v2);
    }

    entry fun dispute_recovery(arg0: &mut RecoveryRequest, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_recovery_owner(arg0, v0);
        assert!(!arg0.finalized, 511);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 <= arg0.dispute_until_ms, 510);
        arg0.disputed = true;
        let v2 = RecoveryDisputed{
            recovery_request_id : 0x2::object::uid_to_inner(&arg0.id),
            guardian_set_id     : arg0.guardian_set_id,
            character_id        : arg0.character_id,
            owner               : v0,
            timestamp_ms        : v1,
        };
        0x2::event::emit<RecoveryDisputed>(v2);
    }

    entry fun finalize_recovery_and_transfer(arg0: &mut GuardianSet, arg1: &mut RecoveryRequest, arg2: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg3: &0x2::clock::Clock) {
        finalize_recovery_state(arg0, arg1, arg3);
        assert!(0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg2) == arg1.character_id, 501);
        rotate_guardian_set_owner(arg0, arg1.proposed_owner, arg1.proposed_heir, arg3);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::guardian_transfer_owner(arg2, arg1.owner, arg1.proposed_owner, arg3);
    }

    fun finalize_recovery_state(arg0: &GuardianSet, arg1: &mut RecoveryRequest, arg2: &0x2::clock::Clock) {
        assert!(arg1.guardian_set_id == 0x2::object::uid_to_inner(&arg0.id), 508);
        assert!(arg1.character_id == arg0.character_id, 501);
        assert!(arg1.guardian_set_nonce == arg0.nonce, 509);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_threshold(&arg0.guardians, arg0.threshold, &arg1.approvals);
        assert_finalizable_state(v0, arg1.executable_after_ms, arg1.disputed, arg1.finalized);
        arg1.finalized = true;
        let v1 = SuccessionFinalized{
            recovery_request_id : 0x2::object::uid_to_inner(&arg1.id),
            guardian_set_id     : arg1.guardian_set_id,
            character_id        : arg1.character_id,
            previous_owner      : arg1.owner,
            proposed_owner      : arg1.proposed_owner,
            proposed_heir       : arg1.proposed_heir,
            guardian_set_nonce  : arg1.guardian_set_nonce,
            timestamp_ms        : v0,
        };
        0x2::event::emit<SuccessionFinalized>(v1);
        let v2 = KeyRotationRequired{
            recovery_request_id : 0x2::object::uid_to_inner(&arg1.id),
            character_id        : arg1.character_id,
            previous_owner      : arg1.owner,
            proposed_owner      : arg1.proposed_owner,
            timestamp_ms        : v0,
        };
        0x2::event::emit<KeyRotationRequired>(v2);
    }

    entry fun finalize_recovery_via_hub(arg0: &mut GuardianSet, arg1: &mut RecoveryRequest, arg2: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::CharacterHub, arg3: &0x2::clock::Clock) {
        finalize_recovery_state(arg0, arg1, arg3);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::hub_character_id(arg2) == arg1.character_id, 501);
        rotate_guardian_set_owner(arg0, arg1.proposed_owner, arg1.proposed_heir, arg3);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::guardian_rotate_hub_owner(arg2, arg1.owner, arg1.proposed_owner, arg3);
    }

    public fun guardian_set_character_id(arg0: &GuardianSet) : 0x2::object::ID {
        arg0.character_id
    }

    public fun guardian_set_heir(arg0: &GuardianSet) : address {
        arg0.heir
    }

    public fun guardian_set_id(arg0: &GuardianSet) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun guardian_set_nonce(arg0: &GuardianSet) : u64 {
        arg0.nonce
    }

    public fun guardian_set_owner(arg0: &GuardianSet) : address {
        arg0.owner
    }

    public fun guardian_set_threshold(arg0: &GuardianSet) : u64 {
        arg0.threshold
    }

    public fun is_guardian(arg0: &GuardianSet, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.guardians, &arg1)
    }

    public fun recovery_request_approval_count(arg0: &RecoveryRequest) : u64 {
        0x1::vector::length<address>(&arg0.approvals)
    }

    public fun recovery_request_character_id(arg0: &RecoveryRequest) : 0x2::object::ID {
        arg0.character_id
    }

    public fun recovery_request_disputed(arg0: &RecoveryRequest) : bool {
        arg0.disputed
    }

    public fun recovery_request_finalized(arg0: &RecoveryRequest) : bool {
        arg0.finalized
    }

    public fun recovery_request_proposed_heir(arg0: &RecoveryRequest) : address {
        arg0.proposed_heir
    }

    public fun recovery_request_proposed_owner(arg0: &RecoveryRequest) : address {
        arg0.proposed_owner
    }

    fun rotate_guardian_set_owner(arg0: &mut GuardianSet, arg1: address, arg2: address, arg3: &0x2::clock::Clock) {
        arg0.owner = arg1;
        arg0.heir = arg2;
        arg0.nonce = arg0.nonce + 1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = GuardianSetUpdated{
            guardian_set_id   : 0x2::object::uid_to_inner(&arg0.id),
            character_id      : arg0.character_id,
            owner             : arg1,
            threshold         : arg0.threshold,
            heir              : arg0.heir,
            timelock_ms       : arg0.timelock_ms,
            dispute_window_ms : arg0.dispute_window_ms,
            nonce             : arg0.nonce,
            timestamp_ms      : arg0.updated_at_ms,
        };
        0x2::event::emit<GuardianSetUpdated>(v0);
    }

    entry fun update_guardian_set(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut GuardianSet, arg2: vector<address>, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, v0);
        assert_guardian_owner(arg1, v0);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 501);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_guardian_args(&arg2, arg3, arg5, arg6);
        arg1.guardians = arg2;
        arg1.threshold = arg3;
        arg1.heir = arg4;
        arg1.timelock_ms = arg5;
        arg1.dispute_window_ms = arg6;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg7);
        let v1 = GuardianSetUpdated{
            guardian_set_id   : 0x2::object::uid_to_inner(&arg1.id),
            character_id      : arg1.character_id,
            owner             : v0,
            threshold         : arg3,
            heir              : arg4,
            timelock_ms       : arg5,
            dispute_window_ms : arg6,
            nonce             : arg1.nonce,
            timestamp_ms      : arg1.updated_at_ms,
        };
        0x2::event::emit<GuardianSetUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

