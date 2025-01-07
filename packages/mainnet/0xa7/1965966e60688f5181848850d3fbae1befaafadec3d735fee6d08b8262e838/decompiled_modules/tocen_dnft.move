module 0xa71965966e60688f5181848850d3fbae1befaafadec3d735fee6d08b8262e838::tocen_dnft {
    struct DynamicNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        creator: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: DynamicNFT, arg1: address) {
        0x2::transfer::transfer<DynamicNFT>(arg0, arg1);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DynamicNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg2),
            img_url     : 0x2::url::new_unsafe_from_bytes(arg1),
            creator     : 0x2::tx_context::sender(arg3),
        };
        0x2::transfer::transfer<DynamicNFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

