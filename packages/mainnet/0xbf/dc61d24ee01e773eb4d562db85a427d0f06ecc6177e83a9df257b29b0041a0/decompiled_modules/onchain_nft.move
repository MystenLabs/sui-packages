module 0xbfdc61d24ee01e773eb4d562db85a427d0f06ecc6177e83a9df257b29b0041a0::onchain_nft {
    struct OnChainNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_data: 0x1::string::String,
        mime_type: 0x1::string::String,
    }

    struct ImageBuilder has store, key {
        id: 0x2::object::UID,
        data: 0x1::string::String,
    }

    struct WalrusNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        blob_id: 0x1::string::String,
        mime_type: 0x1::string::String,
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

    public fun append_chunk(arg0: &mut ImageBuilder, arg1: 0x1::string::String) {
        0x1::string::append(&mut arg0.data, arg1);
    }

    public fun burn_onchain(arg0: OnChainNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let OnChainNFT {
            id          : v0,
            name        : _,
            description : _,
            image_data  : _,
            mime_type   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burn_walrus(arg0: WalrusNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let WalrusNFT {
            id          : v0,
            name        : _,
            description : _,
            blob_id     : _,
            mime_type   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_builder(arg0: &mut 0x2::tx_context::TxContext) : ImageBuilder {
        ImageBuilder{
            id   : 0x2::object::new(arg0),
            data : 0x1::string::utf8(b""),
        }
    }

    public fun edit_onchain_description(arg0: &mut OnChainNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = arg1;
    }

    public fun edit_walrus_description(arg0: &mut WalrusNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = arg1;
    }

    fun init(arg0: ONCHAIN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ONCHAIN_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"storage_type"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"data:{mime_type};base64,{image_data}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Easy NFT Now"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"on-chain"));
        let v5 = 0x2::display::new_with_fields<OnChainNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<OnChainNFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"storage_type"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"blob_id"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/{blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/{blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Easy NFT Now"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"walrus"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{blob_id}"));
        let v10 = 0x2::display::new_with_fields<WalrusNFT>(&v0, v6, v8, arg1);
        0x2::display::update_version<WalrusNFT>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<OnChainNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalrusNFT>>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OnChainNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_data  : arg2,
            mime_type   : arg3,
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

    public fun mint_from_builder(arg0: ImageBuilder, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let ImageBuilder {
            id   : v0,
            data : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = OnChainNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            image_data  : v1,
            mime_type   : arg3,
        };
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = NFTMinted{
            nft_id       : 0x2::object::id<OnChainNFT>(&v2),
            name         : v2.name,
            minter       : v3,
            size_bytes   : 0x1::string::length(&v2.image_data),
            storage_type : 0x1::string::utf8(b"on-chain"),
        };
        0x2::event::emit<NFTMinted>(v4);
        0x2::transfer::public_transfer<OnChainNFT>(v2, v3);
    }

    public fun mint_with_walrus(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = WalrusNFT{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            blob_id     : arg2,
            mime_type   : arg3,
        };
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = NFTMinted{
            nft_id       : 0x2::object::id<WalrusNFT>(&v0),
            name         : v0.name,
            minter       : v1,
            size_bytes   : arg4,
            storage_type : 0x1::string::utf8(b"walrus"),
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<WalrusNFT>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

