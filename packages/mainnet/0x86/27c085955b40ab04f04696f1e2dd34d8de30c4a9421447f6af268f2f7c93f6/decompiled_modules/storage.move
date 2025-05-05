module 0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::storage {
    struct StreamSnapshot has store, key {
        id: 0x2::object::UID,
        stream_id: 0x2::object::ID,
        data: vector<u8>,
        timestamp: u64,
        version: u64,
        metadata: 0x1::string::String,
        creator: address,
    }

    struct SnapshotCreated has copy, drop {
        stream_id: 0x2::object::ID,
        snapshot_id: 0x2::object::ID,
        timestamp: u64,
        version: u64,
        creator: address,
    }

    public fun create_snapshot(arg0: &0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream::DataStream, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : StreamSnapshot {
        let v0 = 0x2::object::id<0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream::DataStream>(arg0);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream::get_version(arg0);
        let v3 = 0x2::tx_context::sender(arg2);
        let v4 = StreamSnapshot{
            id        : 0x2::object::new(arg2),
            stream_id : v0,
            data      : *0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream::get_stream_data(arg0),
            timestamp : v1,
            version   : v2,
            metadata  : arg1,
            creator   : v3,
        };
        let v5 = SnapshotCreated{
            stream_id   : v0,
            snapshot_id : 0x2::object::id<StreamSnapshot>(&v4),
            timestamp   : v1,
            version     : v2,
            creator     : v3,
        };
        0x2::event::emit<SnapshotCreated>(v5);
        v4
    }

    public fun get_snapshot_creator(arg0: &StreamSnapshot) : address {
        arg0.creator
    }

    public fun get_snapshot_data(arg0: &StreamSnapshot) : &vector<u8> {
        &arg0.data
    }

    public fun get_snapshot_metadata(arg0: &StreamSnapshot) : &0x1::string::String {
        &arg0.metadata
    }

    public fun get_snapshot_stream_id(arg0: &StreamSnapshot) : 0x2::object::ID {
        arg0.stream_id
    }

    public fun get_snapshot_timestamp(arg0: &StreamSnapshot) : u64 {
        arg0.timestamp
    }

    public fun get_snapshot_version(arg0: &StreamSnapshot) : u64 {
        arg0.version
    }

    public fun transfer_snapshot(arg0: StreamSnapshot, arg1: address) {
        0x2::transfer::transfer<StreamSnapshot>(arg0, arg1);
    }

    public fun update_snapshot(arg0: &mut StreamSnapshot, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.data = arg1;
        arg0.timestamp = 0x2::tx_context::epoch(arg2);
        arg0.version = arg0.version + 1;
    }

    public fun update_snapshot_metadata(arg0: &mut StreamSnapshot, arg1: 0x1::string::String) {
        arg0.metadata = arg1;
    }

    public fun verify_snapshot_stream(arg0: &StreamSnapshot, arg1: &0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream::DataStream) : bool {
        arg0.stream_id == 0x2::object::id<0x8627c085955b40ab04f04696f1e2dd34d8de30c4a9421447f6af268f2f7c93f6::data_stream::DataStream>(arg1)
    }

    // decompiled from Move bytecode v6
}

