module 0xd828cebe408ac5432bdf3f58d8b1742b2039444ed4979bb1b6a2ad0e10ac8efd::nft_greyhao {
    struct GreyhaoNFT has store, key {
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

    public fun transfer(arg0: GreyhaoNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GreyhaoNFT>(arg0, arg1);
    }

    public fun url(arg0: &GreyhaoNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: GreyhaoNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let GreyhaoNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &GreyhaoNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = nftInfo(arg0);
        let v2 = NFTMinted{
            object_id : 0x2::object::id<GreyhaoNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<GreyhaoNFT>(v1, v0);
    }

    public fun mint_and_transfer(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GreyhaoNFT>(nftInfo(arg1), arg0);
    }

    public fun name(arg0: &GreyhaoNFT) : &0x1::string::String {
        &arg0.name
    }

    fun nftInfo(arg0: &mut 0x2::tx_context::TxContext) : GreyhaoNFT {
        GreyhaoNFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"GREYHAO"),
            description : 0x1::string::utf8(b"NFT was created by GreyHao."),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/107107440"),
        }
    }

    public fun update_description(arg0: &mut GreyhaoNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

