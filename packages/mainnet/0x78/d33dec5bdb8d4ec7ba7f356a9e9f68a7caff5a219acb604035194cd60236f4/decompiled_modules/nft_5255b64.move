module 0x78d33dec5bdb8d4ec7ba7f356a9e9f68a7caff5a219acb604035194cd60236f4::nft_5255b64 {
    struct NFT_5255b64 has drop {
        dummy_field: bool,
    }

    struct MY_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public entry fun transfer(arg0: MY_NFT, arg1: address) {
        0x2::transfer::transfer<MY_NFT>(arg0, arg1);
    }

    public entry fun burn(arg0: MY_NFT) {
        let MY_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MY_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<MY_NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

