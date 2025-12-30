module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::datakey {
    struct DataKey has copy, drop, store {
        key_type: u8,
        address_1: address,
        address_2: address,
        bucket_id: u32,
    }

    struct EncryptionKey has store, key {
        id: 0x2::object::UID,
        owner: address,
        deal_id: 0x2::object::ID,
        encrypted_key: vector<u8>,
        public_key: vector<u8>,
        key_algorithm: vector<u8>,
        created_at: u64,
        expires_at: u64,
    }

    struct KeyRegistry has store, key {
        id: 0x2::object::UID,
        keys: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        total_keys: u64,
    }

    struct KeyStorageFee has store {
        base_fee_per_key: u64,
        fee_per_day: u64,
        discount_threshold: u64,
        discount_percentage: u64,
    }

    struct KeyCreated has copy, drop {
        key_id: 0x2::object::ID,
        deal_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct KeyRotated has copy, drop {
        key_id: 0x2::object::ID,
        old_key_hash: vector<u8>,
        new_key_hash: vector<u8>,
        timestamp: u64,
    }

    public fun calculate_storage_fee(arg0: u64, arg1: u64, arg2: &KeyStorageFee) : u64 {
        let v0 = arg2.base_fee_per_key + arg2.fee_per_day * arg0;
        if (arg1 >= arg2.discount_threshold) {
            v0 - v0 * arg2.discount_percentage / 100
        } else {
            v0
        }
    }

    public fun create_encryption_key(arg0: &mut KeyRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.keys, arg1), 402);
        let v2 = EncryptionKey{
            id            : 0x2::object::new(arg6),
            owner         : v0,
            deal_id       : arg1,
            encrypted_key : arg2,
            public_key    : arg3,
            key_algorithm : arg4,
            created_at    : v1,
            expires_at    : v1 + arg5 * 24 * 60 * 60 * 1000,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = KeyCreated{
            key_id    : v3,
            deal_id   : arg1,
            owner     : v0,
            timestamp : v1,
        };
        0x2::event::emit<KeyCreated>(v4);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.keys, arg1, v3);
        arg0.total_keys = arg0.total_keys + 1;
        0x2::transfer::share_object<EncryptionKey>(v2);
    }

    public fun get_address_1(arg0: &DataKey) : address {
        arg0.address_1
    }

    public fun get_address_2(arg0: &DataKey) : address {
        arg0.address_2
    }

    public fun get_bucket_id(arg0: &DataKey) : u32 {
        arg0.bucket_id
    }

    public fun get_encrypted_key(arg0: &EncryptionKey) : vector<u8> {
        arg0.encrypted_key
    }

    public fun get_key_type(arg0: &DataKey) : u8 {
        arg0.key_type
    }

    public fun get_public_key(arg0: &EncryptionKey) : vector<u8> {
        arg0.public_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KeyRegistry{
            id         : 0x2::object::new(arg0),
            keys       : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            total_keys : 0,
        };
        0x2::transfer::share_object<KeyRegistry>(v0);
    }

    public fun is_expired(arg0: &EncryptionKey, arg1: u64) : bool {
        arg1 >= arg0.expires_at
    }

    public fun new_active_deal_map_key() : DataKey {
        DataKey{
            key_type  : 14,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_bucket_count_key() : DataKey {
        DataKey{
            key_type  : 9,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_bucket_key(arg0: address, arg1: u32) : DataKey {
        DataKey{
            key_type  : 8,
            address_1 : arg0,
            address_2 : @0x0,
            bucket_id : arg1,
        }
    }

    public fun new_bucket_map_key() : DataKey {
        DataKey{
            key_type  : 10,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_consumer_count_key() : DataKey {
        DataKey{
            key_type  : 6,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_consumer_key(arg0: address) : DataKey {
        DataKey{
            key_type  : 5,
            address_1 : arg0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_consumer_map_key() : DataKey {
        DataKey{
            key_type  : 7,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_deal_count_key() : DataKey {
        DataKey{
            key_type  : 12,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_deal_key(arg0: address, arg1: address, arg2: u32) : DataKey {
        DataKey{
            key_type  : 11,
            address_1 : arg0,
            address_2 : arg1,
            bucket_id : arg2,
        }
    }

    public fun new_deal_map_key() : DataKey {
        DataKey{
            key_type  : 13,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_owner_key() : DataKey {
        DataKey{
            key_type  : 0,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_provider_count_key() : DataKey {
        DataKey{
            key_type  : 3,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_provider_key(arg0: address) : DataKey {
        DataKey{
            key_type  : 2,
            address_1 : arg0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_provider_map_key() : DataKey {
        DataKey{
            key_type  : 4,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun new_stable_asset_key() : DataKey {
        DataKey{
            key_type  : 1,
            address_1 : @0x0,
            address_2 : @0x0,
            bucket_id : 0,
        }
    }

    public fun rotate_encryption_key(arg0: &mut EncryptionKey, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 401);
        arg0.encrypted_key = arg1;
        arg0.public_key = arg2;
        let v0 = KeyRotated{
            key_id       : 0x2::object::uid_to_inner(&arg0.id),
            old_key_hash : arg0.encrypted_key,
            new_key_hash : arg1,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<KeyRotated>(v0);
    }

    // decompiled from Move bytecode v6
}

