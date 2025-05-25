module 0x914967cd771fdb782f63ad9622bf8a90e16953a7a5a63de11d4a8a83ff7b68a8::suiet_nft {
    struct SuietNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
    }

    struct NFTCreated has copy, drop {
        object_id: address,
        name: 0x1::string::String,
        recipient: address,
    }

    public fun attribute_keys(arg0: &SuietNFT) : &vector<0x1::string::String> {
        &arg0.attribute_keys
    }

    public fun attribute_values(arg0: &SuietNFT) : &vector<0x1::string::String> {
        &arg0.attribute_values
    }

    public fun description(arg0: &SuietNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_suiet_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Type"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Recovery Message"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"Purpose"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Fund Recovery"));
        let v2 = SuietNFT{
            id               : 0x2::object::new(arg4),
            name             : 0x1::string::utf8(arg0),
            description      : 0x1::string::utf8(arg1),
            url              : 0x1::string::utf8(arg2),
            attribute_keys   : v0,
            attribute_values : v1,
        };
        let v3 = NFTCreated{
            object_id : 0x2::object::uid_to_address(&v2.id),
            name      : v2.name,
            recipient : arg3,
        };
        0x2::event::emit<NFTCreated>(v3);
        0x2::transfer::public_transfer<SuietNFT>(v2, arg3);
    }

    public fun name(arg0: &SuietNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun url(arg0: &SuietNFT) : &0x1::string::String {
        &arg0.url
    }

    // decompiled from Move bytecode v6
}

