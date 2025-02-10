module 0x9968df00387912d47e05bb49847dfcd0b64813acd81fc41a05a98f3b00235e10::RivelleKnitsNFT {
    struct RIVELLEKNITSNFT has drop {
        dummy_field: bool,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        nft_type: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id          : v0,
            nft_type    : _,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: RIVELLEKNITSNFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<RIVELLEKNITSNFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::package::Publisher, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (v0 != @0xd8cd92a693c562da267b86eb14e2fc477234632f57fbdae3b7113aa9082ed936) {
            abort 1
        };
        let v1 = NFT{
            id          : 0x2::object::new(arg5),
            nft_type    : arg1,
            name        : arg0,
            description : arg2,
            url         : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(arg3)),
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, v1.name);
        0x1::vector::push_back<0x1::string::String>(v5, v1.description);
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(0x1::string::into_bytes(arg3)));
        let v6 = 0x2::display::new_with_fields<NFT>(arg4, v2, v4, arg5);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, v0);
        let v7 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

