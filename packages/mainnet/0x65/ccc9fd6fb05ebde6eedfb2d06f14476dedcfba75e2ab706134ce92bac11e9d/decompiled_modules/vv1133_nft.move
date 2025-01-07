module 0x65ccc9fd6fb05ebde6eedfb2d06f14476dedcfba75e2ab706134ce92bac11e9d::vv1133_nft {
    struct VV1133_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public fun transfer(arg0: VV1133_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<VV1133_NFT>(arg0, arg1);
    }

    public fun url(arg0: &VV1133_NFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: VV1133_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let VV1133_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &VV1133_NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VV1133_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        0x2::transfer::public_transfer<VV1133_NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun name(arg0: &VV1133_NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut VV1133_NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

