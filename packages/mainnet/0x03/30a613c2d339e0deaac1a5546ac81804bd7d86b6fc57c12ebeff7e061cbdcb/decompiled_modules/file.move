module 0x330a613c2d339e0deaac1a5546ac81804bd7d86b6fc57c12ebeff7e061cbdcb::file {
    struct File has store, key {
        id: 0x2::object::UID,
        name: 0x1::option::Option<0x1::string::String>,
        encoding: 0x1::string::String,
        mime_type: 0x1::string::String,
        extension: 0x1::string::String,
        size: u64,
        created_at_ts: u64,
        hash: 0x1::string::String,
        config: FileConfig,
        chunks: 0x2::vec_map::VecMap<0x1::string::String, 0x1::option::Option<0x2::object::ID>>,
    }

    struct FileConfig has drop, store {
        chunk_size: u8,
        sublist_size: u16,
        compression_algorithm: 0x1::option::Option<0x1::string::String>,
        compression_level: 0x1::option::Option<u8>,
    }

    public(friend) fun file_address(arg0: &File) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun file_id(arg0: &File) : 0x2::object::ID {
        0x2::object::id<File>(arg0)
    }

    // decompiled from Move bytecode v6
}

