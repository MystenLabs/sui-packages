module 0x72594561ebaba29860a4cefdc9d3fd576a5ad5c1078bd143f9d4c9bcadb2e4fe::collection_manager {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
        };
        0x2::transfer::transfer<Collection>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

