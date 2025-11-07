module 0x17a0da1c9a0e94ed325fbf8ab7c5fd42e8aa4ef029bde8d7de01499e7f3adcd0::nft {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct MyNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        collection_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun create_collection(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            url         : arg2,
        }
    }

    public entry fun create_collection_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_collection(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<Collection>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_collection_id(arg0: &MyNFT) : 0x1::option::Option<0x2::object::ID> {
        arg0.collection_id
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : MyNFT {
        MyNFT{
            id            : 0x2::object::new(arg3),
            name          : arg0,
            description   : arg1,
            url           : arg2,
            collection_id : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun mint_to_collection(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : MyNFT {
        MyNFT{
            id            : 0x2::object::new(arg4),
            name          : arg1,
            description   : arg2,
            url           : arg3,
            collection_id : 0x1::option::some<0x2::object::ID>(arg0),
        }
    }

    public entry fun mint_to_collection_and_transfer(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_to_collection(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<MyNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun remove_collection(arg0: &mut MyNFT) {
        arg0.collection_id = 0x1::option::none<0x2::object::ID>();
    }

    public entry fun set_collection(arg0: &mut MyNFT, arg1: 0x2::object::ID) {
        arg0.collection_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    // decompiled from Move bytecode v6
}

