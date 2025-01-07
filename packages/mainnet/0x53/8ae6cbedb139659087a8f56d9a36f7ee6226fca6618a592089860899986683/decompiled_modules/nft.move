module 0x538ae6cbedb139659087a8f56d9a36f7ee6226fca6618a592089860899986683::nft {
    struct QipanNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: QipanNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<QipanNFT>(arg0, arg1);
    }

    public fun url(arg0: &QipanNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: QipanNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let QipanNFT {
            id   : v0,
            name : _,
            url  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun mint_to_sender(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = QipanNFT{
            id   : 0x2::object::new(arg2),
            name : 0x1::string::utf8(arg0),
            url  : 0x2::url::new_unsafe_from_bytes(arg1),
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<QipanNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<QipanNFT>(v1, v0);
    }

    public fun name(arg0: &QipanNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

