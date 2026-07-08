module 0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::lineage {
    struct CommitmentUpdate has copy, drop, store {
        sequence: u64,
        kind: u8,
        commitment_hash: vector<u8>,
        ref_uri: 0x1::string::String,
        authorized_by: address,
        timestamp_ms: u64,
    }

    struct Lineage has store, key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
        owner: address,
        updates: vector<CommitmentUpdate>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct MigrationPlan has copy, drop, store {
        source_package: 0x1::string::String,
        source_version: u64,
        target_package: 0x1::string::String,
        target_version: u64,
        source_character_id: 0x2::object::ID,
        target_character_ref: 0x1::string::String,
        migration_hash: vector<u8>,
    }

    struct MigrationRecord has store, key {
        id: 0x2::object::UID,
        lineage_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        plan: MigrationPlan,
        approved_by: address,
        timestamp_ms: u64,
    }

    struct LineageCreated has copy, drop {
        lineage_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct CommitmentAppended has copy, drop {
        lineage_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        owner: address,
        sequence: u64,
        kind: u8,
        commitment_hash: vector<u8>,
        ref_uri: 0x1::string::String,
        authorized_by: address,
        timestamp_ms: u64,
    }

    struct MigrationContinuityRecorded has copy, drop {
        migration_record_id: 0x2::object::ID,
        lineage_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
        source_package: 0x1::string::String,
        source_version: u64,
        target_package: 0x1::string::String,
        target_version: u64,
        source_character_id: 0x2::object::ID,
        target_character_ref: 0x1::string::String,
        migration_hash: vector<u8>,
        approved_by: address,
        timestamp_ms: u64,
    }

    entry fun append_commitment(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Lineage, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        append_owner_commitment(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun append_commitment_internal(arg0: &mut Lineage, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock) {
        assert_known_kind(arg1);
        assert_hash(&arg2);
        assert_ref_or_empty(&arg3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x1::vector::length<CommitmentUpdate>(&arg0.updates);
        let v2 = CommitmentUpdate{
            sequence        : v1,
            kind            : arg1,
            commitment_hash : arg2,
            ref_uri         : 0x1::string::utf8(arg3),
            authorized_by   : arg4,
            timestamp_ms    : v0,
        };
        0x1::vector::push_back<CommitmentUpdate>(&mut arg0.updates, v2);
        arg0.updated_at_ms = v0;
        let v3 = CommitmentAppended{
            lineage_id      : 0x2::object::uid_to_inner(&arg0.id),
            character_id    : arg0.character_id,
            owner           : arg0.owner,
            sequence        : v1,
            kind            : arg1,
            commitment_hash : v2.commitment_hash,
            ref_uri         : v2.ref_uri,
            authorized_by   : arg4,
            timestamp_ms    : v0,
        };
        0x2::event::emit<CommitmentAppended>(v3);
    }

    public fun append_owner_commitment(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Lineage, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_lineage_owner(arg0, arg1, 0x2::tx_context::sender(arg6));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        append_commitment_internal(arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg6), arg5);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 502);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 503);
    }

    fun assert_known_kind(arg0: u8) {
        let v0 = if (arg0 == 1) {
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
        } else if (arg0 == 7) {
            true
        } else {
            arg0 == 8
        };
        assert!(v0, 505);
    }

    fun assert_lineage_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &Lineage, arg2: address) {
        assert_owner(arg0, arg2);
        assert!(arg1.owner == arg2, 500);
        assert!(arg1.character_id == 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0), 501);
    }

    fun assert_owner(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: address) {
        assert!(0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::owner(arg0) == arg1, 500);
    }

    fun assert_ref(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 506);
        assert!(0x1::vector::length<u8>(arg0) <= 2048, 504);
    }

    fun assert_ref_or_empty(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) <= 2048, 504);
    }

    public fun commitment_kind(arg0: &CommitmentUpdate) : u8 {
        arg0.kind
    }

    public fun commitment_sequence(arg0: &CommitmentUpdate) : u64 {
        arg0.sequence
    }

    entry fun create_lineage(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_lineage(arg0, arg1, arg2);
        0x2::transfer::public_transfer<Lineage>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun kind_memory() : u8 {
        2
    }

    public fun kind_migration() : u8 {
        8
    }

    public fun kind_payment() : u8 {
        7
    }

    public fun kind_persona() : u8 {
        1
    }

    public fun kind_policy() : u8 {
        4
    }

    public fun kind_raw_data() : u8 {
        3
    }

    public fun kind_storage() : u8 {
        5
    }

    public fun kind_treasury() : u8 {
        6
    }

    public fun latest_commitment(arg0: &Lineage) : CommitmentUpdate {
        *0x1::vector::borrow<CommitmentUpdate>(&arg0.updates, 0x1::vector::length<CommitmentUpdate>(&arg0.updates) - 1)
    }

    public fun lineage_character_id(arg0: &Lineage) : 0x2::object::ID {
        arg0.character_id
    }

    public fun lineage_owner(arg0: &Lineage) : address {
        arg0.owner
    }

    public fun lineage_update_count(arg0: &Lineage) : u64 {
        0x1::vector::length<CommitmentUpdate>(&arg0.updates)
    }

    public fun lineage_updated_at_ms(arg0: &Lineage) : u64 {
        arg0.updated_at_ms
    }

    public fun migration_record_character_id(arg0: &MigrationRecord) : 0x2::object::ID {
        arg0.character_id
    }

    public fun migration_record_lineage_id(arg0: &MigrationRecord) : 0x2::object::ID {
        arg0.lineage_id
    }

    public fun migration_record_owner(arg0: &MigrationRecord) : address {
        arg0.owner
    }

    public fun new_lineage(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : Lineage {
        assert_owner(arg0, 0x2::tx_context::sender(arg2));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = Lineage{
            id            : 0x2::object::new(arg2),
            character_id  : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner         : 0x2::tx_context::sender(arg2),
            updates       : 0x1::vector::empty<CommitmentUpdate>(),
            created_at_ms : v0,
            updated_at_ms : v0,
        };
        let v2 = LineageCreated{
            lineage_id   : 0x2::object::uid_to_inner(&v1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : 0x2::tx_context::sender(arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<LineageCreated>(v2);
        v1
    }

    public fun new_migration_record(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Lineage, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : MigrationRecord {
        assert_lineage_owner(arg0, arg1, 0x2::tx_context::sender(arg9));
        0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::assert_not_paused(arg0);
        assert_ref(&arg2);
        assert_ref(&arg4);
        assert_ref(&arg6);
        assert_hash(&arg7);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        append_commitment_internal(arg1, 8, arg7, arg6, 0x2::tx_context::sender(arg9), arg8);
        let v1 = MigrationPlan{
            source_package       : 0x1::string::utf8(arg2),
            source_version       : arg3,
            target_package       : 0x1::string::utf8(arg4),
            target_version       : arg5,
            source_character_id  : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            target_character_ref : 0x1::string::utf8(arg6),
            migration_hash       : arg7,
        };
        let v2 = MigrationRecord{
            id           : 0x2::object::new(arg9),
            lineage_id   : 0x2::object::uid_to_inner(&arg1.id),
            character_id : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            owner        : arg1.owner,
            plan         : v1,
            approved_by  : 0x2::tx_context::sender(arg9),
            timestamp_ms : v0,
        };
        let v3 = MigrationContinuityRecorded{
            migration_record_id  : 0x2::object::uid_to_inner(&v2.id),
            lineage_id           : 0x2::object::uid_to_inner(&arg1.id),
            character_id         : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            source_package       : v2.plan.source_package,
            source_version       : arg3,
            target_package       : v2.plan.target_package,
            target_version       : arg5,
            source_character_id  : 0x2::object::id<0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter>(arg0),
            target_character_ref : v2.plan.target_character_ref,
            migration_hash       : arg7,
            approved_by          : 0x2::tx_context::sender(arg9),
            timestamp_ms         : v0,
        };
        0x2::event::emit<MigrationContinuityRecorded>(v3);
        v2
    }

    entry fun record_migration(arg0: &0x55d6fe64890a3feaeafc825c28032a9ff81a4891b35208333ded8abadea17d63::identity::LivingCharacter, arg1: &mut Lineage, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = new_migration_record(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<MigrationRecord>(v0, 0x2::tx_context::sender(arg9));
    }

    // decompiled from Move bytecode v7
}

