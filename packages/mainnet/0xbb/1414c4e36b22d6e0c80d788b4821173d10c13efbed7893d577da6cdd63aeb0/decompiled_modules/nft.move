module 0xbb1414c4e36b22d6e0c80d788b4821173d10c13efbed7893d577da6cdd63aeb0::nft {
    struct MYNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    struct MYNFTMintedEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: MYNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<MYNFT>(arg0, arg1);
    }

    public fun url(arg0: &MYNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: MYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MYNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &MYNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &MYNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = MYNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v2 = MYNFTMintedEvent{
            object_id : 0x2::object::id<MYNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<MYNFTMintedEvent>(v2);
        0x2::transfer::public_transfer<MYNFT>(v1, v0);
    }

    public fun name(arg0: &MYNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut MYNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

