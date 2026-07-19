module 0xec7aa73aac596a0f16d88046a022daf0ae3944c928af498528ef897c294be385::nft {
    struct GboxNft has store, key {
        id: 0x2::object::UID,
        uri: 0x2::url::Url,
        name: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
        uri: 0x1::string::String,
    }

    struct BurnEvent has copy, drop {
        object_id: 0x2::object::ID,
    }

    public fun burn(arg0: GboxNft) {
        let GboxNft {
            id   : v0,
            uri  : _,
            name : _,
        } = arg0;
        let v3 = v0;
        let v4 = BurnEvent{object_id: 0x2::object::uid_to_inner(&v3)};
        0x2::event::emit<BurnEvent>(v4);
        0x2::object::delete(v3);
    }

    public fun mint(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GboxNft{
            id   : 0x2::object::new(arg2),
            uri  : 0x2::url::new_unsafe_from_bytes(arg0),
            name : 0x1::string::utf8(b"GBox Collectible"),
        };
        let v1 = MintEvent{
            object_id : 0x2::object::id<GboxNft>(&v0),
            recipient : arg1,
            uri       : 0x1::string::utf8(arg0),
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<GboxNft>(v0, arg1);
    }

    public fun name(arg0: &GboxNft) : &0x1::string::String {
        &arg0.name
    }

    public fun uri(arg0: &GboxNft) : &0x2::url::Url {
        &arg0.uri
    }

    // decompiled from Move bytecode v7
}

