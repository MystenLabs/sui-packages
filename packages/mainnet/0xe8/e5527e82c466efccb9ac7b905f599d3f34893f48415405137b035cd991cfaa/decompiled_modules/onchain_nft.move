module 0xe8e5527e82c466efccb9ac7b905f599d3f34893f48415405137b035cd991cfaa::onchain_nft {
    struct OnChainNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_data: 0x1::string::String,
        mime_type: 0x1::string::String,
        blob_id: 0x1::string::String,
        storage_type: 0x1::string::String,
    }

    struct ONCHAIN_NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        minter: address,
        size_bytes: u64,
        storage_type: 0x1::string::String,
    }

    public entry fun burn(arg0: OnChainNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let OnChainNFT {
            id           : v0,
            name         : _,
            description  : _,
            image_data   : _,
            mime_type    : _,
            blob_id      : _,
            storage_type : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun edit_description(arg0: &mut OnChainNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = arg1;
    }

    fun init(arg0: ONCHAIN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"storage_type"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"blob_id"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"data:{mime_type};base64,{image_data}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Easy NFT Now"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{storage_type}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{blob_id}"));
        let v4 = 0x2::package::claim<ONCHAIN_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<OnChainNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<OnChainNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OnChainNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OnChainNFT{
            id           : 0x2::object::new(arg4),
            name         : arg0,
            description  : arg1,
            image_data   : arg2,
            mime_type    : arg3,
            blob_id      : 0x1::string::utf8(b""),
            storage_type : 0x1::string::utf8(b"on-chain"),
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = NFTMinted{
            nft_id       : 0x2::object::id<OnChainNFT>(&v0),
            name         : v0.name,
            minter       : v1,
            size_bytes   : 0x1::string::length(&v0.image_data),
            storage_type : 0x1::string::utf8(b"on-chain"),
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<OnChainNFT>(v0, v1);
    }

    public entry fun mint_with_walrus(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OnChainNFT{
            id           : 0x2::object::new(arg3),
            name         : arg0,
            description  : arg1,
            image_data   : 0x1::string::utf8(b""),
            mime_type    : 0x1::string::utf8(b""),
            blob_id      : arg2,
            storage_type : 0x1::string::utf8(b"walrus"),
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = NFTMinted{
            nft_id       : 0x2::object::id<OnChainNFT>(&v0),
            name         : v0.name,
            minter       : v1,
            size_bytes   : 0,
            storage_type : 0x1::string::utf8(b"walrus"),
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<OnChainNFT>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

