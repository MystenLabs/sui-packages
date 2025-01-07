module 0x192ee7817ce0e0411c7598ee9c21bf06cc06875849894a41d21e71d9bfd59f9b::special_collection_nft {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        nfts: 0x2::vec_map::VecMap<0x2::object::ID, TomNFT>,
    }

    struct TomNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        collection_id: 0x2::object::ID,
    }

    public entry fun create_collection(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Collection{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            nfts        : 0x2::vec_map::empty<0x2::object::ID, TomNFT>(),
        };
        0x2::transfer::public_transfer<Collection>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun mint_to_collection(arg0: &mut Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TomNFT{
            id            : 0x2::object::new(arg4),
            name          : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            url           : 0x1::string::utf8(arg3),
            collection_id : 0x2::object::id<Collection>(arg0),
        };
        0x2::vec_map::insert<0x2::object::ID, TomNFT>(&mut arg0.nfts, 0x2::object::id<TomNFT>(&v0), v0);
    }

    // decompiled from Move bytecode v6
}

