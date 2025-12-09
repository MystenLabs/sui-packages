module 0x4a0c1f607b8e356c5b17bda81cabeb169330ac231925b241dd619041d4fde8be::nft {
    struct SpamNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public entry fun mint_and_transfer(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SpamNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
        };
        0x2::transfer::public_transfer<SpamNFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

