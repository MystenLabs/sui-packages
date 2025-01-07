module 0xaf873773b0ec5ec38e22891afac1b8b4a66f02a569fdd2220e87777d545ae69b::gracecampo_nft {
    struct GRACECAMPO_NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct GRACECAMPO_NFT_Minted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: GRACECAMPO_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GRACECAMPO_NFT>(arg0, arg1);
    }

    public fun url(arg0: &GRACECAMPO_NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: GRACECAMPO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let GRACECAMPO_NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &GRACECAMPO_NFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_public(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GRACECAMPO_NFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = GRACECAMPO_NFT_Minted{
            object_id : 0x2::object::id<GRACECAMPO_NFT>(&v0),
            creator   : arg3,
            name      : v0.name,
        };
        0x2::event::emit<GRACECAMPO_NFT_Minted>(v1);
        0x2::transfer::public_transfer<GRACECAMPO_NFT>(v0, arg3);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = GRACECAMPO_NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = GRACECAMPO_NFT_Minted{
            object_id : 0x2::object::id<GRACECAMPO_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<GRACECAMPO_NFT_Minted>(v2);
        0x2::transfer::public_transfer<GRACECAMPO_NFT>(v1, v0);
    }

    public fun name(arg0: &GRACECAMPO_NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut GRACECAMPO_NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

