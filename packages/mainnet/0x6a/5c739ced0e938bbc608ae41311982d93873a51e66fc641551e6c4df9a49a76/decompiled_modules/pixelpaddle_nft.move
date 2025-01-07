module 0x6a5c739ced0e938bbc608ae41311982d93873a51e66fc641551e6c4df9a49a76::pixelpaddle_nft {
    struct PixelPaddleNFT has store, key {
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

    struct NFTOwner has key {
        id: 0x2::object::UID,
    }

    public entry fun transfer(arg0: PixelPaddleNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PixelPaddleNFT>(arg0, arg1);
    }

    public fun url(arg0: &PixelPaddleNFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: PixelPaddleNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let PixelPaddleNFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PixelPaddleNFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTOwner{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<NFTOwner>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_to(arg0: &NFTOwner, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PixelPaddleNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<PixelPaddleNFT>(&v0),
            creator   : arg4,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<PixelPaddleNFT>(v0, arg4);
    }

    public fun name(arg0: &PixelPaddleNFT) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

