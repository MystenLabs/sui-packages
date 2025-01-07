module 0x3ac1eb29fd84059dcbb0f15a0bb9c44e776e94bd816ec8c8e205f196142618b5::NFT {
    struct NFT has store, key {
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
        let v1 = NFT{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"ShallWeKissForeverNFT"),
            description : 0x1::string::utf8(b"task3 NFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://s21.ax1x.com/2024/04/23/pk97xY9.jpg"),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    public entry fun transferNFT(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

