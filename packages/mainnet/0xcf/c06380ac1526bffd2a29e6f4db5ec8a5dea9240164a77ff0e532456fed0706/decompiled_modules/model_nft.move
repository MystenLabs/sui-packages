module 0xcfc06380ac1526bffd2a29e6f4db5ec8a5dea9240164a77ff0e532456fed0706::model_nft {
    struct MODEL_NFT has drop {
        dummy_field: bool,
    }

    struct ModelNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        category: 0x1::string::String,
        generation_type: 0x1::string::String,
        walrus_bundle_id: 0x1::string::String,
        walrus_model_blob_id: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        creator: address,
        style_id: 0x1::string::String,
        style_version_id: 0x1::string::String,
        created_at: u64,
    }

    struct ModelNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        style_id: 0x1::string::String,
        walrus_bundle_id: 0x1::string::String,
    }

    fun init(arg0: MODEL_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MODEL_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<ModelNFT>(&v0, arg1);
        0x2::display::add<ModelNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<ModelNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<ModelNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{thumbnail_url}"));
        0x2::display::add<ModelNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://app.bellyseal.com/styles/{style_id}"));
        0x2::display::add<ModelNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bellyseal.com"));
        0x2::display::add<ModelNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"BellySeal"));
        0x2::display::update_version<ModelNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ModelNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = ModelNFT{
            id                   : 0x2::object::new(arg11),
            name                 : arg0,
            description          : arg1,
            category             : arg2,
            generation_type      : arg3,
            walrus_bundle_id     : arg4,
            walrus_model_blob_id : arg5,
            thumbnail_url        : arg6,
            creator              : arg10,
            style_id             : arg7,
            style_version_id     : arg8,
            created_at           : arg9,
        };
        let v1 = ModelNFTMinted{
            nft_id           : 0x2::object::id<ModelNFT>(&v0),
            name             : v0.name,
            creator          : arg10,
            style_id         : v0.style_id,
            walrus_bundle_id : v0.walrus_bundle_id,
        };
        0x2::event::emit<ModelNFTMinted>(v1);
        0x2::transfer::public_transfer<ModelNFT>(v0, arg10);
    }

    // decompiled from Move bytecode v6
}

