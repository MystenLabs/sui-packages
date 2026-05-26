module 0x160d4503e2377bfdca735aa757fe5df0d62817de010d1b34b901fa0f3ea7d6ec::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        media_type: 0x1::string::String,
        created_at: u64,
        file_hash: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        image_blob_id: 0x1::string::String,
        media_type: 0x1::string::String,
        file_hash: 0x1::string::String,
        created_at: u64,
    }

    public fun id(arg0: &NFT) : 0x2::object::ID {
        0x2::object::id<NFT>(arg0)
    }

    public fun created_at(arg0: &NFT) : u64 {
        arg0.created_at
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun file_hash(arg0: &NFT) : &0x1::string::String {
        &arg0.file_hash
    }

    public fun image_blob_id(arg0: &NFT) : &0x1::string::String {
        &arg0.image_blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_once(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun media_type(arg0: &NFT) : &0x1::string::String {
        &arg0.media_type
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = NFT{
            id            : 0x2::object::new(arg6),
            name          : 0x1::string::utf8(arg0),
            description   : 0x1::string::utf8(arg1),
            image_blob_id : 0x1::string::utf8(arg2),
            media_type    : 0x1::string::utf8(arg3),
            created_at    : v0,
            file_hash     : 0x1::string::utf8(arg4),
        };
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = Minted{
            object_id     : 0x2::object::id<NFT>(&v1),
            owner         : v2,
            image_blob_id : v1.image_blob_id,
            media_type    : v1.media_type,
            file_hash     : v1.file_hash,
            created_at    : v0,
        };
        0x2::event::emit<Minted>(v3);
        0x2::transfer::transfer<NFT>(v1, v2);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v7
}

