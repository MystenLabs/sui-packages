module 0x4517f76fb0b2a105c930f240960e5b644cc263c6387b85f766367770292ad59b::avatar_nft {
    struct AvatarNFT has store, key {
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

    public entry fun transfer(arg0: AvatarNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<AvatarNFT>(arg0, arg1);
    }

    public fun url(arg0: &AvatarNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: AvatarNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let AvatarNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.description
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = AvatarNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<AvatarNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<AvatarNFT>(v1, v0);
    }

    public fun name(arg0: &AvatarNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut AvatarNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

