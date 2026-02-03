module 0xbc733a80f277ad54760d01c18291d145afe6089a9351018ee506fe0ff008a483::walrus_storage {
    struct WalrusReference has copy, drop, store {
        blob_id: vector<u8>,
        size: u64,
        content_type: vector<u8>,
        content_hash: vector<u8>,
        is_encrypted: bool,
        uploaded_at: u64,
        storage_epoch: u64,
    }

    struct EmbeddingReference has copy, drop, store {
        blob_id: vector<u8>,
        dimension: u32,
        model: vector<u8>,
        lsh_buckets: vector<u64>,
        embedding_hash: u256,
    }

    struct EmbeddingBatch has copy, drop, store {
        blob_id: vector<u8>,
        count: u64,
        start_index: u64,
        dimension: u32,
        model: vector<u8>,
    }

    struct BlobReferenceCreated has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: vector<u8>,
        content_type: vector<u8>,
        size: u64,
        is_encrypted: bool,
    }

    struct EmbeddingIndexed has copy, drop {
        vault_id: 0x2::object::ID,
        embedding_hash: u256,
        blob_id: vector<u8>,
        dimension: u32,
        lsh_bucket_count: u64,
    }

    public fun batch_blob_id(arg0: &EmbeddingBatch) : vector<u8> {
        arg0.blob_id
    }

    public fun batch_count(arg0: &EmbeddingBatch) : u64 {
        arg0.count
    }

    public fun batch_dimension(arg0: &EmbeddingBatch) : u32 {
        arg0.dimension
    }

    public fun batch_model(arg0: &EmbeddingBatch) : vector<u8> {
        arg0.model
    }

    public fun batch_start_index(arg0: &EmbeddingBatch) : u64 {
        arg0.start_index
    }

    public fun compute_lsh_bucket(arg0: u256, arg1: u64) : u64 {
        ((arg0 % (arg1 as u256)) as u64)
    }

    public fun embedding_blob_id(arg0: &EmbeddingReference) : vector<u8> {
        arg0.blob_id
    }

    public fun embedding_dimension(arg0: &EmbeddingReference) : u32 {
        arg0.dimension
    }

    public fun embedding_hash(arg0: &EmbeddingReference) : u256 {
        arg0.embedding_hash
    }

    public fun embedding_lsh_buckets(arg0: &EmbeddingReference) : vector<u64> {
        arg0.lsh_buckets
    }

    public fun embedding_model(arg0: &EmbeddingReference) : vector<u8> {
        arg0.model
    }

    public fun emit_blob_reference_created(arg0: 0x2::object::ID, arg1: &WalrusReference) {
        let v0 = BlobReferenceCreated{
            vault_id     : arg0,
            blob_id      : arg1.blob_id,
            content_type : arg1.content_type,
            size         : arg1.size,
            is_encrypted : arg1.is_encrypted,
        };
        0x2::event::emit<BlobReferenceCreated>(v0);
    }

    public fun emit_embedding_indexed(arg0: 0x2::object::ID, arg1: &EmbeddingReference) {
        let v0 = EmbeddingIndexed{
            vault_id         : arg0,
            embedding_hash   : arg1.embedding_hash,
            blob_id          : arg1.blob_id,
            dimension        : arg1.dimension,
            lsh_bucket_count : 0x1::vector::length<u64>(&arg1.lsh_buckets),
        };
        0x2::event::emit<EmbeddingIndexed>(v0);
    }

    public fun new_embedding_batch(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u32, arg4: vector<u8>) : EmbeddingBatch {
        assert!(0x1::vector::length<u8>(&arg0) <= 64, 0);
        assert!(!0x1::vector::is_empty<u8>(&arg0), 0);
        EmbeddingBatch{
            blob_id     : arg0,
            count       : arg1,
            start_index : arg2,
            dimension   : arg3,
            model       : arg4,
        }
    }

    public fun new_embedding_reference(arg0: vector<u8>, arg1: u32, arg2: vector<u8>, arg3: vector<u64>, arg4: u256) : EmbeddingReference {
        assert!(0x1::vector::length<u8>(&arg0) <= 64, 0);
        assert!(!0x1::vector::is_empty<u8>(&arg0), 0);
        EmbeddingReference{
            blob_id        : arg0,
            dimension      : arg1,
            model          : arg2,
            lsh_buckets    : arg3,
            embedding_hash : arg4,
        }
    }

    public fun new_walrus_reference(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: u64, arg6: &0x2::tx_context::TxContext) : WalrusReference {
        assert!(0x1::vector::length<u8>(&arg0) <= 64, 0);
        assert!(!0x1::vector::is_empty<u8>(&arg0), 0);
        WalrusReference{
            blob_id       : arg0,
            size          : arg1,
            content_type  : arg2,
            content_hash  : arg3,
            is_encrypted  : arg4,
            uploaded_at   : 0x2::tx_context::epoch_timestamp_ms(arg6),
            storage_epoch : arg5,
        }
    }

    public fun shares_lsh_bucket(arg0: &EmbeddingReference, arg1: &EmbeddingReference) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.lsh_buckets)) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<u64>(&arg1.lsh_buckets)) {
                if (*0x1::vector::borrow<u64>(&arg0.lsh_buckets, v0) == *0x1::vector::borrow<u64>(&arg1.lsh_buckets, v1)) {
                    return true
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun walrus_blob_id(arg0: &WalrusReference) : vector<u8> {
        arg0.blob_id
    }

    public fun walrus_content_hash(arg0: &WalrusReference) : vector<u8> {
        arg0.content_hash
    }

    public fun walrus_content_type(arg0: &WalrusReference) : vector<u8> {
        arg0.content_type
    }

    public fun walrus_is_encrypted(arg0: &WalrusReference) : bool {
        arg0.is_encrypted
    }

    public fun walrus_size(arg0: &WalrusReference) : u64 {
        arg0.size
    }

    public fun walrus_storage_epoch(arg0: &WalrusReference) : u64 {
        arg0.storage_epoch
    }

    public fun walrus_uploaded_at(arg0: &WalrusReference) : u64 {
        arg0.uploaded_at
    }

    // decompiled from Move bytecode v6
}

