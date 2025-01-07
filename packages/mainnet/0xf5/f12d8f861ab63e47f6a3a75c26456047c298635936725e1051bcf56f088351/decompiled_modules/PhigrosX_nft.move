module 0xf5f12d8f861ab63e47f6a3a75c26456047c298635936725e1051bcf56f088351::PhigrosX_nft {
    struct PHIGROSX_NFT has store, key {
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

    public entry fun mint_NFT(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = PHIGROSX_NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"PhigrosX_NFT"),
            description : 0x1::string::utf8(b"PhigrosX's NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://pic.imgdb.cn/item/661cc52c68eb93571375dea9.png"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<PHIGROSX_NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<PHIGROSX_NFT>(v1, v0);
    }

    public entry fun transferNFT(arg0: PHIGROSX_NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PHIGROSX_NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

