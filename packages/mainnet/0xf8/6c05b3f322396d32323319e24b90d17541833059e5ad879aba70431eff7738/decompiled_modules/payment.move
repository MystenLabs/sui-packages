module 0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::payment {
    struct PaymentPolicy has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        policy_hash: vector<u8>,
        per_call_cap_micros: u64,
        daily_cap_micros: u64,
        spent_today_micros: u64,
        day_started_ms: u64,
        provider_bound: bool,
        provider: address,
        locked: bool,
        consumed_nonces: 0x2::table::Table<vector<u8>, bool>,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct PaymentPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        per_call_cap_micros: u64,
        daily_cap_micros: u64,
        provider_bound: bool,
        provider: address,
        timestamp_ms: u64,
    }

    struct PaymentPolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        nonce: u64,
        timestamp_ms: u64,
    }

    struct PaymentPolicyLocked has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        locked: bool,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct PaymentAuthorized has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        payer: address,
        provider: address,
        capability_ref: 0x1::string::String,
        amount_micros: u64,
        nonce_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct ProviderReceiptRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        recorder: address,
        provider: address,
        receipt_ref: 0x1::string::String,
        receipt_hash: vector<u8>,
        amount_micros: u64,
        timestamp_ms: u64,
    }

    struct ProviderClaimSubmitted has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        provider: address,
        claim_ref: 0x1::string::String,
        claim_hash: vector<u8>,
        amount_micros: u64,
        timestamp_ms: u64,
    }

    struct ProviderClaimSettled has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        provider: address,
        claim_ref: 0x1::string::String,
        settlement_hash: vector<u8>,
        amount_micros: u64,
        timestamp_ms: u64,
    }

    struct ProviderClaimRejected has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        provider: address,
        claim_ref: 0x1::string::String,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    fun assert_owner(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: address) {
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_owner(arg0, arg1);
    }

    fun assert_amount(arg0: u64) {
        assert!(arg0 > 0, 406);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 402);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 404);
    }

    fun assert_hash_or_empty(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) <= 128, 404);
    }

    fun assert_policy_args(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u64) {
        assert_ref(arg0);
        assert_hash(arg1);
        assert_amount(arg2);
        assert_amount(arg3);
        assert!(arg2 <= arg3, 408);
    }

    fun assert_policy_matches(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &PaymentPolicy) {
        assert!(arg1.character_id == 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0), 401);
    }

    fun assert_policy_owner(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &PaymentPolicy, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 400);
        assert_policy_matches(arg0, arg1);
    }

    fun assert_provider(arg0: &PaymentPolicy, arg1: address) {
        if (arg0.provider_bound) {
            assert!(arg0.provider == arg1, 409);
        };
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 402);
        assert!(0x1::vector::length<u8>(arg0) <= 512, 403);
    }

    fun assert_unlocked(arg0: &PaymentPolicy) {
        assert!(!arg0.locked, 405);
    }

    entry fun authorize_delegate_payment(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &mut PaymentPolicy, arg2: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::authority::AgentCap, arg3: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::authority::RevocationRegistry, arg4: address, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::authority::assert_cap_scope(arg0, arg2, arg3, arg4, 0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::authority::scope_authorize_payment(), arg8, arg9);
        authorize_payment_internal(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun authorize_owner_payment(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &mut PaymentPolicy, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg7));
        authorize_payment_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun authorize_payment_internal(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &mut PaymentPolicy, arg2: address, arg3: vector<u8>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        assert_unlocked(arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg5);
        assert_amount(arg4);
        assert_provider(arg1, arg2);
        assert!(arg4 <= arg1.per_call_cap_micros, 407);
        roll_day(arg1, 0x2::clock::timestamp_ms(arg6));
        assert!(arg1.spent_today_micros + arg4 <= arg1.daily_cap_micros, 408);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.consumed_nonces, arg5), 410);
        0x2::table::add<vector<u8>, bool>(&mut arg1.consumed_nonces, arg5, true);
        arg1.spent_today_micros = arg1.spent_today_micros + arg4;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg6);
        let v0 = PaymentAuthorized{
            policy_id      : 0x2::object::uid_to_inner(&arg1.id),
            character_id   : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            payer          : 0x2::tx_context::sender(arg7),
            provider       : arg2,
            capability_ref : 0x1::string::utf8(arg3),
            amount_micros  : arg4,
            nonce_hash     : arg5,
            timestamp_ms   : arg1.updated_at_ms,
        };
        0x2::event::emit<PaymentAuthorized>(v0);
    }

    public fun consumed_nonce_count(arg0: &PaymentPolicy) : u64 {
        0x2::table::length<vector<u8>, bool>(&arg0.consumed_nonces)
    }

    entry fun create_payment_policy(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: bool, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg8));
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_policy_args(&arg1, &arg2, arg3, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = PaymentPolicy{
            id                  : 0x2::object::new(arg8),
            character_id        : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            owner               : 0x2::tx_context::sender(arg8),
            policy_uri          : 0x1::string::utf8(arg1),
            policy_hash         : arg2,
            per_call_cap_micros : arg3,
            daily_cap_micros    : arg4,
            spent_today_micros  : 0,
            day_started_ms      : v0,
            provider_bound      : arg5,
            provider            : arg6,
            locked              : false,
            consumed_nonces     : 0x2::table::new<vector<u8>, bool>(arg8),
            nonce               : 0,
            created_at_ms       : v0,
            updated_at_ms       : v0,
        };
        let v2 = PaymentPolicyCreated{
            policy_id           : 0x2::object::uid_to_inner(&v1.id),
            character_id        : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            owner               : 0x2::tx_context::sender(arg8),
            policy_uri          : v1.policy_uri,
            per_call_cap_micros : arg3,
            daily_cap_micros    : arg4,
            provider_bound      : arg5,
            provider            : arg6,
            timestamp_ms        : v0,
        };
        0x2::event::emit<PaymentPolicyCreated>(v2);
        0x2::transfer::public_transfer<PaymentPolicy>(v1, 0x2::tx_context::sender(arg8));
    }

    public fun has_consumed_nonce(arg0: &PaymentPolicy, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.consumed_nonces, arg1)
    }

    public fun payment_policy_character_id(arg0: &PaymentPolicy) : 0x2::object::ID {
        arg0.character_id
    }

    public fun payment_policy_nonce(arg0: &PaymentPolicy) : u64 {
        arg0.nonce
    }

    public fun payment_policy_owner(arg0: &PaymentPolicy) : address {
        arg0.owner
    }

    public fun payment_policy_spent_today_micros(arg0: &PaymentPolicy) : u64 {
        arg0.spent_today_micros
    }

    entry fun record_provider_receipt(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &PaymentPolicy, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg4);
        assert_amount(arg5);
        assert_provider(arg1, arg2);
        let v0 = ProviderReceiptRecorded{
            policy_id     : 0x2::object::uid_to_inner(&arg1.id),
            character_id  : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            recorder      : 0x2::tx_context::sender(arg7),
            provider      : arg2,
            receipt_ref   : 0x1::string::utf8(arg3),
            receipt_hash  : arg4,
            amount_micros : arg5,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ProviderReceiptRecorded>(v0);
    }

    entry fun reject_provider_claim(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &PaymentPolicy, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        assert_unlocked(arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg4);
        assert_provider(arg1, arg2);
        let v0 = ProviderClaimRejected{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg6),
            provider     : arg2,
            claim_ref    : 0x1::string::utf8(arg3),
            reason_hash  : arg4,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ProviderClaimRejected>(v0);
    }

    fun roll_day(arg0: &mut PaymentPolicy, arg1: u64) {
        if (arg1 >= arg0.day_started_ms + 86400000) {
            arg0.day_started_ms = arg1;
            arg0.spent_today_micros = 0;
        };
    }

    entry fun set_payment_lock(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &mut PaymentPolicy, arg2: bool, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg5));
        assert_hash_or_empty(&arg3);
        arg1.locked = arg2;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = PaymentPolicyLocked{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg5),
            locked       : arg2,
            reason_hash  : arg3,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<PaymentPolicyLocked>(v0);
    }

    entry fun settle_provider_claim(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &PaymentPolicy, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg7));
        assert_unlocked(arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg4);
        assert_amount(arg5);
        assert_provider(arg1, arg2);
        let v0 = ProviderClaimSettled{
            policy_id       : 0x2::object::uid_to_inner(&arg1.id),
            character_id    : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            owner           : 0x2::tx_context::sender(arg7),
            provider        : arg2,
            claim_ref       : 0x1::string::utf8(arg3),
            settlement_hash : arg4,
            amount_micros   : arg5,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ProviderClaimSettled>(v0);
    }

    entry fun submit_provider_claim(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &PaymentPolicy, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_policy_matches(arg0, arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_ref(&arg3);
        assert_hash(&arg4);
        assert_amount(arg5);
        assert_provider(arg1, arg2);
        let v0 = ProviderClaimSubmitted{
            policy_id     : 0x2::object::uid_to_inner(&arg1.id),
            character_id  : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            provider      : arg2,
            claim_ref     : 0x1::string::utf8(arg3),
            claim_hash    : arg4,
            amount_micros : arg5,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ProviderClaimSubmitted>(v0);
    }

    entry fun update_payment_policy(arg0: &0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter, arg1: &mut PaymentPolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: bool, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg9));
        assert_unlocked(arg1);
        0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::assert_not_paused(arg0);
        assert_policy_args(&arg2, &arg3, arg4, arg5);
        arg1.policy_uri = 0x1::string::utf8(arg2);
        arg1.policy_hash = arg3;
        arg1.per_call_cap_micros = arg4;
        arg1.daily_cap_micros = arg5;
        arg1.provider_bound = arg6;
        arg1.provider = arg7;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg8);
        let v0 = PaymentPolicyUpdated{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0xf86c05b3f322396d32323319e24b90d17541833059e5ad879aba70431eff7738::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg9),
            policy_uri   : arg1.policy_uri,
            nonce        : arg1.nonce,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<PaymentPolicyUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

