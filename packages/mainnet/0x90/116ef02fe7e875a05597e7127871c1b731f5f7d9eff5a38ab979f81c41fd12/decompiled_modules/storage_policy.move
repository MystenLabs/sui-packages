module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::storage_policy {
    struct StoragePolicy has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        policy_hash: vector<u8>,
        renewal_threshold_ms: u64,
        min_renewal_epochs: u64,
        max_renewal_payment_micros: u64,
        locked: bool,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct StorageBlobRecord has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        blob_ref: 0x1::string::String,
        blob_hash: vector<u8>,
        expires_at_ms: u64,
        retention_epochs: u64,
        encrypted: bool,
        last_renewal_receipt_hash: vector<u8>,
        used_renewal_receipts: 0x2::table::Table<vector<u8>, bool>,
        nonce: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct StoragePolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        policy_uri: 0x1::string::String,
        renewal_threshold_ms: u64,
        min_renewal_epochs: u64,
        max_renewal_payment_micros: u64,
        timestamp_ms: u64,
    }

    struct StoragePolicyLocked has copy, drop {
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        locked: bool,
        reason_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct StorageBlobRecorded has copy, drop {
        record_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        blob_ref: 0x1::string::String,
        blob_hash: vector<u8>,
        expires_at_ms: u64,
        retention_epochs: u64,
        encrypted: bool,
        timestamp_ms: u64,
    }

    struct StorageRenewalIntentRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        blob_ref: 0x1::string::String,
        previous_expiry_ms: u64,
        target_expiry_ms: u64,
        renewal_epochs: u64,
        amount_micros: u64,
        intent_hash: vector<u8>,
        walrus_tx_digest: vector<u8>,
        policy_nonce: u64,
        record_nonce: u64,
        timestamp_ms: u64,
    }

    fun assert_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address) {
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_owner(arg0, arg1);
    }

    fun apply_renewal(arg0: &mut StoragePolicy, arg1: &mut StorageBlobRecord, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        arg1.expires_at_ms = arg2;
        arg1.retention_epochs = arg3;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg7);
        arg0.nonce = arg0.nonce + 1;
        arg0.updated_at_ms = arg1.updated_at_ms;
        let v0 = StorageRenewalIntentRecorded{
            policy_id          : 0x2::object::uid_to_inner(&arg0.id),
            record_id          : 0x2::object::uid_to_inner(&arg1.id),
            character_id       : arg1.character_id,
            owner              : arg1.owner,
            blob_ref           : arg1.blob_ref,
            previous_expiry_ms : arg1.expires_at_ms,
            target_expiry_ms   : arg2,
            renewal_epochs     : arg3,
            amount_micros      : arg4,
            intent_hash        : arg5,
            walrus_tx_digest   : arg6,
            policy_nonce       : arg0.nonce,
            record_nonce       : arg1.nonce,
            timestamp_ms       : arg1.updated_at_ms,
        };
        0x2::event::emit<StorageRenewalIntentRecorded>(v0);
    }

    fun assert_amount(arg0: u64) {
        assert!(arg0 > 0, 509);
    }

    fun assert_blob_args(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u64) {
        assert_ref(arg0);
        assert_hash(arg1);
        assert!(arg2 > 0, 511);
        assert!(arg3 > 0, 508);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 503);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 505);
    }

    fun assert_hash_or_empty(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) <= 128, 505);
    }

    fun assert_policy_args(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: u64) {
        assert_uri(arg0);
        assert_hash(arg1);
        assert!(arg2 > 0, 507);
        assert!(arg3 > 0, 508);
        assert_amount(arg4);
    }

    fun assert_policy_matches(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &StoragePolicy) {
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 501);
    }

    fun assert_policy_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &StoragePolicy, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 500);
        assert_policy_matches(arg0, arg1);
    }

    fun assert_record_matches(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &StoragePolicy, arg2: &StorageBlobRecord) {
        assert_policy_matches(arg0, arg1);
        assert!(arg2.policy_id == 0x2::object::uid_to_inner(&arg1.id), 502);
        assert!(arg2.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 501);
        assert!(arg2.owner == arg1.owner, 500);
    }

    fun assert_record_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &StoragePolicy, arg2: &StorageBlobRecord, arg3: address) {
        assert_policy_owner(arg0, arg1, arg3);
        assert!(arg2.owner == arg3, 500);
        assert!(arg2.policy_id == 0x2::object::uid_to_inner(&arg1.id), 502);
        assert!(arg2.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 501);
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 503);
        assert!(0x1::vector::length<u8>(arg0) <= 512, 504);
    }

    fun assert_renewal_args(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &vector<u8>) {
        assert!(!arg0, 506);
        assert_hash(arg7);
        assert_amount(arg6);
        assert!(arg6 <= arg1, 510);
        assert!(arg5 >= arg2, 508);
        assert!(arg4 > arg3, 511);
    }

    fun assert_uri(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 503);
        assert!(0x1::vector::length<u8>(arg0) <= 2048, 504);
    }

    entry fun create_storage_policy(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, 0x2::tx_context::sender(arg7));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_policy_args(&arg1, &arg2, arg3, arg4, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = StoragePolicy{
            id                         : 0x2::object::new(arg7),
            character_id               : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                      : 0x2::tx_context::sender(arg7),
            policy_uri                 : 0x1::string::utf8(arg1),
            policy_hash                : arg2,
            renewal_threshold_ms       : arg3,
            min_renewal_epochs         : arg4,
            max_renewal_payment_micros : arg5,
            locked                     : false,
            nonce                      : 0,
            created_at_ms              : v0,
            updated_at_ms              : v0,
        };
        let v2 = StoragePolicyCreated{
            policy_id                  : 0x2::object::uid_to_inner(&v1.id),
            character_id               : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                      : 0x2::tx_context::sender(arg7),
            policy_uri                 : v1.policy_uri,
            renewal_threshold_ms       : arg3,
            min_renewal_epochs         : arg4,
            max_renewal_payment_micros : arg5,
            timestamp_ms               : v0,
        };
        0x2::event::emit<StoragePolicyCreated>(v2);
        0x2::transfer::share_object<StoragePolicy>(v1);
    }

    entry fun record_blob(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &StoragePolicy, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg8));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_blob_args(&arg2, &arg3, arg4, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = StorageBlobRecord{
            id                        : 0x2::object::new(arg8),
            policy_id                 : 0x2::object::uid_to_inner(&arg1.id),
            character_id              : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner                     : 0x2::tx_context::sender(arg8),
            blob_ref                  : 0x1::string::utf8(arg2),
            blob_hash                 : arg3,
            expires_at_ms             : arg4,
            retention_epochs          : arg5,
            encrypted                 : arg6,
            last_renewal_receipt_hash : b"",
            used_renewal_receipts     : 0x2::table::new<vector<u8>, bool>(arg8),
            nonce                     : 0,
            created_at_ms             : v0,
            updated_at_ms             : v0,
        };
        let v2 = StorageBlobRecorded{
            record_id        : 0x2::object::uid_to_inner(&v1.id),
            policy_id        : 0x2::object::uid_to_inner(&arg1.id),
            character_id     : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner            : 0x2::tx_context::sender(arg8),
            blob_ref         : v1.blob_ref,
            blob_hash        : v1.blob_hash,
            expires_at_ms    : arg4,
            retention_epochs : arg5,
            encrypted        : arg6,
            timestamp_ms     : v0,
        };
        0x2::event::emit<StorageBlobRecorded>(v2);
        0x2::transfer::share_object<StorageBlobRecord>(v1);
    }

    public(friend) fun record_paid_renewal_from_endowment(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut StoragePolicy, arg2: &mut StorageBlobRecord, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        assert_record_matches(arg0, arg1, arg2);
        assert_renewal_args(arg1.locked, arg1.max_renewal_payment_micros, arg1.min_renewal_epochs, arg2.expires_at_ms, arg3, arg4, arg5, &arg6);
        assert_hash(&arg7);
        assert!(arg2.last_renewal_receipt_hash != arg6, 512);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg2.used_renewal_receipts, arg6), 512);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        arg2.last_renewal_receipt_hash = arg6;
        0x2::table::add<vector<u8>, bool>(&mut arg2.used_renewal_receipts, arg6, true);
        apply_renewal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun record_renewal_intent(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut StoragePolicy, arg2: &mut StorageBlobRecord, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert_record_owner(arg0, arg1, arg2, 0x2::tx_context::sender(arg9));
        assert_renewal_args(arg1.locked, arg1.max_renewal_payment_micros, arg1.min_renewal_epochs, arg2.expires_at_ms, arg3, arg4, arg5, &arg6);
        assert_hash(&arg7);
        assert!(arg2.last_renewal_receipt_hash != arg6, 512);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg2.used_renewal_receipts, arg6), 512);
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        arg2.last_renewal_receipt_hash = arg6;
        0x2::table::add<vector<u8>, bool>(&mut arg2.used_renewal_receipts, arg6, true);
        apply_renewal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun set_storage_policy_lock(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut StoragePolicy, arg2: bool, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_policy_owner(arg0, arg1, 0x2::tx_context::sender(arg5));
        assert_hash_or_empty(&arg3);
        arg1.locked = arg2;
        arg1.nonce = arg1.nonce + 1;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = StoragePolicyLocked{
            policy_id    : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg5),
            locked       : arg2,
            reason_hash  : arg3,
            timestamp_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<StoragePolicyLocked>(v0);
    }

    public fun storage_blob_record_expiry(arg0: &StorageBlobRecord) : u64 {
        arg0.expires_at_ms
    }

    public fun storage_blob_record_id(arg0: &StorageBlobRecord) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun storage_blob_record_nonce(arg0: &StorageBlobRecord) : u64 {
        arg0.nonce
    }

    public fun storage_policy_character_id(arg0: &StoragePolicy) : 0x2::object::ID {
        arg0.character_id
    }

    public fun storage_policy_id(arg0: &StoragePolicy) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun storage_policy_locked(arg0: &StoragePolicy) : bool {
        arg0.locked
    }

    public fun storage_policy_nonce(arg0: &StoragePolicy) : u64 {
        arg0.nonce
    }

    public fun storage_policy_owner(arg0: &StoragePolicy) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

