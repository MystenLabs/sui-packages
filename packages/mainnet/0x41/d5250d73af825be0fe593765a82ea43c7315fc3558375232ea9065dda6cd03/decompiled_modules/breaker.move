module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::breaker {
    struct CircuitBreakerPaused has copy, drop {
        character_id: 0x2::object::ID,
        actor: address,
        paused: bool,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct GuardianPauseRequest has key {
        id: 0x2::object::UID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        paused: bool,
        reason_hash: vector<u8>,
        approvals: vector<address>,
        finalized: bool,
        created_at_ms: u64,
    }

    struct GuardianPauseRequested has copy, drop {
        request_id: 0x2::object::ID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        paused: bool,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct GuardianPauseApproved has copy, drop {
        request_id: 0x2::object::ID,
        guardian_set_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        guardian: address,
        approval_count: u64,
    }

    public entry fun approve_guardian_pause(arg0: &mut GuardianPauseRequest, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.guardian_set_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_id(arg1), 283);
        assert!(arg0.character_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_character_id(arg1), 281);
        assert!(!arg0.finalized, 284);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::is_guardian(arg1, v0), 280);
        assert!(!0x1::vector::contains<address>(&arg0.approvals, &v0), 285);
        0x1::vector::push_back<address>(&mut arg0.approvals, v0);
        let v1 = GuardianPauseApproved{
            request_id      : 0x2::object::uid_to_inner(&arg0.id),
            guardian_set_id : arg0.guardian_set_id,
            character_id    : arg0.character_id,
            guardian        : v0,
            approval_count  : 0x1::vector::length<address>(&arg0.approvals),
        };
        0x2::event::emit<GuardianPauseApproved>(v1);
    }

    fun assert_guardian_set_matches(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet) {
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_character_id(arg1) == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 281);
    }

    fun assert_guardian_threshold(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg1: &vector<address>) {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = *0x1::vector::borrow<address>(arg1, v1);
            if (0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::is_guardian(arg0, v2) && !0x1::vector::contains<address>(&v0, &v2)) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        assert!(0x1::vector::length<address>(&v0) >= 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_threshold(arg0), 286);
    }

    public fun assert_not_paused(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
    }

    fun assert_reason_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) <= 128, 282);
    }

    public entry fun begin_guardian_pause_request(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg2: bool, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_guardian_set_matches(arg0, arg1);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::is_guardian(arg1, 0x2::tx_context::sender(arg5)), 280);
        assert_reason_hash(&arg3);
        let v0 = new_guardian_pause_request(0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_id(arg1), arg2, arg3, arg4, arg5);
        let v1 = GuardianPauseRequested{
            request_id      : 0x2::object::uid_to_inner(&v0.id),
            guardian_set_id : v0.guardian_set_id,
            character_id    : v0.character_id,
            paused          : arg2,
            reason_hash     : v0.reason_hash,
            timestamp_ms    : v0.created_at_ms,
        };
        0x2::event::emit<GuardianPauseRequested>(v1);
        0x2::transfer::share_object<GuardianPauseRequest>(v0);
    }

    public entry fun finalize_guardian_pause(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg2: &mut GuardianPauseRequest, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0) == arg2.character_id, 281);
        assert!(arg2.guardian_set_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_id(arg1), 283);
        assert!(arg2.character_id == 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_character_id(arg1), 281);
        assert!(!arg2.finalized, 284);
        assert_guardian_threshold(arg1, &arg2.approvals);
        arg2.finalized = true;
        set_paused(arg0, arg2.paused, 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_owner(arg1), arg2.reason_hash, arg3);
    }

    fun new_guardian_pause_request(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : GuardianPauseRequest {
        GuardianPauseRequest{
            id              : 0x2::object::new(arg5),
            guardian_set_id : arg1,
            character_id    : arg0,
            paused          : arg2,
            reason_hash     : arg3,
            approvals       : vector[],
            finalized       : false,
            created_at_ms   : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public entry fun pause_by_guardian(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_character_id(arg1) == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 281);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::is_guardian(arg1, 0x2::tx_context::sender(arg4)), 280);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_threshold(arg1) == 1, 286);
        set_paused(arg0, true, 0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public entry fun pause_by_owner(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        set_paused(arg0, true, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    public entry fun resume_by_guardian(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::GuardianSet, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_character_id(arg1) == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 281);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::is_guardian(arg1, 0x2::tx_context::sender(arg4)), 280);
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::guardian::guardian_set_threshold(arg1) == 1, 286);
        set_paused(arg0, false, 0x2::tx_context::sender(arg4), arg2, arg3);
    }

    public entry fun resume_by_owner(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, 0x2::tx_context::sender(arg3));
        set_paused(arg0, false, 0x2::tx_context::sender(arg3), arg1, arg2);
    }

    fun set_paused(arg0: &mut 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: bool, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_reason_hash(&arg3);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::set_paused_from_breaker(arg0, arg1, arg3, arg4);
        let v0 = CircuitBreakerPaused{
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            actor        : arg2,
            paused       : arg1,
            reason_hash  : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CircuitBreakerPaused>(v0);
    }

    // decompiled from Move bytecode v7
}

