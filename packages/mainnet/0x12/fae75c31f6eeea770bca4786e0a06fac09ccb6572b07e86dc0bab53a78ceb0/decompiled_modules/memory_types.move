module 0x12fae75c31f6eeea770bca4786e0a06fac09ccb6572b07e86dc0bab53a78ceb0::memory_types {
    struct ShortTermKey has copy, drop, store {
        id: u64,
    }

    struct LongTermKey has copy, drop, store {
        key: vector<u8>,
    }

    struct EpisodicKey has copy, drop, store {
        id: u64,
    }

    struct SemanticIndexKey has copy, drop, store {
        hash: u256,
    }

    struct ShortTermMemory has copy, drop, store {
        id: u64,
        role: vector<u8>,
        content: vector<u8>,
        timestamp: u64,
        metadata: vector<u8>,
        is_encrypted: bool,
        seal_session_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LongTermMemory has copy, drop, store {
        key: vector<u8>,
        memory_type: u8,
        content: vector<u8>,
        confidence: u8,
        source: vector<u8>,
        created_at: u64,
        updated_at: u64,
        access_count: u64,
        tags: vector<vector<u8>>,
        is_encrypted: bool,
        seal_session_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct EpisodicMemory has copy, drop, store {
        episode_id: u64,
        walrus_blob_id: vector<u8>,
        summary: vector<u8>,
        topics: vector<vector<u8>>,
        turn_count: u64,
        started_at: u64,
        ended_at: u64,
        participants: vector<vector<u8>>,
        is_encrypted: bool,
        seal_session_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SemanticIndexEntry has copy, drop, store {
        embedding_hash: u256,
        walrus_embedding_id: vector<u8>,
        source_memory_key: vector<u8>,
        source_memory_type: u8,
        lsh_buckets: vector<u64>,
        dimension: u32,
        model: vector<u8>,
        indexed_at: u64,
    }

    public fun access_type_delete() : u8 {
        2
    }

    public fun access_type_read() : u8 {
        0
    }

    public fun access_type_write() : u8 {
        1
    }

    public fun episodic_ended_at(arg0: &EpisodicMemory) : u64 {
        arg0.ended_at
    }

    public fun episodic_episode_id(arg0: &EpisodicMemory) : u64 {
        arg0.episode_id
    }

    public fun episodic_is_encrypted(arg0: &EpisodicMemory) : bool {
        arg0.is_encrypted
    }

    public fun episodic_participants(arg0: &EpisodicMemory) : vector<vector<u8>> {
        arg0.participants
    }

    public fun episodic_seal_session_id(arg0: &EpisodicMemory) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_session_id
    }

    public fun episodic_started_at(arg0: &EpisodicMemory) : u64 {
        arg0.started_at
    }

    public fun episodic_summary(arg0: &EpisodicMemory) : vector<u8> {
        arg0.summary
    }

    public fun episodic_topics(arg0: &EpisodicMemory) : vector<vector<u8>> {
        arg0.topics
    }

    public fun episodic_turn_count(arg0: &EpisodicMemory) : u64 {
        arg0.turn_count
    }

    public fun episodic_walrus_blob_id(arg0: &EpisodicMemory) : vector<u8> {
        arg0.walrus_blob_id
    }

    public fun increment_access_count(arg0: &mut LongTermMemory) {
        arg0.access_count = arg0.access_count + 1;
    }

    public fun long_term_access_count(arg0: &LongTermMemory) : u64 {
        arg0.access_count
    }

    public fun long_term_confidence(arg0: &LongTermMemory) : u8 {
        arg0.confidence
    }

    public fun long_term_content(arg0: &LongTermMemory) : vector<u8> {
        arg0.content
    }

    public fun long_term_created_at(arg0: &LongTermMemory) : u64 {
        arg0.created_at
    }

    public fun long_term_is_encrypted(arg0: &LongTermMemory) : bool {
        arg0.is_encrypted
    }

    public fun long_term_key(arg0: &LongTermMemory) : vector<u8> {
        arg0.key
    }

    public fun long_term_memory_type(arg0: &LongTermMemory) : u8 {
        arg0.memory_type
    }

    public fun long_term_seal_session_id(arg0: &LongTermMemory) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_session_id
    }

    public fun long_term_source(arg0: &LongTermMemory) : vector<u8> {
        arg0.source
    }

    public fun long_term_tags(arg0: &LongTermMemory) : vector<vector<u8>> {
        arg0.tags
    }

    public fun long_term_type_behavior() : u8 {
        2
    }

    public fun long_term_type_fact() : u8 {
        0
    }

    public fun long_term_type_preference() : u8 {
        1
    }

    public fun long_term_type_relationship() : u8 {
        3
    }

    public fun long_term_updated_at(arg0: &LongTermMemory) : u64 {
        arg0.updated_at
    }

    public fun memory_type_episodic() : u8 {
        2
    }

    public fun memory_type_long_term() : u8 {
        1
    }

    public fun memory_type_semantic() : u8 {
        3
    }

    public fun memory_type_short_term() : u8 {
        0
    }

    public fun new_episodic_key(arg0: u64) : EpisodicKey {
        EpisodicKey{id: arg0}
    }

    public fun new_episodic_memory(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<vector<u8>>, arg8: bool, arg9: 0x1::option::Option<0x2::object::ID>) : EpisodicMemory {
        EpisodicMemory{
            episode_id      : arg0,
            walrus_blob_id  : arg1,
            summary         : arg2,
            topics          : arg3,
            turn_count      : arg4,
            started_at      : arg5,
            ended_at        : arg6,
            participants    : arg7,
            is_encrypted    : arg8,
            seal_session_id : arg9,
        }
    }

    public fun new_long_term_key(arg0: vector<u8>) : LongTermKey {
        LongTermKey{key: arg0}
    }

    public fun new_long_term_memory(arg0: vector<u8>, arg1: u8, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: vector<vector<u8>>, arg7: bool, arg8: 0x1::option::Option<0x2::object::ID>) : LongTermMemory {
        LongTermMemory{
            key             : arg0,
            memory_type     : arg1,
            content         : arg2,
            confidence      : arg3,
            source          : arg4,
            created_at      : arg5,
            updated_at      : arg5,
            access_count    : 0,
            tags            : arg6,
            is_encrypted    : arg7,
            seal_session_id : arg8,
        }
    }

    public fun new_semantic_index_entry(arg0: u256, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: vector<u64>, arg5: u32, arg6: vector<u8>, arg7: u64) : SemanticIndexEntry {
        SemanticIndexEntry{
            embedding_hash      : arg0,
            walrus_embedding_id : arg1,
            source_memory_key   : arg2,
            source_memory_type  : arg3,
            lsh_buckets         : arg4,
            dimension           : arg5,
            model               : arg6,
            indexed_at          : arg7,
        }
    }

    public fun new_semantic_index_key(arg0: u256) : SemanticIndexKey {
        SemanticIndexKey{hash: arg0}
    }

    public fun new_short_term_key(arg0: u64) : ShortTermKey {
        ShortTermKey{id: arg0}
    }

    public fun new_short_term_memory(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: bool, arg6: 0x1::option::Option<0x2::object::ID>) : ShortTermMemory {
        ShortTermMemory{
            id              : arg0,
            role            : arg1,
            content         : arg2,
            timestamp       : arg3,
            metadata        : arg4,
            is_encrypted    : arg5,
            seal_session_id : arg6,
        }
    }

    public fun semantic_dimension(arg0: &SemanticIndexEntry) : u32 {
        arg0.dimension
    }

    public fun semantic_embedding_hash(arg0: &SemanticIndexEntry) : u256 {
        arg0.embedding_hash
    }

    public fun semantic_indexed_at(arg0: &SemanticIndexEntry) : u64 {
        arg0.indexed_at
    }

    public fun semantic_lsh_buckets(arg0: &SemanticIndexEntry) : vector<u64> {
        arg0.lsh_buckets
    }

    public fun semantic_model(arg0: &SemanticIndexEntry) : vector<u8> {
        arg0.model
    }

    public fun semantic_source_memory_key(arg0: &SemanticIndexEntry) : vector<u8> {
        arg0.source_memory_key
    }

    public fun semantic_source_memory_type(arg0: &SemanticIndexEntry) : u8 {
        arg0.source_memory_type
    }

    public fun semantic_walrus_embedding_id(arg0: &SemanticIndexEntry) : vector<u8> {
        arg0.walrus_embedding_id
    }

    public fun short_term_content(arg0: &ShortTermMemory) : vector<u8> {
        arg0.content
    }

    public fun short_term_id(arg0: &ShortTermMemory) : u64 {
        arg0.id
    }

    public fun short_term_is_encrypted(arg0: &ShortTermMemory) : bool {
        arg0.is_encrypted
    }

    public fun short_term_metadata(arg0: &ShortTermMemory) : vector<u8> {
        arg0.metadata
    }

    public fun short_term_role(arg0: &ShortTermMemory) : vector<u8> {
        arg0.role
    }

    public fun short_term_seal_session_id(arg0: &ShortTermMemory) : 0x1::option::Option<0x2::object::ID> {
        arg0.seal_session_id
    }

    public fun short_term_timestamp(arg0: &ShortTermMemory) : u64 {
        arg0.timestamp
    }

    public fun update_long_term_confidence(arg0: &mut LongTermMemory, arg1: u8) {
        arg0.confidence = arg1;
    }

    public fun update_long_term_content(arg0: &mut LongTermMemory, arg1: vector<u8>, arg2: u64) {
        arg0.content = arg1;
        arg0.updated_at = arg2;
    }

    // decompiled from Move bytecode v6
}

