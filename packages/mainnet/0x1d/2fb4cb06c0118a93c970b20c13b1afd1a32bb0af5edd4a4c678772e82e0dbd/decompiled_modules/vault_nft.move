module 0x1d2fb4cb06c0118a93c970b20c13b1afd1a32bb0af5edd4a4c678772e82e0dbd::vault_nft {
    struct VaultNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: VaultNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VaultNFT>(arg0, arg1);
    }

    public fun url(arg0: &VaultNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &VaultNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultNFT{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<VaultNFT>(&v0),
            creator   : arg3,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::transfer<VaultNFT>(v0, arg3);
    }

    public fun name(arg0: &VaultNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

