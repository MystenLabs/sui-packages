module 0x91876c2c67ee355704e16efd833094ff23b8edd447a7becbd3a3fe2c988da5cc::soulbound_nft {
    struct SoulboundNFT has key {
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

    public fun transfer(arg0: SoulboundNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SoulboundNFT>(arg0, arg1);
    }

    public fun url(arg0: &SoulboundNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun burn(arg0: SoulboundNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let SoulboundNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SoulboundNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = SoulboundNFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<SoulboundNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<SoulboundNFT>(v1, v0);
    }

    public fun name(arg0: &SoulboundNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun update_description(arg0: &mut SoulboundNFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

