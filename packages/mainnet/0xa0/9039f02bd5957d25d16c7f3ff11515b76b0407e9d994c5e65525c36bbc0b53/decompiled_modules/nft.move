module 0xa09039f02bd5957d25d16c7f3ff11515b76b0407e9d994c5e65525c36bbc0b53::nft {
    struct WuKongNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WuKongNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::transfer<WuKongNFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

