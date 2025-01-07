module 0xe55e77a92eef861272720aea7f586675fee653fae3337272558514091acafa9e::movestuduentnft {
    struct MoveStudentNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMint has copy, drop {
        object_id: 0x2::object::ID,
        creater: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: MoveStudentNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MoveStudentNFT>(arg0, arg1);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MoveStudentNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMint{
            object_id : 0x2::object::id<MoveStudentNFT>(&v1),
            creater   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMint>(v2);
        0x2::transfer::public_transfer<MoveStudentNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

