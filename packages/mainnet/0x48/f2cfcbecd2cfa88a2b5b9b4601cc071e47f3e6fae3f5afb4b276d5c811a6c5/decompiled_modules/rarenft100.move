module 0x48f2cfcbecd2cfa88a2b5b9b4601cc071e47f3e6fae3f5afb4b276d5c811a6c5::rarenft100 {
    struct RareNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        rarity_level: u8,
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = RareNFT{
            id           : 0x2::object::new(arg4),
            name         : 0x1::string::utf8(arg0),
            description  : 0x1::string::utf8(arg1),
            image_url    : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity_level : arg3,
        };
        0x2::transfer::transfer<RareNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

