module 0x7a3349763a0a16b825d26fcd5f175e3d85b5701212e4e25ed9cd9472c50babb9::mint {
    struct NFTOBJJ has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &NFTOBJJ) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTOBJJ{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            img_url     : 0x2::url::new_unsafe_from_bytes(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::public_transfer<NFTOBJJ>(v0, arg3);
    }

    public fun description(arg0: &NFTOBJJ) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &NFTOBJJ) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun img_url(arg0: &NFTOBJJ) : &0x2::url::Url {
        &arg0.img_url
    }

    public fun name(arg0: &NFTOBJJ) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

