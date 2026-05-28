module 0xcfc06380ac1526bffd2a29e6f4db5ec8a5dea9240164a77ff0e532456fed0706::image_nft {
    struct IMAGE_NFT has drop {
        dummy_field: bool,
    }

    struct ImageNFT has store, key {
        id: 0x2::object::UID,
        prompt: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        image_url: 0x1::string::String,
        parent_model_nft_id: 0x1::string::String,
        parent_style_id: 0x1::string::String,
        creator: address,
        generation_id: 0x1::string::String,
        created_at: u64,
    }

    struct ImageNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        prompt: 0x1::string::String,
        creator: address,
        generation_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        parent_model_nft_id: 0x1::string::String,
    }

    fun init(arg0: IMAGE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<IMAGE_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<ImageNFT>(&v0, arg1);
        0x2::display::add<ImageNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"BellySeal Generation"));
        0x2::display::add<ImageNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{prompt}"));
        0x2::display::add<ImageNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<ImageNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://app.bellyseal.com/nft/image/{generation_id}"));
        0x2::display::add<ImageNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://bellyseal.com"));
        0x2::display::add<ImageNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"BellySeal"));
        0x2::display::update_version<ImageNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ImageNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = ImageNFT{
            id                  : 0x2::object::new(arg8),
            prompt              : arg0,
            walrus_blob_id      : arg1,
            image_url           : arg2,
            parent_model_nft_id : arg3,
            parent_style_id     : arg4,
            creator             : arg7,
            generation_id       : arg5,
            created_at          : arg6,
        };
        let v1 = ImageNFTMinted{
            nft_id              : 0x2::object::id<ImageNFT>(&v0),
            prompt              : v0.prompt,
            creator             : arg7,
            generation_id       : v0.generation_id,
            walrus_blob_id      : v0.walrus_blob_id,
            parent_model_nft_id : v0.parent_model_nft_id,
        };
        0x2::event::emit<ImageNFTMinted>(v1);
        0x2::transfer::public_transfer<ImageNFT>(v0, arg7);
    }

    // decompiled from Move bytecode v6
}

