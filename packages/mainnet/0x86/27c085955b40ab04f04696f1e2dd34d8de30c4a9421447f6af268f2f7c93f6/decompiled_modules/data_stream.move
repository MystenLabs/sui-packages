module 0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream {
    struct DataStream has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
        subscribers: vector<address>,
        last_updated: u64,
        data: vector<u8>,
        is_public: bool,
        parent_streams: vector<0x2::object::ID>,
        permissions: vector<Permission>,
        metadata: vector<u8>,
        walrus_id: 0x1::option::Option<0x1::string::String>,
        version: u64,
        tags: vector<0x1::string::String>,
        schema: 0x1::option::Option<0x1::string::String>,
        last_snapshot_version: u64,
        last_snapshot_timestamp: u64,
    }

    struct Permission has copy, drop, store {
        address: address,
        level: u8,
    }

    struct DataStreamCreated has copy, drop {
        stream_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
    }

    struct DataStreamUpdated has copy, drop {
        stream_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct SubscriberAdded has copy, drop {
        stream_id: 0x2::object::ID,
        subscriber: address,
    }

    struct StreamsComposed has copy, drop {
        parent_stream_id: 0x2::object::ID,
        child_stream_id: 0x2::object::ID,
    }

    public fun add_permission(arg0: &mut DataStream, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg3), 2), 4);
        let v0 = Permission{
            address : arg1,
            level   : arg2,
        };
        0x1::vector::push_back<Permission>(&mut arg0.permissions, v0);
    }

    public fun add_tag(arg0: &mut DataStream, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 1), 7);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.tags, arg1);
    }

    public fun compose_streams(arg0: &mut DataStream, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 2), 3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.parent_streams, arg1);
        let v0 = StreamsComposed{
            parent_stream_id : 0x2::object::uid_to_inner(&arg0.id),
            child_stream_id  : arg1,
        };
        0x2::event::emit<StreamsComposed>(v0);
    }

    public fun create_data_stream(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: bool, arg3: vector<u8>, arg4: 0x1::option::Option<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) : DataStream {
        let v0 = DataStream{
            id                      : 0x2::object::new(arg6),
            name                    : arg0,
            description             : arg1,
            owner                   : 0x2::tx_context::sender(arg6),
            subscribers             : 0x1::vector::empty<address>(),
            last_updated            : 0,
            data                    : 0x1::vector::empty<u8>(),
            is_public               : arg2,
            parent_streams          : 0x1::vector::empty<0x2::object::ID>(),
            permissions             : 0x1::vector::empty<Permission>(),
            metadata                : arg3,
            walrus_id               : 0x1::option::none<0x1::string::String>(),
            version                 : 0,
            tags                    : arg5,
            schema                  : arg4,
            last_snapshot_version   : 0,
            last_snapshot_timestamp : 0,
        };
        let v1 = Permission{
            address : 0x2::tx_context::sender(arg6),
            level   : 2,
        };
        0x1::vector::push_back<Permission>(&mut v0.permissions, v1);
        let v2 = DataStreamCreated{
            stream_id : 0x2::object::uid_to_inner(&v0.id),
            name      : arg0,
            owner     : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<DataStreamCreated>(v2);
        v0
    }

    public fun get_id(arg0: &DataStream) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_last_snapshot_timestamp(arg0: &DataStream) : u64 {
        arg0.last_snapshot_timestamp
    }

    public fun get_last_snapshot_version(arg0: &DataStream) : u64 {
        arg0.last_snapshot_version
    }

    public fun get_parent_streams(arg0: &DataStream) : &vector<0x2::object::ID> {
        &arg0.parent_streams
    }

    public fun get_schema(arg0: &DataStream) : &0x1::option::Option<0x1::string::String> {
        &arg0.schema
    }

    public fun get_stream_data(arg0: &DataStream) : &vector<u8> {
        &arg0.data
    }

    public fun get_tags(arg0: &DataStream) : &vector<0x1::string::String> {
        &arg0.tags
    }

    public fun get_version(arg0: &DataStream) : u64 {
        arg0.version
    }

    fun has_permission(arg0: &DataStream, arg1: address, arg2: u8) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<Permission>(&arg0.permissions)) {
            let v1 = 0x1::vector::borrow<Permission>(&arg0.permissions, v0);
            if (v1.address == arg1 && v1.level >= arg2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_subscribed(arg0: &DataStream, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.subscribers, &arg1)
    }

    public fun remove_tag(arg0: &mut DataStream, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 1), 8);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.tags)) {
            if (*0x1::vector::borrow<0x1::string::String>(&arg0.tags, v0) == arg1) {
                0x1::vector::remove<0x1::string::String>(&mut arg0.tags, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public fun set_walrus_id(arg0: &mut DataStream, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 2), 6);
        arg0.walrus_id = 0x1::option::some<0x1::string::String>(arg1);
    }

    public fun subscribe_to_stream(arg0: &mut DataStream, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.is_public || has_permission(arg0, v0, 0), 1);
        assert!(!0x1::vector::contains<address>(&arg0.subscribers, &v0), 2);
        0x1::vector::push_back<address>(&mut arg0.subscribers, v0);
        let v1 = SubscriberAdded{
            stream_id  : 0x2::object::uid_to_inner(&arg0.id),
            subscriber : v0,
        };
        0x2::event::emit<SubscriberAdded>(v1);
    }

    public fun transfer_ownership(arg0: &mut DataStream, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 2), 5);
        arg0.owner = arg1;
    }

    public fun transfer_stream(arg0: DataStream, arg1: address) {
        0x2::transfer::transfer<DataStream>(arg0, arg1);
    }

    public fun update_data_stream(arg0: &mut DataStream, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 1), 0);
        arg0.data = arg1;
        arg0.last_updated = 0x2::tx_context::epoch(arg2);
        arg0.version = arg0.version + 1;
        let v0 = DataStreamUpdated{
            stream_id : 0x2::object::uid_to_inner(&arg0.id),
            timestamp : arg0.last_updated,
        };
        0x2::event::emit<DataStreamUpdated>(v0);
    }

    public fun update_last_snapshot_info(arg0: &mut DataStream, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg3), 1), 9);
        arg0.last_snapshot_version = arg1;
        arg0.last_snapshot_timestamp = arg2;
    }

    public fun update_schema(arg0: &mut DataStream, arg1: 0x1::option::Option<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 2), 6);
        arg0.schema = arg1;
    }

    // decompiled from Move bytecode v6
}

