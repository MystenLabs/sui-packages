module 0x18e7b99c1e3b401c3c45dfefb6c02d83736e12e3e35146ef4ec3f4a9d5c11fa::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun get_metadata(arg0: &NFT) : (&0x1::string::String, &0x1::string::String, &0x2::url::Url, &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        (&arg0.name, &arg0.description, &arg0.image_url, &arg0.attributes)
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Collection"), 0x1::string::utf8(b"Girls"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Number"), 0x1::string::utf8(b"1"));
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            attributes  : v0,
        };
        0x2::transfer::public_transfer<NFT>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

